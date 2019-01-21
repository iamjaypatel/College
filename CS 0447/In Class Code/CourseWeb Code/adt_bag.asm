.text
	# Construct a bag
	jal  _bag_constructor
	add  $s0, $zero, $v0	# $s0 is an address of a bag
	# add items into the bag
	add  $a0, $zero, $s0	# Argument for _bag_add
	addi $a1, $zero, 5
	jal  _bag_add
	add  $a0, $zero, $s0
	addi $a1, $zero, 7
	jal  _bag_add
	add  $a0, $zero, $s0
	addi $a1, $zero, 2
	jal  _bag_add
	add  $a0, $zero, $s0
	addi $a1, $zero, 9
	jal  _bag_add
	# getCurrentSize
	add  $a0, $zero, $s0
	jal  _bag_print_bag
	#add  $a0, $zero, $v0
	#addi $v0, $zero, 1
	#syscall
	addi $v0, $zero, 10
	syscall

# _bag_remove
#
# Remove an item out of the bag
#
# Arguemnt
#   - $a0: An address of a bag
# Return value
#   - $v0: data
_bag_remove:
	add  $t0, $zero, $a0	# $t0 is the address of a bag
	lw   $t1, 0($t0)	# $t1 = firstNode
	lw   $t2, 4($t1)	# $t2 = firstNode.nextNode
	sw   $t2, 0($t0)	# firstNode = firstNode.nextNode
	lw   $v0, 0($t1)	# $v0 = node.data
	jr   $ra		# Go back to caller

# _bag_print_bag
#
# Print all items inside the bag (traverse the link chain)
#
# Arguemnt
#   - $a0: An address of a bag
# Return Value
#   - None
_bag_print_bag:
	add  $t0, $zero, $a0	# $t0 is the address of a bag
	lw   $t1, 0($t0)	# $t1 is the currentNode = firstNode
bpbLoop:
	beq  $t1, $zero, bpbDone	# If currentNode = null (0), go to bpbDone
	lw   $a0, 0($t1)	# $a0 = currentNode.data
	addi $v0, $zero, 1	# Syscall 1: Print integer
	syscall			# Print integer (data)
	lw   $t1, 4($t1)	# currentNode = currentNode.nextNode
	j    bpbLoop		# Go back to bpbLoop
bpbDone:
	jr   $ra		# Go back to caller





# _bag_add
#
# Add a new item into the back (new firstNode)
#
# Arguments:
#   - $a0: An address of a bag
#   - $a1: Data (integer)
# Return value
#   - None
_bag_add:
	add  $t0, $zero, $a0	# $t0 is the address of a bag
	add  $t1, $zero, $a1	# $t1 is the data
	# Create a new node
	addi $v0, $zero, 9	# Syscall 9: allocate memory
	addi $a0, $zero, 8	# Size 8 bytes
	syscall			# Allocate memory for a new node
	add  $t2, $zero, $v0	# $t2 is the address of a new node
	sw   $t1, 0($t2)	# newNode.data = aData
	lw   $t3, 0($t0)	# $t3 is the firstNode
	sw   $t3, 4($t2)	# newNode.next = firstNode
	sw   $t2, 0($t0)	# firstNode = newNode
	# number_of_entries++
	lw   $t4, 4($t0)	# $t4 = number_of_entries
	addi $t4, $t4, 1	# number_of_entries++
	sw   $t4, 4($t0)	# number_of_entries = number_of_entries + 1
	jr   $ra		# Go back to caller





# _bag_isEmpty
#
# Check whether a bag is empty
#
# Argument
#   - $a0: An address of a bag
# Return value
#   - $v0: 1 if the given bag is empty. Otherwise, 0
_bag_isEmpty:
	addi $sp, $sp, -12	# Allocate memory on the stack for 12 bytes
	sw   $s1, 8($sp)	# Backup $s1
	sw   $s0, 4($sp)	# Backup $s0
	sw   $ra, 0($sp)	# Backup $ra
	add  $s0, $zero, $a0	# $s0 is an address of a bag
	# call getCurrentSize
	add  $a0, $zero, $s0	# Set the argument
	jal  _bag_getCurrentSize	# call _bag_getCurrentSize
	add  $s1, $zero, $v0	# $s1 is the current size
	beq  $s1, $zero, ieReturn1	# If the current size is 0, return 1
	# return 0
	add  $v0, $zero, $zero	# Set return value to 0
	j    ieDone
ieReturn1:
	addi $v0, $zero, 1	# Set return value to 1
ieDone:
	lw   $s1, 8($sp)	# Restore $s1
	lw   $s0, 4($sp)	# Restore $s0
	lw   $ra, 0($sp)	# Restore $ra
	addi $sp, $sp, 12	# Adjust the $sp back
	jr   $ra		# Go back to caller




# _bag_getCurrentSize
#
# Get the number of items inside the bag
#
# Argument:
#   - $a0: An address of a bag
# Return value:
#   - $v0: A number of entries inside the given bag
_bag_getCurrentSize:
	lw   $v0, 4($a0)	# $v0 = number_of_items
	jr   $ra		# Return to caller


# _bag_constructor
#
# Construct a new bag | firstNode | number_of_entries | (4 bytes each)
#
# Arguments
#   - None
# Return Value
#   - $v0: an address of a new Bag
_bag_constructor:
	# Allocate 8 bytes
	addi $v0, $zero, 9	# Syscall 9: Allocate memory
	addi $a0, $zero, 8	# Amount to allocate
	syscall			# Allocate memory for 8 bytes
	sw   $zero, 0($v0)	# Set firstNode to NULL
	sw   $zero, 4($v0)	# Set number_of_entries to 0
	jr   $ra		# Return to caller




