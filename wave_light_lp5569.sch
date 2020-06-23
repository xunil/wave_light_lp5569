EESchema Schematic File Version 4
EELAYER 30 0
EELAYER END
$Descr A4 11693 8268
encoding utf-8
Sheet 1 1
Title ""
Date ""
Rev ""
Comp ""
Comment1 ""
Comment2 ""
Comment3 ""
Comment4 ""
$EndDescr
$Comp
L lp5569:LP5569 U2
U 1 1 5EE6C8AA
P 5950 3800
F 0 "U2" H 5950 2677 50  0000 C CNN
F 1 "LP5569" H 5950 2586 50  0000 C CNN
F 2 "Package_DFN_QFN:WQFN-24-1EP_4x4mm_P0.5mm_EP2.6x2.6mm" H 5950 3550 50  0001 C CNN
F 3 "" H 5950 3550 50  0001 C CNN
	1    5950 3800
	1    0    0    -1  
$EndComp
$Comp
L Device:C C4
U 1 1 5EE6D66F
P 5850 2250
F 0 "C4" H 5900 1900 50  0000 R CNN
F 1 "1uF" H 5900 2000 50  0000 R CNN
F 2 "Capacitors_SMD:C_0805_HandSoldering" H 5888 2100 50  0001 C CNN
F 3 "~" H 5850 2250 50  0001 C CNN
	1    5850 2250
	-1   0    0    1   
$EndComp
$Comp
L Device:C C5
U 1 1 5EE6E586
P 6250 2250
F 0 "C5" H 6300 1900 50  0000 R CNN
F 1 "1uF" H 6300 2000 50  0000 R CNN
F 2 "Capacitors_SMD:C_0805_HandSoldering" H 6288 2100 50  0001 C CNN
F 3 "~" H 6250 2250 50  0001 C CNN
	1    6250 2250
	-1   0    0    1   
$EndComp
$Comp
L Connector_Generic:Conn_02x04_Odd_Even J2
U 1 1 5EE6F386
P 2700 4000
F 0 "J2" H 2650 4300 50  0000 L CNN
F 1 "Conn_02x04_Odd_Even" H 2650 4200 50  0000 L CNN
F 2 "Pin_Headers:Pin_Header_Straight_2x04_Pitch2.54mm" H 2700 4000 50  0001 C CNN
F 3 "~" H 2700 4000 50  0001 C CNN
	1    2700 4000
	1    0    0    -1  
$EndComp
Text GLabel 3200 3900 2    50   Input ~ 0
ADDR
Text GLabel 2500 4100 0    50   Input ~ 0
SDA
Text GLabel 2500 4000 0    50   Input ~ 0
SCL
Text GLabel 2500 4200 0    50   Input ~ 0
VIN
Text GLabel 2500 3900 0    50   Input ~ 0
GND
Wire Wire Line
	3000 3900 3100 3900
Wire Wire Line
	3100 3900 3100 4000
Wire Wire Line
	3100 4200 3000 4200
Connection ~ 3100 3900
Wire Wire Line
	3100 3900 3200 3900
Wire Wire Line
	3100 4100 3000 4100
Connection ~ 3100 4100
Wire Wire Line
	3100 4100 3100 4200
Wire Wire Line
	3100 4000 3000 4000
Connection ~ 3100 4000
Wire Wire Line
	3100 4000 3100 4100
Text GLabel 5300 4400 0    50   Input ~ 0
ADDR
Text GLabel 5250 4550 0    50   Input ~ 0
GND
$Comp
L power:GND #PWR0101
U 1 1 5EE78BB0
P 5300 4550
F 0 "#PWR0101" H 5300 4300 50  0001 C CNN
F 1 "GND" H 5305 4377 50  0000 C CNN
F 2 "" H 5300 4550 50  0001 C CNN
F 3 "" H 5300 4550 50  0001 C CNN
	1    5300 4550
	1    0    0    -1  
$EndComp
Wire Wire Line
	5300 4550 5250 4550
