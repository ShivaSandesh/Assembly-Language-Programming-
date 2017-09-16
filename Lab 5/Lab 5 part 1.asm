# Alex Wolski && Shiva Sandesh
# CS21 Lab 5 part 1
# Reverse a string 

	.data
 
before:	.asciiz	"String before swap:\n "	# Message displayed before swap
after:	.asciiz	"\nString after swap:   "	# Message displayed after swap
str:	.asciiz	"Shiva isi avihS"		# String to be reversed

	.text
	.globl main

main:	la	$a0, before			# Print message and original string
	li	$v0, 4
	syscall
	la	$a0, str
	li	$v0, 4			      
	syscall
	la	$t1, str			# $t0 and $t1 pointers to the string
	la	$t0, str
scan:	lb	$t2, ($t1)			# Move $t1 to the end of the string
	nop
	beqz	$t2, endscn			# String terminated by \0 i.e 0 
	nop
	addiu	$t1, $t1, 1
	b	scan
	nop
endscn:	addi	$t1, -1
	lb	$t2, ($t0)
	lb	$t3, ($t1)
swap:	bge	$t0, $t1, endswp
	lb	$t2, ($t0)
	lb	$t3, ($t1)
	sb	$t2, ($t1)
	sb	$t3, ($t0)
	addi	$t0, 1
	addi	$t1, -1
	j	swap
endswp:
	la	$a0, after			#Print message and swapped string
	syscall
	la	$a0, str
	syscall
	li	$v0, 10				#Exit program
	syscall