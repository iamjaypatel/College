.text
	# Construct Bag
	jal	_bag_constructor
	add	$s0, $zero, $v0		# $s0 is an address of a bag
	# add items into the bag
	add	$a0, $zero, $s0
	addi	$a1, $zero, 5
	jal	_bag_add
	add	$a0, $zero, $s0
	addi	$a1, $zero, 7
	jal	_bag_add
	add	$a0, $zero, $s0
	addi	$a1, $zero, 2
	jal	_bag_add
	add	$a0, $zero, $s0
	addi	$a1, $zero, 9
	jal	_bag_add
	
	# getCurrentSize
#	add	$a0, $zero, $s0
#	jal	_bag_getCurrentSize
#	add	$a0, $zero, $v0
#	addi	$v0, $zero, 1
#	syscall
	
	# bagPrint()
	add	$a0, $zero, $s0
	jal	_bag_printBag
	
	# test isEmpty
#	add	$a0, $zero, $s0
#	jal	_bag_isEmpty
#	add	$a0, $zero, $v0
#	addi	$v0, $zero, 1
	
	# Terminate Program
	addi	$v0, $zero, 10
	syscall

#Bag Constructor
# Arguments:
#	None
# Return Value:
# 	$v0: an address of new Bag
_bag_constructor:
	#Allocate 8 Bytes
	addi	$v0, $zero, 9		# Syscall 9 to allocate Memory
	addi	$a0, $zero, 8		# Amount to allocate
	syscall
	
	
	sw	$zero, 0($v0)		# Set firstNode to NULL
	sw	$zero, 4($v0)		# Set # Of Entries to 0
	jr	$ra

# Bag getCurrentSize(Bag aBag)
# Arguments:
# 	$a0: An Address of a Bag
# Return Value:
# 	$v0: Return the Number of Entries, inside given Bag
_bag_getCurrentSize:
	lw	$v0, 4($a0)
	jr	$ra

# Bag - isEmpty()
# Arguments:
#	$a0: is an Address of a Bag
# Return Value:
#	$v0: 1 is the given Bag isEmpty, otherwise 0.
_bag_isEmpty:
	addi	$sp, $sp, -12		# Back up 3 Register so -12
	sw	$s1, 8($sp)
	sw	$s0, 4($sp)
	sw	$ra, 0($sp)
	
	add	$s0, $zero, $a0		# $s0 is an address of a Bag
	# Call getGetCurrentSize
	add	$a0, $zero, $s0		
	jal	_bag_getCurrentSize
	add	$s1, $zero, $v0
	beq	$s1, $zero, iEReturn1
	# Return Zero
	add	$v0, $zero, $zero
	j	iEDone
iEReturn1:
	addi	$v0, $zero, 1
iEDone:
	lw	$s1, 8($sp)
	lw	$s0, 4($sp)
	lw	$ra, 0($sp)
	addi	$sp, $sp, 12		# Restore $sp.
	jr	$ra
	
# Bag - add()
# Arguments:
#	$a0: is an Address of a Bag
#	$a1: data(Integer)
# Return Value:
#	None
_bag_add:
	add	$t0, $zero, $a0		# $t0 is the address of Bag
	add	$s1, $zero, $a1		# $t1 is the data
	# Create a new Node
	addi	$v0, $zero, 9
	addi	$a0, $zero, 8
	syscall
	add 	$t2, $zero, $v0		# $t2 is the address of new Node
	sw	$t1, 0($t2)		# newNode.data = aData
	lw	$t3, 0($t0)		# $t3 is the firstNode
	sw	$t3, 4($t2)		# newNode.next = firstNode
	sw	$t2, 0($t0)		# firstNode = newNode
	# #OfEntries ++
	lw	$t4, 4($t0)
	addi	$t4, $t4, 1
	sw	$t4, 4($t0)	
	jr	$ra

# Bag - printBag()
# Arguments:
#	$a0: is an Address of a Bag
# Return Value:
#	None
_bag_printBag:
	add	$t0, $zero, $a0
	lw	$t1, 0($t0)		# $t1 is the currentNode
bpbLoop:
	beq	$t1, $zero, bpbDone
	lw	$a0, 0($t1)		# $a0 = currentNode.data
	addi	$v0, $zero, 1
	syscall
	lw	$t1, 4($t1)
	j	bpbLoop
bpbDone:


_bag_remove:
	add	$t0, $zero, $s0		# $t0 is the address of a bag
	lw	$t1, 0($t0)		# $t1 = firstNode
	lw	$t2, 4($t1)		# $t1 = firstNode.nextNode
	sw	$t2, 0($t0)		# firstNode = firstNode.nextNode
	lw	$v0, 0($t1)		# $v0 = node.data
	jr	$ra	
	


	


	