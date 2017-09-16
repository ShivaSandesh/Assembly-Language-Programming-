# Lab 3 with Zachary Cunningham and Shiva Sandesh
# CS21 
# 2/22/2016
	.text
	.globl main
main:
	ori 	$t0, $zero, 0	# puts 0 in $t0
	ori 	$t1, $zero, 0	# puts 0 in $t1
	ori 	$t2, $zero, 10	# counter register (variable)

 	# while loop
while:
	sub	$t3, $t2, $t0	# for comparison 
	blez	$t3, done	# $t3 < = 0
	addu	$t1, $t1, $t0	# it is for the 'y'
	addiu	$t0, $t0, 1	# it is for the 'x'
	b	while
done:

	# do-while
	ori 	$t0, $zero, 0	# puts 0 in $t0
	ori 	$t1, $zero, 0	# puts 0 in $t1
dowhile:
	addu	$t1, $t1, $t0	# it is for the 'y'
	addiu	$t0, $t0, 1	# it is for the 'x'
	sub	$t3, $t2, $t0	# for comparison
	blez	$t3, donedo	# exit control loop
	b	dowhile
donedo:

	# for loop
	ori 	$t0, $zero, 0	# puts 0 in $t0
	ori 	$t1, $zero, 0	# puts 0 in $t1
for:
	sub	$t3, $t2, $t0	# for comparison 
	blez	$t3, fordone	# $t3 < = 0
	addu	$t1, $t1, $t0	# it is for the 'y'
	addiu	$t0, $t0, 1	# it is for the 'x'
	b	for
fordone:
	