Text GLabel 5300 3650 0    50   Input ~ 0
SCL
Text GLabel 5300 3800 0    50   Input ~ 0
SDA
Wire Wire Line
	5650 2500 5650 2100
Wire Wire Line
	5650 2100 5850 2100
Wire Wire Line
	5850 2500 5850 2400
Wire Wire Line
	6050 2500 6050 2100
Wire Wire Line
	6050 2100 6250 2100
Wire Wire Line
	6250 2500 6250 2400
Text GLabel 8150 2550 0    50   Input ~ 0
LED0
Text GLabel 8150 2650 0    50   Input ~ 0
VLED
Text GLabel 6600 3550 2    50   Input ~ 0
LED0
Text GLabel 6600 3700 2    50   Input ~ 0
LED1
Text GLabel 6600 3850 2    50   Input ~ 0
LED2
Text GLabel 6600 4000 2    50   Input ~ 0
LED3
Text GLabel 6600 4150 2    50   Input ~ 0
LED4
Text GLabel 6600 4300 2    50   Input ~ 0
LED5
Text GLabel 6600 4450 2    50   Input ~ 0
LED6
Text GLabel 6600 4600 2    50   Input ~ 0
LED7
Text GLabel 6600 4750 2    50   Input ~ 0
LED8
Text GLabel 8150 2850 0    50   Input ~ 0
LED1
Text GLabel 8150 2950 0    50   Input ~ 0
VLED
Text GLabel 8150 3150 0    50   Input ~ 0
LED2
Text GLabel 8150 3250 0    50   Input ~ 0
VLED
Text GLabel 8150 3450 0    50   Input ~ 0
LED3
Text GLabel 8150 3550 0    50   Input ~ 0
VLED
Text GLabel 8150 3750 0    50   Input ~ 0
LED4
Text GLabel 8150 3850 0    50   Input ~ 0
VLED
Text GLabel 8150 4050 0    50   Input ~ 0
LED5
Text GLabel 8150 4150 0    50   Input ~ 0
VLED
$Comp
L Connector:Conn_01x02_Male J11
U 1 1 5EE7DB80
P 8350 4350
F 0 "J11" H 8322 4324 50  0000 R CNN
F 1 "Conn_01x02_Male" H 8322 4233 50  0000 R CNN
F 2 "Connector_JST:JST_XH_B2B-XH-A_1x02_P2.50mm_Vertical" H 8350 4350 50  0001 C CNN
F 3 "~" H 8350 4350 50  0001 C CNN
	1    8350 4350
	-1   0    0    -1  
$EndComp
Text GLabel 8150 4350 0    50   Input ~ 0
LED6
Text GLabel 8150 4450 0    50   Input ~ 0
VLED
$Comp
L Connector:Conn_01x02_Male J12
U 1 1 5EE7E11A
P 8350 4650
F 0 "J12" H 8322 4624 50  0000 R CNN
F 1 "Conn_01x02_Male" H 8322 4533 50  0000 R CNN
F 2 "Connector_JST:JST_XH_B2B-XH-A_1x02_P2.50mm_Vertical" H 8350 4650 50  0001 C CNN
F 3 "~" H 8350 4650 50  0001 C CNN
	1    8350 4650
	-1   0    0    -1  
$EndComp
Text GLabel 8150 4650 0    50   Input ~ 0
LED7
Text GLabel 8150 4750 0    50   Input ~ 0
VLED
$Comp
L Connector:Conn_01x02_Male J13
U 1 1 5EE7E4EC
P 8350 4950
F 0 "J13" H 8322 4924 50  0000 R CNN
F 1 "Conn_01x02_Male" H 8322 4833 50  0000 R CNN
F 2 "Connector_JST:JST_XH_B2B-XH-A_1x02_P2.50mm_Vertical" H 8350 4950 50  0001 C CNN
F 3 "~" H 8350 4950 50  0001 C CNN
	1    8350 4950
	-1   0    0    -1  
