.data
thong_bao_nhap : .asciz "Nhập vào số thập phân: "
thong_bao_nhi_phan: .asciz "Dạng nhị phân: "
thong_bao_hex: .asciz "Dạng thập lục phân: "
xuong_dong:    .asciz "\n"
bo_dem_nhi_phan: .space 33  # Lưu nhị phân (32-bit + null)
bo_dem_hex:    .space 9     # Lưu thập lục phân (8 ký tự + null)

.text
main:
    # Hiển thị thông báo nhập số
    li a7, 4
    la a0, thong_bao_nhap
    ecall

    # Nhập số thập phân từ bàn phím
    li a7, 5
    ecall
    mv s1, a0  # Lưu số vào s1

    # === CHUYỂN SANG NHỊ PHÂN ===
    li a7, 4
    la a0, thong_bao_nhi_phan
    ecall

    mv t1, s1              # Copy số vào t1
    la t2, bo_dem_nhi_phan # Con trỏ lưu kết quả

chuyen_nhi_phan:
    beqz t1, in_nhi_phan
    li t3, 2
    remu t0, t1, t3        # t0 = t1 % 2
    addi t0, t0, 48        # chuyển thành ASCII '0' hoặc '1'
    sb t0, 0(t2)
    addi t2, t2, 1
    divu t1, t1, t3        # t1 = t1 / 2
    j chuyen_nhi_phan

in_nhi_phan:
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

# === CHUYỂN SANG THẬP LỤC PHÂN (KHÔNG DÙNG BẢNG) ===
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
