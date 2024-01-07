.data
array1: .space 12
array2: .space 12
array3:   .space  24
newline:.asciiz "\n"
.text

addi $s0,$zero,3
addi $s1,$zero,4
addi $s2,$zero,5

addi $s3,$zero,0
addi $s4,$zero,1
addi $s5,$zero,2

#index
addi $t0,$zero,0

sw $s0,array1($t0)
addi $t0,$t0,4

sw $s1, array1($t0)
addi $t0,$t0,4
sw $s2, array1($t0)



addi $t0,$zero,0

sw $s3,array2($t0)
addi $t0,$t0,4

sw $s4, array2($t0)
addi $t0,$t0,4

sw $s5, array2($t0)

addi $t0,$zero,0
addi $t1,$zero,0
addi $t2,$zero,0


j distributedSort


distributedSort:

blt $t2,12,findMInArr
addi $t0,$zero,0
addi $t1,$zero,0

j mergeAll





mergeAll:

ble $t0,12, addIn1

ble $t1,12, addIn2

addi $t0,$zero,0
addi $t1,$zero,0
addi $t2,$zero,0

j while





addIn1:

lw $t7,array1($t0)
addi $t0,$t0,4

bne $t7,0,addToArray



addIn2:

lw $t7,array2($t1)
addi $t1,$t1,4

bne $t7,0,addToArray






addToArray:

sw $t7,array3($t2)
addi $t2,$t2,4

j mergeAll


findMInArr:


lw $t3,array1($t0)
lw $t4,array2($t1)

blt $t3,$t4, merge
sw $t4,array3($t2)
li $t5,0
sw $t5,array2($t1)
addi $t1,$t1,4
addi $t2,$t2,4

j distributedSort



merge:


sw $t3,array3($t2)
li $t5,0
sw $t5,array1($t0)
addi $t0,$t0,4
addi $t2,$t2,4

j distributedSort



while:
 beq $t2,24,exit
  lw $t6,array3($t2)
 
 addi $t2,$t2,4
 
 li $v0,1
 move $a0,$t6
 syscall
 
 li $v0,4
 la $a0,newline
 syscall
 j while
exit:
li $v0,10
syscall