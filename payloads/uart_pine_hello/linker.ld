ENTRY(___lameos___)

___STACKTOP___ = 0x44000000;

SECTIONS
{

  . = 0x42000000;
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

}