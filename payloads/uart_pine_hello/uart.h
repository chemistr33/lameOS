#pragma once
#include <stdint.h>

#define UART0_BASE   0x01C28000UL  // Allwinner A64 UART0 (16550-like)
#define UART_RBR_THR (0x00)
#define UART_LSR     (0x14)

#define LSR_THRE     (1u << 5)     // Transmitter Holding Register Empty

static inline void mmio_write32(uintptr_t addr, uint32_t val) {
    *(volatile uint32_t *)addr = val;
}

static inline uint32_t mmio_read32(uintptr_t addr) {
    return *(volatile uint32_t *)addr;
}

void uart_hex64(unsigned long x);

// U-Boot already initialized UART0 for its console.
// We only poll LSR and push bytes to THR.
static inline void uart_putc(char c) {
    // Wait for THR empty
    while ((mmio_read32(UART0_BASE + UART_LSR) & LSR_THRE) == 0) { }
    mmio_write32(UART0_BASE + UART_RBR_THR, (uint32_t)(uint8_t)c);
}

static inline void uart_puts(const char *s) {
    for (; *s; ++s) {
        if (*s == '\n') uart_putc('\r');
        uart_putc(*s);
    }
}
