#########################################
#	john_shiva.lab9.asm		#
#					#
#	John Tumath & Shiva Sandesh	#
#	Due 05/02/2016			#
#	CS21 Lab 9 - Memory-mapped I/O	#
#					#
#########################################

	.data
intarr:	.word	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
prom1:	.asciiz	"\nPlease enter an integer: "	
prom2:	.asciiz "\nThe sum of the to numbers is "
prom3:	.asciiz	"\nThe difference of the two numbers is "
	.text
	.globl main

main:	la	$a0, prom1
	addiu	$sp, $sp, -4
	sw	$a0, ($sp)
	jal	printIt
	nop
	move	$s0, $v0	# Value 1
	addiu	$sp, $sp, -4
	sw	$s0, ($sp)
	jal	p_int
	nop
	addiu	$sp, $sp, 4
	jal	printIt
	nop
	move	$s1, $v0	# Value 2
	addiu	$sp, $sp, -4
	sw	$s1, ($sp)
	jal	p_int
	nop
	addiu	$sp, $sp, 4
	addiu	$sp, $sp, 4
	addu	$s3, $s0, $s1
	subu	$s4, $s0, $s1
	addiu	$sp, $sp, -4
	la	$s5, prom2
	nop
	sw	$s5, ($sp)
	addiu	$sp, $sp, -4
	sw	$s3, ($sp)
	jal	p_ans
	nop
	addiu	$sp, $sp, 4
	la	$s5, prom3
	sw	$s5, ($sp)
	addiu	$sp, $sp, -4
	sw	$s4, ($sp)
	jal	p_ans
	nop
	addiu	$sp, $sp, 8
	li	$v0, 10
	syscall
	
### Subroutine to prompt and get int (takes prompt, returns int)
printIt:addiu	$sp, $sp, -4
	sw	$ra, ($sp)
	addiu	$sp, $sp, -4
	sw	$fp, ($sp)
	addiu	$sp, $sp, -4
	sw	$a0, ($sp)		# store the address of prompt on stack
	move	$fp, $sp		# set frame pointer equal to stack pointer

	lw	$a0, 12($fp)
	li	$t3, 1			# to indicate if the number is positive
	li	$v0, 0			# for flushing anything sitting there
	li	$a3, 0xffff0000		# base of memory-mapped IO area
ploop:	lw	$t1, 8($a3)		# extract transmitter control
	nop
	andi	$t1, $t1, 0x0001	# mask off ready bit
	beqz	$t1, ploop
	nop
	lb	$t0, ($a0)		# extract next character
	nop
	beqz	$t0, getInt		# find the 0 byte? Yes == exit
	nop
	sb	$t0, 12($a3)		# write character to display
	addiu	$a0, $a0, 1		# advance to next character
	b	ploop			# and try again
	nop

getInt: lw	$t1, ($a3)
	andi	$t1, $t1, 0x0001	# mask off ready bit
	beqz	$t1, getInt
	nop
	lw	$t1, 4($a3)
	nop
	li	$t4, 0x2d		# hexadecimal equavalent to ' - '
	beq	$t4, $t1, negate
	nop
	## Now check if it is a number or not## 

	li	$t4, 0x39		# it is the ascii code for '9'
	bgt	$t1, $t4,next
	nop
	li	$t4, 0x30		# it is the ascii code for '0'
	blt	$t1, $t4,next
	nop
	li	$t5, 10			# while( c is a digit ),  t *= 10
	mult	$v0, $t5

	mflo	$v0
	nop
	sub	$t1, $t1, $t4		# t += c – '0'
	add	$v0, $v0, $t1
	j	getInt
	nop

negate: li	$t3, 0			# number is negative
	j	getInt
	nop
	
next: 	bnez	$t3, pexit
	nop
	sub	$v0, $zero, $v0		# if the sign bit is 0 marks it is a negative number
						
pexit:	move	$sp, $fp
	lw	$a0, ($sp)
	addiu	$sp, $sp, 4	
	lw	$fp, ($sp)	
	addiu	$sp, $sp, 4	
	lw	$ra, ($sp)
	addiu	$sp, $sp, 4	
	jr	$ra
	nop		
	
	
	

### Subroutine to print text and answer (takes prompt and number, returns nothing)

p_ans:	addiu	$sp, $sp, -4
	sw	$ra, ($sp)
	addiu	$sp, $sp, -4
	sw	$fp, ($sp)
	addiu	$sp, $sp, -4
	sw	$t0, ($sp)
	addiu	$sp, $sp, -4
	sw	$t1, ($sp)
	addiu	$sp, $sp, -4
	sw	$t2, ($sp)
	addiu	$fp, $sp, 0
	lw	$t0, 24($fp)	# Address of string
	lw	$t1, 20($fp)	# Value to print
	addiu	$sp, $sp, -4
	sw	$t0, ($sp)
	jal	p_str
	nop
	sw	$t1, ($sp)
	jal	p_int
	nop
	addiu	$sp, $sp, 4
	lw	$t2, ($sp)	# Subroutine Epilogue
	addiu	$sp, $sp, 4
	lw	$t1, ($sp)	
	addiu	$sp, $sp, 4
	lw	$t0, ($sp)
	addiu	$sp, $sp, 4
	lw	$fp, ($sp)
	addiu	$sp, $sp, 4
	lw	$ra, ($sp)
	addiu	$sp, $sp, 4
	jr	$ra
	nop

