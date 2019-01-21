# Lecture Monday 06/04/2018

.data

.text
	add	$s0, $zero, $zero 	# Counter
	addi	$s1, $zero, 10
loop:	beq	$s0, $s1, done
	addi	$v0, $zero, 1
	add	$a0, $zero, $s0
	syscall
	addi	$s0, $s0, 1
	j	loop

done:	addi	$v0, $zero, 10		# done
	syscall