$EndComp
Text GLabel 8150 4950 0    50   Input ~ 0
LED8
Text GLabel 8150 5050 0    50   Input ~ 0
VLED
$Comp
L Connector:Conn_01x03_Male J4
U 1 1 5EE80D99
P 7150 1300
F 0 "J4" H 7258 1581 50  0000 C CNN
F 1 "Conn_01x03_Male" H 7258 1490 50  0000 C CNN
F 2 "Pin_Headers:Pin_Header_Straight_1x03_Pitch2.54mm" H 7150 1300 50  0001 C CNN
F 3 "~" H 7150 1300 50  0001 C CNN
	1    7150 1300
	-1   0    0    -1  
$EndComp
Text GLabel 6950 1200 0    50   Input ~ 0
VIN
Text GLabel 6950 1300 0    50   Input ~ 0
VLED
Text GLabel 6950 1400 0    50   Input ~ 0
VOUT
Text GLabel 7200 3100 2    50   Input ~ 0
VOUT
$Comp
L LP3990:LP3990 U1
U 1 1 5EE83C7D
P 2750 2450
F 0 "U1" H 2750 2915 50  0000 C CNN
F 1 "LP3990" H 2750 2824 50  0000 C CNN
F 2 "TO_SOT_Packages_SMD:SOT-23-5_HandSoldering" H 2750 2850 50  0001 C CNN
F 3 "" H 2750 2450 50  0001 C CNN
	1    2750 2450
	1    0    0    -1  
$EndComp
Text GLabel 1900 2300 0    50   Input ~ 0
VIN
Text GLabel 5300 3250 0    50   Input ~ 0
V1P8
Text GLabel 3650 2300 2    50   Input ~ 0
V1P8
$Comp
L Device:C C1
U 1 1 5EE84967
P 2000 2450
F 0 "C1" H 1885 2404 50  0000 R CNN
F 1 "1uF" H 1885 2495 50  0000 R CNN
F 2 "Capacitors_SMD:C_0805_HandSoldering" H 2038 2300 50  0001 C CNN
F 3 "~" H 2000 2450 50  0001 C CNN
	1    2000 2450
	-1   0    0    1   
$EndComp
Wire Wire Line
	1900 2300 2000 2300
Wire Wire Line
	2000 2300 2300 2300
Connection ~ 2000 2300
$Comp
L power:GND #PWR0102
U 1 1 5EE85873
P 2750 3100
F 0 "#PWR0102" H 2750 2850 50  0001 C CNN
F 1 "GND" H 2755 2927 50  0000 C CNN
F 2 "" H 2750 3100 50  0001 C CNN
F 3 "" H 2750 3100 50  0001 C CNN
	1    2750 3100
	1    0    0    -1  
$EndComp
$Comp
L power:GND #PWR0103
U 1 1 5EE85EBD
P 2000 2600
F 0 "#PWR0103" H 2000 2350 50  0001 C CNN
F 1 "GND" H 2005 2427 50  0000 C CNN
F 2 "" H 2000 2600 50  0001 C CNN
F 3 "" H 2000 2600 50  0001 C CNN
	1    2000 2600
	1    0    0    -1  
$EndComp
$Comp
L Device:C C2
U 1 1 5EE868D0
P 3450 2450
F 0 "C2" H 3335 2404 50  0000 R CNN
F 1 "1uF" H 3335 2495 50  0000 R CNN
F 2 "Capacitors_SMD:C_0805_HandSoldering" H 3488 2300 50  0001 C CNN
F 3 "~" H 3450 2450 50  0001 C CNN
	1    3450 2450
	-1   0    0    1   
$EndComp
$Comp
L power:GND #PWR0104
U 1 1 5EE868D6
P 3450 2600
F 0 "#PWR0104" H 3450 2350 50  0001 C CNN
F 1 "GND" H 3455 2427 50  0000 C CNN
F 2 "" H 3450 2600 50  0001 C CNN
F 3 "" H 3450 2600 50  0001 C CNN
	1    3450 2600
	1    0    0    -1  
