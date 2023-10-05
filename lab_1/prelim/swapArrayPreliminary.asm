
.data 
	inputRequest: .asciiz "How many elements will you be uploading to the array? "
	endl: .asciiz "\n"
	swapped: .asciiz "Array after contents are swapped: "
	loadComplete: .asciiz "Loading operation had been successful"

.align 2
array: .space 100
arraySize: .word 0


.text 
	main:
	
	j welcome
	
	welcome:
	li $v0,4
	la $a0,inputRequest
	syscall 
	
	li $v0,5
	syscall 
	
	sw $v0,arraySize
	
	j loadInputToArray
	
	display:
	la $s1,array # index
	lw $s2,arraySize
	addi $s4,$zero,0 #counter
	j print
	
	print:
	beq $s2,$s4,endPrint
	lw $a0,($s1)
	li $v0,1
	syscall 
	li $v0,4
	la, $a0,endl
	syscall
	
	addi $s4,$s4,1 #increment
	addi $s1,$s1,4 #next word
	j print

	endPrint:
	jr $ra
	
	swap:
	la $s1,array # index
	lw $s2,arraySize
	add $s3,$zero,$zero # front
	sll $s4,$s2,2 # back
	addi $s4,$s4,-4
	srl $s7,$s2,1
	
	add $s3,$s1,$s3
	add $s4,$s1,$s4
	
	loopSwap:
	beqz $s7,endSwap
	lw $s5,($s3) #temp var
	lw $s6,($s4)
	sw $s6,($s3)
	sw $s5,($s4)
	
	addi $s3,$s3,4 #increment
	addi $s4,$s4,-4 #increment
	addi $s7,$s7,-1 #decrement
	j loopSwap
	
	endSwap:
	jr $ra
	
	loadInputToArray:
	la $s1,array
	addi $s0,$zero,0
	lw $s2,arraySize
	j loopInputLoop
	
	loopInputLoop:
	beq $s0,$s2,control
	li $v0,5
	syscall 
	
	addi $s0,$s0,1
	sw $v0,($s1)
	addi  $s1,$s1,4
	
	j loopInputLoop
	
	control:
	li $v0,4
	la $a0,loadComplete
	syscall
	
	li $v0,4
	la $a0,endl
	syscall
	
	jal display
	
	jal swap
	
	li $v0,4
	la $a0,swapped
	syscall
	
	li $v0,4
	la $a0,endl
	syscall
	
	jal display

	li $v0,10
	syscall
	

	
	
	
	
	
	
	
	
	
	
