; A boot sector that boots a C kernel in 32-bit protected mode
[org 0x7c00]
KERNEL_OFFSET equ 0x1000	; This is the mem offset to which we load kernel

	mov [BOOT_DRIVE], dl	; BIOS stores our boot drive in DL
	
	mov bp, 0x9000		; Set up the stack
	mov sp, bp
	
	mov bx, MSG_REAL_MODE	; Announce that we starting boot from 16-bit mode
	call print_string
	call print_nl


	call load_kernel
	call switch_to_pm	; Switch to pm mode from which we will not return
	jmp $

%include "16bit-print.asm"
%include "disk_load.asm"
%include "32bit-gdt.asm"
%include "32bit-print.asm"
%include "32bit-switch.asm"

[bits 16]

load_kernel:
	mov bx, MSG_LOAD_KERNEL	; Print message to say loading kernel
	call print_string
	call print_nl

	mov bx, KERNEL_OFFSET 	; Read from disk and store in 0x1000
	mov dh, 2		; Loading the first 15 sectors
	mov dl, [BOOT_DRIVE]	; From boot disk
	call disk_load
	ret

[bits 32]
; This is where we arrive after switching and initializing pm

BEGIN_PM:
	mov ebx, MSG_PROT_MODE	; Announce in PM mode
	call print_string_pm
	call KERNEL_OFFSET	; Now jump to address of our loaded kernel code
	jmp $

; Globals
BOOT_DRIVE	db 0
MSG_REAL_MODE	db "Started in 16-bit Real Mode", 0
MSG_PROT_MODE	db "Successfully landed in 32-bit Protected Mode", 0
MSG_LOAD_KERNEL	db "Loaded kernel into memory", 0

; Bootsector padding
times 510 -($-$$) db 0
dw 0xaa55