### Print integer subroutine - John

p_int:	addiu	$sp, $sp, -4
	sw	$ra, ($sp)
	addiu	$sp, $sp, -4
	sw	$fp, ($sp)
	addiu	$fp, $sp, 0
	lw	$t0, 8($fp)	# Load parameter, the int to print
	nop
	bgez	$t0, p_int1	# If non-negative, skip printing negative sign
	neg	$t0, $t0
	sw	$t0, 8($fp)
	li	$a0, 45	
	addiu	$sp, $sp, -4
	sw	$a0, ($sp)	# Push negative sign
	jal	p_chr
	nop
	addiu	$sp, $sp, 4
p_int1:	lw	$t0, 8($fp)	# t0 = n
	la	$t1, intarr	# Array start
	la	$t2, intarr	# Array pointer
	addiu	$t4, $t1, 64	# Array end
	li	$t9, 10
p_int2:	div	$t0, $t9
	mflo	$t0
	mfhi	$t3		# t3 = r
	nop
	addiu	$t3, $t3, '0'
	sw	$t3, ($t2)
	addiu	$t2, $t2, 4	# increment pointer
	bgt	$t2, $t4, p_inte
	bgtz	$t0, p_int2	# if n > 0, restart loop
	nop
	addiu	$t2, $t2, -4	# Array filled, print in reverse order
p_int3:	lw	$t0, ($t2)
	addiu	$sp, $sp, -4	# save off t2, t3
	sw	$t2, ($sp)
	addiu	$sp, $sp, -4
	sw	$t1, ($sp)
	addiu	$sp, $sp, -4
	sw	$t0, ($sp)	# t0 top of stack, to print
	jal	p_chr
	nop	
	addiu	$sp, $sp, 4	# Pop previously used parameter
	lw	$t1, ($sp)
	addiu	$sp, $sp, 4	# ... and temps
	lw	$t2, ($sp)
	addiu	$sp, $sp, 4
	addiu	$t2, $t2, -4	# decrement pointer for array		
	blt	$t2, $t1, p_inte
	nop
	j	p_int3
	nop
p_inte:	addiu	$sp, $sp, -4
	li	$t0, '\n'
	sw	$t0, ($sp)
	jal	p_chr
	nop
	addiu	$sp, $sp, 4
	lw	$fp, ($sp)
	addiu	$sp, $sp, 4
	lw	$ra, ($sp)
	addiu	$sp, $sp, 4
	jr	$ra
	nop

### Print char subroutine - John
	
p_chr:	addiu	$sp, $sp, -4
	sw	$ra, ($sp)
	addiu	$sp, $sp, -4
	sw	$fp, ($sp)
	addiu	$sp, $sp, -4
	sw	$t0, ($sp)
	addiu	$sp, $sp, -4
	sw	$t1, ($sp)
	addiu	$sp, $sp, -4
	sw	$t2, ($sp)
	addiu	$fp, $sp, 0
	lw	$t0, 20($fp)	# Load Char to print to screen
	nop
	li	$t2, 0xffff0000	# Base Address of memory mapped terminal
p_chr1:	lw	$t1, 8($t2)
	nop
	andi	$t1, $t1, 1
	beqz	$t1, p_chr1	# If not ready, loop back
	nop
	sw	$t0, 12($t2)
	lw	$t2, ($sp)	# Subroutine Epilogue
	addiu	$sp, $sp, 4
	lw	$t1, ($sp)	
	addiu	$sp, $sp, 4
	lw	$t0, ($sp)
	addiu	$sp, $sp, 4
	lw	$fp, ($sp)
	addiu	$sp, $sp, 4
	lw	$ra, ($sp)
	addiu	$sp, $sp, 4
	jr	$ra
	nop

### Subroutine to print string - Pass address in via stack parameter

p_str:	addiu	$sp, $sp, -4
	sw	$ra, ($sp)
	addiu	$sp, $sp, -4
	sw	$fp, ($sp)
	addiu	$sp, $sp, -4
	sw	$t0, ($sp)
	addiu	$sp, $sp, -4
	sw	$t1, ($sp)
	addiu	$fp, $sp, 0
	lw	$t0, 16($fp)	# Load address from parameter on stack
	nop
p_str1:	lb	$t1, ($t0)	# Load char
	nop
	beq	$t1, $0, p_stre	# If NUL character found, branch to end
	nop
	addiu	$sp, $sp, -4	# Push char to print and envoke the subroutine
	sb	$t1, ($sp)
	jal	p_chr
	nop
	addiu	$sp, $sp, 4	# Pop char that was printed
	addiu	$t0, $t0, 1	# Increment pointer to char
	j	p_str1
	nop
p_stre:	lw	$t1, ($sp)	# Restore and return
	addiu	$sp, $sp, 4
	lw	$t0, ($sp)
	addiu	$sp, $sp, 4
	lw	$fp, ($sp)
	addiu	$sp, $sp, 4
	lw	$ra, ($sp)
	addiu	$sp, $sp, 4
	jr	$ra
	nop

### End of File