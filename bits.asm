#/*# Start of file bits.a */
#
#/*# MIPSMARK 1.0 1/5/98 Copyright 1998 J. Waldron. */
#
## Question:
##  change the case of all letters in the string "ans"
## simplifying assumption: All characters >='A' are letters
##  (no test cases will use {}[], etc)
## Divide "number" by 32, using shift, not div
##
## Then print "ans" followed by "number" and a newline 
#/*# Output format must be:		*/
#/*# "num Divided By 32 = -1024"		*/

#/*################################################
#					 	#
#		text segment			#
#						#
#################################################

	.text		
       	.globl __start 
__start:		# execution starts here  */


#/* Any changes above this line will be discarded by
# mipsmark. Put your answer between dashed lines.
#-------------- start cut -----------------------

	lw $t0, number # 	
	sra $t1, $t0, 5 # 32 = 2^5 so shift right by 5 to divide by 32

	
	li $t9, 65		# ascii A = 65
	move $s0, $t9		# set s0 = 65
	li $t9, 90		# ascii Z = 90
	move $s1, $t9		# set s1 = 90
	li $t9, 97		# ascii a = 97
	move $s2, $t9		# set s2 = 97
	li $t9, 122		# ascii z = 122
	move $s3, $t9		# set s3 = 122
		
	li $t2, 0	# index for ans
	li $t5, 32	# to be used to change case
loop:	
	lb $t3, ans($t2)	# load letter to t3
	beqz $t3, print		# branch at end of string
	# if t3 < 65 or t3 > 90
	blt $t3, $s0, testSmall
	bgt $t3, $s1, testSmall
	add $t3, $t3, $t5	# change to lower case
	j save
	
testSmall:		
	# if t3 < 97 or t3 > 122
	blt $t3, $s2, save
	bgt $t3, $s3, save
	sub $t3, $t3, $t5	# change to upper case
	
	#move $t4, $t3		# save letter val to t4
	#or $t3, $t3, 32		# bitwise to lower case
	#bne $t3, $t4, save	# if letter case does not match -> save
	#li $t5, 32		# space needs to be fixed
	#not $t5, $t5
	#and $t3, $t3, $t5
save:	
	sb $t3, ans($t2)	# store char
	add $t2, $t2, 1		# index++
	j loop			# restart loop

print:
	la $a0, ans		# print string
	li $v0, 4
	syscall
	
	move $a0, $t1		# print divided number
	li $v0, 1
	syscall

	la $a0, endl		# print endl
	li $v0, 4
	syscall
	
	li $v0, 10
	syscall			# au revoir...


#/*--------------  end cut  -----------------------
# Any changes below this line will be discarded 
# . Put your answer between dashed lines.

#################################################
#                                               #
#               data segment                    #
#                                               #
#################################################

        .data			#*/
number:	.word -32760
ans:	.asciiz	"NUM dIVIDED bY 32 = "
endl:	.asciiz "\n"

#
#/*# End of file bits.a		*/
