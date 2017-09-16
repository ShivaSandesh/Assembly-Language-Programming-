# Shiva Sandesh
# 04/25/2016
# Final Project
# Set up (enable) interrupts, and then loop examining a variable
#  until the user tells the program to quit. 
	.data
source:	.asciiz "AbcD 3456 EfGh IjKl 789 MnOP qRsT uVwX yZ12 \n"  
q:	.word 0				# for the quit flag
display: .space 50

	.text
	.globl main
main:	addiu	$sp, $sp, -4
	la	$t0, source		# load the address of 'source' in $t0
	sw	$t0, ($sp)		# push the address of 'source' to stack
	addiu	$sp, $sp, -4
	la	$t0, display		# load the address of 'display' in $t0
	sw	$t0, ($sp)		# push the address of 'display' to stack
	jal	copy	
	addiu	$sp, $sp, 8		# pop back the space on stack

	# Enable Interrupts in Memory Mapped I/O and set the Status register in kernel
	li	$s0, 0xC01		# to turn on the status register in kernel
	mtc0	$s0, $12		# mtc0 to talk to the kernel 
	li	$s0, 2			# 2 is 10 in binary to set registers 
	sw	$s0, 0xffff0000		# enable interrupt for receiver control 
	sw	$s0, 0xffff0008		# enable interrupt for transmitter control 

quitf:	lw	$t0, q			# load boolean quit into $t0
	beqz	$t0, quitf		# if flag off loop to check again

	li	$v0, 10			# quit if flag on
	syscall
	# Interrupt in Memory Mapped I/O enabled and Status register in kernel set

### Subroutine for copying the 'source' to 'diplay' starts here ###

copy:	addiu	$sp, $sp, -4		
	sw	$ra, ($sp)		# push caller's return address to stack
	addiu	$sp, $sp, -4
	sw	$fp, ($sp)		# push	caller's frame pointer to stack
	move	$fp, $sp		# $fp = $sp
	lw	$t0, 8($fp)		# load the address of the 'display' 
	lw	$t1, 12($fp)		# load the address of the 'source' 
chrcpy:	lb	$t2, ($t1)		# load a byte into register
	sb	$t2, ($t0)		# save it to the 'destination' 
	beqz	$t2, copied
	addiu	$t1, $t1, 1		# increment the source pointers 
	addiu	$t0, $t0, 1		# increment the display pointers 
	b	chrcpy
copied:	move	$sp, $fp		# $sp = $fp+ local variables
	lw	$fp, ($sp)		# load callers $fp
	addiu	$sp, $sp, 4		# pop callers $fp
	lw	$ra, ($sp)		# user's return address
	addiu	$sp, $sp, 4		# pop callres $ra
	jr	$ra			# return to subroutine

### Subroutine for copying the 'source' to 'diplay' ends here ###

### Kernel segment use started from here for the interrupt handler ###
	.kdata
s_at:	.word 0
s_s0:	.word 0
s_t0:	.word 0
s_t1:	.word 0
s_t2:	.word 0
index:	.word 0
	.ktext 0x80000180		# kernel entry point
	.set noat
	move	$k0, $at		# save $at in a safe place
	.set at		
	sw	$k0, s_at
	sw	$s0, s_s0
	sw	$t0, s_t0
	sw	$t1, s_t1
	sw	$t2, s_t2	
	
	mfc0	$t0, $13		# extract the cause register
	andi	$t1, $t0, 0x400		# get the transmitter bit
	bnez	$t1, print		# if trasmitter bit on, print the string
	andi	$t1, $t0, 0x800		# get the receiver bit
	bnez	$t1, getC		# if receiver bit on, get the command

	## if none of this is applicable end the proram
	b	endIt
print:	lw	$t0, index
	lb	$t1, display($t0)	# get the char to be displayed
	beqz	$t1, setInd
	sw	$t1, 0xffff000c         # print character
	addiu	$t0, $t0,1
	b 	doit
setInd:	li	$t0, 0	
doit:	sw	$t0, index
	b	endIt

getC:	li	$t2, 0xffff0004		# to get the entered data
	lb	$t0, ($t2)
	li	$t1, 'q'		# if entered char == 'q', exit
	beq	$t0, $t1, quit
	li	$t1, 's'		# if entered char == 's', sort
	beq	$t0, $t1, sort
	li	$t1, 't'		# if entered char == 't', toggle
	beq	$t0, $t1, toggle
	li	$t1, 'a'		# if entered char == 'a', replace
	beq	$t0, $t1, replace
	li	$t1, 'r'		# if entered char == 'r', reverse
	beq	$t0, $t1, reverse
	b	endIt

### 'a': replace display array elements with the source elements once again ###
replace:li	$s0, '\n'
	la	$t0, source	
	la	$t1, display	
nxtch:	lb	$k0, ($t0)
	sb	$k0, ($t1)	
	beq	$k0, $s0, endIt 
	addiu	$t0, $t0, 1	
	addiu	$t1, $t1, 1	
	b	nxtch		
### 'r': reverse the elements in the display array (excluding the '\n')     ###
reverse:la	$s0, display		# load the address of 'dispaly'
rCheck: lb	$t0, ($s0)
	beqz	$t0, strtc		# loop to get to the end of the string
	addiu	$s0, $s0, 1		
	b	rCheck
strtc:	addiu	$s0, $s0, -2		# $s0=null now, but back of two places
	la	$t0, display
eachar:	ble	$s0, $t0, endIt		# check if indices have crossed or not
	lb	$t1, ($s0)		# load the bytes
	lb	$t2, ($t0)
	sb	$t1, ($t0)		# save them here 
	sb	$t2, ($s0)
	addiu	$t0, $t0, 1		# increement the pointers
	addiu	$s0, $s0, -1
	b	eachar

### 's': sort the display array using any easy sort routine ###
# for (int i = 0; i < size - 1 && ifswapped; i++)
# {
#	for (int j = i+1; j < size ; j++)
#	{
# 		if (array[i] < array[j])
#		{
#			swap(array[i], array[j])
#		}
#	}
#}
sort:   la	$t0, display
	addiu	$t1, $t0, 1		# for the next character in the string
	li	$s0, '\n'
check:	lb	$k0, ($t0)
	lb	$k1, ($t1)
	beq	$k0,$s0, endIt		# check if $k0 ==newline , then end loop
	beq	$k1,$s0, iplus		# to increement the outer loop variable
	bgt	$k0, $k1, swap			
jplus:	addiu	$t1, $t1, 1
	b	check
iplus:	addiu	$t0, $t0, 1		# increement the loop variables
	addiu	$t1, $t0, 1
	b	check			
swap:	sb	$k0, ($t1)
	sb	$k1, ($t0)
	j	jplus
	
### 't': toggle the case of every alphabetic characters     ###
toggle:	la	$s0, display		# load the address of the display string	
        lb	$t0, ($s0)		# load the current character to $t0
toglch: beqz	$t0, endIt		# if $t0==null stop processing the string
	li	$t1, 0x41		# $t1 = 'A'
	blt	$t0, $t1, gnext
	li	$t1, 0x5a		# $t1 = 'Z'
	ble	$t0, $t1, lower
	li	$t1, 0x61		# $t1 = 'a'
	blt	$t0, $t1, gnext
	li	$t1, 0x7a		# $t1 = 'z'
	ble	$t0, $t1, upper
lower:	addiu	$t0, $t0, 32
	b	gnext
upper:	addiu	$t0, $t0, -32
	b	gnext	
gnext:	sb	$t0, ($s0)
	addiu	$s0, $s0,1
	lb	$t0, ($s0)		# load the current character to $t0
	b	toglch	
### 'q': quit -- terminate program execution   ###
quit: 	li	$t0, 1			# load $t0 with 1 to quit the program
	sw	$t0, q			# save to q 
	b	endIt

## End of Interrupt handler ---- Restore the saved regiester in reverse ###
endIt:  lw	$t2, s_t2
	lw	$t1, s_t1
	lw	$t0, s_t0
	lw	$s0, s_s0
        lw	$k0, s_at
	.set	noat
	move	$at, $k0
	.set	at
	eret
	