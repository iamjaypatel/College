# CS 0447 - Summer 2018 
# Lab 03
# Jay Patel (usermane: jjp107)
.data
	num1: 		.asciiz " \nPlease enter a positive number: "
	num2: 		.asciiz " \nPlease enter another positive number: "
	multSign:	.asciiz " * "
	equalSign:	.asciiz " = "
	powerSign:	.asciiz " ^ "
	nonNeg:		.asciiz "Negative number is not allowed. "
	printLine:	.asciiz "\n"
.text
	add	$t7, $zero, $zero	# counter
_prompt1:				# Prompt for Number 1
	addi 	$v0, $zero, 4
	la	$a0, num1
	syscall
	addi 	$v0, $zero, 5
	syscall
	add 	$s0, $zero, $v0		# No 1 in $s0
	move	$s7, $s0
	slt 	$t0, $s0, $zero		
	bne	$t0, $zero, negNum1
	j 	_prompt2
	
negNum1:				# Negative No 1
	addi 	$v0, $zero, 4
	la	$a0, nonNeg
	syscall
	j	_prompt1
	
_prompt2:				# Prompt for Number 2
	addi 	$v0, $zero, 4
	la	$a0, num2
	syscall
	addi 	$v0, $zero, 5
	syscall
	add 	$s1, $zero, $v0		# No 2 is in $s1
	move	$s6, $s1
	slt 	$t4, $s1, $zero		
	bne	$t4, $zero, negNum2
	j 	calcMult
	
negNum2:				# Negative No 2
	addi 	$v0, $zero, 4
	la	$a0, nonNeg
	syscall
	j	_prompt2
	
calcMult:
   	beq 	$s1, $0, mult_loop_end 
    	beq 	$s0, $0, mult_loop_end 

mult_loop:
    	andi 	$t0, $s0, 1    		
    	beq 	$t0, $0, mult_next  		
    	addu 	$s3, $s3, $s1  		
mult_next:
   	sll 	$s1, $s1, 1
    	sll 	$s2, $s2, 1
   	addu 	$s2, $s2, $t0	
    	srl 	$s0, $s0, 1     
    	bne 	$s0, $0, mult_loop
mult_loop_end :

	
calcExp:
	beq 	$t7, $s6, printOutMult
	add	$t7, $t7, 1
	move	$s1, $s6
	j	calcMult
	j	calcExp

	
printOutMult:
	move	$s5, $s3
	# Print No 1
	addi 	$v0, $zero, 1
	add	$a0, $s7, $zero
	syscall
	
	# Print Mult Sign 
	addi 	$v0, $zero, 4
	la	$a0, multSign
	syscall
	
	#Print No 2
	addi 	$v0, $zero, 1
	add	$a0, $s6, $zero
	syscall
	
	# Print Equal Sign
	addi 	$v0, $zero, 4
	la	$a0, equalSign
	syscall
	
	# Print Output of Multiplication
	addi 	$v0, $zero, 1
	add 	$a0, $zero, $s5
	syscall
	
printOutExp:
	# Print Line
	addi 	$v0, $zero, 4
	la	$a0, printLine
	syscall
	# Print No 1
	addi 	$v0, $zero, 1
	add	$a0, $s7, $zero
	syscall
	
	# Print Power Sign 
	addi 	$v0, $zero, 4
	la	$a0, powerSign
	syscall
	
	#Print No 2
	addi 	$v0, $zero, 1
	add	$a0, $s6, $zero
	syscall
	
	# Print Equal Sign
	addi 	$v0, $zero, 4
	la	$a0, equalSign
	syscall
	
	# Print Output of Exp
	addi 	$v0, $zero, 1
	add 	$a0, $zero, $s3
	syscall
	
	j	end
end:
	addi	$v0, $zero, 10
	syscall

	
	
