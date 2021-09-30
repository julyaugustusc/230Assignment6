###########################################################
# Assignment #: 6
# Name: Augustus Crosby 
# ASU email: ancrosby@asu.edu
# Course: CSE230, MW 3:05pm
# Description: Asks for inputs for arrays and prints arrays.
#		Then swaps moves smallest integer to first array and largest 
#		to the second array and prints.
###########################################################

#data declarations: declare variable names used in program, storage allocated in RAM
		.data
line1:		.asciiz "Specify how many numbers should be stored in the arrays (at most 10):\n"
line2:		.asciiz "Enter an integer:\n"
line3:		.asciiz "\nThe array "
line4:		.asciiz " content:\n"
line5:		.asciiz "\n"
line6:		.asciiz "\nResult array "

#program code is contained below under .text

		.text 
		.globl main	# define a global function main

main:

############################################################################
# Procedure/Function swapElements
# Description: takes 2 arrays and compares the lowest number in each position
#		the smallest is then put into the first and then prints the two. 
# parameters: $a2 = address of array1, array number2 is located -40 from this.
#		$t0 = 10 (arraysize) 
# return value: $a0 = print outputs
# registers to be used: $a0, $a2, $v0, $sp, $s0, $zero $s3, $s4, $t0, $t1, $t5, $t6
############################################################################

swapElements:
	li $v0, 4		# load 4 to print string
	la $a0, line1		# load address of line1
	syscall			# print_string()

	li $v0, 5		# load 5 to read int
	syscall 		# read_int()
	move $a1, $v0		# $a1 = howMany

	addi $a2, $sp, -4	# load first number address of Stack pointer 
	li $t1, 1		# number of arrays

############################################################################
# Procedure/Function readArray
# Description: reads in array from user and prints
# parameters: $a2 = address of array1, array number2 is located -40 from this.
#		$t0 = 10 (arraysize/length)
#		$a1 = howMany (input by user)
#		$t1 = number of array the computer is on
# return value: $a0 = outputs
# registers to be used: $a0, $a1, $a2, $v0, $sp, $s0, $zero, $t0, $t1, $t3, $t4
############################################################################

readArray:
	li $t0, 10		# $t0 = maxSize of array
	move $s0, $zero		# $s0 = $zero (i)
Loop1:
	bge $s0, $a1, Label1	# branch if i >= howMany
	bge $s0, $t0, Label1	# branch if i >= maxSize

	li $v0, 4		# load 4 to print string
	la $a0, line2		# load address of line2
	syscall			# print_string()

	li $v0, 5		# load 5 to read int
	syscall 		# read_int()

	addi $sp, $sp, -4	# move sp one int
	sw $v0, 0($sp)		# store word from input to $sp location

	addi $s0, $s0, 1	# $s0++
	j Loop1

Label1:
	li $v0, 4		# load 4 to print string
	la $a0, line3		# load address of line3
	syscall			# print_string()

	li $v0, 1 		# load 1 to print int
	move $a0, $t1		# load current number of array into value
	syscall			# print_int()

	li $v0, 4		# load 4 to print string
	la $a0, line4		# load address of line4
	syscall			# print_string()

	move $s0, $zero		# $s0 = $zero (i)
	move $sp, $a2		# move address stored in $a2 to $sp
	li $t4, 1		# load value of 1 for comparision
	beq $t1, $t4, Loop2
	addi $sp, $sp, -40	# move max numb of int down

Loop2:
	bge $s0, $a1, Label2	# branch if i >= howMany
	bge $s0, $t0, Label2	# branch if i >= maxSize

	li $v0, 1 		# load 1 to print int
	lw $a0, 0($sp)		# load word at $sp
	addi $sp, $sp, -4	# add
	syscall			# print_int()

	li $v0, 4		# load 4 to print string
	la $a0, line5		# load address of line5
	syscall			# print_string()

	addi $s0, $s0, 1	# $s0++
	j Loop2

