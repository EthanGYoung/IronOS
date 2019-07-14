; create an infinite loop (e9 fd ff)
loop:
	jmp loop

; Fill the sector with 510 zeros munus the size of the previous code
times 510-($-$$) db 0
; Magic number to indicate to BIOS that this is an OS image (Written little endian)
dw 0xaa55
