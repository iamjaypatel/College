.data
	numEl:	.word	10
	array:	.word	1, 2, 3, 4, 5, 6, 7, 8, 9, 10
	msg:	.asciiz "Hello World"
.text
#	la 	$s0, array
#	lw	$s1, 0($s0)
#	lw	$s2, 4($s0)
#	add	$s1, $s1, $s2
#	lw	$s2, 8($s0)
#	add	$s1, $s1, $s2
#	lw	$s2, 12($s0)
#	add	$s1, $s1, $s2
#	lw	$s2, 16($s0)
#	add	$s1, $s1, $s2
#	lw	$s2, 20($s0)
#	add	$s1, $s1, $s2
#	lw	$s2, 24($s0)
#	add	$s1, $s1, $s2
#	lw	$s2, 24($s0)
#	add	$s1, $s1, $s2
#	lw	$s2, 28($s0)
#	add	$s1, $s1, $s2
#	lw	$s2, 32($s0)
#	add	$s1, $s1, $s2
#	lw	$s2, 36($s0)
#	add	$s1, $s1, $s2
	
	la	$s0, array
	add	$s1, $zero, $zero	# $s1 is a counter
	la	$s2, numEl
	lw	$s2, 0($s2)		# $s2 is number of elements
	add	$s3, $zero, $zero	# $s3 is the result
loop:	
	beq 	$s2, $s1, done
	sll	$s4, $s1, 2		# Shift by 2, is multiply by 4, $s4 is Offset
	add	$s4, $s4, $zero		# $s4 is the address of $s1
	lw	$s4, 0($s4)		# $s4 is the array[i]
	add	$s3, $s3, $s4		# result = result + array[i]
	addi	$s1, $s1, 1
	j	loop
done:
	addi	$v0, $zero, 1
	add	$a0, $s0,$zero
	syscall
	
	