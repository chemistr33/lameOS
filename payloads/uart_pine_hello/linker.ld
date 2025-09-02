/*
The Entry Linker Script Command
*/

ENTRY(___lameos___)

/* 
Linker Symbol for top of stack, linker symbols are constant addressesr.
*/

___STACKTOP___ = 0x44000000;



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

SECTIONS
{
  . = 0x42000000; /* The Pine64-LTS-V2 board has 2GB of RAM */
  ___image_start___ = .;
  .text :
  {
    *(.text*)
    *(.rodata*)
  }

  .data : ALIGN(16) 
  {
    __data_start = .;
    *(.data*)
    . = ALIGN(16);
    __data_end = .;
  }
  
  .bss (NOLOAD) : ALIGN(16)
    {
    __bss_start = .;
    *(.bss*)
    . = ALIGN(16);
    __bss_end = .;
    }
    . = ALIGN(16);
    ___image_end___ = .;
    ___image_size___ = ___image_end___ - ___image_start___;

}