# Lab8-Part1.asm
# Yanyin Liu and Shiva Sandesh
# 4/11/2016
# CS21 Lab8-Part1
# Computes the value of triangle numbers using a recursive subroutine.
# Triangle( N <= 1 ) = 1
# Triangle( N > 1 ) = N + Triangle( N-1 )

	.data
prompt:	.asciiz	"Please enter a number,  N: "
result:	.asciiz	"The triangle number is: "
	.text
	.globl main
main:
	la	$a0, prompt		# load the address of the prompt
	li	$v0, 4			# system call code for print string
	syscall
	li	$v0, 5			# system call code for read an integer
	syscall
	addiu	$sp, $sp, -4		# allocate space on the stack
	sw	$v0, ($sp)		# save the N onto the stack
	nop
	jal	triangle		# call triangle subroutine 
	nop
	addiu	$sp, $sp, 4		# deallocate space for parameter
	move	$s0, $v0		# save the returned value to $s0
	la	$a0, result		# load the address of the result
	li	$v0, 4			# system call code for print string
	syscall
	move	$a0, $s0		# $a0=$s0
	li	$v0, 1			# system call code foe print integer
	syscall
	li	$v0, 10			# terminate program return control to system
	syscall

triangle:
	addiu	$sp, $sp, -4		# allocate space on the stack
	sw	$ra, ($sp)		# push $ra
	nop
	addiu	$sp, $sp, -4		# allocate space on the stack
	sw	$fp, ($sp)		# push $fp
	nop
	addiu	$sp, $sp, -4		# allocate space on the stack
	sw	$s0, ($sp)		
	nop
	move	$fp, $sp		# initialize the frame pointer
	lw	$s0, 12($fp)		# get the argument using stack pointer	
	li	$t0, 1			
	bgt	$s0, $t0, loop		# branch to loop if N>1
	nop
	li	$v0, 1			# return value = 1
	b	done
	nop
loop:
	addiu	$t0, $s0, -1		# new argument = N-1
	addiu	$sp, $sp, -4		# allocate space on the stack
	sw	$t0, ($sp)		# push the argument onto the stack
	jal	triangle		
	nop
	addiu	$sp, $sp, 4		# deallocate space for variables
	add	$v0, $s0, $v0		# return value = $s0+triangle($t0)
	
done:
	move	$sp, $fp		# $sp=$fp
	lw	$s0, ($sp)		# pop $s0
	addiu	$sp, $sp, 4		
	lw	$fp, ($sp)		# pop $s0
	addiu	$sp, $sp, 4		
	lw	$ra, ($sp)		# pop $s0
	addiu	$sp, $sp, 4		
	jr	$ra
	nop