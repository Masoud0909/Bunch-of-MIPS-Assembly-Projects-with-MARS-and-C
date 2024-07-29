#/*# Start of file math4.a */
#
#/*# MIPSMARK 1.0 1/5/98 Copyright 1998 J. Waldron. */
#
## Question:
## calculate (num1 + num2 - 7) * num3
## 
#/*# Output format must be:		*/
#/*# "answer = 48"		*/
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
# . Put your answer between dashed lines.
#-------------- start cut -----------------------

	lw $t0, num1	# loads an integer from memory
	lw $t1, num2	
	add $a0, $t0, $t1	# result of addition in $a0
	
	li $t2, 7		# loads a CONSTANT immediately from instr
	sub $a0, $a0, $t2	# add the content of a0 and t2, store in a0
	
	lw $t3, num3	# loads an integer from memory
	mul $a0, $t3, $a0	# multiply the content of t3 and a0, store in a0
	
	move $t4, $a0	# move a0 to t4
	
	li $a0, ans	# put string address into a0
	li $v0, 4		# system call to print
	syscall
	
	move $a0, $t4	# move t4 to a0
	li $v0, 1		# system call to print 
	syscall		# pritn the result to console
	
	la $a0, endl	# put string address into a0
	li $v0, 4		# system call to print 
	syscall
	
	li $v0, 10
	syscall 		# aun revoir ...

#/*--------------  end cut  -----------------------
# Any changes below this line will be discarded 
# . Put your answer between dashed lines.

#################################################
#                                               #
#               data segment                    #
#                                               #
#################################################

        .data			#*/
num1:	.word 7
num2:	.word 6
num3:	.word 8
ans:	.asciiz "answer = "
endl:	.asciiz "\n"
#
#/*# End of file math4.a	
