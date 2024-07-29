#/*# Start of file math2.a */
#
#/*# MIPSMARK 1.0 1/5/98 Copyright 1998 J. Waldron. */
#
## Question:
## calculate 5*X^2-3
## 
#/*# Output format must be:		*/
#/*# "answer = 242"		*/
#include <stdio.h>       /* for printf in C programs */

#/*##############################################
#					 	#
#		text segment			#
#						#
#################################################

	.text		
       	.globl __start 
__start:		# execution starts here  
#/* Any changes above this line will be discarded by
# mipsmark. Put your answer between dashed lines. */
#/*-------------- start cut ----------------------- */

	lw $t0, X		# load int from memory
	mul $t0, $t0, $t0	# multiply t0 * t0, store in t0
	li $t1, 5		# set t1 = 5
	li $t2, 3		# set t2 = 3
	
	mul $t0, $t0, $t1	# multiply t0 * t1, store in t0
	sub $t0, $t0, $t2	# subtract t0 - t2, store in t0
	
	la $a0, ans	# print 
	li $v0, 4		# 4 to print string
	syscall 		
	
	move $a0, $t0	# print value of calculated number
	li $v0, 1		# 1 to print integer
	syscall
	
	la $a0, endl
	li $v0, 4
	syscall
	
	li $v0, 10		#finish
	syscall 		# au revoir . . .

#/*--------------  end cut  -----------------------
# Any changes below this line will be discarded by
# mipsmark. Put your answer between dashed lines.

#################################################
#                                               #
#               data segment                    #
#                                               #
#################################################

        .data			#*/
X:	.word 7
ans:	.asciiz "answer = "
endl:	.asciiz "\n"
#
#/*# End of file math2.a		*/
