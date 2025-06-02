.data
test: .asciz "Hello World"
.text
li a7, 4
la a0, test
ecall
