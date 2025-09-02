#!/usr/bin/env bash
# lameos-sanity.sh — minimal AArch64 elf sanity check
# Usage: ./lameos-sanity.sh foo.elf

ELF="$1"
TPREF=${TOOLPREFIX:-aarch64-none-elf-}

if [ -z "$ELF" ] || [ ! -f "$ELF" ]; then
  echo "Usage: $0 payload.elf"
  exit 1
fi

${TPREF}readelf -h "$ELF"       # ELF header (check it's ELF64, little endian, AArch64)
${TPREF}readelf -lW "$ELF"       # Program headers (see VirtAddr/PhysAddr, LOAD segments)
${TPREF}nm -n "$ELF" | head -n 20   # Top 20 symbols sorted by address
${TPREF}size "$ELF"             # Section sizes
${TPREF}objdump -d -lW "$ELF" | head -n 40  # First 40 lines of disassembly
