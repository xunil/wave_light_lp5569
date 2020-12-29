( LP5569 Assembler )

128 chars allocate drop constant prog
prog 128 chars erase

variable pc
0 pc !

: step 				\ Branches are made to step number, not memory byte number;
	pc @ 2 /		\ instructions are always 2 bytes long
	;

: curaddr
	prog pc @ +
	;

: nextpc!
	2 pc +!
	;

variable mode		\ address mode; 0=immediate -1=variable
0 mode !

: imm! 0 mode ! ;
: var! -1 mode ! ;
: mode? mode @ ;

: prescale 1 ;
: noprescale 0 ;
: sign+ 0 ;
: sign- 1 ;

: << lshift ;
: >> rshift ;

: label
	prog pc @ +
	constant
	;

: register
	create c,
	does> var! c@
	;

0 register %a
1 register %b
2 register %c
3 register %d

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
		\ 2 roll or
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
	mode? if			\ Variable address mode
		0 or 			\ variable for num increments
		swap 2 << or 	\ variable for step time
		swap 4 << or 	\ sign
		swap 5 << or 	\ prescale
		84				\ MSB
	else				\ Immediate address mode
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
	imm!			\ for good measure
	;

prog 10 dump
map_next
int
load_next
rst
map_clr
prog 10 dump