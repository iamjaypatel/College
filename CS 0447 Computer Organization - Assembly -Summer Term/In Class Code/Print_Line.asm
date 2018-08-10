.data
	str1:	.asciiz "Hello"
	str2:	.asciiz "World"
.text
	# Print Line 1
	la	$a0, str1
	jal	_printLn
	
	# Print Line 2
	la	$a0, str2
	jal	_printLn
	addi	$v0, $zero, 10
	syscall
# func _printLn
# Argument
# 	$a0 :  is the address of the string to print
# Return Value
# 	None
_printLn: 
	addi	$v0, $zero, 4
	syscall
	addi	$v0, $zero, 11
	addi	$a0, $zero, 10
	syscall
	jr	$ra
