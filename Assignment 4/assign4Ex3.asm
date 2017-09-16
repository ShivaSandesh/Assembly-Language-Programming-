# Assignment 4 Ex 3
# Shiva Sandesh
# 3/19/2016
# Convert first character after every space to upper case if it is not an upper case

	.data
string: .asciiz "In a hole In the ground There lived a hobbit"
endl:  .asciiz "\n"
space: .asciiz " "

	.text
	.globl main
main:   li	$v0, 4
	la	$a0, string	# Print original string				
	syscall
	li	$t0, ' '	# to check if we have space
	la	$t1, string	# $t1 points to the string
	li	$t3, 1		# flag to convert char to upper case
	li 	$t4, 0x20	# offset to convert to upper case
	li	$t5, 91		# the ascii upper case chars end at 91

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

ToUpper:blt     $t2, $t5, next	# then it is already upper case
	nop
	li	$t3, 0
	sub	$t2, $t2, $t4	# convert to the uppercase
	sb	$t2, ($t1)	# save the upper case char
	addi	$t1, $t1, 1
	j	convert
	nop

next:	sb	$t2, ($t1)	# save the byte
	addi	$t1, $t1, 1	# point to the next byte
	li	$t3, 0		# unset the flag -- important 	
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

	