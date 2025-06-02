.eqv MONITOR_SCREEN  0x10010000
.eqv SCREEN_WIDTH    512
.eqv SCREEN_HEIGHT   512
.eqv PIXEL_SIZE      4
.eqv RED             0x00DA251D
.eqv YELLOW          0x00FFFF00
.eqv BLUE            0x000000FF
.eqv KEYBOARD_DATA   0xffff0004   # nơi lưu mã phím người dùng bấm
.eqv KEYBOARD_READY  0xffff0000   # cờ kiểm tra có phím mới không

.data

.text
.globl main
main:
    li s0, 256        # s0 = center_x
    li s1, 256        # s1 = center_y
    li s2, 40         # s2 = bán kính
    li s3, 80          # s3 = tốc độ

    # Vẽ hình tròn ban đầu trước khi đợi phím
    jal clear_screen
    jal draw_circle

main_loop:
    # Chờ có phím bấm
wait_key:
    li t0, KEYBOARD_READY
    lb t1, 0(t0)
    beqz t1, wait_key

    jal handle_input
    jal clear_screen
    jal draw_circle

    j main_loop

##################################################
# Xử lý phím người dùng nhập
##################################################
handle_input:
    li t0, KEYBOARD_DATA
    lb t3, 0(t0)        # đọc mã phím

    # Phím W (0x77): lên
    li t4, 0x77
    beq t3, t4, move_up

    # Phím S (0x73): xuống
    li t4, 0x73
    beq t3, t4, move_down

    # Phím A (0x61): trái
    li t4, 0x61
    beq t3, t4, move_left

    # Phím D (0x64): phải
    li t4, 0x64
    beq t3, t4, move_right

    # Phím Z (0x7A): tăng tốc
    li t4, 0x7A
    beq t3, t4, increase_speed

    # Phím X (0x78): giảm tốc
    li t4, 0x78
    beq t3, t4, decrease_speed

    jr ra
# xu li di len
move_up:
    addi a3, s1,0
    sub a3, a3,s3
    sub a3 ,a3,s2
    bltz a3 , flip_down
    sub s1, s1, s3     # center_y -= speed
    jr ra
flip_down:
    add s1,s1 ,s3 
    jr ra
 #xu li di xuong 
move_down:
    addi a3, s1 , 0
    add a3 , a3 , s3
    add a3 , a3 , s2
    li a5 ,SCREEN_HEIGHT
    bgt a3 , a5 , flip_up 
    add s1, s1, s3     # center_y += speed
    jr ra
flip_up:
    sub s1,s1,s3
    jr ra
   #xu li sang trai  
move_left:
    addi a3, s0,0
    sub a3, a3,s3
    sub a3 ,a3,s2
    bltz a3 , flip_right
    sub s0, s0, s3     # center_x -= speed
    jr ra
flip_right:
    add s0,s0 ,s3 
    jr ra
# xu li sang phai
move_right:
    addi a3, s0 , 0
    add a3 , a3 , s3
    add a3 , a3 , s2
    li a5 ,SCREEN_WIDTH
    bgt a3 , a5 , flip_left 
    add s0, s0, s3     # center_x += speed
    jr ra
flip_left:
    sub s0,s0,s3
    jr ra

increase_speed:
    addi s3, s3, 1     # speed += 1
    jr ra

decrease_speed:
    addi s3, s3, -1    # speed -= 1
    bgez s3, no_key
    li s3, 1           # đảm bảo speed >= 1
no_key:
    jr ra

##################################################
# clear_screen: tô toàn bộ nền màu BLUE
##################################################
clear_screen:
    li t0, MONITOR_SCREEN
    li t1, SCREEN_WIDTH
    li t2, SCREEN_HEIGHT
    mul t3, t1, t2       # tổng số pixel
    li t4, BLUE

clear_loop:
    sw t4, 0(t0)
    addi t0, t0, 4
    addi t3, t3, -1
    bnez t3, clear_loop
    jr ra

##################################################
# draw_circle: Vẽ hình tròn tại (s0, s1) với bán kính s2
##################################################
draw_circle:
    li t0, 0              # current_y = 0

loop_y:
    li t1, 0              # current_x = 0

loop_x:
    sub t2, t1, s0        # dx = x - center_x
    sub t3, t0, s1        # dy = y - center_y
    mul t4, t2, t2        # dx^2
    mul t5, t3, t3        # dy^2
    add t6, t4, t5        # distance^2
    mul s7, s2, s2        # radius^2

    bgt t6, s7, skip_pixel

    li a7, SCREEN_WIDTH
    mul s8, t0, a7        # y * width
    add s8, s8, t1        # + x
    li a6, PIXEL_SIZE
    mul s8, s8, a6        # * 4
    li s9, MONITOR_SCREEN
    add s9, s9, s8        # addr

    li s10, RED
    sw s10, 0(s9)         # vẽ pixel

skip_pixel:
    addi t1, t1, 1
    li s11, SCREEN_WIDTH
    blt t1, s11, loop_x

    addi t0, t0, 1
    li s11, SCREEN_HEIGHT
    blt t0, s11, loop_y

    jr ra
