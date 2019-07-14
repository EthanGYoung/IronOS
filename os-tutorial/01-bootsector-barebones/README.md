To complile the boot image run this command:

nasm -f bin construct_bootimage.asm -o boot_sect_simple.bin

To run:

qemu-system-x86_64 boot_sect_simple.bin
