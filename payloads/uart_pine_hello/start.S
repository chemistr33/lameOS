// start.S - AArch64, flat image @ 0x4200_0000 (Offset +1GB)

.section .text
.align 4
.global ___lameos___
.type   ___lameos___, %function

// Externs provided by linker
.extern __bss_start
.extern __bss_end
.extern ___STACKTOP___

// Externs provided by C Runtime
.extern main


// ########################### LameOS #########################################


___lameos___:
    // Halt Interrupts
    msr     daifset, #0xf

    // Set Execution Privilege Level to EL1
    msr     spsel, #1

    // Stack Pointer Setup (Uses Linker Symbol (constant addr))
    ldr     x0, =___STACKTOP___
    mov     sp, x0
    
    // (Optional) establish a frame pointer for C backtraces
    mov     x29, xzr

    // Zero-Out the .bss, 16B per fell swoop
    ldr     x1, =__bss_start
    ldr     x2, =__bss_end
    mov     x3, xzr
    
/**
 * compare (x1-x2), set flags accordingly
 * if x1 >= x2, branch to next label, 'run_main'
 */
zero_bss:
    cmp     x1, x2
    b.hs    run_main
    /* Store X3 to [X1], Store X3 to [X1+8], increment X1 by 16B */
    stp     x3, x3, [x1], #16
    b       zero_bss

run_main:
    // Jump to C "Runtime"
    bl      main

// If C returns, Hang
hang_forever:
    wfe
    b       hang_forever       
