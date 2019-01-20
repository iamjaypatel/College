.data
	msg: 	.asciiz "Please enter a number: "
	odd: 	.asciiz " is odd."
	even:	.asciiz " is even."
.text

	addi	$v0, $zero, 4
	la	$a0, msg
	syscall
	addi	$v0, $zero, 5
	syscall
	add	$s0, $zero, $v0
	#print given number
	addi	$v0, $zero, 1
	add	$a0, $zero, $s0
	syscall
 	# print even or odd
	andi	$s1, $s0, 1
	beq	$s1, $zero, printEvent
	# print odd
	addi	$v0, $zero, 4
	la	$a0, odd
	syscall
	j	done
printEvent:
	# print even
	addi	$v0, $zero, 4
	la	$a0, even
	syscall

done:
	addi	$v0, $zero, 10
	syscall
