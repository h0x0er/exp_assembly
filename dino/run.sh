#!/bin/bash

set -eo pipefail

# assemble
nasm -f elf64 -o dino.o dino.asm


# link with clang or gcc
clang dino.o main.c -o dino

# run it
chmod +x dino
./dino