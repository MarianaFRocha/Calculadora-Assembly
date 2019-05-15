section .data

    message1: db "Enter the first number: ", 0
    message2: db "Enter the second number: ", 0
    formaEntrada: db "%lf", 0
    formaSaida: db "%lf", 10, 0 ; newline, nul terminator

section .bss

    f1: resq 1
    f2: resq 1

section .text
    
    global main 
    extern scanf 
    extern printf     

main:


    push message1
    call printf

    add esp, 4 
    push f1
    push formaEntrada 
    call scanf
    add esp, 8 

    push message2
    call printf
    add esp, 4 

    push f2
    push formaEntrada
    call scanf
    add esp, 8

    fld qword[f1]
    sub esp, 8
    fst qword[esp]
    push formaSaida
    call printf
    add esp, 12

    fld qword[f2]
    sub esp, 8
    fst qword[esp]
    push formaSaida
    call printf
    add esp, 12


    mov eax,1
    mov ebx,0
    int 80h