$EndComp
Wire Wire Line
	3200 2300 3450 2300
Wire Wire Line
	3650 2300 3450 2300
Connection ~ 3450 2300
Text GLabel 4650 3100 0    50   Input ~ 0
VIN
$Comp
L power:PWR_FLAG #FLG0101
U 1 1 5EE8757A
P 2500 1250
F 0 "#FLG0101" H 2500 1325 50  0001 C CNN
F 1 "PWR_FLAG" H 2500 1423 50  0000 C CNN
F 2 "" H 2500 1250 50  0001 C CNN
F 3 "~" H 2500 1250 50  0001 C CNN
	1    2500 1250
	1    0    0    -1  
$EndComp
$Comp
L power:PWR_FLAG #FLG0102
U 1 1 5EE877AF
P 3400 1250
F 0 "#FLG0102" H 3400 1325 50  0001 C CNN
F 1 "PWR_FLAG" H 3400 1423 50  0000 C CNN
F 2 "" H 3400 1250 50  0001 C CNN
F 3 "~" H 3400 1250 50  0001 C CNN
	1    3400 1250
	1    0    0    -1  
$EndComp
$Comp
L power:GND #PWR0105
U 1 1 5EE87CC7
P 3400 1250
F 0 "#PWR0105" H 3400 1000 50  0001 C CNN
F 1 "GND" H 3405 1077 50  0000 C CNN
F 2 "" H 3400 1250 50  0001 C CNN
F 3 "" H 3400 1250 50  0001 C CNN
	1    3400 1250
	1    0    0    -1  
$EndComp
Text GLabel 2450 1250 0    50   Input ~ 0
VIN
Wire Wire Line
	2450 1250 2500 1250
Text GLabel 2000 1250 0    50   Input ~ 0
V1P8
$Comp
L power:PWR_FLAG #FLG0103
U 1 1 5EE885CC
P 2050 1250
F 0 "#FLG0103" H 2050 1325 50  0001 C CNN
F 1 "PWR_FLAG" H 2050 1423 50  0000 C CNN
F 2 "" H 2050 1250 50  0001 C CNN
F 3 "~" H 2050 1250 50  0001 C CNN
	1    2050 1250
	1    0    0    -1  
$EndComp
Wire Wire Line
	2000 1250 2050 1250
Text GLabel 2900 1250 0    50   Input ~ 0
VOUT
$Comp
L power:PWR_FLAG #FLG0104
U 1 1 5EE88E43
P 2950 1250
F 0 "#FLG0104" H 2950 1325 50  0001 C CNN
F 1 "PWR_FLAG" H 2950 1423 50  0000 C CNN
F 2 "" H 2950 1250 50  0001 C CNN
F 3 "~" H 2950 1250 50  0001 C CNN
	1    2950 1250
	-1   0    0    -1  
$EndComp
Wire Wire Line
	2950 1250 2900 1250
Text GLabel 5300 4100 0    50   Input ~ 0
CLK
Text GLabel 5300 3950 0    50   Input ~ 0
EN_PWM
Text GLabel 5300 4250 0    50   Input ~ 0
GPIO_TRIG_INT
$Comp
L Connector:Conn_01x06_Male J1
U 1 1 5EE92BFD
P 2050 5400
F 0 "J1" H 2158 5781 50  0000 C CNN
F 1 "Conn_01x06_Male" H 2158 5690 50  0000 C CNN
F 2 "Pin_Headers:Pin_Header_Angled_1x06_Pitch2.54mm" H 2050 5400 50  0001 C CNN
F 3 "~" H 2050 5400 50  0001 C CNN
	1    2050 5400
	1    0    0    -1  
