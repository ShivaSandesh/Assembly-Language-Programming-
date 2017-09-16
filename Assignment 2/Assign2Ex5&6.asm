# Shiva Sandesh
# CS21 Assignment 2 Exercise 5 and 6
# 2/24/2016
# Evaluate the polynomial expression:
# Ex 5: 2x^3 -3x^2 + 5x + 12 = x(x(2x - 3) + 5) + 12
# Ex 6: 18xy + 12x - 6y + 12 = 6(3xy + 2x - y + 2)


	.data
x:	.word 1			# word x = -2
y:	.word 0			# word y = 1
answer: .word 0			# word answer= 0
	.text
	.globl main
main: 
	# Excercise 5:
	
	lw	$t0, x		# $t0 stores x
	nop
	sll	$t1, $t0, 1	# $t1 stores 2*x
	addi	$t1, $t1, -3	# $t1 now stores,$t1=2x-3 
	mult    $t1, $t0	# multiply $t1 contents with $t0
	mflo	$t1		# moves contents from lo to $t1
	nop
	nop			# mflo followed by nop and add
	add	$t1, $t1, 5	# $t1 stores result of x(2*x-3)+5
	mult	$t1, $t0	# multiply $t1  with $t0. x*(x*(2x-3)+5) 
	mflo    $t1
	nop
	nop
	add	$t1, $t1, 12  # $t2 results of polynomial
	sw	$t1, answer
	
	# Excercise 6
	
	lw	$t0, x		# $t0 stores x
	lw	$t1, y		# $t1 stores y
	nop
	mult    $t0, $t1	# product x*y
	mflo	$t2		# moves contents from lo to $t2
	sll 	$t0, $t0, 1	# sll used instead nop, $t0=2*x
	ori     $t3, $zero, 3	# $t3=3
	mult    $t2, $t3        # multiply $t2 contents with $t3
	mflo	$t2		# stores 3*x*y in $t2			
	#nop
	add	$t2, $t2, $t0	# $t2= 3*x*y+2*x, we don't need nop
	sub	$t2, $t2, $t1	# $t2= 3*x*y+2*x-y
	addi	$t2, $t2, 2	# $t2= 3*x*y+2*x-y+2
	sll	$t3, $t3, 1	# $t3=2*$t3=6
	mult	$t3, $t2	# multiply $t2 contents with $t3
	mflo	$t3
	nop
	sw	$t3, answer	

	