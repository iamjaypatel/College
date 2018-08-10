# Name: Jay Patel
# Pitt Username: jjp107
# CS 0447 Summer 2018, Project 1 - Simple Calculator
.text

# state_0:
# Set operand 1 and 2 to 0
# Set operator to nothing
# Display operand 1
# Go to state1
state_0:
	add 	$t9, $zero, 0 #Set Keypad to 0
	add 	$t8, $zero, 0 #Set Display to 0
	addi 	$t0, $zero, 0 #Opp 1
	addi 	$t1, $zero, 0 #Opp 2
	addi 	$t2, $zero, 0 #Opperator
	addi 	$t3, $zero, 0 #Result
	add 	$t8, $zero, 0
wait:
	beq 	$t9, $zero, wait

# state_1
# operand1 = (operand1 * 10) + Input	0-9
# Display operand1
# Go back to State 1
# operator = Input			+, -, *, /
# Display operand1
# Go to State 2
# result = operand1			=
# Display result
# Go to State 4
# Go to State 0				C
state_1:
	add	$s1, $t1, $zero
	sll	$s1, $s1, 3
	add	$s1, $s1, $t1
	add	$t0, $s1, $t0
	add	$t8, $t0, 0
	
	sll 	$t9, $t9, 1
	srl 	$t9, $t9, 1
	slti 	$s1, $t9, 10
	beq 	$s1, $zero, op_s1
num_s1:	
	sll 	$t5, $t0, 1
	sll 	$t6, $t0, 3
	add 	$t0, $t5, $t6
	
	add 	$t8, $zero, $zero
	add 	$t0, $t9, $t0
	add 	$t8, $t0, 0
	add 	$t9, $zero, 0
	j 	wait
op_s1:
	beq	$t9, 10, add_s1
	beq	$t9, 11, sub_s1
	beq	$t9, 12, mult_s1
	beq	$t9, 13, div_s1
	beq	$t9, 14, equal		# Used for all instances of calling Equal
	beq	$t9, 15, state_0

add_s1:
	addi	$t2, $zero, 10
	addi	$t9, $zero, 0
	j	state_2_wait
sub_s1:
	addi	$t2, $zero, 11
	addi	$t9, $zero, 0
	j	state_2_wait
mult_s1:
	addi	$t2, $zero, 12
	addi	$t9, $zero, 0
	j	state_2_wait
div_s1:
	addi	$t2, $zero, 13
	addi	$t9, $zero, 0
	j	state_2_wait
equal:
	addi	$t2, $zero, 14
	# Set Result = $t0(Opp 1)
	add 	$t3, $t0, $zero
	# Display Result
	add 	$t8, $t3, $zero
	j	state_4_wait
		
# state_2
# operand2 = (operand2 * 10) + Input	0-9
# Display operand2
# Go to State 3
# operator = Input			+, -, *, /
# Display operand1
# Go back to State 2
# result = operand1			=
# Display result
# Go to State 4
# Go to State 0				C
state_2_wait:
	beq 	$t9, $zero, state_2_wait
state_2:
	sll 	$t9, $t9, 1
	srl 	$t9, $t9, 1
	
	slti 	$s1, $t9, 10
	beq 	$s1, $zero, set_op_2
num_s2:	
	sll 	$t5, $t1, 1
	sll 	$t6, $t1, 3
	add 	$t1, $t5, $t6
	add 	$t8, $zero, $zero
	add 	$t1, $t9, $t1
	add 	$t8, $t1, 0
	add 	$t9, $zero, 0
	j 	state_3_wait

op_s2:
	beq 	$t9, 10, set_op_2
	beq 	$t9, 11, set_op_2
	beq 	$t9, 12, set_op_2
	beq 	$t9, 13, set_op_2	
	beq 	$t9, 14, equal
	beq 	$t9, 15, state_0
set_op_2:
	add 	$t2, $t9, $zero
	addi 	$t9, $zero, 0
	add 	$t8, $t0, $zero
	j 	state_2_wait
