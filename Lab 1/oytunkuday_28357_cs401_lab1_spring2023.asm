.data

array1: .word 9, 8, 7, 6, 5, 4, 3, 2, 1, 0 # final 0 indicates the end of the array; 0 is excluded; it should return TRUE for this array
array2: .word 8, 9, 6, 7, 5, 4, 3, 2, 1, 0 # final 0 indicates the end of the array; 0 is excluded; it should return FALSE for this array
#adding some more arrays for edge case testing
array3: .word 9, 0 #one element, TRUE
array4: .word 6, 9, 0 #two element, FALSE
array5: .word 9, 5, 0 #two element, TRUE
array6: .word 4,6, 5, 0 #three element, false
array7: .word 5,5, 5, 0 #three element, false
array8: .word 6,5,6, 0 #three element, false ******
array9: .word 6,5,4,6, 0 #4 element, false *****
array10: .word 4, 5, 6, 5, 0 #4 element, false
array11: .word 6,5,4,6,7, 0 #4 element, false *****

true: .asciiz "TRUE\n"
false: .asciiz "FALSE\n"
default: .asciiz "This is just a template. It always returns "

.text

main:
      la $a0, array2 # $a0 has the address of the A[0]
      jal lenArray  # Find the lenght of the array
      
      move $a1, $v0  # $a1 has the length of A
      #sub $v0,$v0,$v0
      jal Descending

      bne $v0, 0,  yes
      la  $a0, false
      li $v0, 4
      syscall
      j exit

yes:  la    $a0, true
      li $v0, 4
      syscall

exit:
      li $v0, 10
      syscall


Descending:
###############################################
#   Your code goes here
###############################################
      sub $sp, $sp, 12   # we adjust the stack for saving return address and argument
      sw  $ra, 0($sp)   # stores the return address in stack
      sw  $a1, 4($sp)
      sw  $a0, 8($sp)   
      slti $t0, $a1, 2    #t0 must be 0 for call
      slt $t4, $t0, $v0
      #beq $v0, $zero, Short_condition
      bne $t4, $zero, Label
      sgt $t4, $t4, $zero 
      addi $sp, $sp, 12
      jr $ra
      
Label:
      subi $a1, $a1, 1               #decrease len by 1
      lw $t1, 0($a0)
      lw $t2, 4($a0)
      slt $v0, $t2,$t1           #A[1]>A[0]
      addi $a0, $a0, 4	#make array point to next element
      jal Descending                  #jumps to descending with argument being n-1 and the next pointer on array, we calculate v0 first for shortcircuit condition	
      lw $a0, 8($sp)                 #restores n
      lw $a1, 4($sp)
      lw $ra, 0($sp)                #restores return address
      addi $sp, $sp, 12             #pops the stack off 3 items

      #beq $v0, $zero, Short_condition
      #mul $v0,$t3,$v0
###############################################
# Everything in between should be deleted
###############################################
      jr $ra	

lenArray:       #Fn returns the number of elements in an array
      addi $sp, $sp, -8
      sw $ra,0($sp)
      sw $a0,4($sp)
      li $t1, 0

laWhile:       
      lw $t2, 0($a0)
      beq $t2, $0, endLaWh
      addi $t1,$t1,1
      addi $a0, $a0, 4
      j laWhile

endLaWh:
      move $v0, $t1
      lw $ra, 0($sp)
      lw $a0, 4($sp)
      addi $sp, $sp, 8
      jr $ra
