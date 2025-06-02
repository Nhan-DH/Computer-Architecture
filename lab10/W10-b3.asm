.eqv monito 0x10010000
.eqv white 0x00ffffff
.eqv yellow 0x00ffff00

.text
li a0, monito

li s0, 0
li s1, 32
j loop1
done:
addi s1, s1, 32
loop1: bge s0, s1, done1
li a0, monito
add a0, a0, s0
li t0, white
sw t0, 0(a0)
addi s0, s0, 8
j loop1

done1:
addi s0, s0, -28
loop2: bge s0, s1, done
li a0, monito
add a0, a0, s0
li t0, yellow
sw t0, 0(a0)
addi s0, s0, 8
j loop2