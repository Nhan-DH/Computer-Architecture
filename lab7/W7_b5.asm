.data
	max: .asciz "Largest: "
	min: .asciz "Smallest: "
	dau_phay: .asciz ", "
.text
main:
	li a0, 1
	li a1, 2
	li a2, 3
	li a3, 4
	li a4, 5
	li a5, 6
	li a6, 7
	li a7, 8
	li s10, 8 #s? phàn t? c?a m?ng
#---- Chu?n b? g?i hàm find_max_min
	addi sp, sp, -4 #4 thanh ghi
	sw ra, 0(sp) #lưu ra vào stack

	
	jal find_max_min
#---- Khôi ph?c thanh ghi
	lw ra, 0(sp)
	addi sp, sp, 4
#print max	
	li a7, 4
	la a0, max
	ecall
	
	li a7, 1
	add a0, s0, zero
	ecall
	
	li a7, 4
	la a0, dau_phay
	ecall
	
	li a7, 1
	add a0, s2, zero
	ecall
#print newline	
	li a7, 11
	li a0, 10
	ecall
#print min	
	li a7, 4
	la a0, min
	ecall
	
	li a7, 1
	add a0, s1, zero
	ecall
	
	li a7, 4
	la a0, dau_phay
	ecall
	
	li a7, 1
	add a0, s3, zero
	ecall
#exit	
	li a7, 10
	ecall
end_main:
	
#----- hàm t?m max min
find_max_min: 
	addi sp, sp, -32
	sw a0, 0(sp)
	sw a1, 4(sp)
    	sw a2, 8(sp)
   	sw a3, 12(sp)
	sw a4, 16(sp)
	sw a5, 20(sp)
	sw a6, 24(sp)
	sw a7, 28(sp)
	
	lw s0, 0(sp) #max = a0
	lw s1, 0(sp) #min = a0
	li s2, 0 #index_max = 0
	li s3, 0 #index_min = 0
	li t0, 1 #i = 1 ( sau a0)	
loop:
	beq t0, s10, done
	slli t1, t0, 2 #t1 = i * 4
	add t1, sp, t1
	lw t2, 0(t1) #t2 = a[i]
	
	#kiem tra max
	blt s0, t2, update_max
	j check_min

update_max:
	add s0, t2, zero
	add s2, t0, zero
check_min:
	blt t2, s1, update_min
	j next
update_min:
	add s1, t2, zero
	add s3, t0, zero
next:
	addi t0, t0, 1
	j loop
done:
	addi sp, sp, 32
	jr ra
	