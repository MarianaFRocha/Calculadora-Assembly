
;Dados inicializados
section .data

    inicio: db "Trabalho Final de Arquitetura - Calculadora", 10, 0 ; pula a linha

	;numero real
    formaEntrada: db "%lf", 0
    formaSaida: db "%.8lf", 10, 0 ; pula a linha

    ;sinal
    formaSaidaSinal: db "%s", 10, 0 ; pula a linha
    formaSinal: db "%*c%c", 0 

    ;Para o tratamento de erro
    mensagemErroDigito: db "Operacao Invalida", 10, 0 ; pula a linha 

    mensagemDivZero: db "Erro divisao por zero", 10, 0 ; pula a linha
    z: dd 0.0


;Dados não-inicializados
section .bss

    valor1: resq 1
    valor2: resq 1
    sinal: resd 2

section .text
    
    global main         ;inicio do programa

    ;funcoes do C
    extern scanf 
    extern printf

;Programa Principal
main:

	push EBP        ; ponteiro de base
    mov EBP, ESP    ; salva o valor da função de chamada
    pushad          ; armazenar o conteúdo dos registradores de uso geral na pilha

    ;imprime na tela mesagem inicial
    push inicio     
    call printf

    ;le o primeiro valor digitado pelo usuario
    push valor1
    push formaEntrada 
    call scanf
    add esp, 8 

    ;loop até o usuario pressionar o enter
loop:

    ;le o sinal digitado pelo usuario
	push dword sinal
    push formaSinal 
    call scanf

    ;confere o sinal digitado e faz a operacao desejada
    mov eax, dword [sinal]

    cmp	eax,  '+'
	je	soma

	cmp eax, '-'
	je subtracao

	cmp eax, '/'
	je divisao

	cmp eax, '*'
	je multiplicacao

    ;confere se o enter foi precionado
	cmp eax, 0x0a
	je fechar

    ;confere se o sinal precionado existe
	push mensagemErroDigito
	call printf

	jmp loop


;FUNCAO DE SOMA
soma: 

    push valor2
    push formaEntrada
    call scanf
    add esp, 8

    fld qword[valor1]
    fadd qword[valor2]
    fst qword[valor1]

    ;imprime resultado
    sub esp, 8
    fst qword[esp]
    push formaSaida
    call printf
    add esp, 12

    jmp loop

    ret

;FUNCAO DE SUBTRACAO
subtracao: 

    push valor2
    push formaEntrada
    call scanf
    add esp, 8

    fld qword[valor1]
    fsub qword[valor2]
    fst qword[valor1]

    ;imprime resultado
    sub esp, 8
    fst qword[esp]
    push formaSaida
    call printf
    add esp, 12

    jmp loop

    ret

;FUNCAO DE MULTIPLICACAO
multiplicacao:

    push valor2
    push formaEntrada
    call scanf
    add esp, 8

    fld qword[valor1]
    fmul qword[valor2]
    fst qword[valor1]

    ;imprime resultado
    sub esp, 8
    fst qword[esp]
    push formaSaida
    call printf
    add esp, 12

    jmp loop

    ret

;FUNCAO DE DIVISAO
divisao:

	push valor2
    push formaEntrada
    call scanf
    add esp, 8

    ;confere se o valor digitado eh zero
    fld qword[valor2]
    fld qword [z]
	fcomip 
	fstp
	je erroDivisao 

    fld qword[valor1]
    fdiv qword[valor2]
    fst qword[valor1]

    ;imprime resultado 
    sub esp, 8
    fst qword[esp]
    push formaSaida
    call printf
    add esp, 12

    jmp loop

    ret

;FUNCAO QUE IMPRIME MENSAGEM DE ERRO DE DIVISAO POR 0
erroDivisao:

	push mensagemDivZero
	call printf
	jmp divisao

	ret

;FUNCAO PARA FINALIZAR O PROGRAMA
fechar:

	popad   
    mov ESP, EBP
    pop EBP

    mov  eax, 1 ; sys_exit = 1
	int  80H
