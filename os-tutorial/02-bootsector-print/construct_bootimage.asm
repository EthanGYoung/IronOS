; Write hello to register and tell cpu to issue interupt to video
mov ah, 0x0e ; tty mode
mov al, 'H'
int 0x10
mov al, 'E'
int 0x10
mov al, 'L'
int 0x10
mov al, 'L'
int 0x10
mov al, 'O'
int 0x10

jmp $ ; jump to current address => infinite loop

; Fill the sector with padding zeros munus the size of the previous code
times 510-($-$$) db 0
; Magic number to indicate to BIOS that this is an OS image (Written little endian)
dw 0xaa55
