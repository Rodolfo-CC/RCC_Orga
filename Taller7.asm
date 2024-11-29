section .data
num1 db 5 ; Define un byte en variable 5
num2 db 11 ; Define un byte con un 11
result db 0 ; Define un resultado de un byte con 0
msg db 'Resultado: ', 0 ; Crea un string con la palabra 'Resultado: '
section .bss
buffer resb 4 ; Reserva 4 bytes para el buffer
section .text
global _start
_start:
mov al, [num1] ; mueve el variable de num1 hacia AL register
add al, [num2] ; agrega el valor de num2 hacia AL register
mov [result], al ; Move result from AL to result variable
; Convertir la letra a ASCII
movzx eax, byte [result] ; Extender a cero el byte del resultado a EAX
add eax, 48 ; Convierte el valor numérico a ASCII ('0' = 48)
mov [buffer], al ; Almacena el caracter ASCII en el buffer
; Para imprimir el mensaje
mov eax, 4 ; Llamada al sistema sys_write
mov ebx, 1 ; Descriptor de fichero 1 (stdout)
mov ecx, msg ; puntero del mensaje
mov edx, 11 ; Tamaño del mensaje
int 0x80 ; Llamar “kernel”
; Para imprimir el resultado
mov eax, 4 ; Llamada al sistema sys_write
mov ebx, 1 ; Descriptor de fichero 1 (stdout)
mov ecx, buffer ; Puntero al buffer
mov edx, 1 ; Tamaño del buffer
int 0x80 ; Llamar “kernel”

; Exit the program
mov eax, 1 ; sys_exit system call
xor ebx, ebx ; Exit status 0
int 0x80 ; Llamar “kernel”