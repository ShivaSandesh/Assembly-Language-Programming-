# Assignment 4 Ex 6
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
	

next2:  beq	$t1, $t2,rev    # done printing the arrray so reverse 
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
	j	next2		# j to the next2
	nop 

rev:	addi	$t0, $t0, -4	# $t0 points to array[9], $t0 was never changed
	li	$t1, 0		# counter for index
	la	$t3, array
	la	$a0, endl
	syscall
swap:	bge	$t3, $t0, done	# compare the address and stop when done
	lw	$t4, ($t0)	# load the address
	nop
	lw	$t5, ($t3)
	nop
	sw	$t4, ($t3)	# not putting the nop helps in this case
	sw	$t5, ($t0)
	nop
	addi	$t0, $t0, -4	# move to the previous element 
	addi	$t3, $t3, 4	# move to next element
	b	swap
	nop

done:	la	$t3, array	# $t3 points 
	li	$t2, 10		# maximum index for the array
	

next3:  beq	$t1, $t2,final  # done printing the arrray so reverse 
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
	j	next3		# j to the next2
	nop 
final:	li	$v0, 10
	syscall
	
