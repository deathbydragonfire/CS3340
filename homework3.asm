.data
prompt: .asciiz "Enter some text:"
input: .space 60
wOut: .asciiz " words "
cOut: .asciiz " characters\n"
goodbye1: .asciiz "Goodbye. "
goodbye2: .asciiz "Have a nice day!"
words: .word 0
chars: .word 0

.text
main:
la $a0, prompt
la $a1, input
li $a2, 60
li $v0, 54
syscall			#dialog box asking for a string, stores in input

bne $a1, $zero, quit	#if the status is not good (empty input or hit cancel), exit program
jal count		#call the function to count the characters and words
sw $v0, chars		#store return value
sw $v1, words		#store return value

li $v0, 4
la $a0, input
syscall			#prints the input message

li $v0, 1
lw $a0, words
syscall			#print the number of words

li $v0, 4
la $a0, wOut
syscall			#print the words string

li $v0, 1
lw $a0, chars
syscall			#print the number of characters

li $v0, 4
la $a0, cOut
syscall			#print the chars string

j main			#restart the main loop
quit:

li $v0, 59
la $a0, goodbye1
la $a1, goodbye2
syscall			#print the goodbyes

li $v0, 10
syscall			#exit program

count:
li $t5, 10		#new line char
li $t6, 32		#space char
li $v0, 0		#output for number of chars
li $v1, 1		#output for number of words
la $t0, input		#load address of the message to $t0

addi $sp, $sp, -4	#move the stack pointer down
sw $s1, ($sp)		#push the contents of $s1 to the stack

loop1:			#loop for counting chars
lb $s1, ($t0)		#load the char at $t0
beq $s1, $t5, end1	#if it is a new line, exit the loop
addi $v0, $v0, 1	#iterate the count
addi $t0, $t0, 1	#iterate the address pointer
j loop1			#go back through the loop
end1:

la $t0, input		#reset $t0 to address of message
loop2:
lb $s1, ($t0)		#load the char at $t0
beq $s1, $t5, end2	#if it is a new line, exit loop
addi $t0, $t0, 1	#iterate the address pointer
bne $s1, $t6, loop2	#if the char isnt a space, go back to the start of the loop
addi $v1, $v1, 1	#iterate the count
j loop2
end2:

lw $s1, ($sp)		#pop the stack to $s1
addi $sp, $sp, 4	#move the stack pointer up

jr $ra			#return
