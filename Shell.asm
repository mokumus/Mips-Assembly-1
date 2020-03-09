.data
	command: .space 100
	arrow: .asciiz "MuhammedOS>"
.text
	main:
	
		li $v0, 4
		la $a0, arrow
		syscall	
	
	
		# read command
		li $v0, 8
		la $a0, command
		li $a1, 100
		syscall
	

	
		li $v0, 18
		la $a0, command
		syscall
		
		j main
	
	
	li $v0 10
	syscall