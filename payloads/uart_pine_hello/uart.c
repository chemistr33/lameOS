#include "uart.h"

void uart_hex64(unsigned long x) {
    static const char *H = "0123456789ABCDEF";
    uart_puts("0x");
    for (int i = 60; i >= 0; i -= 4) {
        uart_putc(H[(x >> i) & 0xF]);
    }
}
