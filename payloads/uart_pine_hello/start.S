// start.S - AArch64, flat image @ 0x4200_0000 (Offset +1GB)

.section .text
.align 4
.global ___lameos___
.type   ___lameos___, %function

// Externs from Linker Symbols
.extern __bss_start
.extern __bss_end
.extern ___STACKTOP___

// Externs from C Runtime
.extern main


// ########################### LameOS #########################################


___lameos___:
    // Halt Interrupts
    msr     daifset, #0xf

    // Stack Pointer Setup (Uses Linker Symbol (constant addr))
    ldr     x0, =___STACKTOP___
    mov     sp, x0

    // Zero-Out the .bss, 16B per fell swoop
    ldr     x1, =__bss_start
    ldr     x2, =__bss_end
    mov     x3, xzr

1:
    cmp     x1, x2
    b.hs    2f
    stp     x3, x3, [x1], #16
    b       1b

2:
    // Jump to C
    bl      main

// If C returns, Hang
3:
    wfe
    b       3b