$EndComp
Text GLabel 2250 5200 2    50   Input ~ 0
SCL
Text GLabel 2250 5300 2    50   Input ~ 0
SDA
Text GLabel 2250 5500 2    50   Input ~ 0
CLK
Text GLabel 2250 5400 2    50   Input ~ 0
EN_PWM
Text GLabel 2250 5600 2    50   Input ~ 0
GPIO_TRIG_INT
$Comp
L power:GND #PWR0106
U 1 1 5EE94E0F
P 2250 5700
F 0 "#PWR0106" H 2250 5450 50  0001 C CNN
F 1 "GND" H 2255 5527 50  0000 C CNN
F 2 "" H 2250 5700 50  0001 C CNN
F 3 "" H 2250 5700 50  0001 C CNN
	1    2250 5700
	1    0    0    -1  
$EndComp
$Comp
L Device:R_US R1
U 1 1 5EE95F7A
P 4850 1200
F 0 "R1" H 4918 1246 50  0000 L CNN
F 1 "120k" H 4918 1155 50  0000 L CNN
F 2 "Resistors_SMD:R_0805_HandSoldering" V 4890 1190 50  0001 C CNN
F 3 "~" H 4850 1200 50  0001 C CNN
	1    4850 1200
	1    0    0    -1  
$EndComp
Text Notes 2400 1900 0    50   ~ 0
1.8V LDO Regulator
Text Notes 2450 3650 0    50   ~ 0
Address Selection
Text Notes 1900 4950 0    50   ~ 0
Logic Inputs
Text Notes 6600 950  0    50   ~ 0
LED Power Rail Selection
Text Notes 7900 2400 0    50   ~ 0
LED Connections
$Comp
L Connector:Conn_01x06_Female J3
U 1 1 5EE99C99
P 3300 5400
F 0 "J3" H 3200 5800 50  0000 C CNN
F 1 "Conn_01x06_Female" H 3150 5700 50  0000 C CNN
F 2 "Pin_Headers:Pin_Header_Angled_1x06_Pitch2.54mm" H 3300 5400 50  0001 C CNN
F 3 "~" H 3300 5400 50  0001 C CNN
	1    3300 5400
	-1   0    0    -1  
$EndComp
Text GLabel 3500 5700 2    50   Input ~ 0
SCL
Text GLabel 3500 5600 2    50   Input ~ 0
SDA
Text GLabel 3500 5400 2    50   Input ~ 0
CLK
Text GLabel 3500 5500 2    50   Input ~ 0
EN_PWM
Text GLabel 3500 5300 2    50   Input ~ 0
GPIO_TRIG_INT
$Comp
L power:GND #PWR0107
U 1 1 5EE99CA4
P 3500 5200
F 0 "#PWR0107" H 3500 4950 50  0001 C CNN
F 1 "GND" V 3505 5072 50  0000 R CNN
F 2 "" H 3500 5200 50  0001 C CNN
F 3 "" H 3500 5200 50  0001 C CNN
	1    3500 5200
	0    -1   1    0   
$EndComp
Text Notes 3200 4950 0    50   ~ 0
Logic Outputs
$Comp
L Device:C C3
U 1 1 5EEAE369
P 4750 3250
F 0 "C3" H 4635 3204 50  0000 R CNN
F 1 "1uF" H 4635 3295 50  0000 R CNN
F 2 "Capacitors_SMD:C_0805_HandSoldering" H 4788 3100 50  0001 C CNN
F 3 "~" H 4750 3250 50  0001 C CNN
	1    4750 3250
	-1   0    0    1   
$EndComp
$Comp
L power:GND #PWR0108
U 1 1 5EEAEAD6
P 4750 3400
F 0 "#PWR0108" H 4750 3150 50  0001 C CNN
F 1 "GND" H 4755 3227 50  0000 C CNN
F 2 "" H 4750 3400 50  0001 C CNN
F 3 "" H 4750 3400 50  0001 C CNN
	1    4750 3400
	1    0    0    -1  
$EndComp
Wire Wire Line
	4650 3100 4750 3100
Wire Wire Line
	4750 3100 5300 3100
