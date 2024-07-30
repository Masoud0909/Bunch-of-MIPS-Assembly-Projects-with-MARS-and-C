## Start of file recur1.a
##
## MIPSMARK 1.0 1/5/98 Copyright 1998 J. Waldron.
## All Rights Reserved. See the file README for
## a full copyright notice.
##
## Question:
##
## Write a function named search that will do a
## depth first search of a tree for a marked
## node. A marked node is one that has a value
## field equal to 1. Only one node in the tree is
## marked.
##
## The parameters to search are a pointer to the
## tree and the current depth. On each recursive 
## call add 1 to the depth. This parameter is
## used to keep track of the path from the root
## to the marked node; as you visit a node, you
## will call a procedure named store_path to
## record the fact that you have visited this
## node. The code for store_path and print_path
## (called after you get back from the procedure)
## have been written for you -- all you need to
## do is understand how to set up their parameters
## and make the call.
##
## The code for search could look like:
##           call store_path
##           if (value == 1)
##             return 1
##           if (left tree exists)
##             if (search(left tree, depth+1))
##              return 1
##           if (right tree exists)
##             return search(right tree, depth+1)
##           return 0
##
## Output format must be:
## "apple-->orange-->plum-->grape-->star-->passion"

#################################################
#					 	#
#		text segment			#
#						#
#################################################

	.text		
       	.globl __start 
__start:		# execution starts here

	la $a0,tree
	li $a1,0
	jal search	# search the tree

	jal print_path	# print the path
			# to the node with val=1
	li $v0,10
	syscall		# au revoir....


#------------------------------------------------
# store_path - store pointer at level n in the path
# 	a0 - holds pointer to string
# 	a1 - level to use in path
#------------------------------------------------
store_path:
	li $v0,4
        syscall         # print name of node
	la $a0,endl
        li $v0,4
        syscall         # print newline
	
	sll $t0,$a1,2	# each pointer is 4 bytes
	sw $a0,path($t0)# save pointer to the name
	addi $t0,$t0,4	# make the next entry 
	sw $0,path($t0)	#  equal to 0.
        jr $ra



#------------------------------------------------
# print_path() - print the items stored in path 
#------------------------------------------------
print_path:
        li $t0,0        # i 
        sll $t1,$t0,2	# each pointer is 4 bytes
        lw $a0,path($t1)
next:   li $v0,4	
        syscall         # print path[i]
        addi $t0,$t0,1  # i++
        sll $t1,$t0,2	# each pointer is 4 bytes
        lw $a0,path($t1)
        beqz $a0,done
        move $t1,$a0
        la $a0,arrow
        li $v0,4
        syscall         # print "-->"
        move $a0,$t1
        b next
done:   la $a0,endl
        li $v0,4
        syscall         # print newline
        jr $ra

# Any changes above this line will be discarded by
# mipsmark. Put your answer between dashed lines.
#-------------- start cut -----------------------

search:
	bnez	$a0, exists
	jr $ra
exists:								
	sub	$sp, $sp, 4
	sw	$ra, ($sp)	#save registers
	sub	$sp, $sp, 4	#will use $s0 for pointer to our tree
	sw	$s0, ($sp)	#since it must be remembered across function calls
	move	$s0, $a0	# s0 points to current node

	lw	$a0, ($s0)	# tree -> name
	jal	store_path
	lw	$a0, 4($s0)	# tree-> left
	jal	search
	lw	$a0, 8($s0)	# tree-> right
	jal	search
	

	lw	$s0, ($sp)	#restore registers
	add	$sp, $sp, 4
	lw	$ra, ($sp)
	add	$sp, $sp, 4
	jr	$ra

#--------------  end cut  -----------------------
# Any changes below this line will be discarded by
# mipsmark. Put your answer between dashed lines.

#################################################
#                                               #
#               data segment                    #
#                                               #
#################################################

        .data

# The binary tree.  Note that each node has four 
# words -- a pointer to the name, pointers to 
# left and right subtrees, and the integer
# value field.  

path:	.space 80

tree:	.word name0, node1, node2, 0
node1:	.word name1, node3, node4, 0
node2:	.word name2, node5, node6, 0
node3:	.word name3, node7, 0, 0
node4:	.word name4, node8, node9, 0
node5:	.word name5, 0, 0, 0
node6:	.word name6, node10, node11, 0
node7:	.word name7, 0, 0, 0
node8:	.word name8, 0, 0, 0
node9:	.word name9, node12, node13, 0
node10:	.word name10, 0, 0, 0
node11:	.word name11, 0, 0, 0
node12:	.word name12, node14, node15, 0
node13:	.word name13, 0, 0, 0
node14:	.word name14, 0, 0, 1
node15:	.word name15, node16, node17, 0
node16:	.word name16, 0, 0, 0
node17:	.word name17, 0, 0, 0

name0:	.asciiz "apple"
name1:	.asciiz "orange"
name2:	.asciiz "bananna"
name3:	.asciiz "pear"
name4:	.asciiz "plum"
name5:	.asciiz "peach"
name6:	.asciiz "nectarine"
name7:	.asciiz "pineapple"
name8:	.asciiz "grapefruit"
name9:	.asciiz "grape"
name10:	.asciiz "melon"
name11:	.asciiz "avocado"
name12:	.asciiz "star"
name13:	.asciiz "mango"
name14:	.asciiz "passion"
name15:	.asciiz "cantaloupe"
name16:	.asciiz "watermelon"
name17:	.asciiz "apricot"
	
endl:	.asciiz "\n"
arrow:	.asciiz "-->"
##
## End of file recur1.a
