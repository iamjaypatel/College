.data

.text
	addi	$a0, $zero, 2		# Enter Multiplicant
	addi	$a1, $zero, 12		# Enter Muntiplier
	jal	_exp			# Calling Function
	
	move	$s0, $v0		# Move result to $s0
	
	addi	$v0, $zero, 10		# Terminate Program
	syscall

# func _exp
# Arguments:
#	$a0, is x
#	$a1, is y
# Return Value
#	$v0, is  x ^ y
_exp:
	move 	$s0, $a0		# $s0 is x
	move	$s1, $a1		# $s1 is y
	addi	$s2, $zero, 1		# $s2 is Temp Result
	add	$s3, $zero, $zero	# $s3 is counter
_exp_loop:
	beq	$s3, $s1, _exp_loop_done
	move 	$a0, $s2		# set result as multiplicant
	move	$a1, $s0		# set x as multiplier
	add	$s7, $zero, $ra	
	jal	_multi
	add	$ra, $zero, $s2
	move	$s2, $v0		
	addi	$s3, $s3, 1
	j	_exp_loop
_exp_loop_done:
	add	$v0, $zero, $s2
	jr	$ra
	
# func _multi
# Arguments:
#	$a0, is Multiplicant
#	$a1, is Multiplier
# Return Value
#	$v0, is  Multiplicant * Multiplier
_multi:
	move 	$t0, $a0		# $t0 is Multiplicant
	move	$t1, $a1		# $t1 is Multiplier
	add	$t2, $zero, $zero 	# $t2 is Temp Result
	add	$t3, $zero, $zero	# $t3 is counter
multi_loop:	
	beq	$t3, $t1, multi_loop_done
	add	$t2, $t2, $t0		# result = result + Multiplicant
	addi	$t3, $t3, 1		# increment counter
	j	multi_loop
multi_loop_done:
	move	$v0, $t2		# Move result to $v0
	jr	$ra			# Go back to caller

	