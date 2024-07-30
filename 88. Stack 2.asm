#/*# Start of file stack2.a */
#
#/*# MIPSMARK 1.0 1/5/98 Copyright 1998 J. Waldron. */
#
## Question:
## The program must sum a sequence of numbers
## stored on the  stack. The word
## on the top of the stack tells you how
## many numbers are in the sequence.
## Do not include this first word in the sum.
##
## Do not rely on the existence on the "test"
## variable, or the code above the 
## dashed line.
##
#/*# Output format must be:		*/
#/*# "sum is = 23"		*/
#include <stdio.h>       /* for printf in C programs */
#include <stdlib.h>	 /* for exit() in C programs */


#/*##############################################
#					 	#
#		text segment			#
#						#
#################################################

	.text		
       	.globl __start 
__start:		# execution starts here  */

	la $t0,test	# This code sets up the stack
	lw $t1,($t0)	# Do not alter
	add $t0,$t0,4
loop:	lw $t2,($t0)
	sub $sp,$sp,4
	sw $t2,($sp)
	add $t0,$t0,4
	add $t1,$t1,-1
        bnez $t1,loop	
	la $t0,test
	lw $t1,($t0)
	sub $sp,$sp,4
	sw $t1,($sp)

			# Stack set up now....

#/* Any changes above this line will be discarded 
# . Put your answer between dashed lines. */
#/*-------------- start cut ----------------------- */

#/* 		*/

	lw $t0, ($sp)		# pop val from stack
	add $sp, $sp, 4		# move stack pointer to next item
	move $t9, $t0		# store size of stack
	li $t1, 1		# set popped item = 0
	li $t2, 0		# set sum = 0
	
pop:
	bgt $t1, $t9, end	# while (popped item > size) -> end
	lw $t0, ($sp)		# pop val from stack
	add $sp, $sp, 4		# move stack pointer to next item
	add $t2, $t2, $t0	# sum = sum + popped val
	addi $t1, $t1, 1	# popped item + 1
	j pop			# go back to while

end:
	la $a0, ans		# print "sum = "
	li $v0, 4
	syscall
	
	move $a0, $t2		# print value of sum from stack
	li $v0, 1
	syscall
	
	la $a0, endl		# print endl
	li $v0, 4
	syscall

	li $v0, 10		
	syscall			# au revoir...

#/*
	j __start	#nasty loop if mips program not exited */
#/*--------------  end cut  -----------------------
# Any changes below this line will be discarded by
# mipsmark. Put your answer between dashed lines.

#################################################
#                                               #
#               data segment                    #
#                                               #
#################################################

        .data			#*/
test:	.word 4,6,7,8,2
ans:	.asciiz "sum is = "
endl:	.asciiz "\n"
#
#/*# End of file stack2.a		*/
