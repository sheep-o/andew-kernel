AS = nasm
CC = i686-elf-gcc
LD = i686-elf-ld

all: test

init.o: src/init/init.asm
	$(AS) -f elf32 $^ -o $@

main.o: src/init/main.c
	$(CC) -c $^ -o $@ -std=gnu99 -ffreestanding -O2 -Wall -Wextra

boot/kernel.bin: init.o main.o
	$(CC) -T linker.ld -o $@ -ffreestanding -O2 -nostdlib $^ -lgcc

andew.iso: boot/kernel.bin
	grub-mkrescue -o $@ .

.PHONY: clean
clean:
	rm -rf *.o *.iso boot/*.bin

.PHONY: test
test: andew.iso
	qemu-system-i386 -cdrom $^
