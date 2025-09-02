# N.B. this is a gnu make Makefile, IE use `gmake`.

CROSS   ?= aarch64-none-elf-
CC      := $(CROSS)gcc
OBJCOPY := $(CROSS)objcopy

CFLAGS  := 	-mcpu=cortex-a53 -ffreestanding -nostdlib -nostartfiles \
			-fno-builtin -O2 -Wall -Wextra -MMD -MP

# Link with gcc as the driver so it pulls in libgcc bits if needed later.
LDFLAGS := -Wl,-T,linker.ld -nostdlib -nostartfiles -Wl,-Map=lameOS_UART.map

OBJS = start.o uart.o main.o currentEL.o

all: lameOS_UART.elf lameOS_UART.bin

lameOS_UART.elf: $(OBJS) linker.ld
	$(CC) $(CFLAGS) $(LDFLAGS) -o $@ $(OBJS)

lameOS_UART.bin: lameOS_UART.elf
	$(OBJCOPY) -O binary $< $@

# one rule for C...
%.o: %.c
	$(CC) $(CFLAGS) -c $< -o $@

# one for assembly...
%.o: %.S
	$(CC) $(CFLAGS) -c $< -o $@

# automatic dependencies are created
-include $(OBJS:.o=.d)

clean:
	rm -f $(OBJS) $(OBJS:.o=.d) lameOS_UART.elf lameOS_UART.bin lameOS_UART.map

.PHONY: all clean

.DELETE_ON_ERROR:
