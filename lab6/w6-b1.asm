.data
A : .word -2 , 6 , -1 , 3 , -2
.text
la a0, A
li a1 , 2
j mspfx
continue:
j exit
exit:
li a7 , 10
ecall
end_of_main:
mspfx:
li s0 ,0  #chieu dai cua mang can cong
li s1 , 0x80000000 #so be nhat
li t0 , 0 # buoc nhay i
li t1 , 0 # tong
loop:
add t2 , t0 , t0
add t2 , t2 , t2
add t3 , a0 , t2
lw t4 , 0(t3)
add t1 , t1 , t4
blt s1 , t1 , mdfy
j next
mdfy:
addi s0 , t0 , 1
addi s1, t1 , 0
next:
addi t0 , t0 , 1
blt t0 , a1, loop
done:
j continue 
mspfx_end:

