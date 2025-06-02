.data 
string : .space 50
mes1 : .asciz "nhap xau : "
mes2 : .asciz "do dai xau la : "
.text
main:
get_string:
li a7 , 4
la a0 , mes1
ecall
li a7 , 8
la a0 , string
li a1 , 50
ecall
get_length:
la a4 , string # a4 la dia chi cua string[0]
li t0 , 0 # t0 la i
check_char:
add t1 , a4 , t0 # t1 la dia chi cua string[i]  
lb t2 , 0(t1) # t2 la string[i]
beq t2 , zero , end_of_str
addi t0 , t0 , 1 
j check_char
end_of_str:
end_of_get_length:
print_length:
li a7 , 4 
la a0 , mes2 
ecall
li a7 , 1
add a0 , t0 , zero
ecall



