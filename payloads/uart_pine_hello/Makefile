CROSS   ?= aarch64-none-elf-
CC      := $(CROSS)gcc
OBJCOPY := $(CROSS)objcopy

CFLAGS  := -mcpu=cortex-a53 -ffreestanding -nostdlib -nostartfiles -fno-builtin \
           -O2 -Wall -Wextra
# Link with gcc as the driver so it pulls in libgcc bits if needed later.
LDFLAGS := -Wl,-T,linker.ld -nostdlib -nostartfiles -Wl,-Map=hello.map

OBJS = start.o uart.o main.o

all: hello.elf hello.bin

hello.elf: $(OBJS) linker.ld
	$(CC) $(CFLAGS) $(LDFLAGS) -o $@ $(OBJS)

hello.bin: hello.elf
	$(OBJCOPY) -O binary $< $@

# one rule for C, one for assembly
%.o: %.c
	$(CC) $(CFLAGS) -c $< -o $@

%.o: %.S
	$(CC) $(CFLAGS) -c $< -o $@

clean:
	rm -f $(OBJS) hello.elf hello.bin hello.map

.PHONY: all clean
