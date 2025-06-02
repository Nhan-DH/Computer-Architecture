.data
thong_bao_nhap : .asciz "Nhập vào số thập phân : "
thong_bao_nhi_phan: .asciz "Dạng nhị phân : "
thong_bao_hex: .asciz "Dạng thập lục phân: "
xuong_dong:    .asciz "\n"
bo_dem_nhi_phan: .space 33  # Lưu nhị phân (32-bit + null)
bo_dem_hex:    .space 9     # Lưu thập lục phân (8 ký tự + null)
gioi_han : .asciz "Số nhập vao không thỏa mãn tu 0 - 1000!!!"
.text
main:
    # Hiển thị thông báo nhập số
    li a7, 4
    la a0, thong_bao_nhap
    ecall

    # Nhập số thập phân từ bàn phím
    li a7, 5
    ecall
    addi s1, a0 ,0   # Lưu số vào s1
   # blt s1, zero, loi_ngoai_pham_vi     # nếu s1 < 0 thì nhảy đến thông báo lỗi
   # li s10, 1000
    
   # bgt s1, s10, loi_ngoai_pham_vi       # nếu s1 > 1000 thì nhảy đến thông báo lỗi
  #  j tiep
  #  loi_ngoai_pham_vi:
  #  li a7 , 4
  #  la a0 , gioi_han
  #  ecall
  #  j thoat
    
    #CHUYỂN SANG NHỊ PHÂN
    tiep: 
    li a7, 4
    la a0, thong_bao_nhi_phan
    ecall

    addi t1, s1 ,0              # Copy số vào t1
    la t2, bo_dem_nhi_phan # Con trỏ lưu kết quả

chuyen_nhi_phan:
    beqz t1, tiep_tuc
    li t3, 2
    remu t0, t1, t3        # t0 = t1 % 2
    addi t0, t0, 48        # chuyển thành ASCII '0' hoặc '1'
    sb t0, 0(t2)
    addi t2, t2, 1
    divu t1, t1, t3        # t1 = t1 / 2
    j chuyen_nhi_phan

tiep_tuc:
    bne s1, zero, lap_in_nhi_phan
    li a0, 48   # '0'
    li a7, 11
    ecall
    j chuyen_sang_hex

lap_in_nhi_phan:
    addi t2, t2, -1
    lb a0, 0(t2)
    beqz a0, chuyen_sang_hex
    li a7, 11
    ecall
    j lap_in_nhi_phan

# =CHUYỂN SANG THẬP LỤC PHÂN 
chuyen_sang_hex:
    li a7, 4
    la a0, xuong_dong
    ecall

    li a7, 4
    la a0, thong_bao_hex
    ecall

    mv t1, s1
    la t2, bo_dem_hex

chuyen_hex:
    beqz t1, in_hex
    li t4, 16
    remu t0, t1, t4        # t0 = t1 % 16

    li t5, 10
    blt t0, t5, la_so
    addi t0, t0, 55        # 'A' = 65 = 10 + 55
    j luu_hex

la_so:
    addi t0, t0, 48        # '0' = 48

luu_hex:
    sb t0, 0(t2)
    addi t2, t2, 1
    divu t1, t1, t4        # t1 = t1 / 16
    j chuyen_hex

in_hex:
    bne s1, zero, lap_in_hex
    li a0, 48   # '0'
    li a7, 11
    ecall
    j thoat

lap_in_hex:
    addi t2, t2, -1
    lb a0, 0(t2)
    beqz a0, thoat
    li a7, 11
    ecall
    j lap_in_hex

# Thoát
thoat:
    li a7, 4
    la a0, xuong_dong
    ecall

    li a7, 10
    ecall
