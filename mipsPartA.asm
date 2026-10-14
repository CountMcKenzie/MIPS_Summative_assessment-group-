# loading the immediate values of 3 and 7 into $t0 and $t1 respectively
# $t0 due to appropriate register type and synonamous with variable name for c source code
# $t2 as using conditional branch that doesnt support comparison with immediate  

li $t0, 3
li $t2, 7 

# blt as c logic flipped from source, as there is no blt or equal in MIPS
blt $t0, $t2, t0LT7

# code block for id t0 >= 7
add, $t1, $t0, $t0
j end # jump straight to end to avoid t0LT7 (temp reg 0 less than 7) branch

t0LT7: # branch that indicates logic to jump to in event value in temp reg 0 less than immediate value 7
# code block for id t0 < 7
addi $t1, $t0, 7 # add value in $t0 and immediate value 7, store in $t1

end: # value to jump to that places you at end of if-else block

li $v0, 10 # move the value 10 in $v0, as this correlates to syscall
syscall # syscall reads the value in $v0, which 10 from the previous line and so syscall ends the program