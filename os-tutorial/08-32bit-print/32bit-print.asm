[bits 32]

; Constants
VIDEO_MEMORY equ 0xb8000
WHITE_ON_BLACK equ 0x0f

; Prints null terminated string pointed to by EDX
prin_string_pm:
	pusha
	mov edx, VIDEO_MEMORY ; set edx to the start of vid mem.

print_string_pm_loop:
	mov al, [ebx]	; Store the char at EBX in AL
	mov ah, WHITE_ON_BLACK ; Store the attributes in AH
	
	cmp al, 0	; if (al == 0), at end of string, so
	je done		; jump to done

	mov [edx], ax	; Store char and attributes at curr char cell
	
	add ebx, 1	; Incrememnt EBX to the next char in string
	add edx, 2	; Move to next char cell in vid mem

	jmp print_string_pm_loop	; loop around toprint next char

print_string_pm_done :
	popa
	ret

