# Assignment 6
# Shiva Sandesh
# 03/29/2016
# Newton's algorithm for approximating a square root
# Nothing on the stack for this program !
	
	.data
xcord:	.asciiz "\nEnter the x coordinate: "
ycord:	.asciiz "\nEnter the y coordinate: "
dist:	.asciiz "\nThe distance between coordinate 1 and coordinate 2 is "

	.text
	.globl main

main:	li	$a1, 1		# it is flag to to get the x-cordinate
	jal	getVal		# subroutine to get the users data
	nop
	mtc1	$v0, $f0	# move to coprocessor 1
	cvt.s.w $f1, $f0	# convert to single precision float, $f1=$f0

	jal	getVal		# subroutine to get the users data
	nop
	mtc1	$v0, $f0	# move to coprocessor 1
	cvt.s.w $f2, $f0	# convert to single precision float, $f2=$f0

	jal	getVal		# subroutine to get the users data
	nop
	mtc1	$v0, $f0	# move to coprocessor 1
	cvt.s.w $f3, $f0	# convert to single precision float, $f3=$f0
	
	jal	getVal		# subroutine to get the users data
	nop
	mtc1	$v0, $f0	# move to coprocessor 1
	cvt.s.w $f4, $f0	# convert to single precision float, $f4=$f0
	
	# find the (x2 - x1)^2 + (y2 - y1)^2 i.e n in the algorithm
	sub.s	$f5, $f3, $f1	# (x2-x1) = ($f3-$f1)
	mul.s	$f5, $f5, $f5	# (x2-x1)^2 = ($f3-$f1)^2
	sub.s	$f6, $f4, $f2 	# (y2-y1) = ($f4-$f2)
	mul.s	$f6, $f6, $f6	# (y2-y1)^2 = ($f4-$f2)^2
	add.s	$f7, $f6, $f5	#  (x2-x1)^2 + (y2-y1)^2
	mov.s   $f12, $f7	# $f12 ar the argument to the subroutine

	li.s	$f8, 1.0	# initial guess for sqrt(d^2)
	li.s	$f9, 1.0e-5	# tolerance
	li.s	$f10, 1.0	# constant for the algorithm 
	li.s	$f11, 2.0	# constant for the algorithm
	jal	sqrt
	nop
	
	# Printing results
	li	$v0, 4
	la	$a0, dist
	syscall
	mov.s	$f12, $f0	# $f12 to pass the arguments 
	li	$v0, 2
	syscall
	li	$v0, 10
	syscall	

	# Subroutine to get the user input start here 
getVal:	beq	$a1, $zero,getY # flag is 0, then get y-coordinate
	nop			# else get the x-coordinate
	la 	$a0, xcord	# prompt user to enter data
	b	val
	li	$a1, 0		# unset the flag
	nop

getY:	la 	$a0, ycord	# prompt user to enter data
	b	val
	li	$a1, 1		# set the flag again to get x coordinate next time

val:	li	$v0, 4
	syscall 
	li	$v0, 5
	syscall
	jr	$ra
	nop
	# Subroutine to get the data ends here 
	
	# Subroutine to find the sqrt((distance)^2 )
sqrt:	div.s	$f5, $f12, $f8	# $f5 = distance/guess=n/x
	add.s	$f5, $f5, $f8	# $f5 = x + n/x
	div.s	$f8, $f5, $f11	# $f8 = (x + n/x)/2 
	
	# check if we got the reslts in dersired range
	mul.s	$f6, $f8, $f8	# $f6 = (approximated x)^2 
	div.s	$f6, $f6, $f12	# $f6 = (approximated x)^2 / n
	sub.s	$f6, $f6, $f10	# $f6 =((approximated x)^2 /n) -1
	abs.s	$f6, $f6	# $f6 = | ((approximated x)^2 /n) -1 | 
	c.lt.s	$f6, $f9	# set flag if f6 < tolerance
	bc1t	done		# branch to done if flag set
	nop
	j	sqrt		# if not in desired tolerance do it again
	nop
done:	mov.s	$f0, $f8
	jr	$ra		# jump out of subroutine
	nop


	
