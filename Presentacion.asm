section .data
    prompt db "Introduce un numero: ", 0
    result_msg db "El resultado es: ", 0
    num db 0  ; espacio para almacenar el número ingresado

section .bss
    num_res resb 10  ; espacio para almacenar el número de resultado (convertido a string)

section .text
    global _start

_start:
    ; Mostrar mensaje "Introduce un numero: "
    mov eax, 4         ; código de la llamada al sistema para write
    mov ebx, 1         ; salida estándar (pantalla)
    mov ecx, prompt    ; dirección del mensaje
    mov edx, 19        ; longitud del mensaje
    int 0x80           ; interrupción para llamada al sistema

    ; Leer un número desde la entrada estándar
    mov eax, 3         ; código de la llamada al sistema para read
    mov ebx, 0         ; entrada estándar (teclado)
    mov ecx, num       ; dirección del espacio donde se guardará el número
    mov edx, 2         ; leer hasta 2 bytes (número de 1 dígito)
    int 0x80           ; interrupción para llamada al sistema

    ; Convertir el caracter a un número
    sub byte [num], '0' ; convertir el carácter ASCII a valor numérico

    ; Multiplicar por 2
    mov al, [num]      ; cargar el número en AL
    shl al, 1          ; multiplicar por 2 usando desplazamiento de bits (shift left)

    ; Almacenar el resultado en num_res como texto
    add al, '0'        ; convertir el número a carácter ASCII
    mov [num_res], al  ; almacenar el carácter en num_res

    ; Mostrar mensaje "El resultado es: "
    mov eax, 4         ; código de la llamada al sistema para write
    mov ebx, 1         ; salida estándar (pantalla)
    mov ecx, result_msg; dirección del mensaje
    mov edx, 16        ; longitud del mensaje
    int 0x80           ; interrupción para llamada al sistema

    ; Mostrar el número multiplicado por 2
    mov eax, 4         ; código de la llamada al sistema para write
    mov ebx, 1         ; salida estándar (pantalla)
    mov ecx, num_res   ; dirección del número resultado
    mov edx, 1         ; longitud del número
    int 0x80           ; interrupción para llamada al sistema

    ; Salir del programa
    mov eax, 1         ; código de la llamada al sistema para exit
    xor ebx, ebx       ; código de salida 0
    int 0x80           ; interrupción para llamada al sistema
