.data
nums1:
    .word 1
    .word 0
    .word 0
    .word 2
    .word 5
    
nums2:
    .word 1
    .word 9
    .word 0
    .word 6
    .word 7

nums3:
    .word 0
    .word 0
    .word 0
    .word 0
    .word 4

.text
main:
    la s0 nums1                 # load nums base address to s0
    addi s1 x0 5               #nums_size = 5
    
    #call function moveZeroes
    add a0 s0 x0            # a0 which stands for address of nums array is the first argument
    add a1 s1 x0            # a1 which stands for array size of nums is the second argument
    jal ra moveZeroes        #jump to moveZeroes function
    
    #PrintArray
    jal ra printArray
    li a7 10
    ecall
    
moveZeroes:
    addi sp sp -12
    sw ra 0(sp)
    sw s0 4(sp)
    sw s1 8(sp)
    #li s1 0                    #next non zero index = 0
    addi s2 x0 0                 # next = 0
    addi s3 x0 0                 # pre = 0
    loop:
        bge s2 a1 exit           #next >= numsize exit
        slli t0 s2 2             #next * 4
        add t0 a0 t0             #nums + next*4
        lw t1 0(t0)              #t1 = nums[next]
        beq t1 x0 next_iter
        #slli t2 s1 2             #next_nonzero_index * 4
        addi t2 t1 0             #temp = nums[next]
        
        slli t3 s3 2             #pre * 4
        add t3 a0 t3             #nums + pre*4
        lw t4 0(t3)              #t4 = nums[pre]
        addi t1 t4 0             #nums[next] = nums[pre]
        sw t1 0(t0)
        addi t4 t2 0             #nums[pre] = temp
        sw t4 0(t3)
        addi s3 s3 1             #pre++
    next_iter:
        addi s2 s2 1             #next++
        j loop
 exit:
    lw ra 0(sp)
    lw s0 4(sp)
    lw s1 8(sp)
    addi sp sp 12
    jr ra
 
printArray:
    li a7 1
    addi sp sp -8
    sw ra 0(sp)
    sw s0 4(sp)
    add s0 a0 x0 # s0 = pointer to array
    add t0 x0 x0 # t0 = i in for loop
    printloop:
        bge t0 a1 finish_print_loop
        slli t1 t0 2 # t1 = i * 4
        add t1 t1 s0 # t1 = t1 + array address
        lw a0 0(t1) # a0 = element in nums[i]
        li a7 1
        ecall
        addi t0 t0 1
        j printloop
    finish_print_loop:
        lw ra 0(sp)
        lw s0 4(sp)
        addi sp sp 8
        jr ra
