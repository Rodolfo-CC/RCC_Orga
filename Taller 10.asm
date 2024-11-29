section .data
    num1 db 5
    num2 db 3
    result db 0
    msg db "Resultado: ", 0
    resultStr db "00", 10
    zeroMsg db "Esto es un cero", 10

section .text
    global _start

_start:
    ; Realizar la suma
    mov al, [num1]
    add al, [num2]
    mov [result], al

    ; Verificar si el resultado es cero
    cmp al, 0
    je print_zero

    ; Convertir el resultado a ASCII
    ; El resultado está en AL (0-18), necesitamos convertirlo
    add al, '0'
    mov [resultStr], al
    mov byte [resultStr + 1], 10

    ; Imprimir mensaje de texto
    mov eax, 4
    mov ebx, 1
    mov ecx, msg
    mov edx, 11
    int 0x80

    ; Imprimir el resultado de la suma
    mov eax, 4
    mov ebx, 1
    mov ecx, resultStr
    mov edx, 2
    int 0x80

    jmp end_program

print_zero:
    ; Imprimir "Esto es un cero"
    mov eax, 4
    mov ebx, 1
    mov ecx, zeroMsg
    mov edx, 17
    int 0x80

end_program:
    ; Terminar el programa
    mov eax, 1
    xor ebx, ebx
    int 0x80