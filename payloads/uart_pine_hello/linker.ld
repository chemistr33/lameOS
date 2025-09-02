/* The Entry Linker Script Command */
ENTRY(___lameos___)

/* Linker Symbol for top of stack, linker symbols are constant addressesr.*/
___STACKTOP___ = 0x44000000;

/* Declare segments with permissions. PHDRS= Permissions Headers Segments */
PHDRS
{
  text PT_LOAD FLAGS(0x5); /* RX segment: code + rodata */
  data PT_LOAD FLAGS(0x6); /* RW segment: data + bss    */
}

SECTIONS
{
  . = 0x42000000;                     /*The Pine64-LTS-V2 board has 2GB of RAM*/
  ___image_start___ = .;
  .text :
  {
    *(.text*)
    *(.rodata*)
  } :text                             /* <— attach to RX PHDR */

  .data : ALIGN(16)
  {
    __data_start = .;
    . = ALIGN(16);
    *(.data*)
    . = ALIGN(16);
    __data_end = .;
  } :data                             /* <— attach to RW PHDR */

  .bss (NOLOAD) : ALIGN(16)
    {
    __bss_start = .;
    . = ALIGN(16);
    *(.bss*)
    *(COMMON)
    . = ALIGN(16);
    __bss_end = .;
    } :data                           /* <— attach to RW PHDR */

    . = ALIGN(16);
    ___image_end___ = .;
    ___image_size___ = ___image_end___ - ___image_start___;

}

/*
  Technically, the SECTIONS command is the only thing a linker script needs,
  to work.

  Note the `.` character, that is the location counter in linker language.

  The C runtime specs demand that .bss (better save space) be filled with zeros
  for global/static uninitialized variables. There's a symbol for the
  __bss_start & __data_end for that purpose (to make it easier to bolt on a crt0
  runtime later). The same start/end bounds-linker symbols exist for the .data
  section as well.
*/