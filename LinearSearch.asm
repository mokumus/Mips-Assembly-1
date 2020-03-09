.data
	usage: .asciiz "===LINEAR SEARCH USAGE===\nMax list size is 32, only positive integers.\nEnter '-1' to conclude list\n"
	promt1: .asciiz "Enter list item: "
	promt2: .asciiz "Enter target number: "
	promt3: .asciiz "Target found in the list! Index: "
	promt4: .asciiz "Target not found :("
	newline: .asciiz "\n"
	coma: .asciiz ", "
	arr: .word  -1:32
	
.text
	main: 
		jal print_usage
		
		addi $t0, $zero, 0 #Index(Offset) = $t0, to be increment by 4
		addi $t1, $zero, 0 #counter for number of elements entered
	
	input_list_loop:
		beq $v0, -1, input_target	#Exit on -1
		beq $t1, 32,  input_target	#Exit on max list size is reached
		
		#Promt the user to enter list item
		jal print_promt1
		li $v0, 5
		syscall
		
		#Store result in arr(offset)
		sw $v0, arr($t0)
		
		addi $t0, $t0, 4 #Increment offset
		addi $t1, $t1, 1 #Increment number of elements entered
		
		j input_list_loop
	
	input_target:
		#Promt the user to enter list item
		jal print_promt2
		li $v0, 5
		syscall
		
		#Store result in $s7
		move $s7, $v0
		
		#Prepare for search
		la $a1, arr
		move $a2, $s7
		jal search_array
		
		j exit
		
	#search_array($a1 = array adress, $a2 = key) $v1 = 1 if found, zero if not found
	search_array:
		addi $t8, $a1, 0  	#Start of the array
		addi $t9, $a1, 256 	#End of the array 32*4(sizeof int)
		addi $t6, $zero, 0  #Loop counter
		addi $t5, $zero, -1
		
		search_loop:
			lw $t7, 0($t8)	#$t7 = current element
			beq $t8, $t9, not_found
			beq $t7, $t5, not_found
			beq $t7, $a2, found
			addi $t8, $t8, 4 #increment counter
			
			
			addi $t6, $t6, 1
			j search_loop
			not_found:
				jal print_promt4
				j exit
				
			found:
				jal print_promt3
				li $v0, 1
				move $a0, $t6
				syscall
				j exit
		
	exit:
		jal print_newline
		li $v0, 10	
		syscall	
	
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
		
	print_promt2:
		li $v0, 4
		la $a0, promt2
		syscall
		jr $ra
		
	print_promt3:
		li $v0, 4
		la $a0, promt3
		syscall
		jr $ra
	
	print_promt4:
		li $v0, 4
		la $a0, promt4
		syscall
		jr $ra	
		
	print_newline:
		li $v0, 4
		la $a0, newline
		syscall
		jr $ra
		
	print_coma:
		li $v0, 4
		la $a0, coma
		syscall
		jr $ra
