.data
invalid_length: .asciiz "Input is too long."
invalid_base_number: .asciiz "Invalid base-35 number." #<----- replace with your base-N!!!!
input_empty: .asciiz "Input is empty."
input_string: .space 40000
.text
main:

  li $v0, 8  #get user_input
  la $a0, input_string
  li $a1, 40000
  syscall
   add $t1, $0, 0
  add $t3, $0, 0
  add $t7, $0, 2

  la $t0, input_string
  lb $t1,0($t0)
  
