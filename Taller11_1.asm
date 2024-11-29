section .data 
    num1 db 5            ; Se define la variable num1 con el valor 5
    num2 db 11           ; Se define la variable num2 con el valor 11
    result db 0          ; Se define la variable result con valor inicial 0
    message db "Resultado: ", 0 ; Mensaje a mostrar antes del resultado, termina en 0 para indicar fin de cadena

section .bss
    buffer resb 4        ; Reservamos 4 bytes para el buffer que almacenará los datos para imprimir

section .text
    global _start        ; Punto de entrada del programa

; Macro para imprimir una cadena
%macro PRINT_STRING 1
    mov eax, 4            ; Llamada al sistema (sistema de escritura, número 4)
    mov ebx, 1            ; Descriptor de archivo (1 para stdout)
    mov ecx, %1           ; Dirección de la cadena a imprimir (parámetro de la macro)
    mov edx, 13           ; Longitud de la cadena "Resultado: "
    int 0x80              ; Interrupción para ejecutar la llamada al sistema
%endmacro

; Macro para imprimir un número (se asume que es un número entre 0 y 9)
%macro PRINT_NUMBER 1
    mov eax, %1           ; Cargamos el valor del número a imprimir
    add eax, '0'          ; Convertimos el número a su representación ASCII sumando el valor de '0'
    mov [buffer], eax     ; Guardamos el número convertido en el buffer
    mov eax, 4            ; Llamada al sistema (sistema de escritura, número 4)
    mov ebx, 1            ; Descriptor de archivo (1 para stdout)
    mov ecx, buffer       ; Dirección del buffer
    mov edx, 1            ; Longitud de lo que vamos a imprimir (un solo carácter)
    int 0x80              ; Interrupción para ejecutar la llamada al sistema
%endmacro

_start:
    mov al, [num1]        ; Cargamos el valor de num1 (5) en el registro al
    add al, [num2]        ; Sumamos el valor de num2 (11) al valor en al, resultando 16
    mov [result], al      ; Guardamos el resultado de la suma en la variable result

    PRINT_STRING message  ; Llamamos a la macro PRINT_STRING para mostrar
PRINT_NUMBER [result] 

    ; Salir del programa
    mov eax, 1           
    mov ebx, 0           
    int 0x80

