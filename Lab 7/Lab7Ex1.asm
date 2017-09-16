# 
# lab_07_1.asm
#
# Marc Garard
# Shiva Sandesh
# 2013/04/06
# Lab 07 Part 1
# this program promps for a string and uses a stack 
# to reverse the string.
	.data
prompt:	.asciiz "enter a string to reverse\n"
input:	.space 81
name:	.space 81
	.text
	.globl main
main:	li	$v0, 4		# prompt for string
	la	$a0, prompt	# 
	syscall
	li	$v0, 8		# read string
	la	$a0, input	# set buffer address
	li	$a1, 81		# set length
	syscall
	
	ori	$s0, 0x00	# load address of \0
	addiu	$sp, $sp, -4	# advance stack pointer (push)
	la	$s1, input	# load address of string
	sw	$s0, ($sp)	# stack \0 (push)
	nop
	
push:
	addiu	$sp, $sp, -4
	lb	$s2, ($s1)	# load char
	nop
	beq	$s2, $0, done	# if at end of the sting, stop loop
	nop
	sw	$s2, ($sp)	# save char (word) to stack
	nop
	addi	$s1, $s1, 1
	j	push		#coninue loop
	nop
done:
	addiu 	$sp, $sp, 4	# backup stack one word
	la	$s3, name	# load address of output string

pop:
	lb	$s2, ($sp)	#load char
	nop
	sb	$s2, ($s3)	# save char		
	nop
	beq	$s2, $0,done2	# exit if null
	nop
	addiu	$sp, $sp, 4	# back up stack ptr
	addiu	$s3, $s3, 1	# advance output ptr
	j	pop		# continue popping
	nop
done2:
	li	$v0, 4		# print the reversed string
	la	$a0, name
	syscall