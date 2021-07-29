addi t0 x0 -1
addi t1 x0 1
beq s0 s0 branch0 

branch0:
    bne s0 x0 branch1

branch1:
    bne s0 s0 branch0
    beq s0 s0 branch3

branch2:
    blt x0 t0 branch3
    bltu x0 t0 branch3

branch3:
    bge x0 t1 branch4
    bgeu t0 x0 branch4

branch4:
    blt t0 x0 branch5  
    jal ra, branch3

b:
    jal x0, end

branch5:
    jalr ra, ra, b

end:
    add x0 x0 x0
     
