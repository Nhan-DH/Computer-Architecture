.data
nhap_N: .asciz "Nhap N: "
nhap_M: .asciz "Nhap M: "
so_nguyen_to:  .asciz "So nguyen to: "
newline:    .asciz "\n"

.text 

    # In thông báo nhập N
    li a7, 4
    la a0, nhap_N
    ecall
    li a7, 5
    ecall
    
    addi t0 , a0 , 0
    
    li a7, 4
    la a0, nhap_M
    ecall
    
    li a7, 5
    ecall 
    
    addi t1 , a0 , 0

lap_tu_N_den_M:
    # Nếu t0 > t1 thì thoát chương trình
    bgt t0, t1, end
    # Gọi hàm kiểm tra số nguyên tố
    addi a0, t0 , 0         # Truyền số cần kiểm tra vào a0
    jal ra,ham_kiem_tra  # Gọi hàm kiểm tra số nguyên tố
    bne a0, zero, in_so_nt # Nếu a0 != 0 (tức là số nguyên tố), thì in ra

tang_gia_tri:
    addi t0, t0, 1 
    j lap_tu_N_den_M   

in_so_nt:
    # In chuỗi "So nguyen to: "
    li a7, 4
    la a0, so_nguyen_to
    ecall

    # In số nguyên tố
    li a7, 1
    addi a0, t0, 0
    ecall

    # Xuống dòng
    li a7, 4
    la a0, newline
    ecall

    j tang_gia_tri  # Quay lại vòng lặp 

end:
    li a7, 10  
    ecall

# Hàm kiểm tra số nguyên tố
ham_kiem_tra:
    addi t6, a0 , 0      # Lưu giá trị gốc của a0 vào t6
    
    li t2, 2       # t2 = 2 (bắt đầu kiểm tra từ 2)

    blt t6, t2, tang_gia_tri # Nếu t6 < 2, không phải số nguyên tố

lap_kiem_tra:
    li t3 , 0  #t3 = t2 * t2 
    li t4 , 0  #dem
    # cong t2 lan t2
    vong_lap_nhan:
    # Nếu t3 > t6, thoát vòng lặp
     beq t4, t2, dung_vong_nhan  # t3 = t2 * t2
     add t3, t3 , t2
     addi t4 , t4 , 1
     j vong_lap_nhan
    dung_vong_nhan:  
     bgt t3, t6, prime # Nếu t2*t2 > t6 thì dừng kiểm tra
     
     addi t5 , t6 , 0 # Gán t5 = t6
    # Kiểm tra chia hết bằng phép chia lấy dư
    lap_du:
    blt t5 , t2 , dung_lap_du #khi t5 nho hon t2
    sub t5 , t5 , t2
    j lap_du
    dung_lap_du:
    beq t5, zero, tang_gia_tri # Nếu t6 chia hết cho t2, không phải số nguyên tố
    addi t2, t2, 1    # Tăng t2 lên 1 để kiểm tra số tiếp theo
    j lap_kiem_tra     # Quay lại vòng lặp kiểm tra

    prime:
    li a0, 1         # Nếu qua hết vòng lặp mà không chia hết thì là số nguyên tố
    jr ra            # Trả về


