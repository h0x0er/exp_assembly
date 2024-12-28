#!/bin/bash

set -eo pipefail

# convert to bin-obj
nasm -felf64 -o bin.o cypher.asm

# link bin-obj
# ld bin.o -o cypher

clang main.c bin.o -o cypher

chmod +x cypher

# run bin
./cypher
