mov ah, 0x0e

mov al, 'U'
int 0x10
mov al, 'R'
int 0x10
mov al, ' '
int 0x10
mov al, 'M'
int 0x10	
mov al, 'o'
int 0x10	
mov al, 'M'
int 0x10

	
jmp $
times 510 - ($-$$) db 0
dw 0xaa55
	
	