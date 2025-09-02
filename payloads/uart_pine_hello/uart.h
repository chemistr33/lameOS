// `pragma once` is a kind of header guard
#pragma once
#include <stdint.h>

/*
 * #############################################################################
 * ###                          Magic Number Macros                          ###
 * #############################################################################
 */

/*
 * Physical MMIO base address for UART0 on the Allwinner A64.
 * Think: "where the UART block lives in the SoC memory map."
 * Every UART register access is this BASE + a small byte OFFSET.
 * (On A64, UART0 is at 0x01C28000; UART1/2/3 follow at +0x400 steps.)
 */
#define UART0_BASE   0x01C28000UL

/*
 * Offset for the TX/RX data register (16550 register index 0).
 * - WRITE at BASE + 0x00 -> THR (Transmit Holding Register): send one byte.
 * - READ  at BASE + 0x00 -> RBR (Receiver Buffer Register): get one byte.
 * Mental model: same slot, different meaning based on read vs write.
 * Note: A64 maps classic 8-bit 16550 registers 32-bit apart, so index 0 => 0x00
 */
#define UART_RBR_THR (0x00)

/*
 * Offset for the Line Status Register (LSR) — transmit/receive status bits.
 * You poll this to know if you can write the next byte, or if data arrived.
 * 16550 index for LSR is 5; with 32-bit spacing, 5 * 4 = 0x14.
 */
#define UART_LSR     (0x14)

/*
 * Bit mask for LSR[5] = THRE (Transmit Holding Register Empty).
 * When (LSR & THRE) != 0, the THR can accept the next byte.
 * Mental model: "gate open" for uart_putc(); write then repeat.
 * (If you need "completely finished," also check LSR[6] = TEMT.)
 */
#define LSR_THRE     (1u << 5)

/*
 * #############################################################################
 * ###                    Forward Function Declarations                      ###
 * #############################################################################
 */

// Pass in a 4-Byte integer address and a 4-Byte integer value,
// Treat `addr` as the "address of a 32-bit volatile UART register".
// Store the given 32-bit value into that address.
static inline void mmio_write32(uintptr_t addr, uint32_t val) {
    *(volatile uint32_t *)addr = val;
}

// mmio_read32 takes an integer address big enough to hold any pointer, casts it 
// into a pointer to a volatile 32-bit register, dereferences it to fetch the 
// 32-bit value stored there, and returns that value.
static inline uint32_t mmio_read32(uintptr_t addr) {
    return *(volatile uint32_t *)addr;
}

// uart_hex64 takes a 64-bit unsigned integer and prints it in hexadecimal. It 
// first prints the "0x" prefix, then loops over each 4-bit nibble from most 
// significant to least significant, looks up the corresponding hex character, 
// and prints it one at a time with uart_putc.
void uart_hex64(unsigned long x);

// U-Boot already initialized UART0 for its console.
// We only poll LSR and push bytes to THR.
// Wait until TX holding register is empty (LSR[5]=THRE), 
// then write one byte (low 8 bits of c) into THR at offset 0.
static inline void uart_putc(char c) {
    // Wait for THR empty
    while ((mmio_read32(UART0_BASE + UART_LSR) & LSR_THRE) == 0) {}
    mmio_write32(UART0_BASE + UART_RBR_THR, (uint32_t)(uint8_t)c);
}

// uart_puts() takes a pointer to a constant C string, walks through it until 
// the '\0' terminator, and for each character, if it’s a newline it first 
// prints a carriage return, then it prints the character through uart_putc().
static inline void uart_puts(char const *s) {
    for (; *s; ++s) {
        if (*s == '\n')
            { uart_putc('\r'); } 
        uart_putc(*s);
    }
}
