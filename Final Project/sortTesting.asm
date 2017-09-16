	.data
display:.asciiz "ZYXWVUTSRQPONMLKJIHGFEDCBA\n" 
	.text
	.globl main
main:	li	$s0, 0			# bool to see if no swap occured
	la	$t0, display
	nop
	addiu	$t1, $t0, 1		# for the next character in the string
check:	lb	$t3, ($t0)
	lb	$t4, ($t1)
	beqz	$t3, endIt		# to end the the swap function
	nop
	beqz	$t4, iplus		# to increement the outer loop variable
	nop
	bgt	$t3, $t4, swap	
	nop		
jplus:	addiu	$t1, $t1, 1
	b	check
	nop
iplus:	beqz	$s0, endIt		# check if no swap occured in this pass
	addiu	$t0, $t0, 1		# increement the loop variables
	addiu	$t1, $t0, 1
	li	$s0, 0			# set the flag again
	b	check	
	nop		
swap:	sb	$t3, ($t1)
	sb	$t4, ($t0)
	nop
	li	$s0, 1			# swap occured set $s0 to 0
	j	jplus
	nop

endIt:	la	$a0, display
	li	$v0, 4
        syscall
	li	$v0, 10
	
	