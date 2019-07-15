; Load 'dh' sectors from drive 'dl' into ES:BX
disk_load:
	pusha

	; Need to overwrite input param, so save to stack
	push dx
	
	mov ah, 0x02 	; ah <- int 0x13 function, 0x02 = 'read'
	mov al, dh	; al <- number of sectors to read (0x01 .. 0x80)
	mov cl, 0x02	; cl <- sector (0x01 .. 0x11) -- 0x02 is first avail sector

	mov ch, 0x00 	; ch <- cylinder (0x0 .. 0x3FF, upper 2 bits in 'cl'
			; dl <- drive number (Set by caller from BIOS)
			; (0 = floppy, 1 = floppy2, 0x80 = hdd, 0x81 = hdd2)
	mov dh, 0x00 	; dh <- head number

	; [es:bx] <- Pointer where the buffered data will be stored
	; Caller sets it up
	int 0x13	; BIOS interrupt
	jc disk_error	; if error (In carry bit)

	pop dx
	cmp al, dh	; BIOS also sets 'al' to the # of sectors read. Compare it.
	jne sectors_error
	popa
	ret

disk_error:
	mov bx, DISK_ERROR
	call print_string
	call print_nl
	mov dh, ah	; ah contains error code and dl is disk that dropped error
	call print_hex	
	jmp disk_loop

sectors_error:
	mov bx, SECTORS_ERROR
	call print_string

disk_loop:
	jmp $

DISK_ERROR: db "Disk read error.", 0
SECTORS_ERROR: db "Incorrect number of sectors read", 0
	
