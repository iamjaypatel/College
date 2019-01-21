.text
_foo:
        addi $sp, $sp, -12
        sw   $ra, 0($sp)
        sw   $s0, 4($sp)
        sw   $s1, 8($sp)
        sw   $s2, 12($sp)
        
        lw    $s2, 12($sp)
        lw    $s1, 8($sp)
        lw    $s0, 4($sp)
        lw    $ra, 0($sp)
        addi $sp, $sp, 12
        jr     $ra