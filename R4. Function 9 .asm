#/*# Start of file funct9.a */
#
#/*# MIPSMARK 1.0 1/5/98 Copyright 1998 J. Waldron. */
#
## Question:
##
## $a0 is the address of an array of integers (word)
## $a1 is the number of words in that array
##
## Write a function "countwords" that returns
## the SUM of words in an integer array $a0
## that return a non-zero value when passed to the
## "checknum" function. 
## Otherwise checknum returns 0.
## do not rely on the label "mynums" or the 
## particular implementation of "checkit"
## 

#/*# Output format must be:		*/
#/*# "sum of words that pass test = 13"		*/
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
	
	la $a0,mynums
	lw $a1,len
	jal countwords	# call student's function

	move $a0,$v0
	li $v0,1	# print out returned value
	syscall 

	la $a0,endl	# system call to print
	li $v0,4	# out a newline
	syscall

	li $v0,10
	syscall		# auf Wiedersehen


#
# checknum is a function which takes a word
# in a0,  and returns either 0 or non-zero in v0,
# depending on the result of some test.
# Do not rely of the particular operation performed
# by checknum or the registers used.
# These will be different in other mipsmark cases.
#

checknum:
	slti $v0,$a0,42
        jr $ra

#/* Any changes above this line will be discarded by
# mipsmark. Put your answer between dashed lines. */
#/*-------------- start cut ----------------------- */

countwords:
        move $s7, $ra           # s7 = address of next operation
        move $s1, $a0           # s1 = address of string
        sub $sp, $sp, 4
        sw $s0, ($sp)		# push save value to stack
        li $s6, 0               # sum = 0
        move $s2, $a1		# len = value passed by argument
        li $s5, 0		# counter = 0

loop:
        lw $s3, ($s1)           # load char from string
	beq $s5, $s2, strEnd	# if counter == len goto strEnd
        move $a0, $s3		# else move char to argument
        jal checknum            # call checknum with argument
        addi $s1, $s1, 4        # go to next element in address
        addi $s5, $s5, 1	# increment len
        beqz $v0, loop		# if return val is zero restart
        add $s6, $s6, $s3       # else add sum value returned from checkch
        j loop
        
strEnd:
        move $v0, $s6           # load sum to v0
        move $ra, $s7           # load address at s7 to next operation

	lw $t0, ($sp)		# pop stored value from stack
	add $sp, $sp, 4
	beqz $t0, ret		# if val is zero no test required

        move $s0, $t0           # reset the s registers
        move $s1, $t0           
        move $s2, $t0           
        move $s3, $t0
        move $s4, $t0
        move $s5, $t0
        move $s6, $t0
        move $s7, $t0

ret:
        jr $ra                          # return to main

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
mynums:	.word	1, 2, 3, 67, 42, 55, 0, 7
len:	.word	8
ans:	.asciiz "sum of words that pass test = "
endl:	.asciiz "\n"
#
#/*# End of file funct9.a		*/
