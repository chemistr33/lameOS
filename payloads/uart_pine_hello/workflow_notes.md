Bare-Metal “Hello, UART” on Pine64-LTS (A64)

This is a minimal bare-metal program that prints text over UART0 on the 
Pine64-LTS, loaded via U-Boot over the serial console. No OS, no libc, no boot 
media required.

-------------------------------------------------------------------------------
Board: Pine64-LTS (rev 2, Allwinner A64 SoC)
Host: FreeBSD 14.3 (any UNIX-like should work with adjustments)
Tools:
    -> AArch64 cross-compiler (aarch64-none-elf-gcc etc.)
    -> lrzsz (provides lsz / lrz for YMODEM transfers)
    -> Serial terminal (picocom or minicom)
    -> Connection: 3-pin UART header (3.3 V),USB-UART dongle /dev/cuaU0 on host

########################
##  Directory Layout  ##
########################

uart_pine_hello 
├── Makefile
├── currentEL.S
├── lameOS_UART.bin
├── lameOS_UART.elf
├── lameOS_UART.map
├── lameos-sanity.output.txt
├── lameos-sanity.sh
├── linker.ld
├── main.c
├── start.S
├── uart.c
├── uart.h
└── workflow_notes

###########################################################################
####                                                                   ####
####    Actual Working Minicom Output, My Lame Kernel Doing Stuff...   ####
####                                                                   ####
###########################################################################
                      
U-Boot 2025.04 (Jul 08 2025 - 02:21:58 +0000) Allwinner Technology                    
                                                                                      
CPU:   Allwinner A64 (SUN50I)                                                         
Model: Pine64 LTS                                                                     
DRAM:  2 GiB                                                                          
Core:  75 devices, 23 uclasses, devicetree: separate                                  
WDT:   Not starting watchdog@1c20ca0                                                  
MMC:   mmc@1c0f000: 0, mmc@1c11000: 1                                                 
Loading Environment from FAT... Unable to read "uboot.env" from mmc0:1...             
In:    serial,usbkbd                                                                  
Out:   serial,vidconsole                                                              
Err:   serial,vidconsole                                                              
Net:   eth0: ethernet@1c30000                                                         
                                                                                      
starting USB...                                                                       
Bus usb@1c1a000: USB EHCI 1.00                                                        
Bus usb@1c1a400: USB OHCI 1.0                                                         
Bus usb@1c1b000: USB EHCI 1.00                                                        
Bus usb@1c1b400: USB OHCI 1.0                                                         
scanning bus usb@1c1a000 for devices... 1 USB Device(s) found                         
scanning bus usb@1c1a400 for devices... 1 USB Device(s) found                         
scanning bus usb@1c1b000 for devices... 1 USB Device(s) found                         
scanning bus usb@1c1b400 for devices... 1 USB Device(s) found                         
       scanning usb for storage devices... 0 Storage Device(s) found                  
Hit any key to stop autoboot:  0                                                      
=> setenv lame 0x42000000                                                             
=> loady $lame
## Ready for binary (ymodem) download to 0x42000000 at 115200 bps...                  
C## Total Size      = 0x000004bb = 1211 Bytes
## Start Addr      = 0x42000000
=> go $lame
## Starting application at 0x42000000 ...

#################################################
##  ~$~       LameOS UART Payload Log     ~$~  ##
#################################################
| Current Execution [Privilege] Level (EL) ==>  0x0000000000000002 |

| payload binary image range |
|Start Addr: 0x0000000042000000 ==>> 0x00000000420004C0 |
| Total Payload Size: 0x00000000000004C0 |
9 Lines as proof of life...
[0]
[1]
[2]
[3]
[4]
[5]
[6]
[7]
[8]
[9]


There ya go!

#################################################
##  ~$~     End LameOS UART Payload Log   ~$~  ##
#################################################



###########################################################################
####             A few key notes about the linker.ld file              ####
###########################################################################

I couldn't find anywhere how to correctly put the PHDRS (PFLAGS) correctly.
I tried (R E) , (R|E), (PF_R|PF_E), (RX), ad nauseum. Finally GPT said just
put the hex number 0x5 and 0x6 for :text and :data respectively, and it worked.

Also objdump and readelf have a "wide output option", so do `-lW` instead of
just `-l` in the command string. If you don't go wide, it'll overwrite columns,
maybe that's just a sed idiosyncracy. No idea...
