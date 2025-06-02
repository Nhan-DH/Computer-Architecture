.data 
A: .word 7, -2, 5, 1, 5, 6, 7, 3, 6, 8, 8, 59, 5   # Mảng có thể thay đổi tùy ý
Aend:   # Đánh dấu cuối mảng

.text 
main:  
   la    a0, A        # a0 = địa chỉ phần tử đầu tiên của mảng
   la    a1, Aend     # a1 = địa chỉ sau phần tử cuối cùng
   sub   t0, a1, a0   # t0 = kích thước mảng (tính bằng byte)
   srai  t0, t0, 2    # t0 = số phần tử của mảng (chia cho 4)
   addi  t0, t0, -1   # t0 = số phần tử - 1 (phần tử đầu mặc định đã "sắp xếp")
   j     insertion_sort  # Nhảy đến thuật toán sắp xếp

after_sort: 
   li    a7, 10 
   ecall              # Thoát chương trình

# -------------------------------------------------------------- 
# Thuật toán sắp xếp chèn (Insertion Sort) 
# -------------------------------------------------------------- 
insertion_sort:
   li    t1, 1            # t1 = chỉ số i, bắt đầu từ phần tử thứ hai (i = 1)

outer_loop:
   bge   t1, t0, after_sort  # Nếu i >= số phần tử, kết thúc
   slli  t2, t1, 2           # t2 = i * 4 (offset)
   add   t3, a0, t2          # t3 = địa chỉ A[i]
   lw    t4, 0(t3)           # t4 = key (A[i])
   add   t5, t1, zero        # t5 = j = i

inner_loop:
   beqz  t5, insert_done     # Nếu j == 0, kết thúc vòng lặp
   addi  t6, t5, -1          # t6 = j - 1
   slli  t6, t6, 2           # t6 = (j - 1) * 4
   add   t3, a0, t6          # t3 = địa chỉ A[j-1]
   lw    t2, 0(t3)           # t2 = A[j-1]

   ble   t2, t4, insert_done # Nếu A[j-1] <= key, thoát vòng lặp
   sw    t2, 4(t3)           # Dịch A[j-1] sang phải (A[j] = A[j-1])
   addi  t5, t5, -1          # j -= 1
   j     inner_loop          # Lặp lại vòng lặp

insert_done:
   slli  t6, t5, 2           # t6 = j * 4 (offset)
   add   t3, a0, t6          # t3 = địa chỉ A[j]
   sw    t4, 0(t3)           # Đặt key vào đúng vị trí
   jal   print_array         # In ra mảng sau mỗi lần chèn

   addi  t1, t1, 1           # i += 1
   j     outer_loop          # Lặp lại vòng ngoài

# -------------------------------------------------------------- 
# Chương trình con in ra mảng hiện tại 
# -------------------------------------------------------------- 
print_array:
   la    t0, A       # t0 = con trỏ đầu mảng
   la    t1, Aend    # t1 = địa chỉ sau phần tử cuối cùng

print_loop:
   bge   t0, t1, print_done  # Nếu đã duyệt hết, dừng in
   lw    a0, 0(t0)           # Load giá trị cần in
   li    a7, 1               # syscall print integer
   ecall                     # In số nguyên

   li    a0, 32              # In khoảng trắng (ASCII 32)
   li    a7, 11              # syscall print char
   ecall                     # In khoảng trắng

   addi  t0, t0, 4           # Dịch con trỏ t0 sang phần tử tiếp theo
   j     print_loop          # Lặp lại

print_done:
   li    a0, 10              # In ký tự xuống dòng (ASCII 10)
   li    a7, 11              # syscall print char
   ecall
   jr    ra                  # Quay về lệnh gọi
