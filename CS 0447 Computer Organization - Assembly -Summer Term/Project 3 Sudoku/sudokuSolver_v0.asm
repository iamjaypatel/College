# Jay Patel (jjp107)
# CS 447 - Summer 2018
# Project 3 - Sudoku
.text
# xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
# _print:
#	Prints the sudoku puzzle on console
_print:
	add	$t0, $zero, 0			# Counter for Loop	
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
	addi	$sp, $sp, -20
	sw      $ra, 12($sp)          	# Save the return address
    	sw      $s3, 12($sp)          	# Save the $s3 register
    	sw      $s2, 8($sp)           	# Save the $s2 register
    	sw      $s1, 4($sp)           	# Save the $s1 register
    	sw      $s0, 0($sp)           	# Save the $s0 register
	
	move	$s0, $a1		#s0, is row
	move	$s1, $a2		#s1, is col
	
	# if(r == 8 and c == 9)
	beq	$s0, 8, second_condition
	add	$ra, $zero, 0		# return false
second_condition:
	beq	$s1, 9, return_true_if
	add	$ra, $zero, 0		# return false
return_true_if:
	add	$ra, $zero, 1		# return true
	
	#if ( c == 9 )
	bne	$s1, 9, skip_if_col
	add	$s0, $s0, 1
	add	$s1, $zero, 0
skip_if_col:

	addi 	$t1, $zero, 0xffff8000
	mult	$t1, $s0
	add	$t1, $t1, $s0
	add	$t1, $t1, $s1
	lb 	$t3, ($t1)
	
	# if(data != 0), recurse, _solveSudoku(r, c+1)
	beqz	$t3, else
	add	$a1, $zero, $a1
	addi	$a2, $a2, 1
	jal	_solveSudoku
else:	
	# for( i = 1 to 9)
	addi	$t2, $zero, 1
    for_loop_start:
	bgt 	$t2, 9, for_loop_end
	
	#check for conflict
	#move	$a0, $t2
	#jal	_checkRow
	#bnez	$v0, inc
	#jal	_checkColumn
	#bnez	$v0, inc
	#jal	_checkSubgrid
	#bnez	$v0, inc
	addi	$v0, $zero, 0
	#if(i has no conflict)
	beq	$v0, 1, inc
	# insert number to place
	sb	$t2, ($t1)
	add	$a1, $zero, $a1
	addi	$a2, $a2, 1
	jal	_solveSudoku
   inc:
	addi	$t2, $t2, 1
	
	j	for_loop_start
for_loop_end:
	
# xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
# _checkRow:
# 	Check if give number is in current row
#	$a0: value
#	$v0: 1 if conflict, 0 if no conflict 
_checkRow:
	li	$v0, 0
	addi	$t0, $a0, 9
    _checkRow_loop:
    	lb	$t2, 0($a0)
    	beq	$t2, 0, _checkRow_loop_end
    	add	$t2, $a1, $t2
    	lb	$t1, -1($t2)
    	sb	$zero, -1($t2)
    	beq	$t1, $v0, _checkRow_loop_end
    	li	$v0, 1
    _checkRow_loop_end:
    	addi	$a0, $a0, 1
    	bne	$a0, $t0, _checkRow_loop
    	jr	$ra

# xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
# _checkColumn:
# 	Check if given number is in current column
#	$a0: value
#	$v0: 1 if conflict, 0 if no conflict 
_checkColumn:
	li	$v0, 0
	addi	$t0, $a0, 81
    _checkColumn_loop:
    	lb	$t2, 0($a0)
    	beq	$t2, 0, _checkColumn_loop_end
    	add	$t2, $a1, $t2
    	lb	$t1, -1($t2)
    	sb	$zero, -1($t2)
    	bne	$t1, $zero, _checkColumn_loop_end
    	li	$v0, 1
    _checkColumn_loop_end:
    	addi	$a0, $a0, 9
    	bne	$a0, $t0, _checkColumn_loop
    	jr	$ra

# xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
# _checksubgrid::
# Check if the give number is located in subgrid
#	$a0: Address of upperleft box
#	$v0: 1 if conflict, 0 if no conflict
_checkSubgrid:
	li 	$v0, 0
  	addi 	$t0, $a0, 27
    _checkSubgrid_Rows:
  	addi 	$t1, $a0, 3
    _checkSubgrid_Columns:
  	lb 	$t2, 0($a0)
  	beq 	$t2, 0, _checkSubgrid_end
  	add 	$t2, $a1, $t2
  	lb 	$t3, -1($t2)
  	sb 	$0, -1($t2)
  	bne 	$t3, $0, _checkSubgrid_end
  	li 	$v0, 1
    _checkSubgrid_end:
  	addi 	$a0, $a0, 1
  	bne 	$a0, $t1, _checkSubgrid_Columns
  	addi 	$a0, $a0, 6
  	bne 	$a0, $t0, _checkSubgrid_Rows
  	jr 	$ra
		
# xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
