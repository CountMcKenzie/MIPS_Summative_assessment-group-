.data
array: .word 1,0,0,5,0,0,5,0,1


.text
 
main:

li $t0, 4 #lower bound (inclusive)
li $t1, 9 #upper bound (non-inclusive)


sll $t0, $t0, 2
sll $t1, $t1, 2
 
la $t3, array
add $t3, $t3, $t0
 
lw $s0, 0($t3)#min
lw $s1, 0($t3)#max
li $s2, 0 #sum
 
move $t4, $t0 #iterator
 
forLoop:
bge $t4, $t1, endLoop
 
lw $t5, 0($t3) #array at index 0 is t5
add $s2, $s2, $t5 #adding to sum
 
blt $t5, $s1, notNewMax
move $s1, $t5
notNewMax:
 
bgt $t5, $s0, notNewMin
move $s0, $t5
notNewMin:
 
addi $t4, $t4, 4
addi $t3, $t3, 4
 
j forLoop
 
endLoop:
 
li $t6, 5 #t6 is the number of words iterated over
div $s2, $t6
 
li $v0, 10
syscall