#include "uart.h"

extern unsigned long __image_start__;
extern unsigned long __image_end__;

int main(void) {
    uart_puts("\n[hello] Pine64-LTS bare-metal hello via U-Boot+YMODEM\n");
    uart_puts("[hello] image range: ");
    extern unsigned long __image_start__;
    extern unsigned long __image_end__;
    uart_hex64((unsigned long)&__image_start__); uart_puts(" .. ");
    uart_hex64((unsigned long)&__image_end__);   uart_puts("\n");

    uart_puts("[hello] printing 3 lines as proof of life:\n");
    for (int i = 1; i <= 3; ++i) {
        uart_puts("  line "); uart_putc('0' + i); uart_puts("\n");
    }
    uart_puts("[hello] done. spinning.\n");
    for(;;) { __asm__ volatile("wfe"); }
    return 0;
}
