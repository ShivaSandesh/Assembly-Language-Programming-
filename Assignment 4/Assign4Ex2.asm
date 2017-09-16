# Assignment 4 Ex2 
# Shiva Sandesh
# 3/19/2016
# Convert first character after every space to upper case 

	.data
string: .asciiz "in a hole in the ground there lived a hobbit"
endl:  .asciiz "\n"

	.text
	.globl main
main:   li	$v0, 4
	la	$a0, string	# Print original string				
	syscall
	li	$t0, ' ' 	# to check if we have space
	la	$t1, string	# $t1 points to the string
	li	$t3, 1		# flag to convert char to upper case
	li 	$t4, 0x20	# offset to convert to upper case

convert:lb	$t2, ($t1)	# $t2 stores character at time
	nop
	beqz	$t2, done	# branch if we got to end of string
	nop
	beq	$t2, $t0, handle # if we have space we handle it
	nop
	bnez	$t3, ToUpper	# branch if we have flag set on
	nop			
	addi	$t1, $t1, 1	# pointer points to next char
	b	convert		# test next char
	nop	

handle: li	$t3, 1		# set flag on 	
	addi	$t1, $t1, 1	# pointer points to next char
	b	convert		# test next char
	nop

ToUpper: li	$t3, 0
	sub	$t2, $t2, $t4	# convert to the lowercase
	sb	$t2, ($t1)	# save the upper case char
	addi	$t1, $t1, 1
	j	convert
	nop

done:	la	$a0, endl	# to print end of line character
	li	$v0, 4
	syscall
	la	$a0, string	# new string after manipulation
	li	$v0, 4
	syscall
	li	$v0, 10
	syscall
	
	
	

	