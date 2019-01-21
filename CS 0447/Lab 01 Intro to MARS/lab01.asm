# CS 0447 - Summer 2018 
#Lab 01
# Jay Patel (usermane: jjp107)

.text 
# $t9 = 179 + (-293) + 561
top_of_loop:
	addi	$t9, $zero, 0
	
	addi	$v0, $zero, 32  # Syscall 32: Sleep
	addi	$a0, $zero, 500 # Time to sleepn(500ms)
	syscall			# Perform the syscall (sleep for 500 ms)


	addi	$t9, $t9, 179
	
	addi	$v0, $zero, 32  # Syscall 32: Sleep
	addi	$a0, $zero, 500 # Time to sleepn(500ms)
	syscall			# Perform the syscall (sleep for 500 ms)
		
	addi	$t9, $t9, -293
	
	addi	$v0, $zero, 32  # Syscall 32: Sleep
	addi	$a0, $zero, 500 # Time to sleepn(500ms)
	syscall			# Perform the syscall (sleep for 500 ms)

	addi	$t9, $t9, 561
	
	addi	$v0, $zero, 32  # Syscall 32: Sleep
	addi	$a0, $zero, 500 # Time to sleepn(500ms)
	syscall			# Perform the syscall (sleep for 500 ms)

j	top_of_loop	

