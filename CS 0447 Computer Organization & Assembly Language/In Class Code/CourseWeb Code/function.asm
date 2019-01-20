.text
	addi $a0, $zero, 4	# set multiplicant to 5
	addi $a1, $zero, 6	# set multiplier to 12
	jal  _exp
	add  $s0, $zero, $v0
	addi $v0, $zero, 10
	syscall


# _exp
#
# This is an example of backking up $ra into another register (BAD EXAMPLE)
# We should use stack.
#
# Arguemnts
#   - $a0 is x
#   - $a1 is y
# Return value
#   - $v0 = x^y
_exp:
	add  $s0, $zero, $a0	# $s0 is x
	add  $s1, $zero, $a1	# $s1 is y
	addi $s2, $zero, 1	# $s2 is the temp result
	add  $s3, $zero, $zero	# $s3 is the counter
exp_loop:
	beq  $s3, $s1, exp_done
	add  $a0, $zero, $s2	# set result as a multiplicant
	add  $a1, $zero, $s0	# set x as a multiplier
	add  $s7, $zero, $ra	# BAD EXAMPLE: Backup $ra to another register
	jal  _multi2
	add  $ra, $zero, $s7	# BAD EXAMPLE: Restore $ra from another register
	add  $s2, $zero, $v0	# result = result * x
	addi $s3, $s3, 1	# Counter++
	j    exp_loop
exp_done:
	add  $v0, $zero, $s2	# $v0 = result
	jr   $ra		# Return to caller



# _multi
#
# Arguments:
#   - $a0: multiplicant
#   - $a1: multiplier
# Return value
#   - $v0 = multiplicant * multiplier
_multi:
	add  $t0, $zero, $a0	# $t0 is the multiplicant
	add  $t1, $zero, $a1	# $t1 is the multiplier
	add  $t2, $zero, $zero	# $t2 is a temp result
	add  $t3, $zero, $zero	# $t3 is a counter
multi_loop:
	beq  $t3, $t1, multi_done
	add  $t2, $t2, $t0	# result = result + multiplicant
	addi $t3, $t3, 1	# counter++
	j    multi_loop
multi_done:
	add  $v0, $zero, $t2	# Set $v0 to the result
	jr   $ra		# Go back to caller

# _multi2
#
# A callee that uses $s register example
#
# Arguments:
#   - $a0: multiplicant
#   - $a1: multiplier
# Return Value:
#   - $v0: multiplicant * multiplier
_multi2:
	addi $sp, $sp, -16	# Allocate space on top of the stack for 16 bytes
	sw   $s0, 0($sp)	# Backup $s0
	sw   $s1, 4($sp)	# Backup $s1
	sw   $s2, 8($sp)	# Backup $s2
	sw   $s3, 12($sp)	# Backup $s3
	add  $s0, $zero, $a0	# $t0 is the multiplicant
	add  $s1, $zero, $a1	# $t1 is the multiplier
	add  $s2, $zero, $zero	# $t2 is a temp result
	add  $s3, $zero, $zero	# $t3 is a counter
multi2_loop:
	beq  $s3, $s1, multi2_done	# if counter == multiplier, done
	add  $s2, $s2, $s0	# result = result + multiplicant
	addi $s3, $s3, 1	# counter++
	j    multi2_loop
multi2_done:
	add  $v0, $zero, $s2	# Set $v0 to the result
	lw   $s0, 0($sp)	# Restore $s0
	lw   $s1, 4($sp)	# Restore $s1
	lw   $s2, 8($sp)	# Restore $s2
	lw   $s3, 12($sp)	# Restore $s3
	addi $sp, $sp, 16	# Adjust the stack pointer back
	jr   $ra		# Go back to caller
	







