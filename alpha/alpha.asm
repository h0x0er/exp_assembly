
 
SECTION .data
msg     dw      'Hello World!', 0Ah
 
SECTION .text
global  _start
 
_start:
 
 print:
    mov     edx, 13
    mov     ecx, msg
    mov     ebx, 1
    mov     eax, 4
    int     80h
 
 exit:
    mov     ebx, 0      ; return 0 status on exit - 'No Errors'
    mov     eax, 1      ; invoke SYS_EXIT (kernel opcode 1)
    int     80h