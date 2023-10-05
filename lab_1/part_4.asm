
.data 
	inputRequest: .asciiz "How many elements will you be uploading to the array? "
	inputMenu: .asciiz "Menu: 1) Find the maximum 2) Find the frequency of the maximum 3) Find the number of elements than can divide the maximum without a remainder (excluding the number itself 4) exit\n"
	maxMes:.asciiz "The maximum number is: "
	maxFreqMes: .asciiz "Maximum's Frequency: "
	dividing: .asciiz "Number of elements that divides without a remainder: "
	endl: .asciiz "\n"

.align 2
array: .space 100
arraySize: .word 0
max: .word 0


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
	
	menu:
	li $v0,4
	la $a0,inputMenu
	syscall
	
	li $v0,5
	syscall 
	add $t2,$v0,$zero #t2 = desired operation
	
	#Branch for the operations
	beq $t2,1,findMax
	beq $t2,2,findMaxFreq
	beq $t2,3,findDivisibles
	beq $t2,4,end
	j menu
	
	findMax:
	lw $s0,max # holds the maximum
	la $s1,array # index
	lw $s2,arraySize
	lw $s3,array #holds max dynamically
	addi $s4,$zero,0 #counter
	j loopMax
	loopMax:
	beq $s2,$s4,printMax
	lw $s5,($s1)
	bgt $s5,$s3,assignMax
	addi $s4,$s4,1 #increment
	addi $s1,$s1,4 #next word
	j loopMax
	assignMax:
	add $s3,$zero,$s5
	addi $s4,$s4,1 #increment
	addi $s1,$s1,4 #next word
	j loopMax
	printMax:
	sw $s3,max
	
	li $v0,4
	la $a0,maxMes
	syscall 
	
	li $v0,1
	lw $a0,max
	syscall
	
	li $v0,4
	la $a0,endl
	syscall
	j menu
	
	findMaxFreq:
	lw $s0,max # holds the maximum
	la $s1,array # index
	lw $s2,arraySize
	add $s3,$zero,$zero # number of occurance
	addi $s4,$zero,0 #counter
	j countFreq
	
	countFreq:
	beq $s2,$s4,endFreq
	lw $s5,($s1)
	beq $s5,$s0,incrementFreq
	addi $s4,$s4,1 #increment
	addi $s1,$s1,4 #next word
	j countFreq
	
	incrementFreq:
	addi $s3,$s3,1
	addi $s4,$s4,1 #increment
	addi $s1,$s1,4 #next word
	j countFreq
	
	endFreq:
	li $v0,4
	la $a0,maxFreqMes
	syscall 
	
	li $v0,1
	move $a0,$s3
	syscall
	
	li $v0,4
	la $a0,endl
	syscall
	j menu
	
	
	loadInputToArray:
	la $s1,array
	addi $s0,$zero,0
	lw $s2,arraySize
	j loopInputLoop
	
	loopInputLoop:
	beq $s0,$s2,menu
	li $v0,5
	syscall 
	
	addi $s0,$s0,1
	sw $v0,($s1)
	addi  $s1,$s1,4
	
	j loopInputLoop
	
	end:
	li $v0,10
	syscall
	
	findDivisibles:
	lw $s0,max # holds the maximum
	la $s1,array # index
	lw $s2,arraySize
	add $s3,$zero,$zero # number of perfect dividers
	addi $s4,$zero,0 #counter
	j countPerDiv
	
	countPerDiv:
	beq $s2,$s4,endDiv
	lw $s5,($s1)
	div $s0,$s5
	
	mflo $s5
	beq $s5,1,passDiv
	mfhi $s5
	beq $s5,$zero,incrementDiv

	addi $s4,$s4,1 #increment
	addi $s1,$s1,4 #next word
	j countPerDiv
	
	incrementDiv:
	addi $s3,$s3,1
	addi $s4,$s4,1 #increment
	addi $s1,$s1,4 #next word
	j countPerDiv
	
	passDiv:
	addi $s4,$s4,1 #increment
	addi $s1,$s1,4 #next word
	j countPerDiv
	
	endDiv:
	li $v0,4
	la $a0,dividing
	syscall
	
	li $v0,1
	move $a0,$s3
	syscall
	
	li $v0,4
	la $a0,endl
	syscall
	j menu

	
	
	
	
	
	
	
	
	
	
