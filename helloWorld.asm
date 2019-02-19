.data
a: .word -4

.text
main:
lw $t0, a
bge $t0, 0, exit
sub $t0, $zero, $t0
sw $t0, a

exit:
li $v0, 10
syscall