Connection ~ 4750 3100
$Comp
L Device:C C6
U 1 1 5EEB075D
P 7000 3250
F 0 "C6" H 6885 3204 50  0000 R CNN
F 1 "1uF" H 6885 3295 50  0000 R CNN
F 2 "Capacitors_SMD:C_0805_HandSoldering" H 7038 3100 50  0001 C CNN
F 3 "~" H 7000 3250 50  0001 C CNN
	1    7000 3250
	-1   0    0    1   
$EndComp
$Comp
L power:GND #PWR0109
U 1 1 5EEB0763
P 7000 3400
F 0 "#PWR0109" H 7000 3150 50  0001 C CNN
F 1 "GND" H 7005 3227 50  0000 C CNN
F 2 "" H 7000 3400 50  0001 C CNN
F 3 "" H 7000 3400 50  0001 C CNN
	1    7000 3400
	1    0    0    -1  
$EndComp
Wire Wire Line
	6600 3250 6750 3250
Wire Wire Line
	6750 3250 6750 3400
Wire Wire Line
	6750 3400 7000 3400
Connection ~ 7000 3400
Wire Wire Line
	6600 3100 7000 3100
Wire Wire Line
	7000 3100 7200 3100
Connection ~ 7000 3100
$Comp
L Device:R_US R2
U 1 1 5EEB3A50
P 5650 1200
F 0 "R2" H 5718 1246 50  0000 L CNN
F 1 "2.2k" H 5718 1155 50  0000 L CNN
F 2 "Resistors_SMD:R_0805_HandSoldering" V 5690 1190 50  0001 C CNN
F 3 "~" H 5650 1200 50  0001 C CNN
	1    5650 1200
	1    0    0    -1  
$EndComp
$Comp
L Device:R_US R3
U 1 1 5EEB3A56
P 6000 1200
F 0 "R3" H 6068 1246 50  0000 L CNN
F 1 "2.2k" H 6068 1155 50  0000 L CNN
F 2 "Resistors_SMD:R_0805_HandSoldering" V 6040 1190 50  0001 C CNN
F 3 "~" H 6000 1200 50  0001 C CNN
	1    6000 1200
	1    0    0    -1  
$EndComp
Text GLabel 5550 1350 0    50   Input ~ 0
SCL
Text GLabel 6100 1350 2    50   Input ~ 0
SDA
Text GLabel 5550 1050 0    50   Input ~ 0
VIN
Wire Wire Line
	5550 1050 5650 1050
Wire Wire Line
	5650 1050 6000 1050
Connection ~ 5650 1050
Text Notes 5550 950  0    50   ~ 0
I2C Pullups
Text GLabel 4750 1050 0    50   Input ~ 0
VIN
Wire Wire Line
	4750 1050 4850 1050
Text GLabel 4750 1350 0    50   Input ~ 0
GPIO_TRIG_INT
Wire Wire Line
	4750 1350 4850 1350
Wire Wire Line
	5550 1350 5650 1350
Wire Wire Line
	6000 1350 6100 1350
Text Notes 4500 950  0    50   ~ 0
GPIO Pullup
Text Notes 4750 850  0    50   ~ 0
Only populate on first board
Text Notes 1750 3950 0    50   ~ 0
32h and 40h
Text Notes 1750 4050 0    50   ~ 0
33h and 40h
Text Notes 1750 4150 0    50   ~ 0
34h and 40h
Text Notes 1750 4250 0    50   ~ 0
35h and 40h
Text Notes 1950 4400 0    50   ~ 0
Add 10h to individual address for LP5569A
Text Notes 4850 2850 0    50   ~ 0
LED Controller
Text Notes 7200 1450 0    50   ~ 0
Use Charge Pump Output
Text Notes 7200 1250 0    50   ~ 0
Use Input Voltage
Text Notes 7200 1350 0    50   ~ 0
Common Pin
Wire Wire Line
	2300 2650 2300 2300
