.text 

add  $t0, $t1, $t2
loop:    sub  $t0, $t1, $t2
         and  $t0, $t1, $t2
         or   $t0, $t1, $t2
        nor  $t0, $t1, $t2
        xor  $t0, $t1, $t2
        bne  $t0, $t1, loop
        addi $t0, $t1, 1