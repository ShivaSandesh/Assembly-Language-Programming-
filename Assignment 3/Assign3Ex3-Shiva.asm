# Shiva Sandesh
# CS21 Assignment 3 Exercise 3
# 02/26/2015
# Fibonacci series

	.text
	.globl main
main:
	li	$t0, 0		# 0th tern of Fibonacci Series
	li	$t1, 1		# 1 st term of Fibonacci Series
	li	$t2, 99		# $t2 is loop checker 1 less than we need
	li	$t3, 0		# loop counter 
loop:
	addu	$t1, $t1, $t0	# stores current Fibonacci number
	subu	$t0, $t1, $t0	# to save previous term
	add	$t3, $t3, 1	# increement loop counter
	blt 	$t3, $t2, loop	# test condition
	nop
	li	$v0, 10		# for syscall
	syscall

	