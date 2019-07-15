; A boot sector that enters 32-bit protected mode
[org 0x7c00]

	mov bp, 0x9000		; Set the stack
	mov sp, bp

	mov bx, MSG_REAL_MODE
	call print_string

	call switch_to_pm	; Note that we never return from here

	jmp $

%include "16bit-print.asm"
%include "32bit-gdt.asm"
%include "32bit-print.asm"
%include "32bit-switch.asm"

[bits 32]

BEGIN_PM: ; This is where we arrive after switching to pm
	mov ebx, MSG_PROT_MODE
	call print_string_pm	; 32 bit routine
	
	jmp $

; Globals
MSG_REAL_MODE	db "Started in 16-bit Real Mode", 0
MSG_PROT_MODE	db "Successfully landed in 32-bit PM", 0

; Bootsector padding
times 510-($-$$) db 0
dw 0xaa55
