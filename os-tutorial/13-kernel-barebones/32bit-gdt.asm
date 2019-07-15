; GDT
gdt_start:

gdt_null:	; The first entry is null to cause exception if null pointer
	dd 0x0	; Define double word (4 bytes)
	dd 0x0

gdt_code:	; the code segment descriptor
	; base=0x0 limit=0xffff
	; See comments for definition of bits
	dw 0xffff	; Limit (bits 0-15)
	dw 0x0		; Base (bits 0-15)
	db 0x0		; Base (bits 16-23)
	db 10011010b	; 1st flags, type flags
	db 11001111b	; 2nd flags, limit (bits 16-19)
	db 0x0		; Base (bits 24-31)

gdt_data:	; the data segment descriptor
	; Type flags are different
	dw 0xffff
	dw 0x0
	db 0x0
	db 10010010b
	db 11001111b
	db 0x0

gdt_end:	; Put this at the end to calculate the size of the gdt

; GDT descriptor (variable passed to BIOS)
gdt_descriptor:
	dw gdt_end - gdt_start - 1 	; size of GDT, always less one of true size
	dd gdt_start			; Start address of GDT


; Constants to be used based on the mode (protected or not) as offsets into GDT
CODE_SEG equ gdt_code - gdt_start
DATA_SEG equ gdt_data - gdt_start
