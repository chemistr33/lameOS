	.arch armv8-a+crc
	.file	"foo.c"
// GNU C17 (FreeBSD Ports Collection for aarch64noneelf) version 11.3.0 (aarch64-none-elf)
//	compiled by GNU C version FreeBSD Clang 18.1.6 (https://github.com/llvm/llvm-project.git llvmorg-18.1.6-0-g1118c2e05e67), GMP version 6.3.0, MPFR version 4.2.2, MPC version 1.3.1, isl version none
// GGC heuristics: --param ggc-min-expand=100 --param ggc-min-heapsize=131072
// options passed: -mcpu=cortex-a53 -mlittle-endian -mabi=lp64 -g -O0 -fno-omit-frame-pointer -ffreestanding
	.text
.Ltext0:
	.cfi_sections	.debug_frame
	.file 0 "/home/acer0/code/lameOS/didactic/learnARMasm" "foo.c"
	.align	2
	.global	addfive
	.type	addfive, %function
addfive:
.LFB0:
	.file 1 "foo.c"
	.loc 1 5 5
	.cfi_startproc
	sub	sp, sp, #32	//,,
	.cfi_def_cfa_offset 32
	str	w0, [sp, 28]	// a, a
	str	w1, [sp, 24]	// b, b
	str	w2, [sp, 20]	// c, c
	str	w3, [sp, 16]	// d, d
	str	w4, [sp, 12]	// e, e
// foo.c:5:     {return (a+b+c+d+e);}
	.loc 1 5 15
	ldr	w1, [sp, 28]	// tmp97, a
	ldr	w0, [sp, 24]	// tmp98, b
	add	w1, w1, w0	// _1, tmp97, tmp98
// foo.c:5:     {return (a+b+c+d+e);}
	.loc 1 5 17
	ldr	w0, [sp, 20]	// tmp99, c
	add	w1, w1, w0	// _2, _1, tmp99
// foo.c:5:     {return (a+b+c+d+e);}
	.loc 1 5 19
	ldr	w0, [sp, 16]	// tmp100, d
	add	w1, w1, w0	// _3, _2, tmp100
// foo.c:5:     {return (a+b+c+d+e);}
	.loc 1 5 21
	ldr	w0, [sp, 12]	// tmp101, e
	add	w0, w1, w0	// _9, _3, tmp101
// foo.c:5:     {return (a+b+c+d+e);}
	.loc 1 5 25
	add	sp, sp, 32	//,,
	.cfi_def_cfa_offset 0
	ret	
	.cfi_endproc
.LFE0:
	.size	addfive, .-addfive
	.align	2
	.global	main
	.type	main, %function
main:
.LFB1:
	.loc 1 8 1
	.cfi_startproc
	stp	x29, x30, [sp, -48]!	//,,,
	.cfi_def_cfa_offset 48
	.cfi_offset 29, -48
	.cfi_offset 30, -40
	mov	x29, sp	//,
// foo.c:9:     int v = 1;
	.loc 1 9 9
	mov	w0, 1	// tmp94,
	str	w0, [sp, 44]	// tmp94, v
// foo.c:10:     int w = 2;
	.loc 1 10 9
	mov	w0, 2	// tmp95,
	str	w0, [sp, 40]	// tmp95, w
// foo.c:11:     int x = 3;
	.loc 1 11 9
	mov	w0, 3	// tmp96,
	str	w0, [sp, 36]	// tmp96, x
// foo.c:12:     int y = 4;
	.loc 1 12 9
	mov	w0, 4	// tmp97,
	str	w0, [sp, 32]	// tmp97, y
// foo.c:13:     int z = 5;
	.loc 1 13 9
	mov	w0, 5	// tmp98,
	str	w0, [sp, 28]	// tmp98, z
// foo.c:15:     ret = addfive(v,w,x,y,z);
	.loc 1 15 11
	ldr	w4, [sp, 28]	//, z
	ldr	w3, [sp, 32]	//, y
	ldr	w2, [sp, 36]	//, x
	ldr	w1, [sp, 40]	//, w
	ldr	w0, [sp, 44]	//, v
	bl	addfive		//
	str	w0, [sp, 24]	//, ret
// foo.c:16:     return 77;
	.loc 1 16 12
	mov	w0, 77	// _9,
// foo.c:17: }
	.loc 1 17 1
	ldp	x29, x30, [sp], 48	//,,,
	.cfi_restore 30
	.cfi_restore 29
	.cfi_def_cfa_offset 0
	ret	
	.cfi_endproc
.LFE1:
	.size	main, .-main
.Letext0:
	.section	.debug_info,"",@progbits
