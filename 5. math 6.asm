#/*# Start of file math6.a */
#
#/*# MIPSMARK 1.0 1/5/98 Copyright 1998 J. Waldron. */
#
## Question:     (Linear interpolation)
## Given a straight line and a value x, 
##      find the value y so that (x,y) is on the line
## The line is given by its slope dy/dx as integers, 
##     and the y-axis intercept
##
##  Since we are doing integer arithmetic, the answer will not be exact
##  Divide as late as possible, and ignore possible remainder
##
#/*# Output format must be:		*/
#/*# "answer = 13"		*/
#include <stdio.h>       /* for printf in C programs */

#/*##############################################
#					 	#
#		text segment			#
#						#
#################################################

	.text		
       	.globl __start 
__start:		# execution starts here  */

#/* Any changes above this line will be discarded 
# . Put your answer between dashed lines. */
#/*-------------- start cut ----------------------- */

	lw $t0, dy		# loads an integer form memory
	lw $t1, dx		# loands an integer from memory
	lw $t2, x		# loads an integer from memory
	mul $s0, $t0, $t2	# multiply t0 and t2, store final result in s0
	div $s0, $t1	# divide s0 / t1
	mflo $s1		# move quotent of division to s1
	lw $t3, intercept	# loads an integer from memory
	add $s2, $s1, $t3 	# add s1 and t3, store final result in s2 
	
	la $a0, ans 	# put string address into a0
	li $v0, 4		# system call to print string
	syscall		# out a string
	
	move $a0, $s2	# move s2 to a0
	li $v0, 1		# system call to print integer
	syscall 		# print to console
	
	la $a0, endl	# next line command
	li $v0, 4		# system call to print 
	syscall		# out (execute to the console ) 
	
	li $v0, 10
	syscall		# au revoir ...
	
	

#/*--------------  end cut  -----------------------
#################################################
#                                               #
#               data segment                    #
#                                               #
#################################################

        .data			#*/
x:	.word 9		#find y for this value
dy:	.word 10	# vertical rise
dx:	.word 6		# horizontal run
intercept: .word -2	#line crosses y-axis here
y:	.word -99	#may optionally use this memory...
temp:	.word  0
ans:	.asciiz "answer = "
endl:	.asciiz "\n"
#
#/*# End of file math6.a		*/