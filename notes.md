
## using syscall
- to use `syscall` instead of `int 80h` for interrupt
- using `int 80h` puts program into 32bit mode, thus it expects 32bit-abi(ways to pass arguments) for calling syscall

- refer: https://stackoverflow.com/questions/58667012/why-does-strace-report-my-x64-fasm-program-runs-in-32-bit-mode



## to create pie

in order to remove `-no-pie` whic compiling, we need to 

- add `wrt ..plt` after call to printf
```assembly
call scanf wrt ..plt
call printf wrt ..plt
```
- load address of labels with `rel` i.e to mark it relative
```assembly
mov rsi, [rel some_label]
lea rdi, [rel some_label2]

```

- refer: https://www.reddit.com/r/asm/comments/gxt3mw/create_a_pie_with_nasm_assembling_and_cstdlib/
- https://forums.linuxmint.com/viewtopic.php?t=328218
- lea_usage: https://stackoverflow.com/questions/31234395/why-use-rip-relative-addressing-in-nasm

## references

- syscalls: https://www.chromium.org/chromium-os/developer-library/reference/linux-constants/syscalls/

- calling_conventions: https://en.wikipedia.org/wiki/X86_calling_conventions

- printf_calling: https://www.mgaillard.fr/2024/09/20/printf-assembly-linux.html#:~:text=Calling%20printf()%20is%20done,number%20of%20vector%20register%20arguments. 

- https://sonictk.github.io/asm_tutorial/
- syscall_table: https://filippo.io/linux-syscall-table/

