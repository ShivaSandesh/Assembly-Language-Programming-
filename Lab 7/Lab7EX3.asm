# lab_07_2.asm
# Marc Garard
# Shiva Sandesh
# 2013/04/06
# Lab 07 Part 2
# Removes vowels from a user input string using stack

	.data
prompt:	.asciiz "Input a string : "
input:	.space 100
	.text
	.globl main
main:
	# get string from user
	la	$a0, prompt		# load prompt
	li 	$v0, 4			# prompt user
	syscall
	la	$a0, input		# load input address
	li	$a1, 100		# size of string
	li	$v0, 8			# read in string
	syscall

	# find end of string
	la	$s0, input		# load address of input
	la	$s1, input
	nop
find:	
	lb	$s2, ($s1)
	nop
	beqz	$s2, found
	addi	$s1, $s1, 1		# advance ptr of input
	bnez	$s2, find		# continue loop if not at end
	nop
found:
	addi	$s1, $s1, -1		# backup ptr off NULL 
	li	$t0, ' '
	sb	$t0, ($s1)		# save space to catch last 'y' as vowel
	addiu	$sp, $sp, -4		# move stack pointer up 
	sw	$zero, ($sp)		# push null on top
	nop
	# compare chars to aeiou
compare: 
	lb	$t0, ($s1)		# load the byte into $t0
	nop	
	li	$t1, 'a'		# is $t0 == 'a' ?
	beq	$t0, $t1, skip
	nop
	li	$t1, 'A'		# is $t0 == 'A' ?
	beq	$t0, $t1, skip
	nop
	li	$t1, 'e'		# is $t0 == 'e' ?
	beq	$t0, $t1, skip
	nop
	li	$t1, 'E'		# is $t0 == 'E' ?
	beq	$t0, $t1, skip
	nop
	li	$t1, 'i'		# is $t0 == 'i' ? 
	beq	$t0, $t1, skip
	nop
	li	$t1, 'I'		# is $t0 == 'I' ? 
	beq	$t0, $t1, skip
	nop
	li	$t1, 'o'		# is $t0 == 'o' ?
	beq	$t0, $t1, skip
	nop
	li	$t1, 'O'		# is $t0 == 'O' ?
	beq	$t0, $t1, skip
	nop
	li	$t1, 'u'		# is $t0 == 'u' ?
	beq	$t0, $t1, skip
	nop
	li	$t1, 'U'		# is $t0 == 'U' ?
	beq	$t0, $t1, skip
	nop
	
	li	$t1, ' '
	lb	$t2, 1($s1)
	nop
	bne	$t1, $t2, push
	nop

	li	$t1, 'Y'
	lb	$t2, 1($s1)		# load the byte into $t2
	nop	
	beq	$t0, $t1, skip 
	nop

        # push if not vowel else we skip it
push:	addiu	$sp, $sp, -4
	sw	$t0, ($sp)
	nop

	#  move to the next char
skip:
	beq	$s0, $s1, popIt		
	nop
	addiu	$s1, $s1,-1		# if we have not crossed the prt	
	j	compare			# keep on comparing if it is a vowel or not 
	nop

	# pop everything and store in buffer
popIt:
	lw	$t0, ($sp)		# get the top element
	nop
	addiu	$sp, $sp, 4		# move the stack ptr
	sb	$t0, ($s0)		# store the character at $s0
	nop
	beqz	$t0, done		# if just encountered null, then finished reading
	nop		
	addiu	$s0, $s0, 1		# move the ptr to next location 
	j	popIt			# repeat untill done 
	nop

	# print	
done:	
	li	$v0, 4
	la	$a0, input
	syscall
	li	$v0, 10
	syscall






