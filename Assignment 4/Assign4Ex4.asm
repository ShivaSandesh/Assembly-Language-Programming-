# Assignment 4 Ex 4
# Shiva Sandesh
# 3/20/2016
# Reverse the character from upper to lowercase and vice versa

	.data
string:	.space 81
prompt: .asciiz "Enter a string \n"
	.text
	.globl main

main:	la	$a0, prompt	# load the prompt
     	li	$v0, 4		# print the message (prompt)
	syscall
	li	$v0, 8		# read string from user
	la	$a0, string	# load the address to store string 
	syscall	
	
	li 	$t0, 0x20	# offset to convert to upper case
	la	$t1, string	# $t1 points to the string
	li	$t3, 91		# the ascii upper case chars end at 91
	li	$t4, ' '	# to check if we have space
	li	$t5, '\n'	
	
convert:lb	$t2, ($t1)	# $t2 stores character at time
	nop
	beq	$t2, $t5, done	# branch if we got to end of string
	nop
	beq	$t2, $t4, handle # if we have space we handle it
	nop
	blt	$t2, $t3,ToLower # if we have space we handle it
	nop
	bgt	$t2, $t3,ToUpper # branch if we have flag set on
	nop			
	b	convert		# test next char
	nop	

handle:	addi	$t1, $t1, 1	# pointer points to next char
	b	convert		# test next char
	nop

ToUpper:sub	$t2, $t2, $t0	# convert to the uppercase
	sb	$t2, ($t1)	# save the upper case char
	nop
	addi	$t1, $t1, 1
	j	convert
	nop

ToLower:add	$t2, $t2, $t0	# convert to the lowercase
	sb	$t2, ($t1)	# save the lower case char
	nop
	addi	$t1, $t1, 1
	j	convert
	nop
done:	la	$a0, string	# load the address to store string 
	li	$v0, 4		# read string from user
	syscall	
	li	$v0, 10
	syscall