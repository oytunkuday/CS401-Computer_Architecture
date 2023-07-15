.data

array1: .word 1, 1, 2, 2, 3, 3, 4, 4, 5, 5
array2: .word 2, 2, 3, 3, 4, 4, 5, 5, 6, 6

tempArray1: .space 40 #for storing different elements in array1
tempArray2: .space 40 #for storing different elements in array2


message: .asciiz "The sum of the same elements is "

.text


main:
	la $a0, array1 
	la $a1, tempArray1 
      	jal DiffElement  
      	move $s0, $v0 
      	
      	la $a0, array2 
	la $a1, tempArray2 
      	jal DiffElement  
     	move $s1, $v0

     	la $a0, tempArray1
     	move $a1, $s0
     	la $a2, tempArray2
     	move $a3, $s1
     	
     	jal SumofElements
     	
     	move $t0, $v0
     	
     	la $a0, message
     	li $v0, 4
     	syscall	
     	
      	move $a0, $t0  
      	li $v0,1
      	syscall
      	
      	li $v0, 10
      	syscall   
      

     
DiffElement:
###############################################
#   Your code goes here
###############################################
	
	li $s2, 0 
	move $s4, $a0 
	li $t0, 10 
	move $s3, $a1
	
	array_loop: 
	
	move $s5, $a1 
	li $t1, 0	
	lw $t3, 0($s4) 
	addi $s4, $s4, 4 
	beq $s2, $zero, store_new_element

	temp_array_loop:
	
	lw $t2, 0($s5) 			
	beq $t2, $t3, skip_to_next_array_element	
	addi $t1, $t1, 1 
	beq $t1, $s2, store_new_element 
	addi $s5, $s5, 4 
	j temp_array_loop
		
	skip_to_next_array_element:
	addi $t0, $t0, -1 
	bne $t0, $zero, array_loop
	move $v0, $s2
	jr $ra
	    
	store_new_element:
	sw $t3, 0($s3) 
	addi $s2, $s2, 1
	addi $s3, $s3, 4
	j skip_to_next_array_element
###############################################
# Everything in between should be deleted
############################################### 

	
SumofElements:
###############################################
#   Your code goes here
###############################################
	li $v0, 0
	move $s0, $a0

	label_2_1:
	move $s1, $a3
	lw $t0, 0($s0)
	addi $s0, $s0, 4
	move $s2, $a2

	label_2_2:
	lw $t1, 0($s2)
	addi $s2, $s2, 4
	beq $t1, $t0, increment_sum
	addi $s1, $s1, -1
	bne $s1, $zero, label_2_2
	

	check_label_2_1:
	addi $a1, $a1, -1
	bne $a1, $zero, label_2_1
	jr $ra
	
	increment_sum:
	add $v0, $v0, $t1
	j check_label_2_1	      
      
###############################################
# Everything in between should be deleted
###############################################





