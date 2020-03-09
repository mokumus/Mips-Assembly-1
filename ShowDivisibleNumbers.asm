.data
	usage: .asciiz "===SHOW DIVISIBLE NUMBERS USAGE===\nEnter 3 numbers x,y,z where:\nx<y and x,y,z are larger than 0\n"
	promt: .asciiz "Enter number: "
	newline: .asciiz "\n"
	coma: .asciiz ", "
	arr: .word  -1:3
	
.text
	main: 
		jal print_usage
		
		addi $t0, $zero, 0 
		
		input_loop:
			beq $t0, 12,  process_input
			#Promt the user to enter a number
			jal print_promt
			li $v0, 5
			syscall
			
			#Store result in tempory arr(offset)
			sw $v0, arr($t0)
			
			addi $t0, $t0, 4 #Increment index
			j input_loop
		
		process_input:
			lw $s1, arr
			lw $s2, arr+4
			lw $s3, arr+8
			
			
			print_if_divisible_loop:
				beq $s1, $s2, exit
				addi $s1, $s1, 1
				
				div $s1, $s3
  				mfhi $t1 # reminder to $t1
  				bnez $t1, print_if_divisible_loop
  				
  				li $v0, 1
				la $a0, ($s1)
				syscall
				jal print_coma
				j print_if_divisible_loop

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

	print_promt:
		li $v0, 4
		la $a0, promt
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
