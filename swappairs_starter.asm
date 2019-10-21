#---------------------------------------------------------------------
#       CISC 3593    Computer Organization  Fall 2019
#              Instructor: Vincent Mierlak
#                  HW 5: Swap Pairs
#---------------------------------------------------------------------

       .data 
arr:   .word 2, 1, 4, 3, 6, 5, 8, 7, 10, 9 
size:  .word 10

str1:  .asciiz "arr["
str2:  .asciiz "] = "
nl:    .asciiz "\n"
       .globl main

       .text 
main:
#------------------------------------------------------------------
#              DO NOT MODIFY CODE ABOVE THIS POINT
#------------------------------------------------------------------
#  Use the following Register allocation:
#     $s0 <-- i
#     $s1 <-- base address of arr
#     $s2 <-- size
#     $s3 <-- temp
# ------------------------------------------------------------------

     #--------------------------------------------------------
     #     Implement the function swappairs() here.
     #     Make sure you can break out of the loop and jump
     #     to the label LOOPEXIT
     #--------------------------------------------------------

	addi $s0, $zero, 0 #initialize i
	la $s1, arr #load array address
	lw $s2, size #load size
	addi $t5, $zero, 4
	jal LOOP
	
	
	LOOP:
		bgt $s0, $s2, LOOPEXIT #IF I > SIZE EXIT LOOP
		mul $t2, $s0, $t5  #t2 = I*4
		add $t2, $t2, $s1 # t2 = array base address + iterator bytes
		#store next position to temp
		lw $s3, 4($t2) #temp =  arr[i + 1] 
		lw $t7, 0($t2) #t7(arr[i])
		sw $s3, 0($t2) #store temp into arr[i]
		sw $t7, 4($t2) #arr[i+1] = t7(arr[i])
		addi $s0, $s0, 2 #add 2 to i
		j LOOP
		
		
	
	
	
	



#------------------------------------------------------------------
#       DO NOT MODIFY CODE BELOW THIS POINT
#------------------------------------------------------------------
LOOPEXIT:
        jal PRINTARRAY
        j   EXIT

# PRINTARRAY prints the values in the array
PRINTARRAY:
         addi $sp, $sp, -4 #allocate 4 bytes in the stack, adding takes away memory in stack
         sw   $ra, 0($sp) #fist slot of array

         xor  $s0, $s0, $s0
         
PRLOOP:  slt  $t1, $s0, $s2
         beq  $t1, $zero, EXIT_PRINTARRAY
         
         la $a0, str1
         jal PRINTSTR
         
         move $a0, $s0
         jal PRINTINT
         
         la $a0, str2
         jal PRINTSTR

         sll $t1, $s0, 2
         add $t2, $t1, $s1
         lw  $t5, 0($t2)
         move $a0, $t5
         jal PRINTINT

         la $a0, nl
         jal PRINTSTR

         addi $s0, $s0, 1
         j PRLOOP
EXIT_PRINTARRAY:
        lw $ra, 0($sp)
        addi $sp, $sp, 4
        jr $ra

# PRINTSTR prints a string
PRINTSTR: 
         li $v0, 4              # system call print_str
         syscall
         jr $ra

# PRINTINT prints an integer
PRINTINT:
         li $v0, 1              # system call print_int
         syscall
         jr $ra

EXIT:
         li $v0, 10
         syscall
         

