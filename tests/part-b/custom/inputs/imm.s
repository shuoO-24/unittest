auipc ra 12
lui s0 18

addi s0 s0 95
add s0 x0 s0
addi t0 x0 10
sll t1 s0 t0

slti t1 x0 20
slti t1 x0 31
slli t1 s0 30
ori t1 s0 0xf0
xori t2 s0 31
srli t2 s0 20
srai t2 s0 19
andi t2 s0 0xa0