

nasm -f elf -l calculadora.lst calculadora.asm
gcc -m32 calculadora.o -o teste
./teste
