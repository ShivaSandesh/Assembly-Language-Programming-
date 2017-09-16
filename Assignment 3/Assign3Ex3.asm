# Shiva Sandesh
# CS21 Assignment 3 Exercise 3
# 02/26/2015
# Fibonacci series

	.text
	.globl main
main:
	li	$t0, 0		# 0th tern of Fibonacci Series
	li	$t1, 1		# 1 st term of Fibonacci Series
	li	$t2, 99		# $t2 is loop checker
	li	$t3, 0		# loop counter 
loop:
	addu	$t1, $t1, $t0
	subu	$t0, $t1, $t0
	add	$t3, $t3, 1
	blt 	$t3, $t2, loop
	nop
	li	$v0, 10
	syscall

	