Label2:
	li $t3, 2		# number of arrays
	move $sp, $a2		# move address stored in $a2 to $sp
	addi $sp, $sp, -36	# move max numb of int down
	addi $t1, $t1, 1	# adding 1 to number of arrays
	beq $t3, $t1, readArray	# go back to read array again

	move $s0, $zero		# $s0 = $zero (i)
	move $sp, $a2		# move address stored in $a2 to $sp

Loop3:
	bge $s0, $a1, Label5	# branch if i >= howMany
	bge $s0, $t0, Label5	# branch if i >= maxSize

	lw $s3, 0($sp)		# $s3 = array1[i]
	lw $s4, -40($sp)	# $s4 = array2[i]
	bge $s3, $s4, Label3 	# branch if $s3 >= $s4
	addi $s0, $s0, 1	# i++
	addi $sp, $sp , -4	# move stack pointer one int
	j Loop3

Label3:
	move $t5, $s3		# temp = $t5 = $s3
	move $t6, $s4		# temp2 = $t6 = $s4
	sw $t5, -40($sp)	# store $t5 into $s4's location
	sw $t6, 0($sp)		# store $t6 into $s3's location

	addi $s0, $s0, 1	# i++
	addi $sp, $sp , -4	# move stack pointer one int
	j Loop3

Label5:
	li $t1, 1		# number of arrays
	move $s0, $zero		# $s0 = $zero (i)
	move $sp, $a2		# move address stored in $a2 to $sp

############################################################################
# Procedure/Function printArray
# Description: prints arrays stored!
# parameters: $a2 = address of array1, array number2 is located -40 from this.
#		$t0 = 10 (arraysize/length)
#		$a1 = howMany (input by user)
#		$t1 = number of array the computer is on
# return value: $a0 = outputs printed
# registers to be used: $a0, $a2, $v0, $sp, $s0, $zero, $t1, $t3
############################################################################

printArray:	
	li $v0, 4		# load 4 to print string
	la $a0, line6		# load address of line6
	syscall			# print_string()

	li $v0, 1 		# load 1 to print int
	move $a0, $t1		# load current number of array into value
	syscall			# print_int()

	li $v0, 4		# load 4 to print string
	la $a0, line4		# load address of line4
	syscall			# print_string()

Loop4:
	bge $s0, $a1, Label6	# branch if i >= howMany
	bge $s0, $t0, Label6	# branch if i >= maxSize
	
	li $v0, 1 		# load 1 to print int
	lw $a0, 0($sp)		# load word at $sp
	addi $sp, $sp, -4	# add
	syscall			# print_int()

	li $v0, 4		# load 4 to print string
	la $a0, line5		# load address of line5
	syscall			# print_string()

	addi $s0, $s0, 1	# $s0++
	j Loop4 		
	
Label6:
	move $sp, $a2		# move address stored in $a2 to $sp
	addi $sp, $sp, -40	# move pointer down 10 int
	addi $t1, $t1, 1	# add number of arrays to printer
	move $s0, $zero		# i = 0
	beq $t3, $t1, printArray# go back to print array again
	jr $ra
	


### Honestly this C code is massively confusing and it doesn't make sense to check against both arraysize/length AND howMany each time. It should just end the program if it's a number bigger than 10, but why is 10 even the max? Why isn't printArray used by readArray if readArray is going to output it? How am I suppose to use $v0 as the output if the output is all "void" and not actual outputs?????????? Why have the ability to input which array it is if there is only 2????? why is that not inherent to the way the code is?
## If I get less than 20/20 because of how I wrote my code or commented (cause it does work), then the C code should be fixed. Frankly the C code should be written in a way that makes sense anyway, because there's so much that just seems utterly bizarre and that could have been written better. I digress. I mostly just wrote this out of utter frustration, because I know I wrote it slightly differently from others probably did because it's the only way the C code made sense in my brain at the time.
			
	
	

	
	
	

	