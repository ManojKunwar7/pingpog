all: pingpog
	qemu-system-i386 ping
pingpog: pingpog.asm
	nasm pingpog.asm -o ping