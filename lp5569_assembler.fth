( LP5569 Assembler )

128 chars allocate drop constant prog

variable pc
0 pc !

: step 				\ Branches are made to step number, not memory byte number;
	pc @ 2 /		\ instructions are always 2 bytes long
	;

: curaddr
	prog pc @ +
	;

variable mode		\ address mode; 0=immediate -1=variable
0 mode !

: imm! 0 mode ! ;
: var! -1 mode ! ;

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

\ ( c c c-addr -- )
: instr!
	tuck c! c!
	;

\ ( c-addr -- )
: instr,
	dup 1+ swap -rot
	c, c,
	;

\ ( c-addr -- c c )
: instr@
	dup 1+ swap -rot
	c@ c@
	;

\ instruction with no arguments
: instr
	create
	instr,
	does> instr@ prog pc @ + instr!
	2 pc +! 
	;

\ instruction requiring simple OR of operand
\ Only immediate mode is valid for instructions using this defining word
: instr_or
	create
	instr,
	does> instr@ 2 roll or prog pc @ + instr!
	2 pc +! 
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
	mode if 
		60 + 84 swap	\ Variable address mode
	else
		0 + 40 swap		\ Immediate address mode
	then
	prog pc @ + 2!
	imm!				\ Back to immediate mode
	;

