.data 

.text
# Attempt to find a solution to the sudoku
# The second arg represents the first cell to attempt to fill
sudoku_solve:	# a0 = &sudoku[0][0], a1 = &sudoku[0][0]
 	li 	$v0, 1
 	addi 	$sp, $sp, -28
 	sw 	$ra, 12($sp)
 	sw 	$s0, 16($sp)
 	sw 	$s1, 20($sp)
  	sw 	$s2, 24($sp)
  	sub 	$t0, $a1, $a0
	bge 	$t0, 81, sudoku_solve_end
 	move 	$s0, $a0
  	move 	$s1, $a1
  	addi 	$t0, $s0, 81
sudoku_solve_seek:
  	lb 	$t1, 0($s1)
  	beq 	$t1, $0, sudoku_solve_recur
  	addi 	$s1, $s1, 1
  	bne 	$s1, $t0, sudoku_solve_seek
  	j 	sudoku_solve_end
sudoku_solve_recur:
  	li 	$s2, 1
  	move 	$a1, $s1
  	move 	$a2, $sp
  	jal 	sudoku_choices
sudoku_solve_loop:
  	add 	$t0, $sp, $s2
 	lb 	$t0, -1($t0)
  	beq 	$t0, $0, sudoku_solve_skip
  	sb 	$s2, 0($s1)
  	move 	$a0, $s0
  	addi 	$a1, $s1, 1
  	jal 	sudoku_solve
  	bne 	$v0, $0, sudoku_solve_end
sudoku_solve_skip:
  	addi 	$s2, $s2, 1
  	ble 	$s2, 9, sudoku_solve_loop
  	sb 	$0, 0($s1)
  	li 	$v0, 0
  	j 	sudoku_solve_end
sudoku_solve_end:
  	lw 	$ra, 12($sp)
  	lw 	$s0, 16($sp)
  	lw 	$s1, 20($sp)
  	lw 	$s2, 24($sp)
  	addi 	$sp, $sp, 28
  	jr 	$ra
# xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx

# Marks results with values already used in the row
# Returns 0 if there is a conflict in the row, 1 otherwise
sudoku_check_row:	# a0 = &sudoku[n][0], a1 = &results[0]
  	li 	$v0, 1
  	addi 	$t0, $a0, 9
sudoku_check_row_loop:
  	lb 	$t2, 0($a0)
  	beq 	$t2, 0, sudoku_check_row_skip
  	add 	$t2, $a1, $t2
  	lb 	$t1, -1($t2)
  	sb 	$0, -1($t2)
  	beq 	$t1, $v0, sudoku_check_row_skip
  	li 	$v0, 0
sudoku_check_row_skip:	
  	addi 	$a0, $a0, 1
  	bne 	$a0, $t0, sudoku_check_row_loop
  	jr 	$ra

# Marks results with values already used in the column
# Returns 0 if there is a conflict in the column, 1 othwerise
sudoku_check_col:	# a0 = &sudoku[0][n], a1 = &results[0]
  	li 	$v0, 1
  	addi 	$t0, $a0, 81
sudoku_check_col_loop:
  	lb 	$t2, 0($a0)
  	beq 	$t2, 0, sudoku_check_col_skip
  	add 	$t2, $a1, $t2
  	lb 	$t1, -1($t2)
  	sb 	$0, -1($t2)
  	bne 	$t1, $0, sudoku_check_col_skip
  	li 	$v0, 0
sudoku_check_col_skip:
  	addi 	$a0, $a0, 9
  	bne 	$a0, $t0, sudoku_check_col_loop
  	jr 	$ra

# Marks results with values already used in the 3x3 box
# Returns 0 if there a conflict in the box, 1 otherwise
# Give it the address of the upper left corner of the box
sudoku_check_box:	# a0 = &sudoku[(r/3)*3][(c/3)*3], a1 = &results[0]
  	li 	$v0, 1
  	addi 	$t0, $a0, 27
sudoku_check_box_rows:
  	addi 	$t1, $a0, 3
sudoku_check_box_cols:
  	lb 	$t2, 0($a0)
  	beq 	$t2, 0, sudoku_check_box_skip
  	add 	$t2, $a1, $t2
  	lb 	$t3, -1($t2)
  	sb 	$0, -1($t2)
  	bne 	$t3, $0, sudoku_check_box_skip
  	li 	$v0, 0
sudoku_check_box_skip:
  	addi 	$a0, $a0, 1
  	bne 	$a0, $t1, sudoku_check_box_cols
  	addi 	$a0, $a0, 6
  	bne 	$a0, $t0, sudoku_check_box_rows
  	jr 	$ra

	