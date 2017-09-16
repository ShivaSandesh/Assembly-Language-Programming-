# Shiva Sandesh
# Asignment 7 Exercice 2
# 4/16/2016

	.data
prmpt:	.asciiz " Enter a number : "
result:	.asciiz " The product of two numbers is : "
newln:	.asciiz "\n"
	.text
	.globl main
main:	li	$s0, 0		# loop counter
	li	$s1, 10		# for loop termination
loop: 	bge	$s0, $s1, done
	nop
	jal	getNum
	nop
	move	$s2, $v0	# get the contents of the register $v0
	jal	getNum
	nop

	move	$a0, $s2	# copy the contents of the $s2 to $a0 and
	move	$a1, $v0	# $v0 to $a1 to pass arguments to subroutine
	jal	prod		# subroutine to multiply two numbers
	nop
	move	$a0, $v0	# get the contents of the register $a0
	jal	print		# to pass to the print subroutine
	nop
	addiu	$s0, 1		# increement the loop counter
	j	loop
	nop

	# Subroutine to get the data from user

getNum:	la	$a0, prmpt	# load the address of the prompt
	li	$v0, 4		# print the string
	syscall
	li	$v0, 5		# get the user input
	syscall
	jr	$ra
	nop

	# Subroutine to multiply the data from user input

prod:	mult	$a0, $a1	# find the product
	mflo	$v0		# move to $v0 to return the value
	nop
	nop
	jr	$ra
	nop

	# Subroutine to print the results 

print:	move	$t0, $a0
	li	$v0, 4
	la	$a0, result
	syscall
	move	$a0, $t0
	li	$v0, 1
	syscall
	la	$a0, newln
	li	$v0, 4
	syscall
	jr	$ra
	nop
	# exit the program
done:	li	$v0, 10
	syscall