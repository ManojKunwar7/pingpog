	;; h = high register maybe ? 
	mov ah, 0x00
	; Enter VGA Mode 0x13
	; 320x200 256 colors
	mov al, 0x13
	;; Print it to screen maybe
	int 0x10

	;; (ax is 16 bit value) we will assign 0xA000 this to ax(16 bit value) 
	;; 0xA000 => holds the content display of video mode "0x13" 
	mov ax, 0xA000
	mov es, ax

	mov bx, 0
loop:
	;; byte [0xA000: 0(16 bit)], color
	mov BYTE [es:bx], 0x0B
	;; Increment bx + 1;
	inc bx
	;; cmp bx == 64000
	cmp bx, 64000
	;; jb is jump unsigned integers which is (65,000~)
	;; & jl is jump signed integers which is (-32,000~ - 32,000~)
	;; bx is of 16 bit
	jb loop
	
		
	jmp $
	times 510 - ($-$$) db 0
	dw 0xaa55
