# Jay Patel (jjp107)
# CS 447 - Summer 2018
# Project 3 - Sudoku
.text
# _print:
#	Prints the sudoku puzzle on console
# xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
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
	j 	guess
_print_end:
	addi 	$a0, $0, 0xA #ascii code for LF, if you have any trouble try 0xD for CR.
	addi 	$v0, $0, 11 #syscall 11 prints the lower 8 bits of $a0 as an ascii character.
	syscall
	j 	p_loop
# xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx

################################################################################
# guess -- Test all candidate numbers for the current cell until the board is  #
#          complete                                                            #
#                                                                              #
# Last update:                                                                 #
#   19/05/2006                                                                 #
# Arguments:                                                                   #
#   $a0 - Offset of the cell to guess                                          #
# Registers used:                                                              #
#   $s0 - Offset of the cell to guess (saves $a0)                              #
#   $s1 - Cell's row index                                                     #
#   $s2 - Cell's column index                                                  #
#   $s3 - Currently tested number                                              #
################################################################################
		
guess:
    	# Set up the stack frame
    	sub     $sp, $sp, 20          # Make room on the stack to save registers
    	sw      $ra, 16($sp)          # Save the return address
    	sw      $s3, 12($sp)          # Save the $s3 register
    	sw      $s2, 8($sp)           # Save the $s2 register
    	sw      $s1, 4($sp)           # Save the $s1 register
    	sw      $s0, 0($sp)           # Save the $s0 register
	
	move	$s0, $a0
	beq	$s0, 81, guess_ret_ok

	li	$s3, 9
	div	$s0, $s3
	mflo	$s1
	mfhi	$s2
	
	addi	$s0, $zero, 0xffff8000
	lb	$t0, ($s0)
	beqz	$t0, guess_loop
	addi	$a0, $s0, 1
	jal	guess
	j	guess_ret
    
guess_loop:
	move	$a0, $s3
	move	$a1, $s1
	move	$a2, $s2
	jal	check
	bnez	$v0, guess_chk_failed
	sb	$s3, ($s0)
	addi	$a0, $s0, 1
	jal	guess
	beqz	$v0, guess_ret
guess_chk_failed:
	add	$s3, $s3, -1
	bnez	$s3, guess_loop
	sb	$zero, ($s0)
	li	$v0, 1
	j	guess_ret
guess_ret_ok:
    	move	$v0, $zero
guess_ret:
    # Destroy the stack frame
    lw      $s0, 0($sp)           # Restore the $s0 register
    lw      $s1, 4($sp)           # Restore the $s1 register
    lw      $s2, 8($sp)           # Restore the $s2 register
    lw      $s3, 12($sp)          # Restore the $s3 register
    lw      $ra, 16($sp)          # Restore the return address
    addi    $sp, $sp, 20          # Clean up the stack
    jr      $ra                   # Return
	
	
################################################################################
# check -- Check if a number is, according to Sudoku rules, a legal candidate  #
#          for the given cell                                                  #
#                                                                              #
# Last update:                                                                 #
#   19/05/2006                                                                 #
# Arguments:                                                                   #
#   $a0 - Number to check                                                      #
#   $a1 - Cell's row index                                                     #
#   $a2 - Cell's column index                                                  #
# Registers used:                                                              #
#   None                                                                       #
################################################################################
check:
    # Row check
    li      $t0, 9                # Set counter
    mul     $t1, $a1, $t0         # Offset of the first cell in the row
check_row:
    	addi	$t1, $zero, 0xffff8000
	lb	$t2, ($t1)
    beq     $a0, $t2, check_ret_fail  # Number already present in row
    addi    $t1, $t1, 1           # Increment the pointer to the current cell
    sub     $t0, $t0, 1           # Decrement the counter
    bnez    $t0, check_row        # Check the next cell in the row

    # Column check
    move    $t1, $a2              # Offset of the first cell in the column
check_col:
    	addi	$t1, $zero, 0xffff8000
	lb	$t2, ($t1)
    beq     $a0, $t2, check_ret_fail  # Number already present in column
    addi    $t1, $t1, 9           # Increment the pointer to the current cell
    ble     $t1, 81, check_col    # Check the next cell in the column

    # 3x3-Box check
    div     $t0, $a1, 3           # $t0 = row / 3
    mul     $t0, $t0, 27          # Offset of the row
    div     $t1, $a2, 3           # $t1 = col / 3
    mul     $t1, $t1, 3           # Offset of the column
    add     $t1, $t0, $t1         # Offset of the first cell in the box

    li      $t0, 3                # Set up the row counter
    li      $t3, 3                # Set up the column counter
check_box:
	addi	$t1, $zero, 0xffff8000
	lb	$t2, ($t1)
    beq     $a0, $t2, check_ret_fail  # Number already present in column
    sub     $t3, $t3, 1           # Decrement the column counter
    beqz    $t3, end_box_row      # Check if end of current box row is reached
    addi    $t1, $t1, 1           # Increment the pointer to the current cell
    j       check_box             # Check the next cell in the row
end_box_row:
    addi    $t1, $t1, 7           # Increment the pointer to the current cell
    li      $t3, 3                # Reset the column counter
    sub     $t0, $t0, 1           # Decrement the row counter
    bnez    $t0, check_box        # Check if end of box is reached

    move    $v0, $zero            # Return code is 0 (success)
    j       check_ret             # Jump to the return instructions

check_ret_fail:
    li      $v0, 1                # Return code is 1 (failure)

check_ret:
    jr      $ra                   # Return

