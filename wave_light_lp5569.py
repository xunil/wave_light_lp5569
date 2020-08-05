from smbus2 import SMBus
from itertools import izip_longest
import RPi.GPIO as GPIO

class LP5569:
	# GPIO pin numbers
	EN_PWM_GPIO_PIN = 4

	# Registers
	CONFIG = 0x0
	LED_ENGINE_CONTROL1 = 0x1
	LED_ENGINE_CONTROL2 = 0x2
	LED0_CONTROL = 0x7
	LED1_CONTROL = 0x8
	LED2_CONTROL = 0x9
	LED3_CONTROL = 0xA
	LED4_CONTROL = 0xB
	LED5_CONTROL = 0xC
	LED6_CONTROL = 0xD
	LED7_CONTROL = 0xE
	LED8_CONTROL = 0xF
	LED0_PWM = 0x16
	LED1_PWM = 0x17
	LED2_PWM = 0x18
	LED3_PWM = 0x19
	LED4_PWM = 0x1A
	LED5_PWM = 0x1B
	LED6_PWM = 0x1C
	LED7_PWM = 0x1D
	LED8_PWM = 0x1E
	LED0_CURRENT = 0x22
	LED1_CURRENT = 0x23
	LED2_CURRENT = 0x24
	LED3_CURRENT = 0x25
	LED4_CURRENT = 0x26
	LED5_CURRENT = 0x27
	LED6_CURRENT = 0x28
	LED7_CURRENT = 0x29
	LED8_CURRENT = 0x2A
	MISC = 0x2F
	ENGINE1_PC = 0x30
	ENGINE2_PC = 0x31
	ENGINE3_PC = 0x32
	MISC2 = 0x33
	ENGINE_STATUS = 0x3C
	IO_CONTROL = 0x3D
	VARIABLE_D = 0x3E
	RESET = 0x3F
	ENGINE1_VARIABLE_A = 0x42
	ENGINE2_VARIABLE_A = 0x43
	ENGINE3_VARIABLE_A = 0x44
	MASTER_FADER1 = 0x46
	MASTER_FADER2 = 0x47
	MASTER_FADER3 = 0x48
	MASTER_FADER_PWM = 0x4A
	ENGINE1_PROG_START = 0x4B
	ENGINE2_PROG_START = 0x4C
	ENGINE3_PROG_START = 0x4D
	PROG_MEM_PAGE_SELECT = 0x4F
	PROGRAM_MEM_00 = 0x50
	ENGINE1_MAPPING1 = 0x70
	ENGINE1_MAPPING2 = 0x71
	ENGINE2_MAPPING1 = 0x72
	ENGINE2_MAPPING2 = 0x73
	ENGINE3_MAPPING1 = 0x74
	ENGINE3_MAPPING2 = 0x75
	PWM_CONFIG = 0x80
	LED_FAULT1 = 0x81
	LED_FAULT2 = 0x82
	GENERAL_FAULT = 0x83

	# LED control values
	LEDCTL_EXTERNAL_POWER = 1 << 2
	LEDCTL_EXPONENTIAL_ADJ = 1 << 3
	LEDCTL_RATIOMETRIC_DIM = 1 << 4
	LEDCTL_FADER_NONE = 0
	LEDCTL_FADER_1 = 1 << 5
	LEDCTL_FADER_2 = 2 << 5
	LEDCTL_FADER_3 = 3 << 5
	LEDCTL_FADER_PWMPIN = 5 << 5

	engine_bits = lambda self, e: ((2-e)*2)+2
	engine_mask = lambda self, e: 0xff & ~(3<<self.engine_bits(e))

	def grouper(n, iterable, fillvalue=None):
		args = [iter(iterable)]*n
		return izip_longest(fillvalue=fillvalue, *args)

	def __init__(self, bus=0, address=0x42):
		self.bus = SMBus(bus)
		self.address = address
		self.enabled_sw = False
		self.enabled_hw = False
		GPIO.setmode(GPIO.BCM)
		GPIO.setup(self.EN_PWM_GPIO_PIN, GPIO.OUT, initial=GPIO.LOW)

	def __del__(self):
		GPIO.cleanup()

	def startup(self):
		pass

	def enable(self):
		self.chip_enable_hw()
		self.chip_enable_sw()

	def enabled(self):
		return self.enabled_sw and self.enabled_hw

	def disable(self):
		self.chip_disable_sw()
		self.chip_disable_hw()

	def chip_enable_sw(self):
		self.bus.write_byte_data(self.address, self.CONFIG,	0b01000000)
		self.enabled_sw = True

	def chip_disable_sw(self):
		self.bus.write_byte_data(self.address, self.CONFIG,	0x0)
		self.enabled_sw = False

	def chip_enable_hw(self):
		GPIO.output(self.EN_PWM_GPIO_PIN, GPIO.HIGH)
		self.enabled_hw = True

	def chip_disable_hw(self):
		GPIO.output(self.EN_PWM_GPIO_PIN, GPIO.LOW)
		self.enabled_hw = False

	def use_internal_clock(self):
		if not self.enabled_hw:
			raise Exception("Cannot enable internal clock when LP5569 is hardware-disabled")
		if self.enabled_sw:
			raise Exception("Cannot enable internal clock when LP5569 is software-enabled")
		misc = self.bus.read_byte_data(self.address, self.MISC)
		misc |= 0x01
		self.bus.write_byte_data(self.address, self.MISC, misc)
		io_control = self.bus.read_byte_data(self.address, self.IO_CONTROL)
		io_control |= 0b00001000
		self.bus.write_byte_data(self.address, self.IO_CONTROL, io_control)


	def set_led_control(self, led, fader, ratiometric, exponential, external_power):
		control_byte = 0
		if external_power:
			control_byte |= self.LEDCTL_EXTERNAL_POWER
		if exponential:
			control_byte |= self.LEDCTL_EXPONENTIAL_ADJ
		if ratiometric:
			control_byte |= self.LEDCTL_RATIOMETRIC_DIM
		control_byte |= fader
		self.bus.write_byte_data(self.address, self.LED0_CONTROL + led, control_byte)

	def set_led_pwm(self, led, pwm):
		self.bus.write_byte_data(self.address, self.LED0_PWM + led, pwm)

	def map_led_to_engine(self, led, engine):
		if engine == 0:
			reg = self.ENGINE1_MAPPING2
		elif engine == 1:
			reg = self.ENGINE2_MAPPING2
		elif engine == 2:
			reg = self.ENGINE3_MAPPING2
		if led > 7:
			reg -= 1

		regval = self.bus.read_byte_data(self.address, reg)
		regval |= (1<<(led % 8))
		self.bus.write_byte_data(self.address, reg, regval)

	def load_program(self, engine, start_page, program, offset=0):
		if start_page > 15:
			raise Exception("Program load start page cannot exceed page 15")
		if len(program) > 128:
			raise Exception("Program length cannot exceed 128 bytes")
		if offset % 2 != 0:
			raise Exception("Program load offset must be an even number")
		# XXX: why read the engine control register if we're not going to restore it?
		control2 = self.bus.read_byte_data(self.address, self.LED_ENGINE_CONTROL2)
		# Must place all engines into load program mode to load any engine's SRAM
		self.bus.write_byte_data(self.address, self.LED_ENGINE_CONTROL2, 0b01010100)
		engine_status = self.bus.read_byte_data(self.address, self.ENGINE_STATUS)
		while (engine_status & (1 << 5)) != 0:
			time.sleep(0.001)
			engine_status = self.bus.read_byte_data(self.address, self.ENGINE_STATUS)
		# Now we can write to the SRAM
		self.bus.write_byte_data(self.address, self.PROG_MEM_PAGE_SELECT, start_page)
		n = 0
		# for chunk in self.grouper(32, program):
		# 	self.bus.write_i2c_block_data(self.address, self.PROGRAM_MEM_00 + offset, chunk)
		# 	if n == 0:
		# 		# First pass through the loop, so the offset is no longer needed.
		# 		offset = 0
		# 	n = n + 1
		# 	self.bus.write_byte_data(self.address, self.PROG_MEM_PAGE_SELECT, start_page+n)
		self.bus.write_i2c_block_data(self.address, self.PROGRAM_MEM_00, program)

	def start_engine(self, engine):
		control1 = self.bus.read_byte_data(self.address, self.LED_ENGINE_CONTROL1) & self.engine_mask(engine)
		control1 |= (2 << self.engine_bits(engine))  # Free run, shifted to appropriate engine 
		self.bus.write_byte_data(self.address, self.LED_ENGINE_CONTROL1, control1)

		control2 = self.bus.read_byte_data(self.address, self.LED_ENGINE_CONTROL2) & self.engine_mask(engine)
		control2 |= (2 << self.engine_bits(engine))
		self.bus.write_byte_data(self.address, self.LED_ENGINE_CONTROL2, control2)

	def stop_engine(self, engine):
		control2 = self.bus.read_byte_data(self.address, self.LED_ENGINE_CONTROL2) & self.engine_mask(engine)
		control2 |= (3 << self.engine_bits(engine))
		self.bus.write_byte_data(self.address, self.LED_ENGINE_CONTROL2, control2)

	def demo(self):
		self.chip_enable_hw()
		self.use_internal_clock()
		self.set_led_pwm(0, 128)
		self.map_led_to_engine(0, 0)
		program = [0b01010000, 0x80, 0b01010001, 0x80, 0b01010000, 0x00, 0b10100000, 0x0]
		self.load_program(0, 0, program)
		self.start_engine(0)
		self.chip_enable_sw()




if __name__ == '__main__':
	lp5569 = LP5569(bus=0, address=0x42)
	lp5569.demo()
