.data
invalid_length: .asciiz "Input is too long." #declare variables used to print error messages
invalid_base_number: .asciiz "Invalid base-35 number."
input_empty: .asciiz "Input is empty."
input_string: .space 40000
.text

main:

  li $v0, 8  #store instruction to get user_input
  la $a0, input_string
  li $a1, 40000
  syscall #Call to get user input
  add $t1, $0, 0 #initialize registers
  add $t3, $0, 0
  add $t7, $0, 2

  la $t0, input_string #load user string into register
  lb $t1,0($t0) #load first index of user string
#CHECKING IF INPUT IS EMPTY
beq $t1, 10, Empty_Error
beq $t1, 0 Empty_Error

addi $s0, $0, 35 #Iniatialize registers to be used later
addi $t4, $0, 1
addi $t5, $0, 0
addi $t6, $0, 0

skip_spaces:
  lb $t1,0($t0)
  addi $t0, $t0, 1
  addi $t3, $t3, 1
  beq $t1, 32, skip_spaces
  beq $t1, 10, Empty_Error
  beq $t1, $0, Empty_Error

see_some_chars:
  lb $t1,0($t0)
  addi $t0, $t0, 1
  addi $t3, $t3, 1
  beq $t1, 10, go_back_to_beginning
  beq $t1, 0, go_back_to_beginning
  bne $t1, 32, see_some_chars
see_some_more_chars_or_spaces:
  lb $t1,0($t0) #Load bit from string
  addi $t0, $t0, 1 #Iterate through string
  addi $t3, $t3, 1
  beq $t1, 10, go_back_to_beginning 
  beq $t1, 0, go_back_to_beginning
  bne $t1, 32, Invalid_Base_Error #if character isn't right base print error message
  j see_some_more_chars_or_spaces
go_back__to_beginning:
  sub $t0, $t0, $t3     #restarting the pointer in char_array back to first index
  la $t3, 0             #reset the counter

go_forward:
  lb $t1,0($t0) #Load bit of string
  addi $t0, $t0, 1
  beq $t1, 32, go_forward #Forward through string
  addi $t0, $t0, -1
find_length:
  lb $t1, ($t0)
  addi $t0, $t0, 1
  addi $t3, $t3, 1
  beq $t1, 10, loop_assist 
  beq $t1, 0, loop_assist
  beq $t1, 32, loop_assist
  beq $t3, 5, Length_Error
  j find_length

loop_assist:
  sub $t0, $t0, $t3 #Subtract from registers to regulate loops
  sub $t3, $t3, $t4
  lb $t1, ($t0) #Load bits from string
  sub $s1, $t3, $t4
Find_greatest_power:
  beq $s1, 0, Ascii_converter        #Bringing base to last power of the string
  mult $t4, $s0
  mflo $t4
  sub $s1, $s1, 1
  j Find_greatest_power
multiply:
  mult $t1, $t4
  mflo $t5            #sub_sum
  add $t6, $t6, $t5     #final sum
  beq $t4, 1, Exit
  div $t4, $s0 #dividing t4 to the next power of base
  mflo $t4
  add $t0, $t0, 1
  lb $t1,0($t0)
  j Ascii_converter
Exit:
  move $a0, $t6 #moves sum to a0
  li $v0, 1 #prints contents of a0
  syscall
  li $v0,10 # Load command to end program
  syscall
Ascii_converter:
  blt $t1, 48, Invalid_Base_Error #checks if character is before 0 in ASCII chart
  blt $t1, 58, Number #checks if character is between 48 and 57
  blt $t1, 65, Invalid_Base_Error #checks if character is between 58 and 64
  blt $t1, 90, Upper_Case #checks if character is between 65 and 85
  blt $t1, 97, Invalid_Base_Error #checks if character is between 76 and 96
  blt $t1, 122, Lower_Case #checks if character is between 97 and 121
  blt $t1, 128, Invalid_Base_Error #checks if character is between 118 and 127
Upper_Case:
  addi $t1, $t1, -55
  j multiply
Lower_Case:
  addi $t1, $t1, -87
  j multiply
Number:
  addi $t1, $t1, -48
  j multiply
#BRANCHES FOR ERROR MESSAGES
Empty_Error:
  la $a0, input_empty #loads string
  li $v0, 4
  syscall
  li $v0,10 #ends program
  syscall
Too_Long_Error:
  la $a0, invalid_length #loads string
  li $v0, 4
  syscall
  li $v0,10 #ends program
  syscall
