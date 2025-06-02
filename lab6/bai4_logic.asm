.data
x : .space 32
y : .asciz "Hello Doan cuti"
.text
la a0 , x
la a1 , y
strspy:
add s0 , zero , zero #s0 = i = 0
L1:
add  t1 , s0 , a1 #t1 la dia chi cua y[i]
lb t2 , 0(t1) # t2 la gia tri tai y[i]
add t3 , s0 , a0 # t3 la dia chi cua x[i]
sb t2 , 0(t3)  # x[i] = t2 = y[i]
beq t2 , zero , end_of_strcpy
addi s0 , s0 , 1 
j L1
end_of_strcpy:
li a7 , 4
la a0 , x
ecall 