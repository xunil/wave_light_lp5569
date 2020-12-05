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
Text GLabel 3140 3790 2    50   Input ~ 0
ADDR
Text GLabel 2640 4180 0    50   Input ~ 0
SDA
Text GLabel 2640 3990 0    50   Input ~ 0
SCL
Text GLabel 2640 4370 0    50   Input ~ 0
VIN
Text GLabel 2640 3790 0    50   Input ~ 0
GND
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
Text GLabel 8400 3410 0    50   Input ~ 0
LED0
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
Text GLabel 8400 3510 0    50   Input ~ 0
LED1
Text GLabel 8400 3610 0    50   Input ~ 0
LED2
Text GLabel 8400 3710 0    50   Input ~ 0
LED3
Text GLabel 8400 3810 0    50   Input ~ 0
LED4
Text GLabel 8400 3910 0    50   Input ~ 0
LED5
Text GLabel 8400 4010 0    50   Input ~ 0
LED6
Text GLabel 8400 4110 0    50   Input ~ 0
LED7
Text GLabel 8400 4210 0    50   Input ~ 0
LED8
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
F 2 "Connector_JST:JST_PH_B6B-PH-K_1x06_P2.00mm_Vertical" H 2050 5400 50  0001 C CNN
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
Text Notes 2420 3590 0    50   ~ 0
Address Selection
Text Notes 1900 4950 0    50   ~ 0
Logic Inputs
Text Notes 7190 880  0    50   ~ 0
LED Power Rail Selection
Text Notes 8050 3260 0    50   ~ 0
LED Connections
Text GLabel 3400 5200 2    50   Input ~ 0
SCL
Text GLabel 3400 5300 2    50   Input ~ 0
SDA
Text GLabel 3400 5500 2    50   Input ~ 0
CLK
Text GLabel 3400 5400 2    50   Input ~ 0
EN_PWM
Text GLabel 3400 5600 2    50   Input ~ 0
GPIO_TRIG_INT
$Comp
L power:GND #PWR0107
U 1 1 5EE99CA4
P 3400 5700
F 0 "#PWR0107" H 3400 5450 50  0001 C CNN
F 1 "GND" H 3470 5530 50  0000 R CNN
F 2 "" H 3400 5700 50  0001 C CNN
F 3 "" H 3400 5700 50  0001 C CNN
	1    3400 5700
	1    0    0    -1  
$EndComp
Text Notes 3070 4940 0    50   ~ 0
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
Text Notes 1890 3820 0    50   ~ 0
32h and 40h
Text Notes 1890 4030 0    50   ~ 0
33h and 40h
Text Notes 1890 4210 0    50   ~ 0
34h and 40h
Text Notes 1890 4400 0    50   ~ 0
35h and 40h
Text Notes 1990 4580 0    50   ~ 0
Add 10h to individual address for LP5569A
Text Notes 4850 2850 0    50   ~ 0
LED Controller
Text Notes 6890 1450 0    50   ~ 0
Use Charge Pump Output
Text Notes 7240 1050 0    50   ~ 0
Use Input Voltage
Text Notes 7230 1240 0    50   ~ 0
Common Pin
Wire Wire Line
	2300 2650 2300 2300
Connection ~ 2300 2300
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
$Comp
L Connector:Conn_01x09_Male J5
U 1 1 5FBC5965
P 8600 3810
F 0 "J5" H 8572 3784 50  0000 R CNN
F 1 "Conn_01x09_Male" H 8572 3693 50  0000 R CNN
F 2 "Connector_JST:JST_PH_B9B-PH-K_1x09_P2.00mm_Vertical" H 8600 3810 50  0001 C CNN
F 3 "~" H 8600 3810 50  0001 C CNN
	1    8600 3810
	-1   0    0    -1  
$EndComp
$Comp
L Connector:Conn_01x06_Male J3
U 1 1 5EE99C99
P 3200 5400
F 0 "J3" H 3310 5780 50  0000 C CNN
F 1 "Conn_01x06_Male" H 3310 5700 50  0000 C CNN
F 2 "Connector_JST:JST_PH_B6B-PH-K_1x06_P2.00mm_Vertical" H 3200 5400 50  0001 C CNN
F 3 "~" H 3200 5400 50  0001 C CNN
	1    3200 5400
	1    0    0    -1  
$EndComp
$Comp
L Jumper:SolderJumper_2_Open JP1
U 1 1 5FBD2264
P 2790 3790
F 0 "JP1" H 2790 3880 50  0000 C CNN
F 1 "SolderJumper_2_Open" H 2140 3790 50  0001 C CNN
F 2 "Jumper:SolderJumper-2_P1.3mm_Open_RoundedPad1.0x1.5mm" H 2790 3790 50  0001 C CNN
F 3 "~" H 2790 3790 50  0001 C CNN
	1    2790 3790
	1    0    0    -1  
$EndComp
$Comp
L Jumper:SolderJumper_2_Open JP2
U 1 1 5FBD3335
P 2790 3990
F 0 "JP2" H 2790 4080 50  0000 C CNN
F 1 "SolderJumper_2_Open" H 2140 3990 50  0001 C CNN
F 2 "Jumper:SolderJumper-2_P1.3mm_Open_RoundedPad1.0x1.5mm" H 2790 3990 50  0001 C CNN
F 3 "~" H 2790 3990 50  0001 C CNN
	1    2790 3990
	1    0    0    -1  
