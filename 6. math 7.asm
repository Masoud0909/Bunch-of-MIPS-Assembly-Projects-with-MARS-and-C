#/*# Start of file math7.a */
#
#/*# MIPSMARK 1.0 1/5/98 Copyright 1998 J. Waldron. */
#
## Question:
##  Given a distance and a speed (per hour), 
##	Find the time required to take a trip.
##	Answer in in hours and minutes
##	Ignore fractions of a minute.
##

#/*# Output format must be:		*/
#/*# "2 hours and 35 minutes"		*/
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


#/* Any changes above this line will be discarded
#. Put your answer between dashed lines. */
#/*-------------- start cut ----------------------- */
	lw $t0, distance	# loads an integer from memory
	lw $t1, speed	# loads an integer from memory
	li $t3, 60		# for per hour
	
	div $t0, $t1	# divide t0/t1
	mflo $s0		# move quotent of division to s0
	mfhi $s1		#  "  "    "    "    to s1
	
	mul $t2, $t3, $s1	# calculating per hour
	div $t2, $t1	# t2/t1
	mflo $s2		# move quotent to s2
	
	move $a0, $s0	# move to quotent of division of t0/t1 to a0
	li $v0, 1		# system call to print integer
	syscall 		# print the result 	
	
	la $a0, hstr	# string of "hours and" to a0 from memory
	li $v0, 4		# to print the string 
	syscall		# out a string
	
	move $a0, $s2	# move the result division of t2/t1 to a0
	li $v0, 1		# to print out a intger
	syscall
	
	la $a0, mstr	# string of " minutes\n" to a0 from memory 	
	li $v0, 4		# print out a string
	syscall		# call system to out the string
	
	li $v0,10
	syscall		# au revoir . . .
	
#/*
	j __start	#nasty loop if mips program not exited */
#/*--------------  end cut  -----------------------
# Any changes below this line will be discarded 
# . Put your answer between dashed lines.

#################################################
#                                               #
#               data segment                    #
#                                               #
#################################################

        .data			#*/
#distance:	.word	155
#speed:	.word	60
distance:	.word	1234
speed:	.word	110

hstr:	.asciiz " hours and "
mstr:	.asciiz " minutes\n"
#
#/*# End of file math7.a		*/