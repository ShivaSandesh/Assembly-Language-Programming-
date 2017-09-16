# Alex Wolski && Shiva Sandesh
# CS21 Lab 5 part 2
# 3/12/2016
# Process an array by applying an averaging filter to it.

	.data
size:   .word	12
aText:	.asciiz "The given 'array' : \n"
rText:	.asciiz "\nThe result of applying an averaging filter : \n"
comma:  .asciiz ", "
array:  .word	50, 53, 52, 49, 48, 51, 99, 45, 53, 47, 47, 50
result: .word	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0

	.globl main
	.text
	
main: 	la	$t0, array	# pointer to array
      	la	$t1, result	# pointer to result
	li	$t2, 1		# counter variable
	lw	$t3, size	# for the index of array 
	li	$t4, 3		# for the average of three terms

	# copy the first elemnet of 'array' to 'result' unchanged
	lw	$t5, ($t0)	# load 50 in $t5, 
	nop
	sw	$t5, ($t1)	# Mem[$t1 + 0 (offset) ] = $t5
	addi	$t0, $t0, 4	# array ptr points to next element 
	addi	$t1, $t1, 4	# result ptr points to next element 
	addi	$t2, $t2, 1	# increment counter

	# Process 'array' by applying an avg. filter to it. 

filter: bge	$t2, $t3, done	# branch to done when index is 11
	nop			# branch delay
	lw	$t5, ($t0)	# load current value into $t5
	lw	$t6, -4($t0)	# load prev value to $t6
	nop 
	add	$t5, $t5, $t6	# $t5 store sum of two numbers
	lw	$t6, 4($t0)	# load next element $t6
	nop
	add	$t5, $t5, $t6	# $t5 stores sum of three elements
	div	$t5, $t4	# divide sum by 3 to get average
	mflo	$t5		# move average into $t5
	nop
	sw	$t5, ($t1)	# Mem[$t1 + 0 (offset) ] = $t5
	addi	$t2, $t2, 1	# increment counter
	addi	$t0, $t0, 4	# array ptr points to next element 
	addi	$t1, $t1, 4	# result ptr points to next element 
	b	filter		# branch back to beginning of loop
	nop

	# Now copy the last element from the 'array' to 'result'

done:	lw	$t5, ($t0)	# load last element of array into $t5
	nop
	sw	$t5, ($t1)	# store last element of array to result
	nop

	# Printing the arrays
	la	$a0, aText	#Print message
	li	$v0, 4
	syscall
	la	$t0, array	# ptr reset to begning of 'array'
	li	$t2, 0		# counter = 0

printArray:
	bge	$t2, $t3,pArray # branch when count = size
	nop
	lw	$a0, ($t0)	# load elem from array into $a0 for print
	li	$v0, 1		# prep print int syscall
	syscall			# print the int elem
	addi	$t0, 4		# index ptr to next elem
	addi	$t2, 1		# increment count
	la	$a0, comma	# load comma into $a0 for print
	li	$v0, 4		# prep syscall to print string
	syscall			# print comma
	b	printArray	# branch back to beginning
	nop
pArray:	

	# Printing the result
	la	$a0, rText	#Print message
	li	$v0, 4
	syscall
	li	$t2, 0		# reset counter to 0 now that printed
	la	$t1, result	# ptr reset to begning of 'result'
printResult:
	bge	$t2, $t3,pResult 
	nop
	lw	$a0, ($t1)	# load elem from array into $a0 for print
	li	$v0, 1		# prep print int syscall
	syscall			# print the int elem
	addi	$t1, 4		# index ptr to next elem
	addi	$t2, 1		# increment count
	la	$a0, comma	# load comma into $a0 for print
	li	$v0, 4		# prep syscall to print string
	syscall			# print comma
	b	printResult	# branch back to beginning
	nop
pResult:

		


	