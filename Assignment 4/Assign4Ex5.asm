# Assignment 4 Ex 5
# Shiva Sandesh
# 3/19/2016
# Prompt user for array and find min and max in the array
	.data
array:	.space 40	
prompt:	.asciiz "\n Enter a number: "
endl:	.asciiz "\n"
min:	.asciiz "\n Smallest : "
max: 	.asciiz "\n Largest : "

	.text
	.globl main
main:	la	$t0, array	# $t0 is pointer to array[0]
	li	$t1, 0		# counter for index
	li	$t2, 10		# maximum index for the array

getNum: beq	$t1, $t2,next	# stop reading if counter is max Index
	nop
	li	$v0, 4		# print the prompt
	la	$a0, prompt
	syscall
	li	$v0, 5		# get the number
	syscall
	sw	$v0, ($t0)	# store the number in array
	
	addi	$t1, $t1, 1	# increment the counter
	addi	$t0, $t0, 4	# increase pointer up 4 bytes to next int
	b	getNum		# repeat until counter == 10
	nop
	
	# finding the minimum and maximum in an array

next:	la	$t0, array	# $t0 is pointer to array[0] for searching
	li	$t1, 0		# counter for index
	lw	$t3, ($t0)	# initialize min with array[0]
	lw	$t4, ($t0)	# initialize max with array[0]
	addi	$t1, $t1, 1	# increment count
	addi	$t0, $t0, 4	# pointer points to next element in array

search:	beq	$t1, $t2, done	# done with traversing through array
	nop
	lw	$t5, ($t0)	# $t5 contains the value in address $t0
	nop
	blt	$t5, $t3, small	# if array[element] < min, branch to small
	nop
	bgt	$t5, $t4, big	# if array[element] > max branch to big
	nop	
	addi	$t1, $t1, 1	# increment count
	addi	$t0, $t0, 4	# pointer points to next element in array
	j	search
	nop
small:	or	$t3, $t5, $zero	# set $t3 to $t0 if $t0 < $t3
	addi	$t1, $t1, 1	# increment count
	addi	$t0, $t0, 4	# pointer points to next element in array
	j	search
	nop

big:	or	$t4, $t5, $zero	# set $t4 to $t0 if $t0 > $t4
	addi	$t1, $t1, 1	# increment count
	addi	$t0, $t0, 4	# pointer points to next element in array
	j	search
	nop

done:	li	$v0, 4
	la	$a0, min
	syscall
	or	$a0, $t3, $zero
	li	$v0, 1
	syscall

	li	$v0, 4
	la	$a0, max
	syscall
	or	$a0, $t4, $zero
	li	$v0, 1
	syscall
	li	$v0, 10
	syscall
	

