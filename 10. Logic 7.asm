#/*# Start of file logic7.a */
#
#/*# MIPSMARK 1.0 1/5/98 Copyright 1998 J. Waldron. */
#
## Question:
## "number" is a word.
## If bit 0 is set then set bits 1, 2 
## and 3 and print out the result.
## If bit 0 is cleared then clear bits 1, 2 
## and 3 and print out the result.
##
#/*# Output format must be:		*/
#/*# "result is = 1088"		*/
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

## You may un-comment these lines to input your own number:

#	la $a0, prompt
#	li $v0, 4
#	syscall
#	li $v0, 5	# input integer
#	syscall
#	sw $v0, number

#/* Any changes above this line will be discarded by
# mipsmark. Put your answer between dashed lines. */
#/*-------------- start cut ----------------------- */

#/*  Student's Name: 		Account: 		*/

	lw $t0, number		
	move $t1, $t0
	or $t1, $t1, 0xf
	li $t2, 2
	div $t0, $t2	
	mfhi $t3

	bne $t3, $zero, print
	sub $t1, $t1, 0xf

print:
	la $a0, ans		# print ans
	li $v0, 4
	syscall

	move $a0, $t1	# print val
	li $v0, 1
	syscall

	la $a0, endl	# print endl
	li $v0, 4
	syscall

	li $v0, 10
	syscall		# au revoir...


#/*--------------  end cut  -----------------------
# Any changes below this line will be discarded by
# mipsmark. Put your answer between dashed lines.

#################################################
#                                               #
#               data segment                    #
#                                               #
#################################################

        .data			#*/
number:	.word 0x448
ans:	.asciiz "result is = "
endl:	.asciiz "\n"
prompt:	.asciiz "type a number: "
#
#/*# End of file logic7.a	