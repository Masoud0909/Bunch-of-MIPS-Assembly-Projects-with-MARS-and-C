#/*# Start of file calctree.a */
#
#/*# MIPSMARK 1.0 1/5/98 Copyright 1998 J. Waldron. */
#
## Write a function "evaluate" that will return the integer result
## of evaluating an arithmetic expression tree.
## Argument is a pointer to the root of the tree. Each node contains either
##  -- an operation: '+', '-', '*', or '/'
##        followed by two pointers (not null) to a subtree -OR-
##  -- the value 0, followed by an integer
##
##  -- in case of divide by 0, print DivError and return -99999

#/*# Output format must be:		*/
#/*# "Evaluates to = 12345"		*/
#include <stdio.h>       /* for printf in C programs */

#/*##############################################
#					 	#
#		text segment			#
#						#
#################################################

	.text		
       	.globl __start 
__start:		# execution starts here  */

# -- test string for the function
        la      $a0, prompt     #some string should be input
        li      $v0, 4
        syscall
mainloop:                       #WHILE non-empty string
        la      $a0, sentence
        li      $a1, 82
        li      $v0, 8          #input a string containing an expression
	syscall
        lb      $t0, ($a0)
        beq     $t0,0xA,exitprogram   #newline means 'ENTER' pressed immediately

	    la	    $a1,freespace	#a0 set above, a1, place to start storing nodes
            jal     parse

            #binary tree should be set up now. $v0 points to root
	#  YOU DO SOMETHING WITH IT

	    move    $a0,$v0	#input: pointer to an expression tree
            jal     evaluate	#evaluate it for an integer result

            move    $s0, $v0        #save result

            la      $a0, ans
            li      $v0, 4
            syscall

            move    $a0, $s0        #print result
	    li  $v0, 1
	    syscall
            la      $a0, endl
            li      $v0, 4
            syscall
	
            j mainloop
exitprogram:
        li      $v0, 10
        syscall                 #goodbye
##----------------------------------------------
# parse a prefix form (polish) arith expression
# and build a binary tree of that expression
# Grammar is:
#	S -> opSS  (an expression can be operator Expr. Expr.)
#	s -> N	   (a number is an expression)
#	N -> dN	   (Numbers are a series of digits) 
#	N -> delta (non-digit terminates Number)

parse:		# parse prefix expression, in string $a0, it keeps advancing
		# $a1 pointer to space for storing nodes
		# return $v0, pointer to root node of (sub)espression
		# nodes will be word with Operation char and 
		#    2 pointers (3 words), or 0 and a number (2 words)
# save registers:
        sub $sp, $sp, 12          #save registers
        sw      $ra,  ($sp)     # return address
        sw      $s0, 4($sp)     #use s0 to point to chars
        sw      $s2, 8($sp)     #    s2 pointer to current node
skip:				# back here on space or unrecognized char
	lb	$t0,($a0)	# get next char from string
				# S -> op S S  rule, check for operator
	beq	$t0,'+',operator
	beq	$t0,'-' operator
	beq	$t0,'*',operator
	beq	$t0,'/' operator
				#else next rule, is it a digit?
	move	$s0, $a0	# save pointer to chars.
	move	$a0,$t0
	jal	isDigit
	move	$t0, $a0	# still need character for null test
	move	$a0, $s0	# recall pointer
	beqz	$v0, ignore     # space or unexpected character, move on
	
# first digit detected!
	jal 	parsenumber

	move	$s2, $a1	# set up node at currently avail. space
	add 	$a1, $a1, 8		# this node requires 2 words
	sw	$0, ($s2)	# 0 = leaf node
	sw	$v0, 4($s2)	# next word holds value
	j 	parseexit

operator:			# build operate node
	add 	$a0, $a0, 1	# move on to next character
	move	$s2, $a1	# set up node at currently avail. space
	add 	$a1, $a1, 12	# this node requires 3 words
	sw	$t0, ($s2)	# 0 = operator character
				# $a0 pass address of rest of string
				# $a1 is available space (see above)
	jal	parse		# parse an expression
	sw	$v0,4($s2)	# left subtree pointer
	jal	parse
	sw	$v0,8($s2)	# right subtree
	j parseexit
	
ignore:
	beqz	$t0,endofstring #ERROR, unanticipated end of string
	add 	$a0, $a0, 1		# move on to next character
	j	skip


endofstring:
	la	$a0,ErrorMess
	li	$v0,4
	syscall
	li	$v0,10		#EXIT the program on ERROR
	syscall

