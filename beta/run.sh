#!/bin/bash

echo "mypid: $$"

set -eo pipefail

# convert to bin-obj
nasm -f elf64 -o beta.o beta.asm

# link bin-obj
# ld bin.o -o binary

gcc -no-pie main.c beta.o -o binary

chmod +x binary

# run bin
./binary
