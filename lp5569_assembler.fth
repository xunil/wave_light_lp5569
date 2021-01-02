( LP5569 Assembler )

\ Allocate program space from the heap and give it a name
128 chars allocate drop constant prog
prog 128 chars erase

\ Keeps track of our position in program memory
variable pc
0 pc !

: step 				\ Branches are made to step number, not memory byte number;
	pc @ 2 /		\ instructions are always 2 bytes long
	;

: curaddr prog pc @ + ;
: nextpc! 2 pc +! ;
: 0pc! 0 pc ! ;

variable mode		\ address mode; 0=immediate -1=variable
0 mode !

: imm! 0 mode ! ;
: var! -1 mode ! ;
: mode? mode @ ;

1 constant prescale
0 constant noprescale
0 constant sign+	\ TODO: Automatically determine sign and drop these constants.
1 constant sign-

0 constant noint
1 constant doint
0 constant noreset
1 constant doreset

: << lshift ;
: >> rshift ;

: label	
	pc @ 2/
	constant
	;

: register
	create c,
	does> var! c@
	;

0 register ra
1 register rb
2 register rc
3 register rd

\ Store instruction in the program
\ ( c c c-addr -- )
: instr!
	tuck c! 1+ c!
	;

\ Fetch instruction bytes from the dictionary entry for the defined word
\ ( c-addr -- c c )
: instr@
	dup c@ swap 1+ c@
	;

\ instruction with no arguments are created with this defining word
: instr
	create c, c,
	does> 
		instr@
		curaddr instr!
		nextpc!
	;

\ instruction requiring simple OR of operand
\ Only immediate mode is valid for instructions created with this defining word
: instr_or
	create c, c,
	does>
		instr@
		\ 2 roll or 			\ XXX: Is this word done?
		-rot or swap
		curaddr instr!
		nextpc!
	;

hex

\ Zero-argument instructions
00 00 instr rst
9d 00 instr map_clr
9d 80 instr map_next   
9d c0 instr map_prev
9d 81 instr load_next
9d c1 instr load_prev
c4 00 instr int
e0 00 instr trig_clear 

\ 1-argument immediate mode instructions
9f 00 instr_or load_addr
9f 80 instr_or map_addr
9e 00 instr_or load_start
9c 00 instr_or map_start
9c 80 instr_or load_end
9d 00 instr_or map_sel

\ Multi-mode instructions
: set_pwm 
	mode? if 
		60 or 84	\ Variable address mode
	else
		0 or 40		\ Immediate address mode
	then
	curaddr instr!
	nextpc!
	imm!			\ Back to immediate mode
	;

( prescale sign %steptime %numincr -- )	\ Variable mode
( prescale steptime sign numincr -- )	\ Immediate mode
: ramp
	cr
	mode? if			\ -- Variable address mode
		0 or 			\ variable for num increments
		swap 2 << or 	\ variable for step time
		swap 4 << or 	\ sign
		swap 5 << or 	\ prescale
		84				\ MSB
	else				\ -- Immediate address mode
		-rot			\ ( prescale steptime sign numincr -- prescale numincr steptime sign )
		swap 1 << or 	\ ( prescale numincr steptime sign -- prescale numincr MSB )
		rot 6 << or 	\ ( prescale numincr MSB -- numincr(LSB) MSB )
	then
	curaddr instr!
	nextpc!
	imm!
	;

( prescale time -- )
: wait
	1 << swap
	6 << or
	0 swap
	curaddr instr!
	nextpc!
	imm!
	;

( doint doreset -- )
: end
	3 << 0 or
	swap
	4 << or
	0 swap
	c0 or
	curaddr instr!
	nextpc!
	imm!
	;

( loopcnt stepnum -- )
: branch
	mode? if			\ -- Variable address mode
		dup 40 and		\ ( loopcnt stepnum -- loopcnt stepnum stepnum[7] )
		86 or 			\ ( loopcnt stepnum stepnum[7] -- loopcnt stepnum MSB )
		-rot			\ ( loopcnt stepnum MSB -- MSB loopcnt stepnum )
		3f and	 		\ ( MSB loopcnt stepnum -- MSB loopcnt stepnum[6:0] )
		2 << or 		\ ( MSB loopcnt stepnum[6:0] -- MSB LSB )
		swap			\ ( MSB LSB -- LSB MSB )
	else				\ -- Immediate address mode
		over			\ ( loopcnt stepnum -- loopcnt stepnum loopcnt )
		1 and			\ ( loopcnt stepnum loopcnt -- loopcnt stepnum loopcnt[0] )
		7 << or 		\ ( loopcnt stepnum loopcnt[0] -- loopcnt LSB )
		swap 1 >>		\ ( loopcnt LSB -- LSB loopcnt[6:1] )
		a0 or 			\ ( LSB loopcnt[6:1] -- LSB MSB )
	then
	curaddr instr!
	nextpc!
	imm!
	;

( skipcount var1 var2 -- )
: condbranch
	create c, 0 c,
	does>
		instr@			\ ( skipcount var1 var2 -- skipcount var1 var2 MSB LSB )
		rot or 			\ ( skipcount var1 var2 MSB LSB -- skipcount var1 MSB LSB )
		rot 2 << or 	\ ( skipcount var1 MSB LSB -- skipcount MSB LSB )
		-rot swap 		\ ( skipcount MSB LSB -- LSB MSB skipcount )
		4 >> or 		\ ( LSB MSB skipcount -- LSB MSB )
		curaddr instr!
		nextpc!
		imm!
	;

88 condbranch jne
8a condbranch jl
8c condbranch jge
8e condbranch je

\ Testing!
prog 10 dump

label _start
map_next
int
label _donext
load_next
map_clr

1 rb rd jl			\ skip 1 instruction if rb < rd

5 _donext branch
label _dontdonext
noint doreset end

prog 10 dump

