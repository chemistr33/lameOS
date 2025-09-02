#include "uart.h"

extern char ___image_start___;
extern char ___image_end___;
extern uintptr_t ___image_size___;

int main(void) {
    uart_puts("\n");
    uart_puts("#################################################\n");
    uart_puts("##  ~$~       LameOS UART Payload Log     ~$~  ##\n");
    uart_puts("#################################################\n");
    
    
    uart_puts("| payload binary image range |\n|Start Addr: ");
    uart_hex64((unsigned long)(uintptr_t)&___image_start___); 
        uart_puts(" ==>> ");
    uart_hex64((unsigned long)(uintptr_t)&___image_end___);   
        uart_puts(" |\n");
    uart_puts("| Total Payload Size: ");
    uart_hex64((unsigned long)(uintptr_t)___image_size___);
        uart_puts(" |\n");

    uart_puts("9 Lines as proof of life...\n");
    for (int i = 0; i < 10; ++i) {
        uart_puts("Lineno ["); 
        uart_putc('0' + i); 
        uart_puts("]\n");
    }
    uart_puts("\n\nThere ya go!\n");
    
    uart_puts("\n");
    uart_puts("#################################################\n");
    uart_puts("##  ~$~     End LameOS UART Payload Log   ~$~  ##\n");
    uart_puts("#################################################\n");
    
    // in the assembly start.S, when you return from main.c, the "C Runtime",
    // you just fall through to the `hang_forever:` label, spinning wfe forever.
    return 0;
}