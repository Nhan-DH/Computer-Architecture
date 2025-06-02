.data
message1: .asciz "The sum of "
message2: .asciz " and "
message3: .asciz " is "

.text
#Nhap s0
li a7, 5
ecall
add s0, a0, zero
#Nhap s1
li a7, 5
ecall
add s1, a0, zero
#In "The sum of"
la a0, message1
li a7, 4
ecall
#In s0
add a0, s0, zero
li a7, 1
ecall
# In "and"
la a0, message2
li a7, 4
ecall
#In s1
add a0, s1, zero
li a7, 1
ecall
#In "is"
la a0, message3
li a7, 4
ecall
#In result
add a0, s0, s1
li a7, 1
ecall

