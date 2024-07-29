## Start of file loop3.a
##
## MIPSMARK 1.0 1/5/98 Copyright 1998 J. Waldron.
##
## Question:
## Replace all occurences of 'a' with
## 'A' in the string "chararray" and
## print the resulting string.
##
## Output format must be:
## "AbbbAAbbbAbAbAb"

#################################################
#					 	#
#		text segment			#
#						#
#################################################

	.text		
       	.globl __start 
__start:		# execution starts here
# Any changes above this line will be discarded 
# . Put your answer between dashed lines.
#-------------- start cut -----------------------

	li $t1, 0		# t1 is now array index
	li $t2, 'a'	# t2 holds the value to be found 
	li $t3, 'A'	# t3 holds the value to be replaced
loop:
	lb $t0, chararray($t1)# fetch next char in the array
	beqz $t0, strEnd	# if it's null, exit loop
	bne $t0, $t2, con	# if != 'a' go to con
	sb $t3,chararray($t1)	# else change the value 'a' to 'A'
con:
	add $t1, $t1, 1	# increase index (go to next char)
	j loop
strEnd:
	la $a0, chararray	# a0 because we need it to print
	li $v0, 4		# to print string
	syscall
	
	li $v0, 10		#finish
	syscall		# au revoir...

#--------------  end cut  -----------------------
# Any changes below this line will be discarded 
#. Put your answer between dashed lines.

#################################################
#                                               #
#               data segment                    #
#                                               #
#################################################

        .data
chararray:
	.asciiz "abbbaabbbababab\n"

##
## End of file loop3.a