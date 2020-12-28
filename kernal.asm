bits	32
section 	.text
	align	4
	dd	0x1BADB002
	dd	0x00
	dd	- (0x1BADB002+0x00)

global start
extern main	; Defined in external C file
start:
	cli
	call main
	hlt
