# Shiva Sandesh
# Asignment 7 Exercice 1
# 4/09/2016
# prompt user for single precison floats a, b, c,
# after that evaluate 3ab - 2bc - 5a + 20ac - 16

	.data
aa:	.float 0.0
bb:	.float 0.0
cc:	.float 0.0 
aprmpt:	.asciiz "Enter the value of a:"
bprmpt:	.asciiz "Enter the value of b:"
cprmpt:	.asciiz "Enter the value of c:"
result:	.asciiz "The result of 3ab - 2bc - 5a + 20ac - 16  = "
	.text
	.globl main
main:	la	$a0, aprmpt	# to pass argument to function
	jal	getData
	nop
	s.s	$f0, aa		# save $f0 to a

	la	$a0, bprmpt	# to pass argument to function
	jal	getData
	nop
	s.s	$f0, bb		# save $f0 to bb

	la	$a0, cprmpt	# to pass argument to function
	jal	getData
	nop
	s.s	$f0, cc		# save $f0 to c
	
	jal	solve
	li	$v0, 4
	la	$a0, result
	syscall
	mov.s 	$f12, $f0
	li	$v0, 2
	syscall
	li	$v0, 10
	syscall

getData:li	$v0, 4
	syscall
	li	$v0,6		# get a float
	syscall
	jr	$ra
	nop
	
	# push intermediate values to stack 

solve:	li.s	$f0, -16.0	# $f0 = -16.0 	
	addiu	$sp, $sp, -4
	s.s	$f0, ($sp)	# push -16.0 to stack
	nop

	li.s	$f0, 20.0	# $f0 = 20.0 	
	l.s	$f2, aa		# $f2 = a
	nop
	mul.s	$f0, $f0, $f2	# $f0 = 20a
	addiu	$sp, $sp, -4
	s.s	$f0, ($sp)	# push 20a to stack  'intermediate value'
	nop
	l.s	$f0, ($sp)	# poping 20a form stack and now multiply with c
	addiu	$sp, $sp, 4	# back off stack pointer
	l.s	$f2, cc
	nop
	mul.s	$f0, $f0, $f2	# $f0 = 20ac
	nop
	addiu	$sp, $sp, -4
	s.s	$f0, ($sp)	# push 20ac to stack
	nop


	li.s	$f0, -5.0	# $f0 = -5.0 	
	l.s	$f2, aa		# $f2 = a
	nop
	mul.s	$f0, $f0, $f2	# $f0 = -5a
	nop
	addiu	$sp, $sp, -4
	s.s	$f0, ($sp)	# push -5a to stack
	nop

	
	li.s	$f0, -2.0	# $f0 = -2.0 	
	l.s	$f2, bb		# $f2 = b
	nop
	mul.s	$f0, $f0, $f2	# $f0 = -2b
	nop
	addiu	$sp, $sp, -4
	s.s	$f0, ($sp)	# intermediate value = -2a on stack
	nop
	l.s	$f0, ($sp)	# $f0 = -2a; 
	addiu	$sp, $sp, 4	# back off stack pointer
	l.s	$f2, cc		# $f1 = c
	nop
	mul.s	$f0, $f0, $f2	# $f0 = -2bc
	nop
	addiu	$sp, $sp, -4
	s.s	$f0, ($sp)	# push -2bc to stack
	nop
	

	li.s	$f0, 3.0	# $f0 = 3.0 	
	l.s	$f2, aa		# $f2 = a	
	nop
	mul.s	$f0, $f0, $f2	# $f0 = 3a
	nop
	addiu	$sp, $sp, -4
	s.s	$f0, ($sp)	# intermediate value = 3a on stack
	nop
	l.s	$f0, ($sp)	# $f0 = 3a; 
	addiu	$sp, $sp, 4	# back off stack pointer
	l.s     $f2, bb
	nop
	mul.s   $f0, $f0, $f2	# $f0 = 3ab
	nop
	addiu	$sp, $sp, -4
	s.s	$f0, ($sp)	# push 3ab to stack
	nop

	# pop everything from Stack 
	l.s	$f0, ($sp)	# $f0 = 3ab
	nop
	addiu	$sp, $sp, 4	# pop 3ab
	l.s	$f2, ($sp)	# $f2 = -2bc
	nop
	addiu	$sp, $sp, 4	# pop 2bc
	add.s	$f0, $f0, $f2	# $f0 = 3ab - 2bc
	l.s	$f2, ($sp)	# $f2 = 5a
	nop
	addiu	$sp, $sp, 4	
	add.s	$f0, $f0, $f2	# $f0 = 3ab - 2bc - 5a
	l.s	$f2, ($sp)	# $f2 = 20ac
	nop
	addiu	$sp, $sp, 4
	add.s	$f0, $f0, $f2	# $f0 = 3ab - 2bc - 5a + 20ac
	l.s	$f2, ($sp)
	nop
	addiu	$sp, $sp, 4
	add.s	$f0, $f0, $f2	# f0 = 3ab - 2bc - 5a + 20ac -16
	jr	$ra
	nop	
	

	