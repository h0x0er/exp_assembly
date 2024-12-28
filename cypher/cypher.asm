
default rel

extern printf

SECTION .text




; rsi=log_type
; rdi=msg
log:
   push rbp
   push rsi
   push rdi

   ; print banner
   lea rdi, [rel log_fmt_str]
   mov rsi, [rsp+8]
   mov rdx, [rsp]
   call printf wrt ..plt

   pop rdi
   pop rsi
   pop rbp

   xor rax, rax
   ret


; rsi = num to print
log_num:
   push rbp
   push rdi
   push rsi


   lea rdi, [rel log_fmt_num]
   mov rdx, rsi
   lea rsi, [rel info_str]
   call printf wrt ..plt


   pop rsi
   pop rdi
   pop rbp
   ret

info:
   push rbp

   mov rdi, rdi
   lea rsi, [rel info_str]
   call log

   pop rbp
   xor rax, rax
   ret

warn:
   push rbp

   mov rdi, rdi
   lea rsi, [rel warn_str]
   call log

   pop rbp
   xor rax, rax
   ret



global print_internal
; rdi=str to print
; rsi= str size
print_internal:
   push rbp

  
   mov rax, 1 ; sys_write
   mov rdx, rsi ; str_size
   mov rsi, rdi ; str_to_print
   mov rdi, 1 ; stdout
   syscall


   pop rbp
   ret



extern scanf
global assembly_main
assembly_main:
   push rbp

   ; print banner
   lea rdi, [rel banner]
   call info


   ;take input
   lea rdi, [rel inpt_fmt]
   lea rsi, [rel input_data] ; load addrof(input_data)
   call scanf wrt ..plt

   ; print num
   mov rdx, [rel input_data] ; load valueAt(input_data)
   mov rsi, rdx
   call log_num


   ; exec ls cmd
   mov rax, 0x3b ; sys_execve
   lea rdi, [rel ls_cmd]
   mov rsi, 0
   mov rdx, 0
   syscall 




main_end:
   pop rbp
   xor rax, rax
   ret



global rename_internal
; rdi = oldname = arg0
; rsi = name = arg1
rename_internal:
   push rbp

   mov rax, 0x52
   syscall

   pop rbp
   ret





SECTION .bss

input_data resq 1

SECTION .rodata

ls_cmd db "/usr/bin/ls",0x0

inpt_fmt db "%ld",0x0

banner db "entering assembly",0x00

log_fmt_num db "[%s] %ld",0xd,0xa,0x00
log_fmt_str db "[%s] %s",0xd,0xa,0x00
info_str db "INFO",0x00
warn_str db "WARN",0x00

success db "success",0x00





