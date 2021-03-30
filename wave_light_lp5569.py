from smbus2 import SMBus
import RPi.GPIO as GPIO
from constants import *
import time

class LP5569:
    class Reg:
        I2C_DELAY = 0.00001
        def __init__(self, bus, address=0x42, debug=True):
            self.bus = SMBus(bus)
            self.address = address
            self.broadcast = False
            self.debug = debug

        def __getitem__(self, item):
            return self.bus.read_byte_data(self.get_address(), item)

        def __setitem__(self, key, value):
            if self.debug:
                byte_was = self.bus.read_byte_data(self.get_address(), key)
                time.sleep(self.I2C_DELAY)
            if isinstance(value, list):
                self.bus.write_i2c_block_data(self.get_address(), key, value)
                time.sleep(self.I2C_DELAY)
            else:
                self.bus.write_byte_data(self.get_address(), key, value)
                time.sleep(self.I2C_DELAY)
                if self.debug:
                    byte_is = self.bus.read_byte_data(self.get_address(), key)
                    time.sleep(self.I2C_DELAY)
                    print("\x1b[0;32mDEBUG\x1b[0m: Byte at register {0:#04x} was {1:#010b} ({1:#04x}), wrote {2:#010b} ({2:#04x}), now is {3:#010b} ({3:#04x})".format(
                            key,
                            byte_was,
                            value,
                            byte_is
                    ))

        def begin_broadcast(self):
            self.broadcast = True

        def end_broadcast(self):
            self.broadcast = False

        def get_address(self):
            return self.address if not self.broadcast else 0x40

    engine_bits = lambda self, e: ((2 - e) * 2) + 2
    engine_mask = lambda self, e: 0xff & ~(0b11 << self.engine_bits(e))

    def __init__(self, bus=0, address=0x42):
        self.enabled_sw = False
        self.enabled_hw = False
        self.broadcast = False
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
        self.reg[CONFIG] = 0b01000000
        self.enabled_sw = True

    def chip_disable_sw(self):
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
        self.reg[MISC] |= (0x01 | (3 << 3))  # int_clk_en = 0b1; cp_mode = 0b11

    def enable_internal_clock_output(self):
        self.reg[IO_CONTROL] = 0b00001000

    def begin_broadcast(self):
        self.reg.begin_broadcast()

    def end_broadcast(self):
        self.reg.end_broadcast()

    def set_led_control(self, led, fader, ratiometric, exponential, external_power):
        control_byte = 0
        if external_power:
            control_byte |= LEDCTL_EXTERNAL_POWER
        if exponential:
            control_byte |= LEDCTL_EXPONENTIAL_ADJ
        if ratiometric:
            control_byte |= LEDCTL_RATIOMETRIC_DIM
        control_byte |= fader
        self.reg[LED0_CONTROL + led] = control_byte

    def set_led_pwm(self, led, pwm):
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
        self.reg[mapping_reg] |= (1 << (led % 8))

    def enable_fader(self, engine):
        self.reg[ENGINE1_MAPPING1 + (engine * 2)] |= 0b10

    def set_fader(self, fader, value):
        self.reg[fader] = value

    def load_program(self, engine, start_page, program, offset=0):
        if start_page > 15:
            raise Exception("Program load start page cannot exceed page 15")
        if len(program) > 128:
            raise Exception("Program length cannot exceed 128 bytes")
        if offset % 2 != 0:
            raise Exception("Program load offset must be an even number")
        if len(program) % 2 != 0:
            raise Exception("Program length must be a multiple of 2 bytes")
        # Must place all engines into load program mode to load any engine's SRAM
        # Load program mode can only be entered from Disabled mode
        self.reg[LED_ENGINE_CONTROL2] = 0b00000000  # Disabled
        self.reg[LED_ENGINE_CONTROL2] = 0b01010100  # Load SRAM
        while (self.reg[ENGINE_STATUS] & (1 << 5)) != 0:
            time.sleep(0.001)

        # Now we can write to the SRAM
        page = start_page
        chunk = program[0:(32 - offset)]
        while len(chunk) > 0:
            print("\x1b[0;31mLOAD\x1b[0m: chunk is {0}".format(chunk))
            print("\x1b[0;31mLOAD\x1b[0m: page={0}, offset={1}".format(page, offset))
            self.reg[PROG_MEM_PAGE_SELECT] = page
            self.reg[PROGRAM_MEM_00 + offset] = chunk
            program = program[(32 - offset):]
            chunk = program[0:32]
            offset = 0
            page += 1
        self.reg[ENGINE1_PROG_START + engine] = (start_page + offset)
        self.reg[ENGINE1_PC + engine] = 0

    def set_engine_program_start(self, engine, start_addr, pc):
        self.reg[ENGINE1_PROG_START + engine] = start_addr
        self.reg[ENGINE1_PC + engine] = pc

    def start_engine(self, engine, run_mode):
        control1 = self.reg[LED_ENGINE_CONTROL1] & self.engine_mask(engine)
        control1 |= (run_mode << self.engine_bits(engine))  # Shifted to appropriate engine
        self.reg[LED_ENGINE_CONTROL1] = control1

        control2 = self.reg[LED_ENGINE_CONTROL2] & self.engine_mask(engine)
        control2 |= (ENGINE_RUN_PROGRAM << self.engine_bits(engine))
        self.reg[LED_ENGINE_CONTROL2] = control2

    def forcibly_start_engine(self):
        self.reg[LED_ENGINE_CONTROL2] = 0b10101000
        status = self.reg[ENGINE_STATUS] & 0x7F
        while status != 0:
            print("Waiting for engine to become available; status is {0:#010b} ({0:#04x})".format(status))
            time.sleep(1)
            status = self.reg[ENGINE_STATUS] & 0x7F
        self.reg[LED_ENGINE_CONTROL1] = 0b10101000

    def stop_engine(self, engine):
        control2 = self.reg[LED_ENGINE_CONTROL2] & self.engine_mask(engine)
        control2 |= (3 << self.engine_bits(engine))
        self.reg[LED_ENGINE_CONTROL2] = control2

    def step_engine(self, engine):
        self.start_engine(engine, RUNMODE_STEP)

    def clear_interrupt(self):
        x = self.reg[ENGINE_STATUS]

    def demo(self):
        demo_led = 1
        demo_engine = 0

        print("Enabling chip in hardware")
        self.chip_enable_hw()
        time.sleep(0.1)
        print("Setting internal clock active")
        self.use_internal_clock()
        time.sleep(0.1)

        self.begin_broadcast()
        print("Enabling chip in software")
        self.chip_enable_sw()
        time.sleep(0.1)

        print("Setting LED control to no fader, no ratiometric dimming, external power, exponential adjustment")
        self.set_led_control(demo_led, LEDCTL_FADER_NONE, False, True, True)
        print("Setting all LEDs to full brightness")
        for i in range(0, 9):
            self.set_led_pwm(i, 255)
        print("Returning LEDs to off")
        for i in range(0, 9):
            self.set_led_pwm(i, 0)

        self.end_broadcast()
        print("Setting internal clock to output")
        self.enable_internal_clock_output()
        self.begin_broadcast()

        self.dump_engine_status()
        # Ramp program
        ramp_program = [
            0b10011101, 0b00000001,     # 0000:0: Map LED 0 to engine 0
            0b00100000, 0x80,           # 0002:1: Ramp up in 0x80 increments
            0b00100000, 0x00,           # 0004:2: Wait
            0b00100001, 0x80,           # 0006:3: Ramp down in 0x80 increments
            0b00100000, 0x00,           # 0008:4: Wait
            0b10100000, 0b00000001,     # 000A:5: Branch back to step 1
        ]
        # On-off program
        # program = [0b01000000, 0xFF, 0b00111110, 0x0, 0b01000000, 0x00, 0b0111110, 0x0, 0x0, 0x0]
        # SparkFun Example Scanner program
        scanner_program = [
            0x9c, 0x10, 0x9c, 0x9f, 0x06, 0xff, 0x02, 0x00,
            0x07, 0xff, 0x9d, 0x80, 0xa0, 0x02, 0x00, 0x0a,
            0x00, 0x05, 0x00, 0x0a, 0x00, 0x05, 0x00, 0x0a,
            0x00, 0x05, 0x00, 0x0a, 0x00, 0x05, 0x00, 0x0a,
            0x00, 0x01, 0x00, 0x02, 0x00, 0x40, 0x00, 0x04,
            0x00, 0x08, 0x00, 0x80, 0x00, 0x10, 0x00, 0x20,
            0x01, 0x00, 0x00, 0x20, 0x00, 0x10, 0x00, 0x80,
            0x00, 0x08, 0x00, 0x04, 0x00, 0x40, 0x00, 0x02
        ]

        sine_program = [
            0b10011100, 0b00011000,     # 0000:0:0: map_start 0x18 (word-sized SRAM address)
            0b10011100, 0b10100001,     # 0002:0:1: load_end 0x21 (word-sized SRAM address)
            0b00000100, 0x40,           # 0004:0:2: Ramp up by 0x40 over 2 x 0.488ms
            0b10011101, 0b10000000,     # 0006:0:3: map_next
            0b10100000, 0b00000010,     # 0008:0:4: branch to step 2, forever
            0b10011110, 0b00011000,     # 000A:1:0: load_start 0x18
            0b10011100, 0b10100001,     # 000C:1:1: load_end 0x21
            0b10011111, 0b10100000,     # 000E:1:2: map_addr 0x20
            0b00000101, 0x40,           # 0010:1:3: ramp down by 0x40 over 2 x 0.488ms
            0b10011101, 0b10000000,     # 0012:1:4: map_next
            0b10100000, 0b00000011,     # 0014:1:5: branch to step 3, forever
            0b00000000, 0b00000000,     # 0016:u:7: rst
            0b00000000, 0b00000000,     # 0018:u:5: rst
            0b00000000, 0b00000000,     # 001A:u:6: rst
            0b00000000, 0b00000000,     # 001C:u:7: rst
            0b00000000, 0b00000000,     # 001E:u:7: rst
            0b00000000, 0b00000000,     # 0020:u:5: rst
            0b00000000, 0b00000000,     # 0022:u:6: rst
            0b00000000, 0b00000000,     # 0024:u:7: rst
            0b00000000, 0b00000000,     # 0026:u:7: rst
            0b00000000, 0b00000000,     # 0028:u:5: rst
            0b00000000, 0b00000000,     # 002A:u:6: rst
            0b00000000, 0b00000000,     # 002C:u:7: rst
            0b00000000, 0b00000000,     # 002E:u:7: rst
            0b00000000, 0b00000001,     # 0030:u:x: map LED 0
            0b00000000, 0b00000011,     # 0032:u:x: map LEDs 0, 1
            0b00000000, 0b00000110,     # 0034:u:x: map LEDs 1, 2
            0b00000000, 0b00001100,     # 0036:u:x: map LEDs 2, 3
            0b00000000, 0b00011000,     # 0038:u:x: map LEDs 3, 4
            0b00000000, 0b00110000,     # 003A:u:x: map LEDs 4, 5
            0b00000000, 0b01100000,     # 003C:u:x: map LEDs 5, 6
            0b00000000, 0b11000000,     # 003E:u:x: map LEDs 6, 7
            0b00000001, 0b10000000,     # 0040:u:x: map LEDs 7, 8
            0b00000001, 0b00000000,     # 0042:u:x: map LED 8
            # 0b00000000, 0b00000000,     # 0044:u:x: unmap all LEDs
        ]

        program = sine_program
        #program = scanner_program

        print("Loading program: {0}".format(program))
        self.load_program(engine=demo_engine, start_page=0, program=program, offset=0)
        self.set_engine_program_start(engine=demo_engine, start_addr=0, pc=0)
        self.set_engine_program_start(engine=1, start_addr=5, pc=0)
        # print("Enabling internal clock AGAIN")
        # self.reg[MISC] = 0x49
        # self.reg[IO_CONTROL] = 0x8
        self.dump_engine_status()
        #print("Starting engine {0} (engine {1} in docs)".format(demo_engine, demo_engine+1))
        #self.start_engine(demo_engine, RUNMODE_FREE)

        self.reg[LED_ENGINE_CONTROL1] = 0b10101000  # XXX integrate this into start_engine; no engine can be in
        self.reg[LED_ENGINE_CONTROL2] = 0b10101000  # XXX load_sram state if you want the program to run.

        # for i in range(0, 60):
        #     self.dump_engine_status()
        #     time.sleep(1)
        while True:
            time.sleep(1)

    def dump_engine_status(self, dump_pc=False):
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
            if dump_pc:
                engine_status[k].append('PC={0}'.format(self.reg[ENGINE1_PC + i]))
        print("\x1b[0;32mDEBUG\x1b[0m: ", end='')
        for k, v in engine_status.items():
            print("{0}: {1}  ".format(k, v), end='')
        print("engine status={0:#010b} ({0:#04x})".format(self.reg[ENGINE_STATUS]))

if __name__ == '__main__':
    # lp = LP5569()
    lp = LP5569(0, 0x35)
    lp.demo()
