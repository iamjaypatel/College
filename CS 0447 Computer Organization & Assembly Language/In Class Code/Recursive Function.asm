# Recursive Function in Class 06/13/2018
.data

.text
	addi	$a0, $zero, 5
	jal	_factorial
	add	$a0, $zero, $v0
	addi	$v0, $zero 1
	syscall
	addi	$v0, $zero, 10
	syscall

# xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
# Function _factorial(n)
# Arguments:
#	$a0 : n
# Return Value
# 	$v0 : n!
_factorial:
	# Back Up
	addi	$sp, $sp, -8
	sw	$s0, 4($sp)
	sw	$ra, 0($sp)
	
	add	$s0, $zero, $a0		# $s0 is n
	bne	$s0, $zero, callFactorial
	addi	$v0, $zero, 1
	j	_factorial_done
callFactorial:
	addi	$a0, $s0, -1
	jal	_factorial
	mult	$s0, $v0
	mflo	$v0
_factorial_done:
	# Restore
	lw	$s0, 4($sp)
	lw	$ra, 0($sp)
	addi	$sp, $sp, 8
	
	jr	$ra
# xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx