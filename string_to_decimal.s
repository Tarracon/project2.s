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
