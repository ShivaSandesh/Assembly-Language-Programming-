# Lab 3 with Zachary Cunningham and Shiva Sandesh
# CS21 
# 2/29/2016

	.text
	.globl main
main:
	ori 	$t0, $zero, 0	# puts 0 in $t0 (a)
	ori 	$t1, $zero, 0	# puts 0 in $t1 (b)
	ori 	$t2, $zero, 10	# counter register (variable)
 	# while loop
while:
	sub	$t3, $t2, $t0	# for comparison (10-a)
	blez	$t3, exitwhile	# if 10-a <= 0, branch to 'exitwhile'
	sll	$zero, $zero, 0	# instead of nop which is a macro
	addu	$t1, $t1, $t0	# add a to b
	addiu	$t0, $t0, 1	# increment a
	j	while		# jump to 'while'
	sll	$zero, $zero, 0	# instead of nop which is a macro
exitwhile:
	
	
	# do-while
	ori 	$t0, $zero, 0	# puts 0 in $t0 (a)
	ori 	$t1, $zero, 0	# puts 0 in $t1	(b)
dowhile:
	addu	$t1, $t1, $t0	# add a to b and stores in b
	addiu	$t0, $t0, 1	# increment a
	sub	$t3, $t2, $t0	# for comparison (10-a)
	blez	$t3, exitdo	# if 10-a <= 0, branch to 'exitdo'
	sll	$zero, $zero, 0	# instead of nop which is a macro
	j	dowhile		# jump to 'dowhile'
	sll	$zero, $zero, 0	# instead of nop which is a macro
exitdo:

	# for loop
	ori 	$t0, $zero, 0	# puts 0 in $t0	(a)
	ori 	$t1, $zero, 0	# puts 0 in $t1	(b)
for:
	sub	$t3, $t2, $t0	# for comparison (10-a)
	blez	$t3, exitfor	# if 10-a <= 0, branch to 'exitfor'
	sll	$zero, $zero, 0	# instead of nop which is a macro
	addu	$t1, $t1, $t0	# add a to b
	addiu	$t0, $t0, 1	# increment a
	j	for		# jump to 'for'
	sll	$zero, $zero, 0	# instead of nop which is a macro
exitfor:
	
	# if statement
	ori 	$t0, $zero, 0	# puts 0 in $t0	(a)
	ori 	$t1, $zero, 0	# puts 0 in $t1	(b)

	sub	$t2, $t0, $t1	# for comparison (a-b)
	bgtz	$t2, done	# if a-b > 0, branch to 'done'
	sll	$zero, $zero, 0	# instead of nop which is a macro
	ori	$t1, $zero, 10	# set b equal to 10
done:
	# if else statement
	ori 	$t0, $zero, 0	# puts 0 in $t0	(a)
	ori 	$t1, $zero, 0	# puts 0 in $t1	(b)

	sub	$t2, $t0, $t1	# for comparison (a-b)
	blez	$t2, else	# if a-b <= 0, branch to 'else'
	sll	$zero, $zero, 0	# instead of nop which is a macro
	ori	$t1, $zero, 10	# set b equal to 10
	j	ifelsedonee
	sll	$zero, $zero, 0	# instead of nop which is a macro
else:	
	ori	$t0, $zero, 20	# set a equal to 20

ifelsedonee: 

	ori	$v0, $zero, 10
	syscall

# End of file

