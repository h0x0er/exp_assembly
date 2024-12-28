nasm -f elf64 -o bin.o $1
ld bin.o -o binary
chmod +x binary