 print_string:
	pusha

start:
	mov al, [bx] ; 'bx' is base addr of string
	cmp al, 0
	je done
	
	; print with BIOS help
	mov ah, 0x0e
	int 0x10 ; 'al' already contains the char
	
	; increment pointer for next loop
	add bx, 1
	jmp start

done:
	popa
	ret

print_nl:
	pusha

	mov ah, 0x0e
	mov al, 0x0a ; newline char

	int 0x10

	mov al, 0x0d ; carriage return
	int 0x10

	popa
	ret
