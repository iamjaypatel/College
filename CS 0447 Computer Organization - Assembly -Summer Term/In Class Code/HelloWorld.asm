.data 
	msg1: .asciiz "Please enter an Integer: "
	msg2: .asciiz "Please enter another Integer: "
	plus: .asciiz " + "
	equal:.asciiz " = "
.text
	# Print: Ask for the First Integer
	addi 	$v0, $zero, 4
	la	$a0, msg1
	syscall
	addi	$v0, $zero, 5
	syscall
	add	$s0, $zero, $v0
	
	# Print: Ask for the Second Integer
	addi 	$v0, $zero, 4
	la	$a0, msg2
	syscall
	addi	$v0, $zero, 5
	syscall
	
	# Add: Perform the Addition
	add	$s1, $zero, $v0

	# Print: Print the First Integer
	addi 	$v0, $zero, 1
	add	$a0, $s0, $zero
	syscall
	
	# Print: Print plus sign
	add	$s2, $s0, $s1
	addi 	$v0, $zero, 4
	la	$a0, plus
	syscall

	# Print: Prints the Second Integer
	addi 	$v0, $zero, 1
	add	$a0, $s1, $zero
	syscall

	# Print: Prints Equal sign
	addi 	$v0, $zero, 4
	la	$a0, equal
	syscall
	
	# Print: Prints the Total
	addi 	$v0, $zero, 1
	add	$a0, $s2, $zero
	syscall
	