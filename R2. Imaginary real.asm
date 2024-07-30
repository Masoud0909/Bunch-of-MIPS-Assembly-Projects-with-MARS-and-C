#/*# Start of file real4.a */
#
#/*# MIPSMARK 1.0 1/5/98 Copyright 1998 J. Waldron. */
#
##	Write a function ffact that will compute
##	the Factorial of the integer passed in $a0
##		0! = 1! = 1.0
##		n! = (n-1)! * n
##	calculate it as a real number using double precision
##	as factorials get very large very soon
##
##	return the answer in coprocessor register $f12
#/*# Output format must be:		*/
#/*# "5! is 120"		*/


#/*##############################################
#					 	#
#		text segment			#
#						#
#################################################

	.text		
       	.globl __start 
__start:		# execution starts here  */

	la $a0,ans	# print a string n 
	li $v0,4
	syscall

	lw $a0, num
	jal ffact	#to calculate num! (factorial)
	li $v0,1	#print DOUBLE in $f12, as returned
	syscall
	li $v0,4	#print endline
	la $a0,endl
	syscall

	li $v0,10	#exit
	syscall

#/* Any changes above this line will be discarded by
# mipsmark. Put your answer between dashed lines. */
#/*-------------- start cut ----------------------- */


#ffact:
#li $t0,0
#l.d $f12,one #load one
#l.d $f10,one #Load one
#loop:
#beq $t0,$a0,exitLoop
#add.d $f0,$f0,$f10 #get number to multiply
#mul.d $f12,$f12,$f0
#add $t0,$t0,1 #increase i by one
#j loop
#exitLoop:
#jr $ra

# one: .double 1


ffact:
move $s7, $a0
#5 in f2
mtc1.d $a0, $f2
cvt.d.w $f2, $f2
#1 in f4 and f12
addi $t0,$0,1
mtc1.d $t0, $f4
cvt.d.w $f4, $f4
mov.d $f12,$f4
#5*4*3*2*1
Loop:
c.eq.d $f4, $f2
bc1t ret
mul.d $f12,$f12,$f2
sub.d $f2,$f2,$f4
j Loop

ret:
move $f12, $a0
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
num:	.word  5
ans:	.asciiz "5! is "
endl:	.asciiz "\n"
#
#/*# End of file real4.a		*/
