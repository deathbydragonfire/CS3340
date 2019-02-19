.data
a: .word 0
b: .word 0
c: .word 0
outA: .word 0
outB: .word 0
outC: .word 0
name: .asciiz ""
namePrompt: .asciiz "What is your name? "
intPrompt: .asciiz "Please enter an integer between 1-100: "
message: .asciiz "your answers are: "

.text
main:

li $v0, 4		#print a string
la $a0, namePrompt	#load name prompt
syscall			#call the print

li $v0, 8		#read a string
la $a0, name		#store it in name
li $a1, 12		#max characters is 12
syscall			#call the read

li $v0, 4		#print a string
la $a0, intPrompt	#load int prompt
syscall			#call the print

li $v0, 5		#read an int
syscall			#call the read (int stored in $v0)
sw $v0, a		#store int in 'a'

li $v0, 4		#print a string
la $a0, intPrompt	#load int prompt
syscall			#call the print

li $v0, 5		#read an int
syscall			#call the read (int stored in $v0)
sw $v0, b		#store int in 'b'

li $v0, 4		#print a string
la $a0, intPrompt	#load int prompt
syscall			#call the print

li $v0, 5		#read an int
syscall			#call the read (int stored in $v0)
sw $v0, c		#store int in 'c'


lw $t0, a  		#load a to $t0
lw $t1, b		#load b to $t1
lw $t2, c		#load c to $t2

#calculate 2a-b+9
#	   =a+a-b+9

add $t4, $t0, $t0	#a+a
sub $t5, $t4, $t1	#2a -b
addi $t6, $t5, 9	#2a-b +9

sw $t6, outA		#store result in result A

#calculate c-b+(a-5)
#	  =c-b+a-5

sub $t4, $t2, $t1	#c-b
add $t5, $t4, $t0	#c-b +a
addi $t6, $t5, -5	#c-b+a -5

sw $t6, outB		#store result in result B

#calculate (a-3)+(b+4)-(c+7)
#	   =a+b-c-6

add $t4, $t0, $t1	#a+b
sub $t5, $t4, $t2	#a+b -c
addi $t6, $t5, -6	#a+b-c -6

sw $t6, outC		#store result in result C

li $v0, 4
la $a0, name
syscall			#print user's name
la $a0, message		
syscall			#print the message
li $v0, 1		
lw $a0, outA
syscall			#print result A
li $v0, 11
li $a0, 32
syscall			#print a space
li $v0, 1
lw $a0, outB
syscall			#print result B
li $v0, 11
li $a0, 32
syscall			#print a space
li $v0, 1
lw $a0, outC
syscall			#print result C

li $v0, 10  	#end program
syscall
