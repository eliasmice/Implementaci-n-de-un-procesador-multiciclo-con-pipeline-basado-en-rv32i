addi x6, x0, 0x00000200
slli x6,x6, 4
addi x5, x0, 4
sw x5,0(x6)  # Store 5
addi x6, x6, 4
addi x5, x0, 6
sw x5,0(x6)  # Store 1
addi x6, x6, 4
addi x5, x0, 1
sw x5,0(x6)  # Store 4 
addi x6, x6, 4
addi x5, x0, 9
sw x5,0(x6)  # Store 2
addi x6, x6, 4
addi x5, x0, 0
sw x5,0(x6)  # Store 8


# Put your code here

addi x7, x0, 0 # i

addi x9,x0,5   #n


For_i:
beq x7,x9,Fin
addi x8, x0, 0 # j

For_j:
sub x12,x9,x7 # n-i
addi x12,x12,-1# n-i-1
beq x8,x12,vuelva_i 
addi x13, x0, 0x000000200
slli x13, x13, 4
slli x14,x8,2
add x13,x13,x14   # x13 = 0x00002000 + j*4

lw x10,(x13)	#x10 = el primer dato de memoria
lw x11,4(x13)  
ble x10,x11,vuelva_j
# Swap
sw x11,0(x13)
sw x10,4(x13)

vuelva_j:

addi x8,x8,1 # j ++
jal x0, For_j

vuelva_i:
addi x7,x7,1  # i++
jal x0, For_i

Fin:
addi x6, x0, 0x00000200
slli x6,x6, 4
lw x20, 0(x6)
lw x21, 4(x6)
lw x22, 8(x6)
lw x23, 12(x6)
lw x24, 16(x6)
