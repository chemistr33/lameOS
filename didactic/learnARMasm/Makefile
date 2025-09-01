# Makefile — tiniest useful AArch64 build
# Usage: gmake [asm|obj|dis|all|clean]
# If your tool prefix differs: gmake CROSS=aarch64-none-elf

CROSS   ?= aarch64-none-elf
CC      := $(CROSS)-gcc          # force cross-compiler (ignore env CC)
OBJDUMP := $(CROSS)-objdump

CPU     ?= cortex-a53
SRC     ?= foo.c
OBJ     := $(SRC:.c=.o)
ASM     := $(SRC:.c=.s)
DUMP    := $(SRC:.c=.objdump)

# -O0 + frame pointer = very didactic assembly
CFLAGS  := -O0 -g -fno-omit-frame-pointer -ffreestanding -nostdlib \
           -mcpu=$(CPU) -Wall -Wextra -fverbose-asm

.PHONY: all asm obj dis clean
all: asm obj dis

asm: $(ASM)
$(ASM): $(SRC)
	$(CC) $(CFLAGS) -S $< -o $@

obj: $(OBJ)
$(OBJ): $(SRC)
	$(CC) $(CFLAGS) -c $< -o $@

dis: $(DUMP)
$(DUMP): $(OBJ)
	$(OBJDUMP) -drwC $< > $@

clean:
	rm -f $(ASM) $(OBJ) $(DUMP)