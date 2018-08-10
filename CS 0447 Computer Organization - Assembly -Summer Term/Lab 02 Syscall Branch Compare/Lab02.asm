# CS 0447 - Summer 2018 
#Lab 02
# Jay Patel (usermane: jjp107)
.data
	greet:		.asciiz "Enter a number between 0 and 9: "
	lowGuess:	.asciiz "Your guess is too low \n"
	highGuess:	.asciiz "Your guess is too high \n"
	lose:		.asciiz "You lose! The number was: "
	win:		.asciiz "Congratulation! You Win :) \n"
.text
					#counter
	addi	$t0, $zero, 0 
	addi 	$t9, $zero, 3
					#Generating Random Number
	addi 	$v0, $zero, 42
	add 	$a0, $zero, $zero
	addi 	$a1, $zero, 10
	syscall 
	add 	$s0, $zero, $a0
ask:					# Ask the User to Guess
	addi 	$v0, $zero, 4
	la	$a0, greet
	syscall
	j	readNum
readNum:				# Read User Input
	addi	$v0, $zero, 5
	syscall
	add	$s1, $zero, $v0
	j loopGame
loopGame:				# Game Loop
	beq	$s1, $s0, gameWon
	addi 	$t0, $t0, 1
	beq 	$t0, $t9, gameLost
	slt 	$t2, $s1, $s0
	beq 	$t2, $zero, high
	bne 	$t2, $zero, low
high:					# Guess is too High
	addi 	$v0, $zero, 4
	la	$a0, highGuess
	syscall
	j	ask
low:					# Guess is too Low
	addi 	$v0, $zero, 4
	la	$a0, lowGuess
	syscall
	j	ask
gameWon:				# User Won the Game
	addi 	$v0, $zero, 4
	la	$a0, win
	syscall
	j	end
gameLost:				# User Lost the Game
	addi 	$v0, $zero, 4
	la	$a0, lose
	syscall
	j	printNum
printNum:				# Print the Computer's Number
	addi 	$v0, $zero, 1
	add	$a0, $s0, $zero
	syscall	
	j	end
end:					# Terminate Game 
	addi	$v0, $zero, 10
	syscall