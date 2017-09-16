# Shiva Sandesh
# CS21 Assignment 3 Exercise 2
# 02/26/2015
# Assign3Ex1

	.text
	.globl main
main:
	li	$t0, 0		# $t0=0, holds sum of even terms
	li	$t1, 0		# $t1=0, holds sum of odd terms
	li	$t2, 0		# $t2=0, holds sum of all terms
	li	$t3, 1		# $t3=0, loop counter
	li	$t4, 101	# $t4=101 to hold end count
loop:  
	add	$t1, $t1, $t3	# sums all the odd terms
	add	$t2, $t2, $t3	# sum of all the terms
	addi	$t3, $t3, 1     # increments the loop counter
	add	$t2, $t2, $t3	# sum of all the terms
	add	$t0, $t0, $t3	# sums all the even terms
	addi	$t3, $t3, 1     # increments the loop counter
	blt	$t3, $t4, loop	# re-run loop while counter < 101
	nop
	li	$v0, 10
	syscall
