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
	;; Print it to screen
	int 0x10

	;; This is a formula maybe 
	
	
	;; loop
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
	
	xor ax, ax 										; 1 ^ 1 = 0 || 1 ^ 0 = 1
	mov es, ax
	mov word [es:0x0070] , draw_frame ; ip
	mov word [es:0x0072] , 0x00				; cs

	jmp $
	
	
draw_frame:
	pusha
	;; (ax is 16 bit value) we will assign 0xA000 this to ax(16 bit value) 
	;; 0xA000 => holds the content display of video mode "0x13" i.e colors(rgb)
	mov ax, 0x0000
	mov ds, ax
	
	mov ax, 0xA000
	mov es, ax
	
	mov ch, 0x00
	call draw_ball

	;; Wall Collsion logic
	;; ball_x <= 0 || ball_x >= WIDTH - BALL_WIDTH (ball_x + BALL_WIDTH >= WIDTH)  jump horizontally

 	cmp word [ball_x] , 0
 	jle .neg_dx

 	mov ax, [ball_x]
 	add ax, BALL_WIDTH
 	cmp ax, WIDTH
 	jge .neg_dx
	
 	jmp .horicolision

	.neg_dx:
	neg word [ball_dx]

	.horicolision:
	
	mov ax , [ball_x]
	add ax , [ball_dx]
	mov [ball_x] , ax


;; vertical collision logic (ball_y <= 0 || ball_y >= HEIGHT - BALL_HEIGHT )
	;; 1 condition for vertical
	mov ax, [ball_y]
	cmp ax, 0
	jle .neg_dy

	;; 2 condition for vertical
	mov ax , [ball_y]
	cmp ax , HEIGHT - BALL_HEIGHT
	jge .neg_dy

	jmp .vericolision
	;; Negate dy
	.neg_dy:
	neg word [ball_dy]
	
	.vericolision:
	mov ax , [ball_y]
	add ax , [ball_dy]
	mov [ball_y] , ax

	mov ch , 0x0A
	call draw_ball
	;; iret isused for calling your own interrupt routine
	;; ret is used when you doing a normal function call
	popa
	iret

	;; Review this in a book (dry run)
draw_ball:
		
	mov word [y], 0
.y:										;row
	mov word [x], 0
.x:										;col

	mov ax, WIDTH
	mov bx, [y] 
	add bx, [ball_y]
	mul bx
	mov bx, ax
	add bx, [x]
	add bx, [ball_x]
	mov BYTE [es:bx], ch	

	inc word [x]
  cmp word [x], BALL_WIDTH
	jb	 .x
	
	inc word [y]
  cmp word [y], BALL_HEIGHT
	jb .y	
	ret

;; 1. dd means define double word which allocates 32 bit,
;; 2. dw means define word which allocates 16 bit ,
;; 3. db means define byte which allocates 8 bit,
	
y: dw 0xcccc 
x: dw 0xcccc
ball_x: dw 10
ball_y:	dw 10
ball_dx: dw 2
ball_dy: dw 2
	
times 510 - ($-$$) db 0
dw 0xaa55
