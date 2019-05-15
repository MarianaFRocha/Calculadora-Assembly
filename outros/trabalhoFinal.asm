section .data

    formaEntrada: db "%lf", 0
    formaSaida: db "%lf", 10, 0 ; pula a linha
    mensagemDivZero: db "Erro divisao por zero", 10, 0 ; pula a linha
    z: dd 0.0

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

    push f1
    push formaEntrada 
    call scanf
    add esp, 8  

loop:

    ;call soma

    ;call subtracao

;    call multiplicacao

    call divisao

    jmp loop

  	popad   
    mov ESP, EBP
    pop EBP

    ret 
    int 80h


soma: 

    push f2
    push formaEntrada
    call scanf
    add esp, 8

    fld qword[f1]
    fadd qword[f2]
    fst qword[f1]

    sub esp, 8
    fst qword[esp]
    push formaSaida
    call printf
    add esp, 12

    ret

subtracao: 

    push f2
    push formaEntrada
    call scanf
    add esp, 8

    fld qword[f1]
    fsub qword[f2]
    fst qword[f1]

    sub esp, 8
    fst qword[esp]
    push formaSaida
    call printf
    add esp, 12

    ret

multiplicacao:

    push f2
    push formaEntrada
    call scanf
    add esp, 8

    fld qword[f1]
    fmul qword[f2]
    fst qword[f1]

    sub esp, 8
    fst qword[esp]
    push formaSaida
    call printf
    add esp, 12

    ret

;TEM QUE TRATAR DIVISAO POR ZERO
divisao:

	push f2
    push formaEntrada
    call scanf
    add esp, 8
    

    fld qword[f2]
    fld qword [z]
	fcomip 
	je erroDivisao      

    fld qword[f1]
    fdiv qword[f2]
    fst qword[f1]

    sub esp, 8
    fst qword[esp]
    push formaSaida
    call printf
    add esp, 12

    ret

erroDivisao:

	push mensagemDivZero
	call printf
	jmp divisao

	ret




