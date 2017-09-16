# Assignment 4 Ex1 
# Shiva Sandesh
# 3/19/2016
# Convert upper case string to lower case 


	.data
string: .asciiz "ASSIGNMENTFOUR"
endl:   .asciiz "\n"
	.text
	.globl main

main: 	li	$v0, 4
	la	$a0, string	# Print original string				
	syscall
	la	$t0, string	# $t0 points to the string

lowerCase:
	lb	$t1, ($t0)	# $t1 stores character at time
	nop
	beqz	$t1, done	# branch if we got to end of string
	addi	$t1, $t1, 0x20	# add ascii offset to convert lowercase
	sb	$t1, ($t0)
	nop
	addi	$t0, $t0, 1 
	j	lowerCase
	nop	
done:	li	$v0, 4
	la	$a0, endl	# Print newline			
	syscall
	li	$v0, 4
	la	$a0, string	# Print lowercase string			
	syscall
	li	$v0, 10
	syscall
