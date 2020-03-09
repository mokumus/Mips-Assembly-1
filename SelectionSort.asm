.data
	usage: .asciiz "===SELECTION SORT USAGE===\nMax list size is 32, only positive integers.\nEnter '-1' to conclude list\n"
	promt1: .asciiz "Enter list item: "
	newline: .asciiz "\n"
	coma: .asciiz ", "
	arr: .word  -1:32
	
.text
	main: 
		jal print_usage
		
		addi $t0, $zero, 0 #Index(Offset) = $t0, to be increment by 4
		addi $t1, $zero, 0 #counter for number of elements entered
		
		jal input_list_loop
		
		P1:
			jal selection_sort
		
		exit:
			jal print_newline
			li $v0, 10	
			syscall	
	
	
	input_list_loop:
		beq $v0, -1, P1	#Exit on -1
		beq $t1, 32, P1	#Exit on max list size is reached
		
		#Promt the user to enter list item
		jal print_promt1
		li $v0, 5
		syscall
		
		#Store result in arr(offset)
		sw $v0, arr($t0)
		
		addi $t0, $t0, 4 #Increment offset
		addi $t1, $t1, 1 #Increment number of elements entered
		
		j input_list_loop
		
		
### Selection sort procedure###
	selection_sort:
  		la $s0, arr        
  		addi $s0, $s0, 128   # $s0 = tail
  		la $s1, arr          # $s1 = head

  		selection_sort_loop:
    		beq $s1, $s0, print_arr		#End if head == tail
    
    		la $s2, arr             # $s2 = address of first el (for inner loop)

    		find_current_min_loop:
      			
      			beq $s2, $s0, selection_sort_loop_end #Break if head == tail


      			lw $t0, 0($s1)          # $t0 = left element
      			beq $t0, -1, print_arr
      			lw $t1, 0($s2)          # $t1 = rigtht element

      			bgt $t0, $t1, find_current_min_loop_end # Break if $t0 > $t1

      			# Else > swap
      			move $a0, $s1
      			move $a1, $s2
      			jal swap

    		find_current_min_loop_end:
      			addi $s2, $s2, 4   
      			j find_current_min_loop

  			selection_sort_loop_end:
    			addi $s1, $s1, 4    
    			j selection_sort_loop
		
		
###Swap procedure###

	#swap($a0 = *a, $a1 =*b)
	swap:
  		lw $t0, 0($a0)	#$t0 = address of a
  		lw $t1, 0($a1)	#$t1 = address of b
  		
  		sw $t0, 0($a1)
  		sw $t1, 0($a0)
  		
 	 	jr $ra	
		
###Printing procedures###
	print_usage:
		li $v0, 4
		la $a0, usage
		syscall
		jr $ra

	print_promt1:
		li $v0, 4
		la $a0, promt1
		syscall
		jr $ra
	
	print_newline:
		li $v0, 4
		la $a0, newline
		syscall
		jr $ra
		
	print_arr:
  		la $t0, arr			#$t0 = head
  		la $t1, arr
  		addi $t1, $t1, 128  #$t1 = tail
 
 		print_loop:
   			beq $t1, $t0, exit
    		lw $a0, 0($t0)
			beq $a0, -1, exit
			
    		li $v0, 1
    		syscall                 

    		li $v0, 4    
    		la $a0, coma
  		 	syscall       

    		addi $t0, $t0, 4
    		j print_loop


		
