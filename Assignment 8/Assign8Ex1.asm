# Shiva Sandesh
# 4/16/2016
# Assignment 8 Exercise 1
# Recursive function using a stack frame to implement the Fibonacci function,
# with all parameters passed on the stack, not via registers.
	
	.data
prmpt:	.asciiz " Please enter an integer to find Fibonacci number : "
result:	.asciiz " Fibonacci ( " 
paren:	.asciiz " ) = " 

	.text
	.globl main

main:	jal	getNum			# Get an integer from user 
	nop
	addiu	$sp, $sp, -4 
	sw	$v0, ($sp)		# store the number to stack from $v0 
	nop
	jal	fib			# subroutine to calculate nth fibonacci
	nop
	move	$t0, $v0		# move the resulsts from $v0 to $t0
	la	$a0, result
	li	$v0, 4
	syscall
	lw	$a0, ($sp)		# to load "N' which is on stack  already
	nop
	li	$v0, 1			# syscall code print N
	syscall
	la	$a0, paren		# print the string
	li	$v0, 4
	syscall
        addiu	$sp, $sp, 4		# $pop of input from stack
	move	$a0, $t0		# $a0= fib(N), now
	li	$v0, 1
	syscall
	
	li	$v0, 10			# syscall code to end the program
	syscall

	# Subroutine to get a number form user 

getNum:	la	$a0, prmpt		# load and print the prompt
	li	$v0, 4
	syscall
	li	$v0, 5			# get the user data
	syscall 
	jr	$ra			# exit subroutine
	nop

	# Subroutine to calculate nth  fibonacci number 

fib:	addiu	$sp, $sp, -4	
	sw	$ra, ($sp)		# push the return address to stack
	nop
	addiu	$sp, $sp, -4		# push the frame pointer to stack
	sw	$fp, ($sp)
	nop
	addiu	$fp, $sp, -8		# space for local variables
	move	$sp, $fp
	lw	$t0, 16($fp)		# n is 4 words down stack 
	nop
	blez	$t0, rtrn0		# if( n <= 0 ) return 0
	nop
	li	$t1, 1			# for comparison 
	beq	$t1, $t0, rtrn1		# if( n <= 1 ) return 1
	nop
	addiu	$a0, $t0, -1		# to pass to fib(N-1) for recursive call
	addiu	$sp, $sp, -4		# to push N-1 to stack
	sw	$a0, ($sp)		# save the word of to stack
	nop
	jal	fib			# jump and link to fib
	nop
	addiu	$sp, $sp, 4 		
	sw	$v0, 4($fp)		# results back to space saved on stack
	nop
	lw	$t0, 16($fp)		# load n into the $t0 
	nop
	addiu	$a0, $t0, -2		# load $a0 with n-2
	addiu	$sp, $sp, -4		# to push N-1 to stack
	sw	$a0, ($sp)		# save the word of to stack
	nop
	jal	fib			# jump and link to fib
	nop
	addiu	$sp, $sp, 4 		
	sw	$v0, ($fp)		# results back to space saved on stack
	nop
	j	output
	nop

rtrn0:  li	$v0, 0			# if( n <= 0 ) return 0
	j	done
	nop

rtrn1:  li	$v0, 1			# if( n <= 1 ) return 1
	j	done
	nop
output:	lw	$t0, 4($fp)		# load the fib(n-1) to $t0
	nop
	lw	$v0, ($fp)		# load the fib(n-2) to $v0
	nop
	add	$v0, $v0, $t0		# $v0 = fib(n-1)+fib(n-2)
	j	done
	nop

done:   move	$sp, $fp		# $sp=$fp	
	addiu 	$sp, $sp, 8		# pop of the space for local variable
	lw	$fp, ($sp)		# pop off callers frame pointer
	nop
	addiu	$sp,$sp, 4		# move the stack pointer
	lw 	$ra, ($sp)		# pop off caller's return address
	nop
	addiu	$sp, $sp, 4
	jr	$ra
	nop
	
	