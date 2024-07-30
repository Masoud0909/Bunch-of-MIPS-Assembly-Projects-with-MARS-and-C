#/*# Start of file stack8.a */
#
#/*# MIPSMARK 1.0 1/5/98 Copyright 1998 J. Waldron. */
#
## Question:
## The program must sum the negative numbers in 
## a sequence of "count" numbers stored on the stack
## and print out the total.
##
## Do not rely on the existence on the "test"
## variable, or the code above the 
## dashed line.
##
#/*# Output format must be:		*/
#/*# "sum is = -15"		*/
#include <stdio.h>       /* for printf in C programs */

#/*##############################################
#					 	#
#		text segment			#
#						#
#################################################

	.text		
       	.globl __start 
__start:		# execution starts here  */

	la $t0,test	# This code sets up the stack
	lw $t1,count
loop:	lw $t2,($t0)
	sub $sp,$sp,4
	sw $t2,($sp)
	add $t0,$t0,4
	add $t1,$t1,-1
        bnez $t1,loop

			# Stack set up now....

#/* Any changes above this line will be discarded by
# mipsmark. Put your answer between dashed lines.
#-------------- start cut -----------------------

#get count
   	lw $t1,count
   #Variable for sum storage
	addi $t0,$0,0
#sum of negative numbers finding loop
sumLoop:
   #Stack top value
	lw $t2,($sp)
    #Check for negative
	bgez $t2,next
    #If negative
	add $t0,$t0,$t2
#Get stack top,decrement count
next:
	add $sp,$sp,4
	addi $t1,$t1,-1
   #Check loop condition check
	bnez $t1,sumLoop
#Display result message
	addi $v0,$0,4
	la $a0,ans
	syscall
#Display result
	addi $v0,$0,1
	add $a0,$0,$t0
	syscall
#Get next line
	addi $v0,$0,4
	la $a0,endl
	syscall
#end of the program
	addi $v0,$0,10
	syscall

#/*--------------  end cut  -----------------------
# Any changes below this line will be discarded by
# mipsmark. Put your answer between dashed lines.

#################################################
#                                               #
#               data segment                    #
#                                               #
#################################################

        .data			#*/
test:	.word 4,-6,-9,0,8
count:	.word 5
ans:	.asciiz "sum is = "
endl:	.asciiz "\n"
#
#/*# End of file stack8.a		*/
