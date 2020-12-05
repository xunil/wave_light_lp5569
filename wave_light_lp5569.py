from smbus2 import SMBus
#from itertools import izip_longest
import RPi.GPIO as GPIO
from constants import *
import time

class LP5569:
    class Reg:
        def __init__(self, bus, address=0x42):
            self.bus = SMBus(bus)
            self.address = address

        def __getitem__(self, item):
            return self.bus.read_byte_data(self.address, item)

        def __setitem__(self, key, value):
            byte_was = self.bus.read_byte_data(self.address, key)
            time.sleep(0.02)
            if isinstance(value, list):
                self.bus.write_i2c_block_data(self.address, key, value)
                time.sleep(0.02)
            else:
                self.bus.write_byte_data(self.address, key, value)
                time.sleep(0.02)
                byte_is = self.bus.read_byte_data(self.address, key)
                time.sleep(0.02)
                print("\x1b[0;32mDEBUG\x1b[0m: Byte at register {0:#04x} was {1:#010b} ({1:#04x}), wrote {2:#010b} ({2:#04x}), now is {3:#010b} ({3:#04x})".format(
                        key,
                        byte_was,
                        value,
                        byte_is
                ))

    engine_bits = lambda self, e: ((2 - e) * 2) + 2
    engine_mask = lambda self, e: 0xff & ~(3 << self.engine_bits(e))

    # def grouper(n, iterable, fillvalue=None):
    #     args = [iter(iterable)] * n
    #     return izip_longest(fillvalue=fillvalue, *args)

    def __init__(self, bus=0, address=0x42):
        self.enabled_sw = False
        self.enabled_hw = False
        GPIO.setmode(GPIO.BCM)
        GPIO.setup(EN_PWM_GPIO_PIN, GPIO.OUT, initial=GPIO.LOW)
        self.reg = self.Reg(bus, address)

    def __del__(self):
        self.chip_disable_sw()
        self.chip_disable_hw()
        GPIO.cleanup()

    def enable(self):
        self.chip_enable_hw()
        self.chip_enable_sw()

    def enabled(self):
        return self.enabled_sw and self.enabled_hw

    def disable(self):
        self.chip_disable_sw()
        self.chip_disable_hw()

    def chip_enable_sw(self):
        # self.bus.write_byte_data(self.address, CONFIG,	0b01000000)
        self.reg[CONFIG] = 0b01000000
        self.enabled_sw = True

    def chip_disable_sw(self):
        # self.bus.write_byte_data(self.address, CONFIG,	0x0)
        self.reg[CONFIG] = 0x0
        self.enabled_sw = False

    def chip_enable_hw(self):
        GPIO.output(EN_PWM_GPIO_PIN, GPIO.HIGH)
        self.enabled_hw = True

    def chip_disable_hw(self):
        GPIO.output(EN_PWM_GPIO_PIN, GPIO.LOW)
        self.enabled_hw = False

    def use_internal_clock(self):
        if not self.enabled_hw:
            raise Exception("Cannot enable internal clock when LP5569 is hardware-disabled")
        if self.enabled_sw:
            raise Exception("Cannot enable internal clock when LP5569 is software-enabled")
        self.reg[IO_CONTROL] |= 0b00001000
        self.reg[MISC] |= 0x01

    def set_led_control(self, led, fader, ratiometric, exponential, external_power):
        control_byte = 0
        if external_power:
            control_byte |= LEDCTL_EXTERNAL_POWER
        if exponential:
            control_byte |= LEDCTL_EXPONENTIAL_ADJ
        if ratiometric:
            control_byte |= LEDCTL_RATIOMETRIC_DIM
        control_byte |= fader
        # self.bus.write_byte_data(self.address, LED0_CONTROL + led, control_byte)
        self.reg[LED0_CONTROL] = control_byte

    def set_led_pwm(self, led, pwm):
        # self.bus.write_byte_data(self.address, LED0_PWM + led, pwm)
        self.reg[LED0_PWM + led] = pwm

    def map_led_to_engine(self, led, engine):
        mapping_reg = ENGINE1_MAPPING2
        if engine == 0:
            mapping_reg = ENGINE1_MAPPING2
        elif engine == 1:
            mapping_reg = ENGINE2_MAPPING2
        elif engine == 2:
            mapping_reg = ENGINE3_MAPPING2
        if led > 7:
            mapping_reg -= 1
        # regval = self.bus.read_byte_data(self.address, mapping_reg)
        # regval |= (1 << (led % 8))
        # self.bus.write_byte_data(self.address, mapping_reg, regval)
        self.reg[mapping_reg] |= (1 << (led % 8))

    def load_program(self, engine, start_page, program, offset=0):
        if start_page > 15:
            raise Exception("Program load start page cannot exceed page 15")
        if len(program) > 128:
            raise Exception("Program length cannot exceed 128 bytes")
        if offset % 2 != 0:
            raise Exception("Program load offset must be an even number")
        # XXX: why read the engine control register if we're not going to restore it?
        # control2 = self.bus.read_byte_data(self.address, LED_ENGINE_CONTROL2)
        control2 = self.reg[LED_ENGINE_CONTROL2]
        # Must place all engines into load program mode to load any engine's SRAM
        # self.bus.write_byte_data(self.address, LED_ENGINE_CONTROL2, 0b01010100)
        self.reg[LED_ENGINE_CONTROL2] = 0b01010100
        # engine_status = self.bus.read_byte_data(self.address, ENGINE_STATUS)
        while (self.reg[ENGINE_STATUS] & (1 << 5)) != 0:
            time.sleep(0.001)
        # engine_status = self.bus.read_byte_data(self.address, ENGINE_STATUS)
        # Now we can write to the SRAM
        # self.bus.write_byte_data(self.address, PROG_MEM_PAGE_SELECT, start_page)
        self.reg[PROG_MEM_PAGE_SELECT] = start_page
        n = 0
        # for chunk in self.grouper(32, program):
        # 	self.bus.write_i2c_block_data(self.address, self.PROGRAM_MEM_00 + offset, chunk)
        # 	if n == 0:
        # 		# First pass through the loop, so the offset is no longer needed.
        # 		offset = 0
        # 	n = n + 1
        # 	self.bus.write_byte_data(self.address, self.PROG_MEM_PAGE_SELECT, start_page+n)
        # self.bus.write_i2c_block_data(self.address, PROGRAM_MEM_00, program)
        self.reg[PROGRAM_MEM_00] = program

    def start_engine(self, engine):
        # control1 = self.bus.read_byte_data(self.address, LED_ENGINE_CONTROL1) & self.engine_mask(engine)
        # control1 |= (2 << self.engine_bits(engine))  # Free run, shifted to appropriate engine
        # self.bus.write_byte_data(self.address, LED_ENGINE_CONTROL1, control1)
        control1 = self.reg[LED_ENGINE_CONTROL1] & self.engine_mask(engine)
        control1 |= (2 << self.engine_bits(engine))  # Free run, shifted to appropriate engine
        self.reg[LED_ENGINE_CONTROL1] = control1

        # control2 = self.bus.read_byte_data(self.address, LED_ENGINE_CONTROL2) & self.engine_mask(engine)
        # control2 |= (2 << self.engine_bits(engine))
        # self.bus.write_byte_data(self.address, LED_ENGINE_CONTROL2, control2)
        control2 = self.reg[LED_ENGINE_CONTROL2] & self.engine_mask(engine)
        control2 |= (2 << self.engine_bits(engine))
        self.reg[LED_ENGINE_CONTROL2] = control2

    def stop_engine(self, engine):
        # control2 = self.bus.read_byte_data(self.address, LED_ENGINE_CONTROL2) & self.engine_mask(engine)
        # control2 |= (3 << self.engine_bits(engine))
        # self.bus.write_byte_data(self.address, LED_ENGINE_CONTROL2, control2)
        control2 = self.reg[LED_ENGINE_CONTROL2] & self.engine_mask(engine)
        control2 |= (3 << self.engine_bits(engine))
        self.reg[LED_ENGINE_CONTROL2] = control2

    def demo(self):
        print("Enabling chip in hardware")
        self.chip_enable_hw()
        print("Setting internal clock active")
        self.use_internal_clock()
        print("Enabling chip in software")
        self.chip_enable_sw()
        print("Setting LED 0 to half brightness")
        self.set_led_pwm(0, 128)
        self.dump_engine_status()
        print("Mapping LED 0 to engine 0 (engine 1 in docs)")
        self.map_led_to_engine(0, 0)
        self.dump_engine_status()
        program = [0b01010000, 0x80, 0b01010001, 0x80, 0b01010000, 0x00, 0b10100000, 0x0]
        print("Loading program: {0}".format(program))
        self.load_program(0, 0, program, 0)
        self.dump_engine_status()
        print("Starting engine 0 (engine 1 in docs)")
        self.start_engine(0)
        self.dump_engine_status()
        time.sleep(60)

    def dump_engine_status(self):
        engine_status = {
            'Engine 1': [],
            'Engine 2': [],
            'Engine 3': [],
        }
        status1_labels = ['Hold', 'Step', 'Free run', 'Execute once']
        status2_labels = ['Disabled', 'Load program', 'Run program', 'Halt']
        control1 = self.reg[LED_ENGINE_CONTROL1] >> 2
        control2 = self.reg[LED_ENGINE_CONTROL2] >> 2
        for i in range(3, 0, -1):
            k = 'Engine %d' % i
            engine_status[k].append(status1_labels[control1 & 0b00000011])
            engine_status[k].append(status2_labels[control2 & 0b00000011])
            control1 = control1 >> 2
            control2 = control2 >> 2
        for k, v in engine_status.items():
            print("{0}: {1}  ".format(k, v), end='')
        print()

if __name__ == '__main__':
    lp = LP5569()
    lp.demo()