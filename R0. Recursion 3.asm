#/*# Start of file recur3.a */
#
#/*# MIPSMARK 1.0 1/5/98 Copyright 1998 J. Waldron. */
#
## Question:
##
## Write a function named traverse that will
## do an preorder traverse of a binary tree.
##
##	RETURN the sum of all fruit found
##
## The tree defined in the data segment such that 
## an INorder traverse would be alphabetical
## in preorder, the root node will come first
##
## The argument to travrese is a pointer to
##  a node of the tree, 
##
## A node consists fo 4 words:
##	name - address of string such as "apple"
##	left - pointers to child nodes	visit LEFT first
##	right    "           "		then RIGHT
##	value - an integer, might represent number of apples, for example
##
##  IMPORTANT!!
##	A value of 0 indicates a dead branch. It has no apples, 
##	and any further branches will also be dead,
##	 so return the value 0 immediately
##
## The code for traverse could look like:
##
##	if (pointer is null OR value is 0) return 0 	
##		  print_name (name)
##	   val1 = traverse   (left)
##	   val2 = traverse   (right)
##           return val1 + val2 + value  # sum of all values found so far
##
##
## Output format should follow the pattern:
## "apple, apricot, orange, peach, pear, pineapple 42"
## 
#/*# Output format must be:		*/
#/*# "peach, avocado, apricot, cantaloupe, banana, orange, 109"		*/
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

	li $t0,42	#you never know what may be in registers
	li $t1,55
	li $s0,-666
# calling your function--
        la $a0,bush
        jal traverse	# Traverse the tree  <<===== YOU
			# Should have printed names in alphabet order
        move  $a0,$v0
        li $v0,1
        syscall         # print value (sum of fruit)
        la $a0,endl
        li $v0,4
        syscall         # print newline
_exit:
        li $v0,10
        syscall         # auf Wiedersehen


#------------------------------------------------
# print_name() - print the items as they are visited in order
#		argument $a0 is address of a string
#------------------------------------------------
print_name:
	li $v0,4
        syscall         # print path[i]
        la $a0,arrow
        li $v0,4
        syscall         # print ", "
        jr $ra


#/* Any changes above this line will be discarded by
# mipsmark. Put your answer between dashed lines. */
#/*-------------- start cut ----------------------- */

traverse:	#  $a0 is the address of a (node of) a tree
	bnez	$a0, exists
	jr $ra			#tree is empty, do nothing
exists:
	sub	$sp, $sp, 4
	sw	$ra, ($sp)	#save registers
	sub	$sp, $sp, 4		#will use $s0 for pointer to our tree
	sw	$s0, ($sp)	#since it must be remembered across function calls
	move	$s0, $a0	# s0 points to current node

# tree traverse right to left using example
# sums all of the value of each node

	lw	$a0, 8($s0)	# tree-> right
	jal	traverse

	lw	$a0,  ($s0)	# tree -> name
	jal	print_name

	lw 	$a0 , 12($s0)	# add value of node
	move $t1, $a0
    	add $s1, $s1, $a0
	
	lw	$a0, 4($s0)	# tree-> left
	jal	traverse

	lw	$s0, ($sp)	#restore registers
	add	$sp, $sp, 4
	lw	$ra, ($sp)
	add	$sp, $sp, 4
	
	move 	$v0, $s1	# move sum to v0
	jr	$ra

	j __start	#nasty loop if mips program not exited 
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
# The binary tree.  Note that each node has four
# words -- a pointer to the name, pointers to
# left and right subtrees, and the integer
# value field, in this case value could be the
# price of one fruit

path:   .space 40

bush:   .word name5, node1, node2, 10
node1:  .word name11, node3, node4, 15
node2:  .word name7, node5, node6, 0	#dead branch!
node3:  .word name17, 0, 0, 30
node4:  .word name15, node8, node9, 20
node5:  .word name3, 0, 0, 40
node6:  .word name12, 0, 0, 50
node7:  .word name0, 0, 0, 230
node8:  .word name2, 0, 0, 30 
node9:  .word name1, 0, 0, 4
# these nodes not used
node10: .word name4, 0, 0, 70
node11: .word name16, 0, 0, 60
node12: .word name8, node14, node15, 90
node13: .word name14, 0, 0, 80
node14: .word name9, 0, 0, 91
node15: .word name10, node16, node17, 97
node16: .word name13, 0, 0, 130
node17: .word name6, 0, 0, 35

name0:  .asciiz "apple"
name1:  .asciiz "orange"
name2:  .asciiz "banana"
name3:  .asciiz "pear"
name4:  .asciiz "plum"
name5:  .asciiz "peach"
name6:  .asciiz "nectarine"
name7:  .asciiz "pineapple"
name8:  .asciiz "grapefruit"
name9:  .asciiz "grape"
name10: .asciiz "melon"
name11: .asciiz "avocado"
name12: .asciiz "star"
name13: .asciiz "mango"
name14: .asciiz "passion"
name15: .asciiz "cantaloupe"
name16: .asciiz "watermelon"
name17: .asciiz "apricot"

endl:   .asciiz "\n"
arrow:  .asciiz ", "
notfound: .asciiz " not found\n"
space:	.asciiz	" "
seek:   .asciiz "peach"
	.space  30      # to store string that is sought
prompt: .asciiz "What to search for? "

#
#/*# End of file recur3.a		*/
