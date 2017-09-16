# Shiva Sandesh
# 4/25/2016
# Assignment 8 Exercise 2
# Gregory Leibniz series aprroximation of the PI using both the recursicve and
# iterative version to write out the sum of the first 1000, 2000, 3000, ..., 10000 terms
	
	.data
iter:	.double	0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0
recur:	.double 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0
endl:	.asciiz	"\n"
tab:	.asciiz "\t"
it:	.asciiz	"PI Iterative"
re:	.asciiz "PI Recursive"
	.text
	.globl	main
main:
	jal	PIit			# call Pi iterative
	nop
	mtc1	$zero, $f8			
	cvt.d.w $f8, $f8
	mfc1.d	$s1, $f8
	sll	$s2, $s1, 16		# for the double precision
	srl	$s2, $s2, 16		# for the double precision 
	srl	$s1, $s1, 16
	addiu	$sp, $sp, -4		
	sw	$zero, ($sp)		# push it on the stack
	addiu	$sp, $sp, -4
	sw	$s1, ($sp)		# push it on the stack
	addiu	$sp, $sp, -4
	sw	$s2, ($sp)
	jal	PIre			# call PI recurive
	nop
	addiu	$sp, $sp, 12		# pop of from stack
	la	$a0, it
	li	$v0, 4
	syscall
	la	$a0, tab		# for tab in between the results
	li	$v0, 4
	syscall
	la	$a0, re
	li	$v0, 4
	syscall
	la	$a0, endl		# end of line character
	li	$v0, 4
	syscall
	la	$s0, iter
	la	$s1, recur
	addiu	$s2, $s0, 72
prt:
	l.d	$f12, ($s0)
	li	$v0, 3
	syscall
	la	$a0, tab
	li	$v0, 4
	syscall
	l.d	$f12, ($s1)
	li	$v0, 3
	syscall
	la	$a0, endl
	li	$v0, 4
	syscall
	addiu	$s0, $s0, 8
	addiu	$s1, $s1, 8
	ble	$s0, $s2, prt
	nop
	
	li	$v0, 10
	syscall

PIit:
	# start of subroutine prolog
	addiu	$sp, $sp, -4
	sw	$ra, ($sp)		# push $ra
	addiu	$sp, $sp, -4
	sw	$fp, ($sp)		# push $fp
	nop
	or	$fp, $sp, $0		# parameter at 8($fp)

	# $t0 = address of "iter" double array
	# $t1 = counter
	# $t2 = stop condition
	# $t3  = int temp variable
	# $f4 = accumulator
	# $f6 = current value
	# $f8 = double temp variable
	la	$t0, iter		# load save values array
	nop
	li	$t1, 0			# inittialize counter to zero
	li	$t2, 1000		# initialize stop condition
	mtc1	$zero, $f4		# initialize accumulator to zero
	cvt.d.w	$f4, $f4
	mtc1	$zero, $f6		# initialize current calue to zero
	cvt.d.w	$f6, $f6		
loop:
	sll	$t3, $t1, 1		# 2k
	addiu	$t3, $t3, 1		# 2k + 1
	mtc1	$t3, $f6		# save 2k + 1 to current value
	cvt.d.w	$f6, $f6
	li	$t3, 1
	mtc1	$t3, $f8		# load 1 into double temp
	cvt.d.w	$f8, $f8
	div.d	$f6, $f8, $f6		# 1/(2k + 1)
	add.d	$f4, $f4, $f6		# add current value into accumulator
	addiu	$t1, $t1, 1		# increment counter
	sll	$t3, $t1, 1		# 2k
	addiu	$t3, $t3, 1		# 2k + 1
	mtc1	$t3, $f6		# save 2k + 1 to current value
	cvt.d.w	$f6, $f6
	li	$t3, -1
	mtc1	$t3, $f8		# load 1 into double temp
	cvt.d.w	$f8, $f8
	div.d	$f6, $f8, $f6		# -1/(2k + 1)
	add.d	$f4, $f4, $f6		# add current value into accumulator
	addiu	$t1, $t1, 1		# increment counter
	blt	$t1, $t2, loop		# if(counter < stop) -> dont save
	nop
	li	$t3, 4
	mtc1	$t3, $f8		# load 4 into double temp
	cvt.d.w	$f8, $f8
	mul.d	$f8, $f8, $f4		# 4*accumulator
	s.d	$f8, ($t0)		# save value to array
	addiu	$t0, $t0, 8		# increment array pointer
	li	$t3, 10000
	addiu	$t2, $t2, 1000		# change stop condition
	blt	$t1, $t3, loop		# end loop if counter reaches 10000
	nop
	# start of subroutine epilog
	lw	$fp, ($sp)		# pop $fp
	addiu	$sp, $sp, 4
	lw	$ra, ($sp)		# pop $ra
	addiu	$sp, $sp, 4
	jr	$ra			# return
	nop

PIre:
	# start of subroutine prolog
	addiu	$sp, $sp, -4
	sw	$ra, ($sp)		# push $ra
	addiu	$sp, $sp, -4
	sw	$fp, ($sp)		# push $fp
	or	$fp, $sp, $0
	# end of subroutine epilog
	# parameter: 16($fp) = n; 12($fp), 8($fp) accumulator
	lw	$t0, 16($fp)		# load n
	nop
	lw	$t1, 12($fp)
	nop

	sll	$t1, $t1, 16
	lw	$t2, 8($fp)
	nop
	or	$t1, $t2, $t1
	mtc1	$t1, $f8
	sll	$t0, $t0, 1		# 2n
	addiu	$t0, $t0, 1		# 2n + 1
	mtc1	$t0, $f4
	cvt.d.w	$f4, $f4
	li	$t1, 4
	mtc1	$t1, $f6
	cvt.d.w	$f6, $f6
	div.d	$f4, $f6, $f4		# 4/(2n + 1)
	add.d	$f8, $f4, $f8
	lw	$t0, 16($fp)		# load n
	nop
	addiu	$t0, $t0, 1		# to next (negative) term
	sll	$t0, $t0, 1		# 2n
	addiu	$t0, $t0, 1		# 2n + 1
	mtc1	$t0, $f4
	cvt.d.w	$f4, $f4
	li	$t1, -4
	mtc1	$t1, $f6
	cvt.d.w	$f6, $f6
	div.d	$f4, $f6, $f4		# -4/(2n + 1)
	add.d	$f8, $f4, $f8
	lw	$t0, 16($fp)
	nop
	addiu	$t0, $t0, 2		# increment term
	li	$t1, 1000
	div	$t0, $t1
	mfhi	$t1
	nop
	nop
	bnez	$t1, dontSave		# check save condition
	nop
	mflo	$t1
	addiu	$t1, $t1, -1		# get save index
	sll	$t1, $t1, 3
	s.d	$f8, recur($t1)

dontSave:
	li	$t1, 10000
	beq	$t0, $t1, return
	nop
	mfc1.d	$t1, $f8
	sll	$t2, $t1, 16
	srl	$t2, $t2, 16
	srl	$t1, $t1, 16
	addiu	$sp, $sp, -4
	sw	$t0, ($sp)
	addiu	$sp, $sp, -4
	sw	$t1, ($sp)
	addiu	$sp, $sp, -4
	sw	$t2, ($sp)
	jal	PIre
	nop
	addiu	$sp, $sp, 12

return:
	# start of subroutine epilog
	lw	$fp, ($sp)		# pop $fp
	addiu	$sp, $sp, 4
	lw	$ra, ($sp)		# pop $ra
	addiu	$sp, $sp, 4
	jr	$ra			# return
	nop
	# end of subroutine epilog