#/*# Start of file gcd.a */
#
#/*# MIPSMARK 1.0 1/5/98 Copyright 1998 J. Waldron. */
#
## Question:
## Write a function "gcd" that takes two
## numbers in $a0 and $a1, and returns their
## greatest common divisor. Both numbers will
## be greater than zero.
## Use Euclid's algorithm, based upon
##    gcd(a, a) = a
##    gcd(a, b) = gcd(b, a)
##    gcd(a, b) = gcd(a-b, b) {use with a>b}
##
#/*# Output format must be:		*/
#/*# "GCD is = 3"		*/
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
	li $v0,4
	syscall

	li $a0,39
	li $a1,24
	jal gcd	# call  function

	move $a0,$v0
	li $v0,1
	syscall 

	la $a0,endl	# system call to print
	li $v0,4	# out a newline
	syscall

exit:	li $v0,10
	syscall		# au revoir...

#/* Any changes above this line will be discarded 
# . Put your answer between dashed lines. */
#/*-------------- start cut ----------------------- */


    gcd:
        beq $a0, $a1, done  #if "a" ($a0) is finally equal to "b" ($a1), proceeds to "exit"
        sgt  $v0, $a1, $a0      #is the value of "b" greater than "a"?
        bne $v0, $zero, loop    #if true: proceeds to "loop", if false: continues on

        subu $a0, $a0, $a1  #subtracts "b" from "a" (b < a)
        b gcd           #returns back to "gcd" and repeats

    loop:
        subu $a1, $a1, $a0  #Subtracts "a" from "b" (a < b)
        b gcd           #returns back to "gcd" and repeats
        
    done:
        move $v0, $a0       #return "a"
        jr $ra


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
ans:	.asciiz "GCD is = "
endl:	.asciiz "\n"
#
#/*# End of file gcd.a		*/
