.text 

#	addi 	$t1, $zero, 0xffff8000
#	lb 	$t3, ($t1)
	
#	addi	$t1, $t1, 10		# cell no to put in 0-80

#	add	$t2, $zero, $t2		# No to put in
#	add	$t4, $zero, $t2
#	add	$t3, $zero, $t4		# add no to put in to $t3
#	sb	$t3, ($t1)
_solveSudoku:
	# Boolean p
	addi	$v0, $zero, 0
	
	move	$s0, $a0	# r
	move	$s1, $a1	# c
	
	#if(r == 8 and c == 9)
	bne	$s0, 8, return_false
check_col:
	bne	$s1, 9, return_false
	addi	$v0, $zero, 1	# return true
	
	#if(c == 9)
	bne	$s1, 9, _continue
	addi	$s0, $s0, 1
	addi	$s1, $zero, 0
_continue: 
	# put data in $t2
	addi 	$t3, $zero, 0xffff8000	# r = 0, c = 0
	mult	$t3, $s0
	add	$t3, $t3, $s0
	add	$t3, $t3, $s1
	lb	$t2,($t3)
	#if(data is != 0)
	beq	$t2, 0, _else
	addi	$t3, $t3, 1		# increment offset
	addi	$s1, $s1, 1
	move	$a0,$s0
	move	$a1, $s1
	jal	_solveSudoku
_else:
	# for( i = 1 to 9)
	li	$t4, 1	
	for_loop:
	bgt	$t4, 9, return_false
	#if(i has no conflict)
	sb	$t4, ($t3)
	
	j	for_loop
return_false:
	addi	$v0, $zero, 0