
.data
	endl: .asciiz "\n"
	error: .asciiz "Division by zero! Program terminates "
	enterB: .asciiz "Please enter B: "
	enterC: .asciiz "Please enter C: "
	enterD: .asciiz "Please enter D: "
	opComplete: .asciiz "Operation is complete with result: "

.text

main:
	li $v0,4
	la $a0,enterB
	syscall
	
	li $v0,5
	syscall
	add $t0,$zero,$v0 # B
	
	li $v0,4
	la $a0,enterC
	syscall
	
	li $v0,5
	syscall
	add $t1,$zero,$v0 # C
	
	li $v0,4
	la $a0,enterD
	syscall
	
	li $v0,5
	syscall
	add $t2,$zero,$v0 # D
	
	li $v0,4
	la $a0,endl
	syscall
	
	move $a0,$t0
	move $a1,$t1
	jal divide
	
	add $t3,$v0,$zero
	
	move $a0,$t2
	move $a1,$t0
	jal divide
	
	add $t3,$v1,$t3 #mod operation added
	sub $t3,$t3,$t1
	
	move $a0,$t3
	move $a1,$t0
	jal divide
	
	add $t3,$v0,$zero
	
	#completed
	
	li $v0,4
	la $a0,opComplete
	syscall
	
	li $v0,1
	move $a0,$t3
	syscall
	
	li $v0,4
	la $a0,endl
	syscall
	
	j finish

divide:
	add $s1,$a0,$zero # dividend
	add $s2,$a1,$zero # divisor
	beqz $s2, divZero
	add $s3,$zero,$zero # quotient
	add $s4,$zero,$zero # remainder
	j loop

loop:
       	blt $s1, $s2, done
        sub $s1, $s1, $s2   # Subtract divisor from dividend
        addi $s3, $s3, 1    # Increment quotient

        j loop

done:
    	move $v0,$s3 #quotient
    	move $v1,$s1 #remainder
    	jr $ra

divZero:
    	li $v0, 4
   	la $a0, error
  	syscall
  	li $v0, 4
    	la $a0, endl
    	syscall
    
    	j finish
finish:
	li $v0,10
	syscall
	
	
	