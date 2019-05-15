section .data

	;real
    formaEntrada: db "%lf", 0
    formaSaida: db "%lf", 10, 0 ; pula a linha
    mensagem: db "IGUAL", 10, 0

    z: dd 2.0

section .bss

    f1: resq 1
    f2: resq 1


section .text
    
    global main 
    extern scanf 
    extern printf     



main:

	push EBP        ; base pointer
    mov EBP, ESP    ; put stack pntr in EBP
    pushad          ; pushes all registers on stackecx



    push dword[z]
    push formaSaida
    call printf


    mov     esp, ebp	; takedown stack frame
    pop     ebp		; same as "leave" op

	mov	eax,0		;  normal, no error, return value
	ret	

igual: 

 	push mensagem
	call printf

	ret