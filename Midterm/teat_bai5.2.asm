.data
thong_bao_nhap : .asciz "Nhập vào số thập phân : "
thong_bao_nhi_phan: .asciz "Dạng nhị phân : "
thong_bao_hex: .asciz "Dạng thập lục phân: "
xuong_dong:    .asciz "\n"
bo_dem_nhi_phan: .space 33  # Lưu nhị phân (32-bit + null)
bo_dem_hex:    .space 9   # Lưu thập lục phân (8 ký tự + null)
bang_hex:      .asciz "0123456789ABCDEF"