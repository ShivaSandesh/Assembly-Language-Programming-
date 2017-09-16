# Shiva Sandesh
# reading the inut form the keyboard

	.data
pMsg:	.asciiz	"\n Enter an integer (You will see it ASCII eqivalent)\n"

	.text
	.globl	main
main:	la	$a0, pMsg		# prompt for a string
	jal	printIt			# without syscall
	nop
	jal	readIt
	nop
	#sw	$v0, aa
	#nop
	addiu	$a0, $v0, -48
	li	$v0, 1
	syscall
	la	$a0, pMsg		# prompt for a string
	jal	printIt			# without syscall
	nop
	jal	readIt
	nop
	#sw	$v0, bb
	#nop
	move	$a0, $v0
	li	$v0, 1
	syscall
	li	$v0, 10
	syscall

readIt:	li $t0, 0xffff0000
rd_poll:lw 	$v0, 0($t0)
	andi 	$v0, $v0, 0x01
	beq 	$v0, $zero, rd_poll
	lw 	$v0, 4($t0)
	nop
	jr	$ra
	nop
printIt:
	li	$a3, 0xffff0000		# base of memory-mapped IO area
ploop:	lw	$t1, 8($a3)		# extract transmitter control
	nop
	andi	$t1, $t1, 0x0001	# mask off ready bit
	beqz	$t1, ploop
	nop
	lb	$t0, ($a0)		# extract next character
	nop
	beqz	$t0, pexit		# find the 0 byte? Yes == exit
	nop
	sw	$t0, 12($a3)		# write character to display
	addiu	$a0, $a0, 1		# advance to next character
	j	ploop			# and try again
	nop
pexit:	jr	$ra
	nop	