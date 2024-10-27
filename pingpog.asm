	;; 2 cs(segment) : 2 ip(pointer) for interrupt handler
	;; 0x0000:0x0000

	;; Tells the bios where our boot sector seats in bios 
	org 0x7C00
	
	;; eax = register (16:16)(32 bit)
	;; x = register h:l (8:8) (16 bit)
	;; h = register(higher 8 bit)(zero based maybe ?) , l = lower regsiter (8 bit)
	;; how to define a varibale (macro) %define (variable_name) (variable_value) 
	%define ROW 50	
	%define WIDTH 320
	%define HEIGHT 200 

	%define BALL_WIDTH 10
	%define BALL_HEIGHT 10
	
	;; Enter video mode
	mov ah, 0x00
	; Enter VGA Mode 0x13
	; 320x200 256 colors
	mov al, 0x13
	;; Print it to screen maybe?
	int 0x10

	;; This is a formula maybe 
	
	
;; loop:
;; 	;; byte [0xA000: 0(16 bit)], color
;; 	mov BYTE [es:bx], 0x0B
;; 	;; Increment bx + 1;
;; 	inc bx
;; 	;; cmp bx == 64000 
;; 	;; cmp bx, 64000
;; 	cmp bx , WIDTH * ROW + WIDTH
;; 	;; jb is jump unsigned integers which is (65,000~)
;; 	;; & jl is jump signed integers which is (-32,000~ - 32,000~)
;; 	;; bx is of 16 bit
	;; 	jb loop

 ;; mov word [ball_x], 0
 ;; mov word [ball_y], 0						
 ;; mov word [ball_dx], 1
 ;; mov word [ball_dy], 1
	
	xor ax, ax
	mov es, ax
	mov word [es:0x0070] , draw_frame
	mov word [es:0x0072] , 0x00  

	jmp $
	
	
draw_frame:
	pusha
	;; (ax is 16 bit value) we will assign 0xA000 this to ax(16 bit value) 
	;; 0xA000 => holds the content display of video mode "0x13" i.e colors(rgb) 
	mov ax, 0xA000
	mov es, ax

	

	
	mov ch, 0x00
	call draw_ball
	
	mov ax , [ball_x]
	add ax , [ball_dx]
	mov [ball_x] , ax

	mov ax , [ball_y]
	add ax , [ball_dy]
	mov [ball_y] , ax

	mov ch , 0x0A
	call draw_ball
	;; iret isused for calling your own interrupt routine
	;; ret is used when you doing a normal function call
	popa
	iret

draw_ball:
		
	mov word [i], 0
draw_ball_i:										;row
	mov word [j], 0								;
draw_ball_j:										;col

	mov ax, WIDTH
	mov bx, [i]
	add bx, [ball_y]
	mul bx
	mov bx, ax
	add bx, [j]
	add bx, [ball_x]
	mov BYTE [es:bx], ch	

	inc word [j]
  cmp word [j], BALL_WIDTH
	jb draw_ball_j
	
	inc word [i]
  cmp word [i], BALL_HEIGHT
	jb draw_ball_i	
	ret

;; 1. dd means define double word which allocates 32 bit,
;; 2. dw means define word which allocates 16 bit ,
;; 3. db means define byte which allocates 8 bit,
	
i: dw 0 
j: dw 0
ball_x: dw 0
ball_y:	dw 0
ball_dx: dw 1
ball_dy: dw 1
	
	times 510 - ($-$$) db 0
	dw 0xaa55
