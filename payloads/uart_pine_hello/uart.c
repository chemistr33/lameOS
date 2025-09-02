#include "uart.h"

// Print a 64-bit value in fixed 16-digit hex format (0xXXXXXXXX...).
// Shifts 4 bits at a time from MSB→LSB and maps each nibble to ASCII.
void uart_hex64(unsigned long x) {
    static const char *H = "0123456789ABCDEF";
    uart_puts("0x");
    for (int i = 60; i >= 0; i -= 4) {
        uart_putc(H[(x >> i) & 0xF]);
    }
}
