# Lab 4 with Shiva Sandesh and HongKan  Liu
# CS21
# 03/02/2016
# multiply by shifting and adding and cheking the result
# with the multiply instruction

	.data
x:	.word 0		# for user input 1
y:	.word 0		# for user input 2
result: .word 0		# for the result = x*y
prompt1: .asciiz "\n Please nter the first integer."
prompt2: .asciiz "\n Please enter the second integer."
prompt3: .assciiz "\n Output using shift and add algorithm."
prompt4: .assciiz "\n Output using the multiply instruction."

	.text
	.globl main
main:
	
	li	$v0, 4		# system call code for Print String 
	la	$a0, prompt1	# load address of promp into $a0 
	syscall			# print the first prompt
	
	li	$v0, 5		# load 5 into $v0 to init Read Int syscall
	syscall			# read the integer from user input(reads into $v0)
	sw	$v0, x		# store the integer in x variable