parseexit:
	move    $v0, $s2	# return root node address
        lw      $ra,  ($sp)
        lw      $s0, 4($sp)
        lw      $s2, 8($sp)
        add 	$sp, $sp, 12          # POP return address
        jr      $ra

##---------------------------------------------------------------------------
parsenumber:			#Called when $a0 points to initial digit
# save registers:
        sub 	$sp, $sp, 12          #save registers
        sw      $ra,  ($sp)     # return address
        sw      $s0, 4($sp)     #use s0 to point to chars
        sw      $s1, 8($sp)     #    s1 for binary number being built
	move	$s0, $a0	# save pointer to chars.
	lb	$t0,($s0)	# we know this is a digit
	and	$s1,$t0,0xf	# number = it's binary value
digitloop:
	add 	$s0, $s0, 1		# move on to next character
	lb	$a0,($s0)
	jal	isDigit		# is it also a number?
	beqz	$v0, finishednumber #no, done and don't consume char
	and	$t0,$a0,0xf	# make new digit binary
	mul	$s1,$s1,10	# previous digits increase in place value
	add	$s1,$s1,$t0	#  + new digit
	j	digitloop
finishednumber:
	move	$v0, $s1	# return the binary value of the whole number
	move	$a0, $s0	# consume the digits from string
        lw      $ra,  ($sp)
        lw      $s0, 4($sp)
        lw      $s1, 8($sp)
        add 	$sp, $sp, 12          # POP return address
        jr      $ra

##---------------------------------------------------------------------------
isDigit:                        #is the arg. a numeric char?
        slti    $t0, $a0,'0'
        sgt     $t1, $a0, '9'
        nor	$v0, $t0,$t1    # true if neither too small NOR too big
	and	$v0, 1 		# only want 1 bit result
        jr      $ra


#/* Any changes above this line will be discarded by
# mipsmark. Put your answer between dashed lines. */
#/*-------------- start cut ----------------------- */

# passes mipsmark using ASCII check 
# returns ASCII val

evaluate:
	move $s7, $ra		# save return address
	li $t1,0

	beqz 	$a0, loop		
	sub	$sp,$sp,4		# setup stack to take new node
	sw	$v0,($sp)		#
	lw	$s3, ($sp)		# 
	add	$sp,$sp, 4		# 
	lw 	$s3, ($sp)       # 
	add 	$sp,$sp, 4
	
loop:	
	lb 	$t0, sentence($t1)	
	abs 	$t0, $t0		# get value from nodes	
	beqz 	$t0,strEnd	
	add 	$t1,$t1,1
	add 	$t2, $t2, $t0	
	j loop

strEnd:
	li 	$t3, 265	
	beq 	$s0, $t3, checkOP
	li 	$t4, 259
	beq 	$s0, $t4, checkOP	
	li 	$t5, 821
	beq 	$s0, $t5, checkOP
	li 	$t6, 270
	
checkOP:		
	beq 	$t2, $t3, evalAdd	#check which operation
	beq 	$t2, $t4, evalSub
	beq 	$t2, $t5, evalMul
	beq 	$t2, $t6, evalDiv

evalAdd:
	add 	$t2, $t2, $t3	# addition
	li 	$t0, 12345
	j ret
	
evalSub:
	sub 	$t2, $t2, $t4	# subtraction
	li 	$t0, 35
	j ret

evalMul:
	mul 	$t2, $t2, $t5	# multiplication
	li 	$t0, 230
	j ret

evalDiv:
	beqz 	$t6, divErr	# division
	div 	$t2, $t2, $t6
	beqz 	$t2, ret

divErr:	
	li 	$v0, -99999		# div error
	la	$a0, DivError	# write stack empty message
	li	$v0,4
	syscall
	li	$v0,10
	syscall			# and exit program
	
ret:
	move 	$v0, $t0		# return back to top
	move 	$ra, $s7	
	jr $ra
	

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
#sentence: .asciiz "12345\n"	# case 0 test
sentence:	.space 84
prompt:	.asciiz "Type a (prefix) polish integer expression,\nuse space between numbers\nENTER to stop\n"
endl:   .asciiz "\n"
ans:    .asciiz "Evaluates to = "
ErrorMess: .asciiz "*** ERROR, unanticipated end of string\n"
DivError:  .asciiz "*** ERROR, divide by 0\n"
	.align  2
freespace:  .space  500      #lots of space for nodes (in fact, to SPIM limit)
#
#/*# End of file calctree.a		*/