Connection ~ 2300 2300
$Comp
L Connector:Conn_01x02_Male J10
U 1 1 5EE7D733
P 8350 4050
F 0 "J10" H 8322 4024 50  0000 R CNN
F 1 "Conn_01x02_Male" H 8322 3933 50  0000 R CNN
F 2 "Connector_JST:JST_XH_B2B-XH-A_1x02_P2.50mm_Vertical" H 8350 4050 50  0001 C CNN
F 3 "~" H 8350 4050 50  0001 C CNN
	1    8350 4050
	-1   0    0    -1  
$EndComp
$Comp
L Connector:Conn_01x02_Male J9
U 1 1 5EE7D3E2
P 8350 3750
F 0 "J9" H 8322 3724 50  0000 R CNN
F 1 "Conn_01x02_Male" H 8322 3633 50  0000 R CNN
F 2 "Connector_JST:JST_XH_B2B-XH-A_1x02_P2.50mm_Vertical" H 8350 3750 50  0001 C CNN
F 3 "~" H 8350 3750 50  0001 C CNN
	1    8350 3750
	-1   0    0    -1  
$EndComp
$Comp
L Connector:Conn_01x02_Male J8
U 1 1 5EE7D1FB
P 8350 3450
F 0 "J8" H 8322 3424 50  0000 R CNN
F 1 "Conn_01x02_Male" H 8322 3333 50  0000 R CNN
F 2 "Connector_JST:JST_XH_B2B-XH-A_1x02_P2.50mm_Vertical" H 8350 3450 50  0001 C CNN
F 3 "~" H 8350 3450 50  0001 C CNN
	1    8350 3450
	-1   0    0    -1  
$EndComp
$Comp
L Connector:Conn_01x02_Male J7
U 1 1 5EE7CFF6
P 8350 3150
F 0 "J7" H 8322 3124 50  0000 R CNN
F 1 "Conn_01x02_Male" H 8322 3033 50  0000 R CNN
F 2 "Connector_JST:JST_XH_B2B-XH-A_1x02_P2.50mm_Vertical" H 8350 3150 50  0001 C CNN
F 3 "~" H 8350 3150 50  0001 C CNN
	1    8350 3150
	-1   0    0    -1  
$EndComp
$Comp
L Connector:Conn_01x02_Male J6
U 1 1 5EE7CCB5
P 8350 2850
F 0 "J6" H 8322 2824 50  0000 R CNN
F 1 "Conn_01x02_Male" H 8322 2733 50  0000 R CNN
F 2 "Connector_JST:JST_XH_B2B-XH-A_1x02_P2.50mm_Vertical" H 8350 2850 50  0001 C CNN
F 3 "~" H 8350 2850 50  0001 C CNN
	1    8350 2850
	-1   0    0    -1  
$EndComp
$Comp
L Connector:Conn_01x02_Male J5
U 1 1 5EE7A0CC
P 8350 2550
F 0 "J5" H 8322 2524 50  0000 R CNN
F 1 "Conn_01x02_Male" H 8322 2433 50  0000 R CNN
F 2 "Connector_JST:JST_XH_B2B-XH-A_1x02_P2.50mm_Vertical" H 8350 2550 50  0001 C CNN
F 3 "~" H 8350 2550 50  0001 C CNN
	1    8350 2550
	-1   0    0    -1  
$EndComp
$Comp
L Connector:Conn_01x02_Male J14
U 1 1 5EF1BC1B
P 6150 5650
F 0 "J14" H 6122 5624 50  0000 R CNN
F 1 "Conn_01x02_Male" H 6122 5533 50  0000 R CNN
F 2 "Connector_JST:JST_XH_B2B-XH-A_1x02_P2.50mm_Vertical" H 6150 5650 50  0001 C CNN
F 3 "~" H 6150 5650 50  0001 C CNN
	1    6150 5650
	-1   0    0    -1  
$EndComp
Text GLabel 5950 5750 0    50   Input ~ 0
VIN
Text GLabel 5950 5650 0    50   Input ~ 0
GND
$EndSCHEMATC
