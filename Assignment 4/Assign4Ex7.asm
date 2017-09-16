# Assignment 4 Ex 7
# Shiva Sandesh
# 3/19/2016
# Prompt user for array and reverse the elements
	.data
array:	.word 0:10	
prompt:	.asciiz "\n Enter a number: "
tab:	.asciiz "\t"
endl:   .asciiz "\n"

	.text
	.globl main
main:	la	$t0, array	# $t0 is pointer to array[0]
	li	$t1, 0		# counter for index
	li	$t2, 10		# maximum index for the array

getNum: beq	$t1, $t2, next	# stop reading if counter is max Index
	nop
	li	$v0, 4		# print the prompt
	la	$a0, prompt
	syscall
	li	$v0, 5		# get the number
	syscall
	sw	$v0, ($t0)	# store the number in array
	addi	$t1, $t1, 1	# increment the counter
	addi	$t0, $t0, 4	# increase pointer up 4 bytes to next int
	j	getNum		# repeat until counter == 10
	nop

	# print the array before we swap values

next:  	li	$t1, 0		# counter for index
	li	$v0, 4		# next line
	la	$a0, endl
	syscall
	la	$t3, array	# $t3 points 
	li	$t2, 10		# maximum index for the array
	
next1:  beq	$t1, $t2, next2  # done printing the arrray so sort it
	nop
	lw	$t4, ($t3)	# load the actual value
	nop
	or	$a0, $t4, $zero	# or $a0 to return the value 
	li	$v0, 1		# for syscall
	syscall
	li	$v0, 4
	la	$a0, tab	# reusing the $a0 register
	syscall
	addi	$t3, $t3, 4	# point to the next element in the array
	addi	$t1, $t1, 1	# increement the pointer
	j	next1		# j to the next2
	nop

	# sorting the array here

	li	$t0, 9		# loop counter ( the maximum value)

next2:  li	$t1, 0		# to swap; 1 means swap
	li	$t2, 0		# counter set to zero
	la	$t3, array	# base address of array
	ble	$t2, $t0, sort	# branch  to sort if test condition met
	nop
	addi	$t0, $t0, -1	
	bnez	$t1, next2	# if did not swap branch back to next2
	nop
	j	done		#done

sort:   lw	$t4, ($t3)	# load value
	lw	$t5, 4($t3)	# load next value
	nop
	bgt	$t4, $t5, swap	# swap if previous value > next value 
	nop
	addi	$t3, $t3, 4	# advance the pointer and counter
	addi	$t2, $t2, 1
	ble	$t2, $t0, sort	# branch to sort counter smaller than test condition
	nop
	addi	$t0, $t0, -1	
	b	next2		# branch to label next2
	nop

swap:   sw	$t4, 4($t3)	# swap and store 
	sw	$t5, ($t3)	
	addi	$t3, $t3, 4	
	addi	$t2, $t2, 1
	li	$t1, 1		# setflag for the swap tester to 1
	b	sort		# branch to sort
	nop

done:   la	$t0, array	# done checking print now
	li	$t1, 0		
	li 	$t2, 10

prints: lw	$a0, ($t0)	# print each value in array
	li	$v0, 1
	syscall
	la	$a0, tab	# print tab
	li	$v0, 4
	syscall
	
	addi	$t0, $t0, 4	
	addi	$t1, $t1, 1
	blt	$t1, $t2, prints
	nop
	li	$v0, 10
	syscall