[bits 16] ; In real mode for now

; Switch to protected mode
switch_to_pm:

	cli			; Disable interrupts until setup 32 bit interrupt vector

	lgdt [gdt_descriptor]	; Load global gdt table, which defines protected mode segments

	mov eax, cr0		; To make switch to protected mode, we set first bit
	or eax, 0x1
	mov cr0, eax

	jmp CODE_SEG:init_pm	; Make a far jump to clear pipeline of data not in pm


[bits 32] ; In protected mode
; Initialize registers and stack
init_pm:
	mov ax, DATA_SEG	; Old segs are meaningless
	mov ds, ax		; Update all registers to data seg in GDT 
	mov ss, ax
	mov es, ax
	mov fs, ax
	mov gs, ax

	mov ebp, 0x90000	; Update stack to top of free space
	mov esp, ebp
	
	call BEGIN_PM
