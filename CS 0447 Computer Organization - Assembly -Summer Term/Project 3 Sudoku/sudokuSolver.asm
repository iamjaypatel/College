# Jay Patel (jjp107)
# CS 447 - Summer 2018
# Project 3 - Sudoku
.text
# xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
# _print:
#	Prints the sudoku puzzle on console

_print:
	add	$t0, $zero, 0			# Counter for Loop	
	addi	$s4, $zero, 9
    p_loop:
	beq 	$t0, 81, p_loop_done
	addi 	$t1, $zero, 0xffff8000
	add 	$t1, $t1, $t2
	lb 	$t3, ($t1)
	addi 	$t2, $t2, 1
	div 	$t4, $t2, 9			# Divide by 9, prints 9 numbers/line
	mfhi 	$t5
	addi 	$v0, $zero, 1
	add 	$a0, $zero, $t3
	syscall
	addi 	$t0, $t0, 1
	beq 	$t5, $zero, _print_end
	j 	p_loop
    p_loop_done:
	j 	_solveSudoku
_print_end:
	addi 	$a0, $0, 0xA #ascii code for LF, if you have any trouble try 0xD for CR.
	addi 	$v0, $0, 11 #syscall 11 prints the lower 8 bits of $a0 as an ascii character.
	syscall
	j 	p_loop
	
# xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
# Main Solver _solveSudoku(r,c)
# Arguments:
# 	    r: $a1 => $s0
# 	    c: $a2 => $s1
# Return:
# 	$ra, 1 if true, 0 if false.	
_solveSudoku:
	move	$s0, $a1		#s0, is row
	move	$s1, $a2		#s1, is col
	
	# if(r == 8 and c == 9)
	bne	$s0, 8, skip
second_condition:
	bne	$s1, 9, skip
	add	$v0, $zero, 1		# return true
	j	_solveSudokuDone
	#if ( c == 9 )
skip:
	bne	$s1, 9, skip_if_col
	add	$s0, $s0, 1
	add	$s1, $zero, 0
skip_if_col:
	li	$t5, 9
	addi 	$t1, $zero, 0xffff8000
	mult	$t5, $s0
	mflo	$t5
	add	$t1, $t1, $t5
	add	$t1, $t1, $s1
	lb 	$t3, ($t1)
	
	# if(data != 0), recurse, _solveSudoku(r, c+1)
	beqz	$t3, else
	#move	$a1, $s0
	addi	$a2, $a2, 1
	jal	_solveSudoku
else:	
	# for( i = 1 to 9)
	addi	$t2, $zero, 1
    for_loop_start:
	bgt 	$t2, 9, for_loop_end
	
	move	$a0, $t2
	move	$a1, $s0	
	move	$a2, $s1
	jal	_check
	bnez	$v0, _checkFailed
	#if(i has no conflict)
	
	# insert number to place
	sb	$t2, ($t1)
	addi	$t2, $zero, 1
	add	$a1, $zero, $a1
	addi	$a2, $a2, 1
	
	move	$s0, $t2
	
	addi	$sp, $sp, -20
	sw      $ra, 16($sp)          	# Save the return address
    	sw      $t2, 12($sp)          	# Save the $s3 register
    	sw      $s2, 8($sp)           	# Save the $s2 register
    	sw      $s1, 4($sp)           	# Save the $s1 register
    	sw      $s0, 0($sp)           	# Save the $s0 register
    	
	jal	_solveSudoku
	beqz	$v0, _checkFailed
	li	$v0, 1
	jr	$ra
   _checkFailed:
	addi	$t2, $t2, 1
	j	for_loop_start
	
    for_loop_end:
_solveSudokuReturn:
	sb	$zero, ($t1)
	# Destroy the stack frame
	lw	$s0, 0($sp)		# Restore the $s0 register
    	lw	$s1, 4($sp)           	# Restore the $s1 register
   	lw	$s2, 8($sp)           	# Restore the $s2 register
    	lw	$t2, 12($sp)          	# Restore the $s3 register
    	lw	$ra, 16($sp)          	# Restore the return address
    	addi	$sp, $sp, 20          	# Clean up the stack
    	li	$v0, 0
    	jr	$ra                   	# Return

# xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
# _check
# Checks Row, Column and Subgrid
#	$a0: Number to check
#	$a1: Cell's Row Index
#	$a2: Cell's Column Index
# xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
_check:
# _checkRow
	li	$t7, 0
	addi	$t6, $zero, 0xffff8000
	#addi	$t5, $zero, 9
	mult	$a1, $s4
	mflo	$t8
	add	$t6, $t8, $t6
_checkRow:
	li	$v0, 0
	bgt	$t7, 8, _checkColumn
	lb	$t4, ($t6)
	beq	$a0, $t4, _checkFail
	addi	$t6, $t6, 1
	addi	$t7, $t7, 1
	j	_checkRow
#_checkColumn 	
_checkColumn:
	li	$t7, 0
	add	$t6, $zero, 0xffff8000
	add	$t6, $a2, $t6
_checkColumnLoop:
	li	$v0, 0
	bgt	$t7, 8, _checkSubgrid
	lb	$t4, ($t6)
	beq	$a0, $t4, _checkFail
	addi	$t6, $t6, 9
	addi	$t7, $t7, 1
	j	_checkColumnLoop

 #_checkSubgrid
 # a0: Number    a1: Row   $a2: Column
_checkSubgrid:	
	li	$t8, 3
   row_loop:
	div	$t8, $a1
	mfhi	$t7
	beqz	$t7, col_loop
	addi	$a1, $a1, -1
	j	row_loop
    col_loop:
	div	$t8, $a2
	mfhi	$t6
	beqz 	$t6, run_check
	addi	$a2, $a2, -1
	j	col_loop
    run_check: 
	add	$t6, $zero, 0xffff8000
	mult	$t4, $s4
	mflo	$t4
	add	$t6, $t4, $t6
	add	$t6, $t6, $a2	# top left reached
	li	$t9, 0		# Row Counter
	li	$t0, 0		# Col Counter
    real_loop:
	lb	$t4, ($t6)
	beq	$t4, $a0, _checkFail
	addi	$t0, $t0, 1
	blt	$t0, 3, continue
   	addi	$t6, $t6, 7
   	addi	$t9, $t9, 1
   	addi	$t0, $zero,0
   continue:
   	addi	$v0, $zero, 0
	bgt	$t9, 3, _checkReturn
	j	real_loop
	
_checkFail:
	li	$v0, 1
_checkReturn:
	jr	$ra
_solveSudokuDone:
	li	$v0, 10			# Terminate
	syscall