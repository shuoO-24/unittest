# CS61CPU

Look ma, I made a CPU! Here's what I did:
- ALU
- Register File
- Control Logic
- Immediate generator

## ALU

### `srl`
`SLL`, `SRL`, and `SRA` perform logical left, logical right, and arithmetic right shifts on the value in register rs1 by the shift amount held in the **lower 5 bits of register `rs2`**.
So we used a splitter before the shifter.  

### Multiply

- `mul`: lower 32 bits of the 64-bit result
- `mulh`: upper 32 bits of the 64-bit result
- Use multiplier:![](https://tva1.sinaimg.cn/large/008i3skNgy1gsk98w55muj30v206a40c.jpg)

#### `mulh`

  - use splitter to separate sign and magnitude parts
  - sign bit: use XOR gate to determine the output's sign bit 
A simple XOR gate cannot get correct outputs.a
Use multiplexer to branch these cases with different outputs 
- if A[31] = 1, negate A, then
- if B[31] = 1, negate B, then
- if A[31] == B[31] == 1, output negated A * negated B
- if A[31] == B[31] == 0, output A * B
- if A[31] != B[31]
  - if A[31] = 0, B[31] = 1, output negated upper bits of A * negated B
  - if A[31] = 1, B[31] = 0, output negated upper bits of negated A * B

---

## Task 2 Register File

### Dux

It can put input into certain output based on the current value received through the input on the south edge.


## Task 3 Addi

### Immediate Generator

I made immdiate generator for general usage, not only for addi. It can decide the type of instruction: R, I, S, B, J, U by opcode.

### Control Logic

Bsel in the control logic also run general cases, but Immediate selector and ALU selector need some upgrading for general cases



## Task 5 More Instructions

### Branch Comparator

Implemented with bit comparator


### Immediate generator

Already Implemented at Task3(+ one more for csrwi)

### Control Logic
**CSR unimplemented yet**

- PCsel : Set to 1 when Branch accepted (BrEq or BrLt becomes 1)
- RegWEn : We write back to register when the Instruction is one of (R, I, JALR, JAL, LUI, AUIPC).
- ImmSel : I didn't use priority encoder(already implemented), but this circuit is priority encoder.
- BrUn : Set to 1 when function 3 is 0x6 or 0x7 and the instruction is B type.
- ASel : Set to 1 when the instruction is one of (B type, JAL, AUIPC).
- BSel : Set to 1 when the insturction is one of (I type, S type, B type, JAL, JALR, LUI, AUIPC, CSR)
- ALUSel : When instruction is R type or Arithmetic of I type, select ALU opertor with priority encoder with the value of funct3 and funct7, and using enable port. Elsewise, ALU operator is add(0000). Finally, select one of (R type ALU op, IA type ALU op, Others ALU op(add)) with mux(For example, when the instruction is R type, select bits of MUX(ALUMUX) becomes 001, when IA, it becomes 010, and when the istruction is other types, it becomes 100).
- MemRW : It becomes 1 when the instruction is S type.
- WBSel : Using Priority Encoder, it sets to 0 when load, 1 when instruction is one of (R, IA, LUI, AUIPC), and 2 when the instruction is one of JAL or JALR.
- CSRWen : CSRWen sets to 1 when it is CSRW or CSRWI 
- CSRSel : CSRSel is 0 when it is CSRW and it becomes 1 when the instruction is CSRWI

### CPU

Followed as we learned

