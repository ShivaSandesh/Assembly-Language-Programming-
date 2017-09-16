# Shiva Sandesh
# CS21 Assignment 2
# 2/24/2013

	.text
	.globl main
main:
	# Exercise 1
	
	li	$t0, 456	# 1 instruction
	li	$t1,-229	# 2 instructions so macro
	li	$t2, 325        # 1 instruction
	li	$t3,-552	# 2 instructions so macro
	add	$t0, $t0, $t1	# $t0=456+(-229)=227
	add	$t0, $t0, $t2	# $t0=227+325=552
	add	$t0, $t0, $t3	# $t0=552-552=0
	
	# Exercise 2
	
	li	$t0, 0x0		# 1 instruction
	add	$t0, $t0, 0x1000        # add 0x1000=4096 to $t0   
	add	$t0, $t0, 0x1000	# add 0x1000 2 nd time  
	add	$t0, $t0, 0x1000	# add 0x1000 3 rd time 
	add	$t0, $t0, 0x1000	# add 0x1000 4 th time  
	add	$t0, $t0, 0x1000	# add 0x1000 th time 
	add	$t0, $t0, 0x1000	# add 0x1000 6 th time 
	add	$t0, $t0, 0x1000	# add 0x1000 7 th time 
	add	$t0, $t0, 0x1000	# add 0x1000 8 th time 
	add	$t0, $t0, 0x1000	# add 0x1000 9 th time 
	add	$t0, $t0, 0x1000	# add 0x1000 10 th time 
	add	$t0, $t0, 0x1000	# add 0x1000 11 th time 
	add	$t0, $t0, 0x1000	# add 0x1000 12 th time 
	add	$t0, $t0, 0x1000	# add 0x1000 13 th time 
	add	$t0, $t0, 0x1000	# add 0x1000 14 th time 
	add	$t0, $t0, 0x1000	# add 0x1000 15 th time 
	add	$t0, $t0, 0x1000	# now $t0=65536 

	li	$t1, 0x1000		# load $t1=0x1000 with macro
	sll	$t1, $t1, 4		# sll 4 of 0x1000= 65536

	li	$t2, 0x1000		# load $t2=0x1000 with macro
	add	$t2, $t2, $t2           # add 4096 to $t2, $t2=8192
	add	$t2, $t2, $t2		# add 8192 to $t2, $t2=16384
	add	$t2, $t2, $t2		# add 16364 to $t2, $t2=32768
	add	$t2, $t2, $t2		# add 32768 to $t2, $t2=65536	
	
        # Exercise 3

	li	$t1, 0x7000		# load 0x7000 in $t1
	sll	$t1, $t1, 16		# $t1=0x70000000
	addu	$t1, $t1, $t1		# overflow not detected
	
	li	$t2, 0x7000		# load 0x7000 in $t1
	sll	$t2, $t2, 16		# $t1=0x70000000
	add	$t2, $t2, $t2		# overflow detected	
