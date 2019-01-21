# Name: Jay Patel
# Pitt Username: jjp107
# CS 0447 Summer 2018, Project 2 - Simon
.data
	set_arr:	.space 100	# Array to remember sequence
.text
_startPlay:
wait:
	bne	$t9, 16, wait
	add	$t8, $t9, 0
loop_wait:
	bne	$t8, $zero, loop_wait
game_loop:
	addi 	$t9, $t9, 0
	addi 	$v0, $zero, 0
	jal 	get_Random	# Generate Random No
	addi 	$s0, $v0, 0
	addi 	$a0, $s0, 0
	addi 	$v0, $zero, 0
	jal 	set_store_Random
	jal 	playSequence
	jal 	userPlay
	beq 	$v0, 0, game_loop
	addi 	$t8, $zero, 15
startLoop:
	bne 	$t8, $zero, startLoop
	jal 	clear_array
	j 	_startPlay	
	addi 	$v0, $zero, 10
	syscall
# Genereate Random No
get_Random:
	li 	$a1, 4
	li 	$v0, 42
	syscall
	addi 	$v0, $zero, 1
	sllv  	$v0, $v0, $a0
	jr 	$ra
# Set and Store Random No
set_store_Random:
	addi 	$t0, $a0, 0
	addi 	$t2, $zero, 0
     loop:	
	lb 	$t1, set_arr($t2)
	beq 	$t1, $zero, store
	addi 	$t2, $t2,1
	j 	loop
     store:
	sb 	$t0, set_arr($t2)
	jr 	$ra
# Function: playSequence
# Wnen called, it will play sequence of tones
playSequence:
	addi 	$t2, $zero, 0
     playSequence_Loop:	
	lb 	$t1, set_arr($t2)
	beq 	$t1, $zero, playSequence_done
	addi 	$t8, $t1, 0
     playSequence_Wait:	
	bne 	$t8, $zero, playSequence_Wait
	addi 	$t2, $t2, 1
	j 	playSequence_Loop
playSequence_done:
	jr 	$ra
# Function: userPlay
# Lets user play back the sequence.
# Return value: (Value to notify caller whether user successfully play back sequence or not).
#		$v0, 0 if Success, 1 if fails
userPlay:
	addi 	$t2, $zero, 0
	addi 	$t9, $zero, 0
     userPlay_Loop:	
	lb 	$t1, set_arr($t2)
	beq 	$t1, 0, success
     userPlay_Input_Loop:	
	beq 	$t9, 0, userPlay_Input_Loop
	addi 	$t0, $t9, 0
	addi 	$t8, $t9, 0
     userPlay_InSound:	
	bne 	$t8, 0, userPlay_InSound
	addi 	$t9, $zero, 0
	bne 	$t1, $t0, fail
	addi 	$t2, $t2, 1
	j 	userPlay_Loop
     success:
	addi 	$v0, $zero, 0
	j 	return
     fail:
	addi 	$v0, $zero, 1
	j 	return
return:
	jr 	$ra

clear_array:
	addi 	$t2, $zero,0
     clear_array_Loop:
	lb 	$t1, set_arr($t2)
	beq 	$t1, $zero, clear_array_done
	sb	$zero, set_arr($t2)
	addi 	$t2, $t2, 1
	j 	clear_array_Loop
clear_array_done:
	jr 	$ra