;NOTA YA IMPRIME NUMEROS MAYORES DE UN DIGITO PERO SOLO ACEPTA DEL 1 al 9 xd
section .data
    prompt db "Introduce un número del 1 al 9: ", 0
    result_msg db "El resultado es: ", 0
    newline db 10, 0

section .bss
    num resb 1       ; espacio para almacenar el número ingresado
    num_res resb 3   ; espacio para almacenar el número convertido a string (hasta 3 caracteres)

section .text
    global _start

_start:
    ; Mostrar el mensaje "Introduce un número: "
    mov eax, 4       ; syscall write
    mov ebx, 1       ; salida estándar
    mov ecx, prompt  ; dirección del mensaje
    mov edx, 32      ; longitud correcta del mensaje
    int 0x80

    ; Leer un número del usuario
    mov eax, 3       ; syscall read
    mov ebx, 0       ; entrada estándar
    mov ecx, num     ; dirección donde se almacenará el número
    mov edx, 1       ; leer 1 byte (un dígito)
    int 0x80

    ; Convertir el carácter leído a un número
    sub byte [num], '0'

    ; Validar si es un dígito válido (0-9)
    cmp byte [num], 0
    jl error          ; si es menor que 0, error
    cmp byte [num], 9
    jg error          ; si es mayor que 9, error

    ; Multiplicar por 2
    mov al, [num]     ; cargar el número en AL
    shl al, 1         ; multiplicar por 2 usando desplazamiento de bits

    ; Convertir el resultado a ASCII (manejar números mayores a 9)
    cmp al, 10        ; ¿El resultado es mayor o igual a 10?
    jl one_digit      ; si no, es un dígito simple

    ; Si el resultado tiene dos dígitos, convertirlos a ASCII
    mov bl, 10
    div bl            ; dividir AL por 10 (resultado en AL, resto en AH)
    add al, '0'       ; convertir cociente a ASCII
    mov [num_res], al ; almacenar el primer dígito
    mov al, ah        ; cargar el resto
    add al, '0'       ; convertir a ASCII
    mov [num_res + 1], al
    mov byte [num_res + 2], 0 ; finalizar con nulo
    jmp display_result

one_digit:
    add al, '0'       ; convertir el resultado a ASCII
    mov [num_res], al ; almacenar el carácter en num_res
    mov byte [num_res + 1], 0 ; finalizar con nulo

display_result:
    ; Mostrar mensaje "El resultado es: "
    mov eax, 4
    mov ebx, 1
    mov ecx, result_msg
    mov edx, 16
    int 0x80

    ; Mostrar el número multiplicado por 2
    mov eax, 4
    mov ebx, 1
    mov ecx, num_res
    mov edx, 2        ; longitud máxima del resultado
    int 0x80

    ; Imprimir una nueva línea
    mov eax, 4
    mov ebx, 1
    mov ecx, newline
    mov edx, 1
    int 0x80

    ; Salir del programa
    mov eax, 1
    xor ebx, ebx
    int 0x80

error:
    ; Mostrar mensaje de error si no es un número válido
    mov eax, 4
    mov ebx, 1
    mov ecx, newline
    mov edx, 1
    int 0x80
    jmp _start


