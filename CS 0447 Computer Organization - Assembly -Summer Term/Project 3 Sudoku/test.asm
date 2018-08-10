# MIPS Sudoku Solver
# Andrew Zich - 2011

.data
  sudoku: .byte 8 0 0 4 0 6 0 0 7
          .byte 0 0 0 0 0 0 4 0 0
          .byte 0 1 0 0 0 0 6 5 0
          .byte 5 0 9 0 3 0 7 8 0
          .byte 0 0 0 0 7 0 0 0 0
          .byte 0 4 8 0 2 0 1 0 3
          .byte 0 5 2 0 0 0 0 9 0
          .byte 0 0 1 0 0 0 0 0 0
          .byte 3 0 0 9 0 2 0 0 5

.text

# Prints out the sudoku in a grid using _'s instead of 0's
sudoku_print:	# a0 = &sudoku[0][0]
  	addi 	$sp, $sp, -16
  	sw 	$ra, 0($sp)
  	sw 	$s0, 4($sp)
  	sw 	$s1, 8($sp)
  	sw 	$s2, 12($sp)
  	move 	$s0, $a0
  	addi 	$s1, $s0, 81
sudoku_print_rows:
  	addi 	$s2, $s0, 9
sudoku_print_cols:
  	lb 	$a0, 0($s0)
  	bne 	$a0, $0, sudoku_print_byte
  	li 	$a0, 47
sudoku_print_byte:
  	addi 	$a0, $a0, 48
  	li 	$v0, 11
  	syscall
  	li 	$a0, 32
  	li 	$v0, 11
  	syscall
  	addi 	$s0, $s0, 1
  	bne 	$s2, $s0, sudoku_print_cols
  	li 	$a0, 10
  	li 	$v0, 11
  	syscall
  	bne 	$s1, $s0, sudoku_print_rows
  	li 	$a0, 10
  	li 	$v0, 11
  	syscall
  	lw 	$ra, 0($sp)
  	lw 	$s0, 4($sp)
  	lw 	$s1, 8($sp)
  	lw 	$s2, 12($sp)
  	addi 	$sp, $sp, 16
  	jr 	$ra

# Checks which values can fit in the specified cell without conflict
sudoku_choices:	# a0 = &sudoku[0][0], a1 = &sudoku[r][c], a2 = &results[0]
  	addi 	$sp, $sp, -20
  	sw 	$ra, 0($sp)
  	sw 	$s0, 4($sp)
  	sw 	$s1, 8($sp)
  	sw 	$s2, 12($sp)
  	sw 	$s3, 16($sp)
  	move 	$s2, $a0
  	move 	$s3, $a2
  	li 	$t0, 1
  	addi 	$a2, $a2, 9
sudoku_choices_init:
  	sb 	$t0, -1($a2)
  	addi 	$a2, $a2, -1
  	bne 	$a2, $s3, sudoku_choices_init
  	sub 	$t0, $a1, $a0
  	li 	$t1, 9
  	div 	$t0, $t1
  	mfhi 	$s0
  	mflo 	$s1
  	move 	$a0, $s0
  	add 	$a0, $s2, $a0
  	move 	$a1, $s3
  	jal 	sudoku_check_col
  	sll 	$a0, $s1, 3
  	add 	$a0, $a0, $s1
  	add 	$a0, $s2, $a0
  	move 	$a1, $s3
  	jal 	sudoku_check_row
  	li 	$t1, 3
  	div 	$s0, $t1
  	mfhi 	$t0
  	sub 	$s0, $s0, $t0
  	div 	$s1, $t1
  	mfhi 	$t0
  	sub 	$s1, $s1, $t0
  	sll 	$a0, $s1, 3
  	add 	$a0, $a0, $s1
  	add 	$a0, $a0, $s0
  	add 	$a0, $a0, $s2
  	move 	$a1, $s3
  	jal 	sudoku_check_box
  	lw 	$ra, 0($sp)
  	lw 	$s0, 4($sp)
  	lw 	$s1, 8($sp)
  	lw 	$s2, 12($sp)
  	lw 	$s3, 16($sp)
  	addi 	$sp, $sp, 20
  	jr 	$ra

