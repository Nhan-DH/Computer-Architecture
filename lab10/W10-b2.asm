.eqv SEVENSEG_LEFT    0xFFFF0011    # Dia chi cua den led 7 doan trai 
                                    #     Bit 0 = doan a 
                                    #     Bit 1 = doan b 
                                    #     ...    
                                    #     Bit 7 = dau . 
.eqv SEVENSEG_RIGHT   0xFFFF0010    # Dia chi cua den led 7 doan phai 
 .data
SEGMENT_CODES:  # Mảng ánh xạ chữ số 0-9 sang mã LED 7 đoạn
    .byte 0x3F   # 0
    .byte 0x06   # 1
    .byte 0x5B   # 2
    .byte 0x4F   # 3
    .byte 0x66   # 4
    .byte 0x6D   # 5
    .byte 0x7D   # 6
    .byte 0x07   # 7
    .byte 0x7F   # 8
    .byte 0x6F   # 9
.text 
 li a7 , 12
 ecall
 addi t0 , a0 , 0
 mv t1 , t0
 li t2 , 10 
 div t3 , t1 , t2
 rem t4 , t1 , t2
 #lay ma Led 7 thanh tu anh xa
 la t5 , SEGMENT_CODES
 add t6 , t5 , t3
 lb a0 , 0(t6)
  jal     SHOW_7SEG_LEFT
 la t5 , SEGMENT_CODES
 add t6 , t5 , t4
 lb a0 , 0(t6)
 jal     SHOW_7SEG_RIGHT         # show
     
exit:      
    li      a7, 10 
    ecall 
end_main: 
 
# --------------------------------------------------------------- 
# Function  SHOW_7SEG_LEFT : turn on/off the 7seg 
# param[in]  a0   value to shown        
# remark     t0 changed 
# --------------------------------------------------------------- 
SHOW_7SEG_LEFT:   
    li      t0, SEVENSEG_LEFT   # assign port's address  
    sb      a0, 0(t0)           # assign new value   
    jr      ra 
                  
# --------------------------------------------------------------- 
# Function  SHOW_7SEG_RIGHT : turn on/off the 7seg 
# param[in]  a0   value to shown        
# remark     t0 changed 
# --------------------------------------------------------------- 
SHOW_7SEG_RIGHT:  
    li   t0, SEVENSEG_RIGHT     # assign port's address 
    sb   a0, 0(t0)              # assign new value  
    jr   ra