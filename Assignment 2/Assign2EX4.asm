# Shiva Sandesh
# CS21 Assignment 2, Exercise 4
# 2/24/2013
# Value of this expression: (x*y)/z
# x = 1600000 (=0x00186A00)
# y = 80000 (=0x00013880)
# z = 400000 (=0x00061A80). 
	
	.text
	.globl main
main:
	# EXERCISE 4
	
	ori	$t0, $zero, 0x186A	# x=$t0=0x186A
	sll	$t0, $t0, 8		# now x=$0=0x186A00
	ori	$t1, $zero, 0x1388	# y=$t1=0x1388
	sll	$t1, $t1, 4		# now y=$t1=0x13880
	ori	$t2, $zero, 0x61A8	# z=$t2=0x61A8
 	sll	$t2, $t2, 4		# now z=$t2=0x61A80
	div	$t0, $t2		# dvides $t1 by $t2
	mflo    $t3			# move lower 32 bits in $t3 	
	sll	$zero, $zero, 0
	sll	$zero, $zero, 0
        mult	$t3, $t1		# multiples $t3 with $t1
        mflo	$t4			# move lower 32 bits in $t4 