\ create a buffer
\ to store an element in the buffer, store the step number, the length of the string, and then the string bytes
\ to find an element in the buffer
\	the tested string and the length of the string should be the top two stack elements.
\	start at the beginning of the buffer, skip the step number
\ 	push the address to the stack
\	push the string length to the stack
\	call str=

decimal

1024 chars allocate drop constant fixup-table
fixup-table 1024 chars erase
variable #fixups
0 #fixups !

: fixup-ofs
	32 * fixup-table +
	;

\ Add an entry to the fixup table.
( c-addr u -- )
: >fixup
	#fixups @
	fixup-ofs dup	 	\ Calculate offset to the next free space in the table ( c-addr u fixup-ofs fixup-ofs )
	$ff swap c! 		\ Store flag byte (FF = stepnum not yet known)  ( c-addr u fixup-ofs )
	over				\ ( c-addr u fixup-ofs u )
	over 1+				\ ( c-addr u fixup-ofs u fixup-ofs+1 )
	c!					\ ( c-addr u fixup-ofs )
	2 +					\ ( c-addr u fixup-ofs+2 )
	swap				\ ( c-addr fixup-ofs+2 u )
	move				\ ( -- )
	#fixups dup @ 1+ swap !
	;

\ Retrieve an entry from the fixup table
( n -- stepnum c-addr u )
: fixup>
	32 * fixup-table + dup 		\ Calculate offset to the indicated record and duplicate it on the stack ( n -- addr addr )
	c@ swap dup 1 cells +		\ Fetch the step number ( addr addr -- addr c -- c addr -- c addr addr -- c addr addr+1 )
	c@ swap 2 cells + swap		\ ( c addr addr+1 -- c addr u -- c u addr+2 -- c addr+2 u )
	;

( c-addr u -- fixupnum|0 )
: find-fixup
	0 -rot					\ ( c-addr u -- 0 c-addr u )
	cr
	#fixups @ 0 ?do
		2dup
		." find-fixup 1: " .s cr
		i fixup-ofs			\ Calculate offset to the i'th fixup
		." find-fixup 2: " .s cr
		1+ dup 1+			\ ( c-addr1 u1 f-ofs+1 f-ofs+2 )
		." find-fixup 3: " .s cr
		swap c@				\ ( c-addr1 u1 c-addr2 u2 )
		." find-fixup 4: " .s cr
		str= if
			." find-fixup 5: " .s cr
			drop drop drop
			i leave
		then
	loop
	." find-fixup 6: " .s cr
	;