# -------- Toolchain --------
# Set in environment or .env: CROSS_COMPILE=aarch64-none-elf-
# Example: export CROSS_COMPILE=/opt/xcc/bin/aarch64-none-elf-
-include .env
CROSS_COMPILE ?= aarch64-none-elf-

CC      := $(CROSS_COMPILE)gcc
CXX     := $(CROSS_COMPILE)g++
AS      := $(CROSS_COMPILE)gcc
AR      := $(CROSS_COMPILE)ar
LD      := $(CROSS_COMPILE)ld
OBJCOPY := $(CROSS_COMPILE)objcopy
OBJDUMP := $(CROSS_COMPILE)objdump
SIZE    := $(CROSS_COMPILE)size

# -------- Project / Board --------
BOARD   ?= pine64-lts
OUTDIR  ?= build/$(BOARD)
KDIR    := kernel
LD_SCRIPT ?= $(KDIR)/arch/aarch64/link.ld  # adjust if you keep it elsewhere

# Optional board overrides:
# You can define e.g. DRAM_BASE, UART base, extra objs/libs here.
# File: boards/$(BOARD)/board.mk
-include boards/$(BOARD)/board.mk

# -------- Flags --------
ARCH    := -mcpu=cortex-a53 -ffreestanding -fno-builtin -nostdlib -nostartfiles
WARN    := -Wall -Wextra -Wundef -Werror=implicit-function-declaration
OPT     := -O2
# FreeBSD uses clang by default, but we’re using cross-GCC above; keep it strict:
CSTD    := -std=c11

CFLAGS  := $(ARCH) $(OPT) $(WARN) $(CSTD) -fno-stack-protector -fno-asynchronous-unwind-tables -fdata-sections -ffunction-sections
CFLAGS  += -I$(KDIR)/include -Ikernel -Ilibs -Iexternal
ASFLAGS := $(ARCH) -x assembler-with-cpp -I$(KDIR)/include
LDFLAGS := -T $(LD_SCRIPT) -nostdlib -static -Wl,--gc-sections -Wl,-Map,$(OUTDIR)/kernel.map

# -------- Sources --------
# Collect kernel and libs sources (C and ASM). Add more paths as your tree grows.
SRC_C := $(shell find $(KDIR) libs external -type f -name '*.c' 2>/dev/null)
SRC_S := $(shell find $(KDIR) libs external -type f \( -name '*.S' -o -name '*.s' \) 2>/dev/null)

# Example top-level scratch file (optional):
HELLO   := hello.c

# Object lists
OBJ_C   := $(patsubst %.c,$(OUTDIR)/%.o,$(SRC_C))
OBJ_S   := $(patsubst %.S,$(OUTDIR)/%.o,$(patsubst %.s,$(OUTDIR)/%.o,$(SRC_S)))
OBJS    := $(OBJ_S) $(OBJ_C)

# -------- Default Target --------
.PHONY: all
all: dirs $(OUTDIR)/kernel.elf $(OUTDIR)/kernel.bin $(OUTDIR)/kernel.lst size

# -------- Rules --------
.PHONY: dirs
dirs:
	@mkdir -p $(OUTDIR)
	@mkdir -p $(sort $(dir $(OBJS)))

# Pattern rules for objects
$(OUTDIR)/%.o: %.c
	@echo "  CC  $<"
	@$(CC) $(CFLAGS) -c $< -o $@

$(OUTDIR)/%.o: %.S
	@echo "  AS  $<"
	@$(AS) $(ASFLAGS) -c $< -o $@

$(OUTDIR)/%.o: %.s
	@echo "  AS  $<"
	@$(AS) $(ASFLAGS) -c $< -o $@

# Link kernel
$(OUTDIR)/kernel.elf: $(OBJS) $(LD_SCRIPT)
	@echo "  LD  $@"
	@$(CC) $(ARCH) $(OBJS) $(LDFLAGS) -o $@

# Binary + listing
$(OUTDIR)/kernel.bin: $(OUTDIR)/kernel.elf
	@echo "  OBJCOPY  $@"
	@$(OBJCOPY) -O binary $< $@

$(OUTDIR)/kernel.lst: $(OUTDIR)/kernel.elf
	@echo "  OBJDUMP  $@"
	@$(OBJDUMP) -d -S $< > $@

.PHONY: size
size: $(OUTDIR)/kernel.elf
	@$(SIZE) $<

# -------- Hello scratch (optional) --------
# Quick sanity check while bootstrapping the toolchain.
.PHONY: hello
hello: dirs $(OUTDIR)/hello.elf $(OUTDIR)/hello.lst

$(OUTDIR)/hello.o: $(HELLO)
	@echo "  CC  $<"
	@$(CC) $(CFLAGS) -c $< -o $@

$(OUTDIR)/hello.elf: $(OUTDIR)/hello.o
	@echo "  LD  $@"
	@$(CC) $(ARCH) -nostdlib -Wl,-emain -Wl,-e,_start -Wl,--gc-sections $< -o $@

$(OUTDIR)/hello.lst: $(OUTDIR)/hello.elf
	@echo "  OBJDUMP  $@"
	@$(OBJDUMP) -d -S $< > $@

# -------- Util --------
.PHONY: clean distclean print-vars
clean:
	@echo "  CLEAN"
	@rm -rf $(OUTDIR)/*.elf $(OUTDIR)/*.bin $(OUTDIR)/*.map $(OUTDIR)/*.lst $(OBJS)

distclean:
	@echo "  DISTCLEAN"
	@rm -rf build

print-vars:
	@echo "CROSS_COMPILE=$(CROSS_COMPILE)"
	@echo "BOARD=$(BOARD)"
	@echo "OUTDIR=$(OUTDIR)"
	@echo "LD_SCRIPT=$(LD_SCRIPT)"


