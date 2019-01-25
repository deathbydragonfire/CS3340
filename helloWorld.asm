.data  #defining static data
var1: 2
var2: 5
var3: 1
result: 9
.text  #this segment is really the code
main:
	lw $t1, var1
	lw $t2, var2 
	lw $t3, var3
	
	add $t4, $t1, $t2
	sub $t4, $t4, $t3
	sw $t4, result
	