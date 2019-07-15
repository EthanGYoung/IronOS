[bits 32]
[extern main] ; Define calling point must have same name as main in kernel.c
call main	; calls the C function. Lets the linker know where this is
jmp $
