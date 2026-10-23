.data # anything below here and above .text is variables that are defined in memory.

studentID: .word 1,0,0,5,0,0,5,0,1 # our studentID stored as an array in memory, when we say array (including throughout this program) I mean a contuguously allocated block of memory that stores all words defined after .word sequentially

.text # anything below here is the program, procedural instructions.

li $t0, 4 #lower bound (inclusive)
li $t1, 9 #upper bound (non-inclusive)


sll $t0, $t0, 2 # multiply lower bound by 4, so its scaled to MIPS word size in bytes
sll $t1, $t1, 2 # multiply upper bound by 4, so its scaled to MIPS word size in bytes
 
la $t3, studentID # load the address of the first word of contiguasly allocated words at label studentID in memory 

add $t0, $t0, $t3 # adding lower bound to array address and storing in lower bound location, ensureing lower bound register is now an address - lower bound can also be used as our iterator
add $t1, $t1, $t3 # adding upper bound to array address and storing in upper bound location, ensureing upper bound register is now an address - upper bound can also be a comparison to compare to our iterator as an exit case
 
lw $s0, 0($t3)#min - initialise min variable, initialised to first word of our subsection of the array specified at address in temp reg 3, which is our array studentID as a starting point, as its safe and will be overwritten if incorrect
lw $s1, 0($t3)#max - initialise max variable, initialised to first word of our subsection of the array specified at address in temp reg 3, which is our array studentID as a starting point,, as its safe and will be overwritten if incorrect
li $s2, 0 #sum - initialised to 0 so it can be a procedural sum that updates per loop iteration
 
forLoop: # branch name to indicate the start of the loop
beq $t0, $t1, endLoop # comparison to see if our lower bound value is the same as our upper bound, if it is then branch to endLoop, breaking the loop 
 
lw $t5, 0($t0) # load the value specified at the address given by temp register 3, into temp register 5. this is the word (part of our student ID) that will be focused on for this iteration for necessary logic to reach final values

add $s2, $s2, $t5 # adding to sum - sum initialised out of loop, adding to it the value of our student value we are looking at on this loop iteration
 
blt $t5, $s1, notNewMax # check if the value of our student ID number of interest is greater than the current value stored in saved register 1, which holds our max value, if its not skip the next line which updates our max value
move $s1, $t5 # update our max value, copy the part of our student number that is greater than the old value in saved register 1 into saved register 1 overwriting it
notNewMax: # where we jump to if the value is not a new max, skipping the previous line which overwrites the max
 
bgt $t5, $s0, notNewMin # check if the value of our student ID number of interest is less than the current value stored in saved register 0, which holds our min value, if its not skip the next line which updates our min value
move $s0, $t5 # update our min value, copy the part of our student number that is less than the old value in saved register 0 into saved register 0 overwriting it
notNewMin: # where we jump to if the value is not a new min, skipping the previous line which overwrites the min
 
addi $t0, $t0, 4 # add 4 to the lower bound, as the value which is now just above our lower bound (after 4 has been added) has been accounted for and we can can now iterate to the next value in our student id
j forLoop # jump back to the start of the loop to begin the next iteration for the next number in our studentID array
 
endLoop: # end loop branch that will be branched to once our lower bound is equal to our upper bound - which means every value in our studentID array has been iterated over
 
li $t6, 5 #t6 is the number of words iterated over, used to calculate the average and hard coded for simplicity and given scope of program / goals. we will only look at 5 numbers at a time
div $s2, $t6 # div which stores our average in the hi and lo registers, lo being the amount of times the denominator goes into the numerator, and hi storing the remainder.
 
li $v0, 10 # loading 10 into $v0 as syscall looks at this register to determine its behaviour, 10 tells syscall to end the program
syscall # syscall called with appropriate value in $v0 telling the program to end