.data
	msg: .word 0x15a9b379

.text
	lw	$t0, msg
	lw	 $s0, 12($t0)
