## Start of file easy.a
##
## MIPSMARK 1.0 1/5/98 Copyright 1998 J. Waldron.
## All Rights Reserved. See the file README for
## a full copyright notice.
##
## Question:
## Print out the message "hello world"
## 
## Output format must be:
## "hello world"

#################################################
#					 	#
#		text segment			#
#						#
#################################################

	.text		
       	.globl __start 
__start:		# execution starts here

# Any changes above this line will be discarded by
# mipsmark. Put your answer between dashed lines.
#-------------- start cut -----------------------

	la $a0, str	# put string address into a0
	li $v0, 4		#system call to print 
	syscall		# out a string 
	
	li $v0, 10		
	syscall		# au revoir...

#--------------  end cut  -----------------------
# Any changes below this line will be discarded by
# mipsmark. Put your answer between dashed lines.

#################################################
#                                               #
#               data segment                    #
#                                               #
#################################################

        .data
str:	.asciiz "hello world\n"
##
## End of file easy.a
