# Shiva Sandesh
# CS21 Assignment 3 Exercise 1
# 02/26/2015


	.text
	.globl main
main:
	li	$t0, 0		# load 0 into $t0, holds sum
	li	$t1, 1		# load 1 into $t2, holds count
	li	$t2, 101	# load 101 into $t3, holds end counter
loop:
	add	$t0, $t0, $t1	# adds the running counter to sum
	addi	$t1, $t1, 1	# increment running counter	
	blt	$t1, $t2, loop  # re-run the loop while counter < 101
	nop	
	li	$v0, 10		#syscall code 10
	syscall
