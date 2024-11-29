section .data
msg db 'Caracter: ', 0
newline db 0xA

section .bss

res resb 1 ; Espacio para el carácter

section .text
global _start

_start:

; Paso 1: Configurar el valor de 'l' (ele minúscula)
mov eax, 'l'
mov [res], eax
; Mostrar 'l'
mov eax, 4
mov ebx, 1
mov ecx, res
mov edx, 1
int 0x80

; Paso 2: Configurar el valor de 'D'
mov eax, 'D'
mov [res], eax
; Mostrar 'D'
mov eax, 4
mov ebx, 1
mov ecx, res
mov edx, 1

int 0x80

; Paso 3: Configurar el valor de 'B'
mov eax, 'B'
mov [res], eax
; Mostrar 'B'
mov eax, 4
mov ebx, 1
mov ecx, res
mov edx, 1
int 0x80

; Paso 4: Configurar el valor de '4'
mov eax, '4'
mov [res], eax
; Mostrar '4'
mov eax, 4
mov ebx, 1
mov ecx, res
mov edx, 1
int 0x80

; Paso 5: Configurar el valor de '2'
mov eax, '2'
mov [res], eax
; Mostrar '2'

mov eax, 4
mov ebx, 1
mov ecx, res
mov edx, 1
int 0x80

; Salto de línea
mov eax, 4
mov ebx, 1
mov ecx, newline
mov edx, 1
int 0x80

; Terminar el programa
mov eax, 1
xor ebx, ebx
int 0x80