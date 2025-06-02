.data
string : .space 50
mes1 : .asciz "nhap vao xau : "
mes2 : .asciz "xau theo chieu nguoc lai la : "
invert : .space 20
.text
main:
scan:
li a7 , 4
la a0 , mes1 
ecall
li a7 , 8
la a0 , string 
li a1 , 20
ecall
string_length:
la t0 , string 
li t1 , 0 
find_length:
lb t2 , 0(t0)
beq t2 , zero , end
addi t0 , t0 , 1
addi t1 , t1 , -1
j find_length
end:
invert_loop:
la s10 , string
la s11 , invert
li s1 , 0 
add t4 , s10 , t1 # t1 la dia chi cua string[i]
lb t2 , 0(t4) # t2 la string[i]
add t3 , s11 , s1 # t3 la dia chi cua invert[0]
sb t2 , 0(t3) 
beq t2 , zero , end_of_strcpy
addi s1 , s1 , 1
addi t1 , t1 , -1 
j invert_loop
end_of_strcpy:
li a7 , 4 
la a0 , mes2
ecall
li a7 , 4
la a0, invert
ecall