.Ldebug_info0:
	.4byte	0xef
	.2byte	0x5
	.byte	0x1
	.byte	0x8
	.4byte	.Ldebug_abbrev0
	.uleb128 0x3
	.4byte	.LASF4
	.byte	0x1d
	.4byte	.LASF0
	.4byte	.LASF1
	.8byte	.Ltext0
	.8byte	.Letext0-.Ltext0
	.4byte	.Ldebug_line0
	.uleb128 0x4
	.4byte	.LASF2
	.byte	0x1
	.byte	0x7
	.byte	0x5
	.4byte	0x95
	.8byte	.LFB1
	.8byte	.LFE1-.LFB1
	.uleb128 0x1
	.byte	0x9c
	.4byte	0x95
	.uleb128 0x1
	.string	"v"
	.byte	0x9
	.4byte	0x95
	.uleb128 0x2
	.byte	0x91
	.sleb128 -4
	.uleb128 0x1
	.string	"w"
	.byte	0xa
	.4byte	0x95
	.uleb128 0x2
	.byte	0x91
	.sleb128 -8
	.uleb128 0x1
	.string	"x"
	.byte	0xb
	.4byte	0x95
	.uleb128 0x2
	.byte	0x91
	.sleb128 -12
	.uleb128 0x1
	.string	"y"
	.byte	0xc
	.4byte	0x95
	.uleb128 0x2
	.byte	0x91
	.sleb128 -16
	.uleb128 0x1
	.string	"z"
	.byte	0xd
	.4byte	0x95
	.uleb128 0x2
	.byte	0x91
	.sleb128 -20
	.uleb128 0x1
	.string	"ret"
	.byte	0xe
	.4byte	0x95
	.uleb128 0x2
	.byte	0x91
	.sleb128 -24
	.byte	0
	.uleb128 0x5
	.byte	0x4
	.byte	0x5
	.string	"int"
	.uleb128 0x6
	.4byte	.LASF3
	.byte	0x1
	.byte	0x4
	.byte	0x5
	.4byte	0x95
	.8byte	.LFB0
	.8byte	.LFE0-.LFB0
	.uleb128 0x1
	.byte	0x9c
	.uleb128 0x2
	.string	"a"
	.byte	0x11
	.4byte	0x95
	.uleb128 0x2
	.byte	0x91
	.sleb128 -4
	.uleb128 0x2
	.string	"b"
	.byte	0x18
	.4byte	0x95
	.uleb128 0x2
	.byte	0x91
	.sleb128 -8
	.uleb128 0x2
	.string	"c"
	.byte	0x1f
	.4byte	0x95
	.uleb128 0x2
	.byte	0x91
	.sleb128 -12
	.uleb128 0x2
	.string	"d"
	.byte	0x26
	.4byte	0x95
	.uleb128 0x2
	.byte	0x91
	.sleb128 -16
	.uleb128 0x2
	.string	"e"
	.byte	0x2d
	.4byte	0x95
	.uleb128 0x2
	.byte	0x91
	.sleb128 -20
	.byte	0
	.byte	0
	.section	.debug_abbrev,"",@progbits
.Ldebug_abbrev0:
	.uleb128 0x1
	.uleb128 0x34
	.byte	0
	.uleb128 0x3
	.uleb128 0x8
	.uleb128 0x3a
	.uleb128 0x21
	.sleb128 1
	.uleb128 0x3b
	.uleb128 0xb
	.uleb128 0x39
	.uleb128 0x21
	.sleb128 9
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x2
	.uleb128 0x18
	.byte	0
	.byte	0
	.uleb128 0x2
	.uleb128 0x5
	.byte	0
	.uleb128 0x3
	.uleb128 0x8
	.uleb128 0x3a
	.uleb128 0x21
	.sleb128 1
	.uleb128 0x3b
	.uleb128 0x21
	.sleb128 4
	.uleb128 0x39
	.uleb128 0xb
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x2
	.uleb128 0x18
	.byte	0
	.byte	0
	.uleb128 0x3
	.uleb128 0x11
	.byte	0x1
	.uleb128 0x25
	.uleb128 0xe
	.uleb128 0x13
	.uleb128 0xb
	.uleb128 0x3
	.uleb128 0x1f
	.uleb128 0x1b
	.uleb128 0x1f
	.uleb128 0x11
	.uleb128 0x1
	.uleb128 0x12
	.uleb128 0x7
	.uleb128 0x10
	.uleb128 0x17
	.byte	0
	.byte	0
	.uleb128 0x4
	.uleb128 0x2e
	.byte	0x1
	.uleb128 0x3f
	.uleb128 0x19
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0xb
	.uleb128 0x39
	.uleb128 0xb
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x11
	.uleb128 0x1
	.uleb128 0x12
	.uleb128 0x7
	.uleb128 0x40
	.uleb128 0x18
	.uleb128 0x7c
	.uleb128 0x19
	.uleb128 0x1
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0x5
	.uleb128 0x24
	.byte	0
	.uleb128 0xb
	.uleb128 0xb
	.uleb128 0x3e
	.uleb128 0xb
	.uleb128 0x3
	.uleb128 0x8
	.byte	0
	.byte	0
	.uleb128 0x6
	.uleb128 0x2e
	.byte	0x1
	.uleb128 0x3f
	.uleb128 0x19
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0xb
	.uleb128 0x39
	.uleb128 0xb
	.uleb128 0x27
	.uleb128 0x19
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x11
	.uleb128 0x1
	.uleb128 0x12
	.uleb128 0x7
	.uleb128 0x40
	.uleb128 0x18
	.uleb128 0x7a
	.uleb128 0x19
	.byte	0
	.byte	0
	.byte	0
	.section	.debug_aranges,"",@progbits
	.4byte	0x2c
	.2byte	0x2
	.4byte	.Ldebug_info0
	.byte	0x8
	.byte	0
	.2byte	0
	.2byte	0
	.8byte	.Ltext0
	.8byte	.Letext0-.Ltext0
	.8byte	0
	.8byte	0
	.section	.debug_line,"",@progbits
.Ldebug_line0:
	.section	.debug_str,"MS",@progbits,1
.LASF4:
	.string	"GNU C17 11.3.0 -mcpu=cortex-a53 -mlittle-endian -mabi=lp64 -g -O0 -fno-omit-frame-pointer -ffreestanding"
.LASF3:
	.string	"addfive"
.LASF2:
	.string	"main"
	.section	.debug_line_str,"MS",@progbits,1
.LASF1:
	.string	"/home/acer0/code/lameOS/didactic/learnARMasm"
.LASF0:
	.string	"foo.c"
	.ident	"GCC: (FreeBSD Ports Collection for aarch64noneelf) 11.3.0"
