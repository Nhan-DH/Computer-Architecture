.data 
A: .word 7, -2, 5, 1, 5, 6, 7, 3, 6, 8, 8, 59, 5   # Mảng có thể thay đổi tùy ý
Aend:   # Nhãn đánh dấu cuối mảng, không chứa dữ liệu

.text 
main:  
   la    a0, A        # a0 = địa chỉ phần tử đầu tiên của mảng
   la    a1, Aend     # a1 = địa chỉ sau phần tử cuối cùng
   sub   t2, a1, a0   # t2 = kích thước mảng (tính bằng byte)
   srai  t2, t2, 2    # t2 = số phần tử của mảng (chia cho 4)
   add   a1, a0, t2   # a1 = địa chỉ phần tử cuối cùng
   addi  a1, a1, -4   # a1 = dịch về đúng phần tử cuối
   j     sort         # Nhảy đến sắp xếp

after_sort: 
   li    a7, 10 
   ecall              # Thoát chương trình

# -------------------------------------------------------------- 
# Sắp xếp chọn (Selection Sort) 
# -------------------------------------------------------------- 
sort:  
   beq   a0, a1, done   # Nếu chỉ còn một phần tử, mảng đã được sắp xếp -> thoát
   j     max            # Gọi thủ tục tìm phần tử lớn nhất

after_max:  
   lw    t0, 0(a1)      # Lấy giá trị phần tử cuối mảng vào t0
   sw    t0, 0(s0)      # Gán giá trị phần tử cuối vào vị trí phần tử lớn nhất
   sw    s1, 0(a1)      # Đưa giá trị lớn nhất vào cuối mảng
   jal   print_array    # In ra mảng sau mỗi lần hoán đổi
   addi  a1, a1, -4     # Dịch con trỏ a1 về trước
   j     sort           # Lặp lại quá trình sắp xếp

done:  
   j     after_sort 

# -------------------------------------------------------------- 
# Tìm phần tử lớn nhất trong mảng con 
# -------------------------------------------------------------- 
max: 
   addi  s0, a0, 0   # s0 = con trỏ phần tử lớn nhất
   lw    s1, 0(s0)   # s1 = giá trị phần tử đầu tiên
   addi  t0, a0, 0   # t0 = con trỏ duyệt mảng

loop: 
   beq   t0, a1, ret # Nếu t0 == a1, đã duyệt hết mảng -> quay lại after_max
   addi  t0, t0, 4   # Tiến con trỏ t0 đến phần tử tiếp theo
   lw    t1, 0(t0)   # Đọc giá trị phần tử tiếp theo vào t1

   blt   t1, s1, loop # Nếu t1 < s1, tiếp tục vòng lặp
   addi  s0, t0, 0   # Cập nhật con trỏ s0 về t0
   addi  s1, t1, 0   # Cập nhật giá trị lớn nhất
   j     loop        # Tiếp tục tìm max

ret: 
   j     after_max   # Quay lại after_max sau khi tìm thấy max

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
