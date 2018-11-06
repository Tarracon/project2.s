#Started CompOrg Project 2
#project2code.s
.data #Declare variables to be used in program
     max_input: .space 4
     error: .asciiz "Input too long"
.text
main:
     addi $t7, $zero, 16
     li $v0, 8
     la $a0, max_input
     syscall
     
     
     
          
