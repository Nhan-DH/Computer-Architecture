.data 
A: .word 7, -2, 5, 1, 5, 6, 7, 3, 6, 8, 8, 59, 5   # Mảng có thể thay đổi tùy ý
Aend:   # Nhãn đánh dấu cuối mảng, không chứa dữ liệu

.text 
main:  
   la    a0, A        # a0 = địa chỉ phần tử đầu tiên của mảng
   la    a1, Aend     # a1 = địa chỉ sau phần tử cuối cùng
   sub   t2, a1, a0   # t2 = kích thước mảng (tính bằng byte)
   srai  t2, t2, 2    # t2 = số phần tử của mảng (chia cho 4)
   addi  t2, t2, -1   # t2 = số lần lặp chính của Bubble Sort
   j     bubble_sort  # Nhảy đến thuật toán sắp xếp

after_sort: 
   li    a7, 10 
   ecall              # Thoát chương trình

# -------------------------------------------------------------- 
# Thuật toán sắp xếp nổi bọt (Bubble Sort) 
# -------------------------------------------------------------- 
bubble_sort:
   beqz  t2, after_sort  # Nếu t2 == 0, đã sắp xếp xong
   slli  t1, t2, 2   # t1 = t2 * 4 (chuyển số phần tử thành byte)
   add   a2, a0, t1  # a2 = địa chỉ phần tử (n-1)
   li    t3, 0         # Biến cờ kiểm tra xem có đổi chỗ không

outer_loop:
   addi   t0, a0, 0     # t0 = con trỏ phần tử đầu tiên

inner_loop:
   beq   t0, a2, end_inner_loop  # Nếu đã tới cuối vùng cần xét, kết thúc vòng trong
   lw    t1, 0(t0)               # Đọc giá trị phần tử hiện tại
   lw    t4, 4(t0)               # Đọc giá trị phần tử tiếp theo

   ble   t1, t4, skip_swap       # Nếu t1 <= t4, không cần đổi chỗ
   sw    t1, 4(t0)               # Đổi chỗ hai phần tử
   sw    t4, 0(t0)
   li    t3, 1                   # Đánh dấu đã có sự đổi chỗ
   jal   print_array             # In mảng sau khi hoán đổi

skip_swap:
   addi  t0, t0, 4               # Di chuyển con trỏ t0 đến phần tử tiếp theo
   j     inner_loop              # Lặp lại vòng trong

end_inner_loop:
   beqz  t3, after_sort          # Nếu không có hoán đổi nào, kết thúc sớm
   addi  t2, t2, -1              # Giảm số vòng lặp chính
   j     outer_loop              # Lặp lại vòng ngoài

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
