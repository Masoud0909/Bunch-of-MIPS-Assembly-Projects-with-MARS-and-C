#/*# Start of file loop4.a */
#
#/*# MIPSMARK 1.0 1/5/98 Copyright 1998 J. Waldron. */
#
## Question:
## Swap each pair of elements in
## the string "chararray" and
## print the resulting string.
## There will always be an even number
## of characters in "chararray".
## Finally, print endl .
##

#/*# Output format must be:		*/
#/*# "badcfe"		*/
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

	li $t0, 0		# set index to 0
	li $t1, 1		# set next element = 1
loop:
	lb $t2, chararray($t0)# set t2 = element at array index
	beqz $t2, strEnd	# if null go to strEnd
	lb $t3, chararray($t1)# set to next element
	
	#swap the pair of elements from array
	sb $t2, chararray($t1)
	sb $t3, chararray($t0)
	add $t0, $t0, 2	#increment index to next pair 
	add $t1, $t1, 2	#next element
	j loop
strEnd:
	la $a0, chararray	# print swapped chararray
	li $v0, 4		
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
chararray:
	.asciiz "abcdef"
endl:	.asciiz "\n"

#
#/*# End of file loop4.a		*/