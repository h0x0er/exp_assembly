extern printf

SECTION .text

global dino_main
dino_main:
    push rbp

    ; lea rdi, [rel dino_banner]
    ; call printf wrt ..plt
    
    call dino_print_banner

    call dino_take_input


    xor rax, rax

    pop rbp
    ret


dino_print_banner:
    push rbp
    mov rax, 1 ; sys_write
    mov rdi, 1 ; stdout
    lea rsi, [rel dino_banner]
    mov rdx, dino_banner_size
    syscall
    pop rbp
    ret

dino_take_input:
    push rbp

    sub rsp, 16

    mov rax, 0 ; sys_read
    mov rdi, 0 ; stdin
    mov rsi, rsp ;  where to write
    mov rdx, 8 ; size
    syscall

    mov rax, "out: "
    push rax
    xor rax, rax

    mov rax, 1 ; sys_write
    mov rdi, 1 ; stdout
    mov rsi, rsp ; str to write
    mov rdx, 16 ; size
    syscall

    pop rax
    add rsp, 16
    pop rbp
    xor rax, rax
    ret



SECTION .rodata

dino_banner db "hi from dino :) enter something :|",0dh,0ah,0x0
dino_banner_size equ $-$$

