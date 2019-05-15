sys_Exit       equ     1 ;id codigos del sistema
extern printf

section .data
formatoChar: db '%c', 0AH,0
formatoDec: dq '%d', 0AH,0
formatoStr: db '%s', 0AH, 0
mayus: db "Convert MAYUS", 0AH,0
minus: db "Convert MINUS", 0AH,0
tipoCnvs: db "2",0x0A

section .bss

section .text
global  main

_exit:
mov     rax,    1       ; exit
mov     rbx,    0       ; exit status
int     80h

main:
;Get the input data

 mov rcx, rdi     ; argc
 mov r8, 0     ; offset
 add r8, 8 ; apunta al siguiente argumento
 mov rdx, qword [rsi+r8] ; argv



 mov [tipoCnvs],rdx;Store value in variable
   ;print input
   ;mov rdi, formatoStr ; first parameter for printf
   ;mov rsi, rdx ; second parameter for printf
   ;mov rax, 0 ; no floating point register used
   ;call printf  ; call to printf     

;Print input value

 mov rdi,formatoStr
 mov rsi,[tipoCnvs]
 mov rax, 0; no floating point register used
 call printf

; This is the Comparison part that I'm interested in

mov rsi, [tipoCnvs]
cmp byte [rsi], '2'
 je CvrtMinus

 ;Convierte a Mayusculas
 CvrtMayus:
 mov rdi,mayus
 mov rax,0; no floating point register used
 call printf
 jmp _exit

 ;Convierte a Minusculas
 CvrtMinus:
 mov rdi,minus
 mov rax,0; no floating point register used
 call printf
 jmp _exit


    push sinal
    push formaSinal 
    call scanf

	push dword sinal
    push formaSaidaSinal
    call printf
    add esp, 4


     push f1
    push formaEntrada 
    call scanf

    fld qword[f1]
    fst qword[esp]
    push formaSaida
    call printf
    add esp, 12