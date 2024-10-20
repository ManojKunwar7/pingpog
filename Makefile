all: pingpog
	qemu-system-i386 pingpog

pingpog: pingpog.asm
	nasm pingpog.asm -o pingpog