# Checks if the specified cell is not in conflict
sudoku_checks:	# a0 = &sudoku[0][0], a1 = &sudoku[r][c]
  	addi 	$sp, $sp, -28
  	sw 	$ra, 12($sp)
  	sw 	$s0, 16($sp)
  	sw 	$s1, 20($sp)
  	sw 	$s2, 24($sp)
  	move 	$s2, $a0
  	sub 	$t0, $a1, $a0
  	li 	$t1, 9
  	div 	$t0, $t1
  	mfhi 	$s0
  	mflo 	$s1
  	li 	$t0, 0x01010101
  	sw 	$t0, 0($sp)
  	sw 	$t0, 4($sp)
  	sb 	$t0, 8($sp)
  	move 	$a0, $s0
  	add 	$a0, $s2, $a0
  	move 	$a1, $sp
  	jal 	sudoku_check_col
  	beq 	$v0, $0, sudoku_checks_end
  	li 	$t0, 0x01010101
  	sw 	$t0, 0($sp)
  	sw 	$t0, 4($sp)
  	sb 	$t0, 8($sp)
  	sll 	$a0, $s1, 3
  	add 	$a0, $a0, $s1
  	add 	$a0, $s2, $a0
  	move 	$a1, $sp
  	jal 	sudoku_check_row
  	beq 	$v0, $0, sudoku_checks_end
  	li 	$t1, 3
  	div 	$s0, $t1
  	mfhi 	$t0
  	sub 	$s0, $s0, $t0
  	div 	$s1, $t1
  	mfhi 	$t0
  	sub 	$s1, $s1, $t0
  	li 	$t0, 0x01010101
  	sw 	$t0, 0($sp)
  	sw 	$t0, 4($sp)
  	sb 	$t0, 8($sp)
  	sll 	$a0, $s1, 3
  	add 	$a0, $a0, $s1
  	add 	$a0, $a0, $s0
  	add 	$a0, $a0, $s2
  	move 	$a1, $sp
  	jal 	sudoku_check_box
sudoku_checks_end:
  	lw 	$ra, 12($sp)
  	lw 	$s0, 16($sp)
  	lw 	$s1, 20($sp)
  	lw 	$s2, 24($sp)
  	addi 	$sp, $sp, 28
  	jr 	$ra

# Checks if the sudoku has no conflicts
sudoku_check:	# a0 = &sudoku[0][0]
  	addi 	$sp, $sp, -28
  	sw 	$ra, 12($sp)
  	sw 	$s0, 16($sp)
  	sw 	$s1, 20($sp)
  	sw 	$s2, 24($sp)
  	move 	$s0, $a0
  	addi 	$s1, $s0, 81
sudoku_check_rloop:
  	li 	$t0, 0x01010101
  	sw 	$t0, 0($sp)
  	sw 	$t0, 4($sp)
  	sb 	$t0, 8($sp)
  	move 	$a0, $s0
  	move 	$a1, $sp
  	jal 	sudoku_check_row
  	beq 	$v0, $0, sudoku_check_end
  	add 	$s0, $s0, 9
  	bne 	$s0, $s1, sudoku_check_rloop
  	addi 	$s0, $s0, -81
  	addi 	$s1, $s0, 9
sudoku_check_cloop:
  	li 	$t0, 0x01010101
  	sw 	$t0, 0($sp)
  	sw 	$t0, 4($sp)
  	sb 	$t0, 8($sp)
  	move 	$a0, $s0
  	move 	$a1, $sp
  	jal 	sudoku_check_col
  	beq 	$v0, $0, sudoku_check_end
  	add 	$s0, $s0, 1
  	bne 	$s0, $s1, sudoku_check_cloop
  	addi 	$s0, $s0, -9
  	addi 	$s1, $s0, 81
sudoku_check_bloopr:
  	addi 	$s2, $s0, 9
sudoku_check_bloopc:
  	li 	$t0, 0x01010101
  	sw 	$t0, 0($sp)
  	sw 	$t0, 4($sp)
  	sb 	$t0, 8($sp)
  	move 	$a0, $s0
  	move 	$a1, $sp
  	jal 	sudoku_check_box
  	beq 	$v0, $0, sudoku_check_end
  	addi 	$s0, $s0, 3
  	bne 	$s0, $s2, sudoku_check_bloopc
  	addi 	$s0, $s0, 18
  	bne 	$s0, $s1, sudoku_check_bloopr
  	li 	$v0, 1
sudoku_check_end:
  	lw 	$ra, 12($sp)
  	lw 	$s0, 16($sp)
  	lw 	$s1, 20($sp)
  	lw 	$s2, 24($sp)
  	addi 	$sp, $sp, 28
  	jr 	$ra

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

main:
  	addi 	$sp, $sp, -4
  	sw 	$ra, 0($sp)
  	la 	$a0, sudoku
  	jal 	sudoku_print
  	la 	$a0, sudoku
  	la	$a1, sudoku
  	jal 	sudoku_solve
  	la 	$a0, sudoku
  	jal 	sudoku_print
  	la 	$a0, sudoku
  	jal 	sudoku_check
  	move 	$a0, $v0
  	li 	$v0, 1
  	syscall
  	li 	$a0, 10
  	li 	$v0, 11
  	syscall
  	lw 	$ra, 0($sp)
  	addi 	$sp, $sp, 4
  	jr 	$ra