$EndComp
$Comp
L Jumper:SolderJumper_2_Open JP3
U 1 1 5FBD370A
P 2790 4180
F 0 "JP3" H 2790 4260 50  0000 C CNN
F 1 "SolderJumper_2_Open" H 2140 4180 50  0001 C CNN
F 2 "Jumper:SolderJumper-2_P1.3mm_Open_RoundedPad1.0x1.5mm" H 2790 4180 50  0001 C CNN
F 3 "~" H 2790 4180 50  0001 C CNN
	1    2790 4180
	1    0    0    -1  
$EndComp
$Comp
L Jumper:SolderJumper_2_Open JP4
U 1 1 5FBD3AC0
P 2790 4370
F 0 "JP4" H 2790 4450 50  0000 C CNN
F 1 "SolderJumper_2_Open" H 2130 4350 50  0001 C CNN
F 2 "Jumper:SolderJumper-2_P1.3mm_Open_RoundedPad1.0x1.5mm" H 2790 4370 50  0001 C CNN
F 3 "~" H 2790 4370 50  0001 C CNN
	1    2790 4370
	1    0    0    -1  
$EndComp
Wire Wire Line
	3020 3790 3020 3990
Wire Wire Line
	2940 3990 3020 3990
Wire Wire Line
	3020 3990 3020 4180
Wire Wire Line
	3020 4180 2940 4180
Connection ~ 3020 3990
Wire Wire Line
	3020 4180 3020 4370
Wire Wire Line
	3020 4370 2940 4370
Connection ~ 3020 4180
Wire Wire Line
	2940 3790 3020 3790
Wire Wire Line
	3020 3790 3140 3790
Connection ~ 3020 3790
$Comp
L Jumper:SolderJumper_3_Bridged12 JP5
U 1 1 5FBEB610
P 8130 1210
F 0 "JP5" V 8130 1278 50  0000 L CNN
F 1 "SolderJumper_3_Bridged12" V 8175 1277 50  0001 L CNN
F 2 "Jumper:SolderJumper-3_P1.3mm_Bridged12_RoundedPad1.0x1.5mm" H 8130 1210 50  0001 C CNN
F 3 "~" H 8130 1210 50  0001 C CNN
	1    8130 1210
	0    1    1    0   
$EndComp
Text GLabel 7980 1210 0    50   Input ~ 0
VLED
Text GLabel 8130 1410 0    50   Input ~ 0
VOUT
Text GLabel 8130 1010 0    50   Input ~ 0
VIN
$Comp
L Connector:Conn_01x09_Male J2
U 1 1 5FC0C417
P 8600 4790
F 0 "J2" H 8572 4764 50  0000 R CNN
F 1 "Conn_01x09_Male" H 8572 4673 50  0000 R CNN
F 2 "Connector_JST:JST_PH_B9B-PH-K_1x09_P2.00mm_Vertical" H 8600 4790 50  0001 C CNN
F 3 "~" H 8600 4790 50  0001 C CNN
	1    8600 4790
	-1   0    0    -1  
$EndComp
Text GLabel 8280 4390 0    50   Input ~ 0
VLED
Wire Wire Line
	8280 4390 8340 4390
Wire Wire Line
	8340 4390 8340 4490
Wire Wire Line
	8340 5190 8400 5190
Connection ~ 8340 4390
Wire Wire Line
	8340 4390 8400 4390
Wire Wire Line
	8340 5090 8400 5090
Connection ~ 8340 5090
Wire Wire Line
	8340 5090 8340 5190
Wire Wire Line
	8340 4990 8400 4990
Connection ~ 8340 4990
Wire Wire Line
	8340 4990 8340 5090
Wire Wire Line
	8340 4890 8400 4890
Connection ~ 8340 4890
Wire Wire Line
	8340 4890 8340 4990
Wire Wire Line
	8340 4790 8400 4790
Connection ~ 8340 4790
Wire Wire Line
	8340 4790 8340 4890
Wire Wire Line
	8340 4690 8400 4690
Connection ~ 8340 4690
Wire Wire Line
	8340 4690 8340 4790
Wire Wire Line
	8340 4590 8400 4590
Connection ~ 8340 4590
Wire Wire Line
	8340 4590 8340 4690
Wire Wire Line
	8340 4490 8400 4490
Connection ~ 8340 4490
Wire Wire Line
	8340 4490 8340 4590
$Comp
L Mechanical:MountingHole H1
U 1 1 5FC5DE4F
P 8240 2130
F 0 "H1" H 8340 2176 50  0000 L CNN
F 1 "MountingHole" H 8340 2085 50  0000 L CNN
F 2 "MountingHole:MountingHole_2.7mm" H 8240 2130 50  0001 C CNN
F 3 "~" H 8240 2130 50  0001 C CNN
	1    8240 2130
	1    0    0    -1  
$EndComp
$Comp
L Mechanical:MountingHole H2
U 1 1 5FC5E5F8
P 8240 2320
F 0 "H2" H 8340 2366 50  0000 L CNN
F 1 "MountingHole" H 8340 2275 50  0000 L CNN
F 2 "MountingHole:MountingHole_2.7mm" H 8240 2320 50  0001 C CNN
F 3 "~" H 8240 2320 50  0001 C CNN
	1    8240 2320
	1    0    0    -1  
$EndComp
$Comp
L Mechanical:MountingHole H3
U 1 1 5FC5E93F
P 8240 2510
F 0 "H3" H 8340 2556 50  0000 L CNN
F 1 "MountingHole" H 8340 2465 50  0000 L CNN
F 2 "MountingHole:MountingHole_2.7mm" H 8240 2510 50  0001 C CNN
F 3 "~" H 8240 2510 50  0001 C CNN
	1    8240 2510
	1    0    0    -1  
$EndComp
Text Notes 1780 6550 0    50   ~ 0
TODO: \nFigure out external clock; internal clock doesn't want to come out the clock pin\n\n
$EndSCHEMATC