# state_3
# operand2 = (operand2 * 10) + Input	0-9
# Display operand2
# Go back to State 3
# result = operand1 operator operand2	+, -, *, /
# Display result
# operand1 = result
# operand2 = 0
# operator = Input
# Go to State 2
# result = operand1 operator operand2	=
# Display result	
# operand2 = 0
# Go to State 4
# Go to State 0				C
state_3_wait:
	beq 	$t9, $zero, state_3_wait
state_3:
	sll 	$t9, $t9, 1
	srl 	$t9, $t9, 1
	slti 	$s1, $t9, 10
	beq 	$s1, $zero, op_s3
num_s3:	
	sll 	$t5, $t1, 1
	sll 	$t6, $t1, 3
	add 	$t1, $t5, $t6
	add 	$t8, $zero, $zero
	add 	$t1, $t9, $t1
	add 	$t8, $t1, 0
	add 	$t9, $zero, 0
	j 	state_3_wait
op_s3:
	beq 	$t9, 10, _calc
	beq 	$t9, 11, _calc
	beq 	$t9, 12, _calc
	beq 	$t9, 13, _calc	
	beq 	$t9, 14, _calc
	beq 	$t9, 15, state_0
_calc:
	addi 	$s5, $zero, 0
	addi 	$s6, $zero, 0
	beq 	$t2, 12, calc_Mult
	beq 	$t2, 13, calc_Divide
	beq 	$t2, 10, calc_Add
	beq 	$t2, 11, calc_Subtract
calc_Mult:
	add 	$t3, $t3, $t0
	addi 	$s5, $s5, 1
	bne 	$s5, $t1, calc_Mult
	j 	finish_Calc
calc_Divide: 
	slti 	$s7, $t0, 0
	beq 	$s7, 1, divide_Neg
divide_Pos:
	sub 	$t0, $t0, $t1
	slti 	$s6, $t0, 0
	bne 	$s6, $zero, finish_Calc
	addi 	$t3, $t3, 1
	slti 	$s6, $t0, 1
	bne 	$s6, $zero, finish_Calc
	j 	divide_Pos
divide_Neg:	
	addi 	$s7, $zero, -1
	add 	$t0, $t0, $t1
	slt 	$t6, $zero, $t0
	bne 	$s6, 0, finish_Calc
	subi 	$t3, $t3, 1
	slt 	$s6, $s7, $t0
	bne 	$s6, 0,finish_Calc
	j 	divide_Neg
calc_Add:
	add 	$t3, $t0, $t1
	j 	finish_Calc
calc_Subtract:
	sub 	$t3, $t0, $t1
	j 	finish_Calc
finish_Calc:
	add 	$t8, $t3, $zero
	beq 	$t9, 14, fin_EQ
	addi 	$t0, $t3, 0
	add 	$t3, $zero, $zero
	add 	$t1, $zero, $zero
	add 	$t2, $t9, $zero
	j 	state_2
fin_EQ:
	add 	$t2, $zero, $zero
	add 	$t1, $zero, $zero
	add 	$t9, $zero, $zero
	j 	state_4_wait
# state_4
# operand1 = Input			0-9
# Display operand1
# Go to State 1
# operand1 = result			+, -, *, /
# operator = Input
# Go to State 2
# Display result			=
# Go back to State 4
# Go to State 0				C
state_4_wait:
	beq 	$t9, $zero, state_4_wait
state_4:
	sll 	$t9, $t9, 1
	srl 	$t9, $t9, 1
	slti 	$s1, $t9, 10
	beq 	$s1, $zero, op_s4
num_s4:	
	add 	$t8, $zero, $zero
	add 	$t0, $t9, $t0
	add 	$t8, $t0, 0
	add 	$t9, $zero, 0
	j 	wait
op_s4:
	beq 	$t9, 14, eq_s4
	beq 	$t9, 15, state_0
	add 	$t0, $t3, $zero
	add 	$t3, $zero, $zero
	add 	$t1, $zero, $zero
	add 	$t2, $t9, $zero
	j 	state_2_wait
eq_s4:
	add 	$t8, $t3, $zero
	addi 	$t1, $zero, 0
	add 	$t3, $zero, $zero
	add 	$t9, $zero, $zero
	j 	state_4_wait
