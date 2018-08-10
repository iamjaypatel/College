.text
	addi $a0, $zero, 5		# Set argmuent (n) 
	jal  _factorial			# Call factorial(n)
	add  $a0, $zero, $v0		# $a0 = n!
	addi $v0, $zero, 1		# Syscall 1: Print integer
	syscall				# Print n!
	addi $v0, $zero, 10		# Syscall 10: Terminal program
	syscall				# Terminte program

# _factorial(n)
#
# Argument
#   - $a0: n
# Return Value
#   - $v0 = n!
_factorial:
	addi $sp, $sp, -8		# Allocate memory on the stack
	sw   $s0, 4($sp)		# Backup $s0
	sw   $ra, 0($sp)		# Backup $ra
	add  $s0, $zero, $a0		# $s0 is n
	bne  $s0, $zero, callFactorial	# If n != 0, make a recursive call
	addi $v0, $zero, 1		# n == 0, return 1
	j    factorialDone
callFactorial:
	addi $a0, $s0, -1		# $a0 = n - 1
	jal  _factorial			# Call factorial(n - 1)
	mult $s0, $v0			# lo = n * factorial(n - 1)
	mflo $v0			# v0 = n * factorial(n - 1)
factorialDone:
	lw   $s0, 4($sp)		# Restore $s0
	lw   $ra, 0($sp)		# Restore $ra
	addi $sp, $sp, 8		# Adjust the stack pointer back
	jr   $ra			# Return to caller








