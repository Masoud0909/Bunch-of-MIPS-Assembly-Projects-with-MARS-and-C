#/*# Start of file funct7.a */
#
#/*# MIPSMARK 1.0 1/5/98 Copyright 1998 J. Waldron. */
#
## Question:
##
## Write a function "strchk" that returns
## the number of characters in a string $a0
## that return a 1 when passed to the
## "checkch" function.
## Otherwise checkch returns 0.
## do not rely on the label "str" or the 
## particular implementation of "checkch"
## 

#/*# Output format must be:		*/
#/*# "number of characters that pass test = 3"		*/
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


	la $a0,ans
	li $v0,4	# print out string
	syscall 
	
	la $a0,str
	jal strchk	# call strchk function

	move $a0,$v0
	li $v0,1	# print out returned value
	syscall 

	la $a0,endl	# system call to print
	li $v0,4	# out a newline
	syscall

	li $v0,10
	syscall		# au revoir...


#
# checkch is a function which takes a character
# in a0,  and returns either 0 or 1 in v0,
# depending on the result of some test.
# Do not rely of the particular operation performed
# by checkch or the registers used.
# These will be different in other mipsmark cases.
#

checkch:
        li $v0,0
        beq  $a0,'a',yes
        beq  $a0,'e',yes
        beq  $a0,'i',yes
        beq  $a0,'o',yes
        beq  $a0,'u',yes
        jr $ra
yes:    li $v0,1
        jr $ra

#/* Any changes above this line will be discarded 
# . Put your answer between dashed lines. */
#/*-------------- start cut ----------------------- */

#/*  			*/

strchk:
	move $s7, $ra		# s7 = address of next operation
	move $t7, $a0		# t7 = address of string
	li $s1, 0		# sum = 0

loop:
	lb $t0, ($t7)		# load char from string
	beqz $t0, strEnd	# stop when end of string
	move $a0, $t0
	jal checkch		# call checkch
	add $s1, $s1, $v0	# add sum value returned from checkch
	add $t7, $t7, 1		# go to next element
	j loop	

strEnd:
	move $v0, $s1		# load sum to v0
	move $ra, $s7		# load address at s7 to next operation
	jr $ra			# return to main

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
str:	.asciiz "aei0956xyz\n"
ans:	.asciiz "number of characters that pass test = "
endl:	.asciiz "\n"
#
#/*# End of file funct7.a		*/
