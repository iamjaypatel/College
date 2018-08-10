.data
	str:	.asciiz "Hello World!!!"
.text 
	add	$s0, $zero, 0	# $s0 is counter
	la	$s1, str	# $s1 is the address of str in memory
	
loop:
	lb	$s2, 0($s1)
	beq	$s2, $zero, done
	addi	$s0, $s0, 1	# increase counter by 1
	addi	$s1, $s1, 1
	j 	loop
done:
	addi	$v0, $zero, 1
	add	$a0, $zero, $s0
	syscall
	