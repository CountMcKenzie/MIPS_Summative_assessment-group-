.data
 
fibSequence: .word 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0

.text
j main # jump to main which is below outputVal procedure ensureing we dont run the procedure with undefined values and initiate undefined, erronious behaviour

outputVal: # used so logic of outputting numbers doesnt have to be repeated 3 times (1 for 0, 1 for 1, 1 for in loop) - value in $a0 should be correct when invoked per procedure syntax
li $v0, 1 # loads 1 into $v0 to ensure syscall has intended behaviour of outputting a number that is in $a0
syscall # syscall outputs number in $a0, which is correctly defined outside of procedure, before invoking and has behaviour defined by previous line to output number

li $v0, 11 # value in $v0 11 to define behaviour for syscall to output single character
li $a0, 32 # 32 is an ascii reference, where 32 in ascii is a space
syscall # outputs single space per behaviour defined by $v0 and ascii determinator in $a0
jr $ra # JR so we return to the correct line, where we jumped and link from, jal stores the address to return to in the return address ($ra) register


main: # to indicate start point of program, where we can safely jump to from the start and avoid running procedures with undefined registers

la $t0, fibSequence # the address that points to our first value within fibSequence defined in memory

# code to output the first 2 words in fibSequence, as these are predetermined and thus not calculated during loop logic, loop only outputs calculated values
lw $a0, 0($t0) # load the first number at address $t0 with 0 offset (so the first number) and store it in arg register 0, immedietely putting it in correct register for outPut val procedure syntax and internal / MIPS syscall output syntax 
jal outputVal # JAL, ensuring we return to this line with JR, invoking to output the value 0, as this is predetermined and wont be outputted during loop logic
lw $a0, 4($t0) # load the first number at address $t0 with 4 bytes of offset (so the second number) and store it in arg register 0, immedietely putting it in correct register for outPut val procedure syntax and internal / MIPS syscall output syntax 
jal outputVal # JAL, ensuring we return to this line with JR, invoking to output the value 1, as this is predetermined and wont be outputted during loop logic

li $t4, 0 # iterator - counts how many times we have looped (how many values on top of the predetermined 0 and 1 have been calculated) used in beq comparison as exit case with limit at start of loop
li $t5, 8 # limit - limits how many values we calculate, where limit is n we calculate n values but output n + 2 values, as 0 and 1 is predetermined. used in beq comparison as exit case with iterator at start of loop


startLoop: # indicates the start of the loop, where to jump to to ensure loop logic and checks are executed and ensure orderly program flow.

beq $t4, $t5, endloop # loop exit case, if our iterator is equal to the limit, we want to jump to the end

lw $t1, 0($t0) # gets value at index iterator for purposes of calculating next fib value
lw $t2, 4($t0) # gets value at index iterator + 1 for purposes of calculating next fib value

add $t3, $t1, $t2 # adds the 2 values loaded previously to calculate the next fibbonaci value

move $a0, $t3 # moves the new value into argument register 0, as outputVal is a pseudo function and use case lines up with requirements of function and syscall within function
jal outputVal # jump and link to defined procedure outputVal and make sure that we can return with jump return and be at same point so flow is not broken, outputs newly calculated fibbonacci value


sw $t3, 8($t0) # put the new value in its repective place within the array, 8 byte offset as the 2 words at offsets 0 and 4 were used and thus occupied to calculate the fib value we are storing 
addi $t0, $t0, 4 # adds 4 to the memory address in $t0, offsetting appropriately for the next iteration of the loop.

addi $t4, $t4, 1 # adding 1 to our incrementor in temp register 4 to ensure we are tracking how many times this loop has been executed
j startLoop # jumping back to the start of the loop
endloop:# indicates where loop logic ends, can be jumped to to prevent loop from being executed again
