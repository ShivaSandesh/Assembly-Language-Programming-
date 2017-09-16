.data
display:.asciiz "ZYXWVUTSRQPONMLKJIHGFEDCBA \n" 
	.text
	.globl main
main:	la	$s0, display		# load the address of the display string 
        lb	$t0, ($s0)		# load the current character to $t0
	nop
toglch: beqz	$t0, endIt		# if $t0==null stop processing the string
	nop
	li	$t1, 0x41		# $t1 = 'A'
	blt	$t0, $t1, gnext
	nop
	li	$t1, 0x5a		# $t1 = 'Z'
	ble	$t0, $t1, lower
	nop
	li	$t1, 0x61		# $t1 = 'a'
	blt	$t0, $t1, gnext
	nop
	li	$t1, 0x7a		# $t1 = 'z'
	ble	$t0, $t1, upper
	nop
lower:	addiu	$t0, $t0, 32
	b	gnext
	nop
upper:	addiu	$t0, $t0, -32
	b	gnext	
	nop
gnext:	sb	$t0, ($s0)
	nop
	addiu	$s0, $s0,1
	lb	$t0, ($s0)		# load the current character to $t0
	nop
	b	toglch	
	nop
endIt:	la	$a0, display
	li	$v0, 4
        syscall
	li	$v0, 10
	syscall