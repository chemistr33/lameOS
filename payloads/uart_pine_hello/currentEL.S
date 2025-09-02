
.text
.globl get_current_el
get_current_el:
    mrs     x0, CurrentEL   // x0 might equal 0x0, 0x4, 0x8, 0xC
    lsr     x0, x0, #2      // After shifting right by 2, x0 = 0, 1, 2, 3 
    ret                     // which corresponds to EL0, EL1, EL2, EL3