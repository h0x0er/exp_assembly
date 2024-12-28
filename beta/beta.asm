
bits 64
cpu x64



extern printf

global _get_pid
global _print_pid
global _print_ppid

global _rename_file

SECTION .text
 
_get_pid:
   push rbp ; setup stack

   mov rax, 0x14
   int 0x80

   pop rbp
   ret




_print_pid:
   push rbp ; setting up stack

   mov rax, 0x14
   int 0x80

   mov rsi, rax ; arg2
   mov rdi, fmt ; arg1
   mov rax,0
   call printf

   pop rbp
   ret
   

_print_ppid:
   push rbp ; setting up stack

   mov rax, 0x40
   int 0x80 ; trigger syscall


   mov rsi, rax ; arg2
   mov rdi, fmt2 ; arg1
   mov rax,0
   call printf ; call c function

   pop rbp
   ret

_rename_file:
   push rbp

   mov rax, 38 ; rename
   int  0x80

   ; clean regs
   xor rdi, rdi
   xor rsi, rsi

   mov rdi, fmt2
   mov rsi, rax
   call printf

   pop rbp
   ret


extern creat
global _create_file
_create_file:
   push rbp

 

   push rdi
   push rsi

   mov rsi, [rsp+0x8]
   mov rdi, fmt3
   call printf


   mov rsi, [rsp]
   mov rdi, fmt2
   call printf


   mov rsi, [rsp]
   mov rdi, [rsp+0x8]
   call creat

   mov rsi, rax
   mov rdi, fmt2
   call printf


   pop rsi
   pop rdi

   pop rbp
   ret




global authn

authn:
   push rbp

   cmp rdi, 10
   jle fail
   
suc:
   mov rdi, success
   call printf
   jmp auth_end

fail:
   mov rdi, failed
   call printf


auth_end:
   pop rbp
   xor rax, rax
   ret



global to_str
to_str:

   push rbp
   
   cmp rdi, 1
   je one

   cmp rdi, 2
   je two

   cmp rdi, 3
   je three

   jmp to_str_default

one:
   mov rdi, one_str
   call printf
   jmp to_str_end


two:
   mov rdi, two_str
   call printf
   jmp to_str_end


three:
   mov rdi, three_str
   call printf
   jmp to_str_end


to_str_default:
   mov rdi, default_str
   call printf

to_str_end:
   pop rbp
   xor rax,rax
   ret



extern scanf
global take_input
take_input:
   push rbp

   push rdi
   push rsi

   sub rsp, 16

   
   mov rdi, inpt_fmt
   mov rsi, rsp
   call scanf



loop1:

   mov rdi, inpt_fmt2
   mov rsi, [rsp]
   call printf

   mov rdx, [rsp]
   sub rdx, 1
   mov [rsp], rdx
   
   cmp rdx, 0
   jnz loop1


   add rsp, 16
   pop rsi
   pop rdi
   pop rbp

   xor rax, rax
   ret

SECTION .bss

; take_input
inpt_num resw 4


SECTION .rodata

;; take_input
inpt_fmt db "%ld",0x00
inpt_fmt2 db "entered number: %ld",0xd,0xa,0x00



;; to_str
one_str db "one",0xd,0xa,0x00
two_str db "two",0xd,0xa,0x00
three_str db "three",0xd,0xa,0x00
four_str db "four",0xd,0xa,0x00

default_str db "not added yet",0xd,0xa,0x00


; authn 
success db "auth success",0xd,0xa,0x00
failed db "auth failed",0xd,0xa,0x00


; formats
fmt db "pid: %d",0x0a,0xd,0x00
fmt2 db "ret: %d",0x0a,0xd,0x00
fmt3 db "str: %s ",0x0a,0xd,0x00



