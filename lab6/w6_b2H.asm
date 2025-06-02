.data
	A: .word 7, -2, 5, 1, 5, 6, 7, 3, 6, 8, 8, 59, 5
	Aend: .word
	space: .asciz " "
	newline: .asciz "\n"
.text
main:
	la a0, A # a0 = address(A[0])
	la a1, Aend
	sub a2, a1, a0
	srli a3, a2, 2 #tính số phần tử của mảng
	addi a1, a1, -4 # a1 = address(A[n-1])
	j sort # sort
after_sort:
	li a7, 10
	ecall
end_main:
# --------------------------------------------------------------
# Procedure sort (ascending selection sort using pointer)
# a0: con trỏ đến phần tử đầu tiên trong đoạn chưa sắp xếp 
# a1: con trỏ đến phần tử cuối cùng trong đoạn chưa sắp xếp
# t0: nơi lưu tạm thời giá trị của phần tử cuối
# s0: con trỏ đến phần tử lớn nhất trong đoạn chưa sắp xếp
# s1: giá trị lớn nhất trong đoạn chưa sắp xếp
# --------------------------------------------------------------
sort:
	beq a0, a1, done # single element list is sorted
	j max # call the max procedure
after_max:
	lw t0, 0(a1) # load last element into t0
	sw t0, 0(s0) # copy last element to max location
	sw s1, 0(a1) # copy max value to last element
	addi a1, a1, -4 # decrement pointer to last element
	j print #sau mot lan sap xep thi in
	j sort # repeat sort for smaller list
done:
	j after_sort
# ---------------------------------------------------------------------
# Thủ tục max
# Chức năng: tìm giá trị và địa chỉ của phần tử lớn nhất trong danh sách
# a0: con trỏ đến phần tử đầu tiên  
# a1: con trỏ đến phần tử cuối cùng  
# ---------------------------------------------------------------------
max:
	addi s0, a0, 0 # init max pointer to first element
	lw s1, 0(s0) # init max value to first value
	addi t0, a0, 0 # init next pointer to first
loop:
	beq t0, a1, ret # if next=last, return
	addi t0, t0, 4 # advance to next element
	lw t1, 0(t0) # load next element into t1
	blt t1, s1, loop # if (next)<(max), repeat
	addi s0, t0, 0 # next element is new max element
	addi s1, t1, 0 # next value is new max value
	j loop # change completed; now repeat
ret:
	j after_max
print:
	li t2, 0 #i = 0
print_loop:
	la a0, A
	beq a3, t2, endprint #nếu i = số phần tử thì end
	slli t3, t2, 2
	add t3, a0, t3 #địa chi của a[i]
	lw a0, 0(t3)
	li, a7, 1
	ecall
	la a0, space
    	li a7, 4
    	ecall
	addi t2, t2, 1
	j print_loop
endprint:
	la a0, newline
    	li a7, 4
    	ecall
    	la a0, A
    	j sort