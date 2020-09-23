;==================== DECLARACION DE MACROS ====================

print macro cadena;*********************************************
mov ah, 09h
mov dx, offset cadena
int 21h
endm

imprimir macro len, fn, fb, y8, vc, f1
mov ah, 09h
lea dx, y8
int 21h

PUSH SI
PUSH AX

xor si, si

lp:
	mov al, [f1+si]
	cmp al, 001b
	je VERFN
	jmp VERVC

VERFN:
	inc si
	print fn
	cmp si, len
	jb lp

VERVC:;VER VACIO
	inc si
	print vc
	cmp si, len
	jb lp

POP AX
POP SI
endm


ObtenerTexto macro buffer;------------------
PUSH SI
PUSH AX

xor si, si
CONTINUE:
getChar
cmp al, 0dh
je FIN
mov buffer[si], al
inc si
jmp CONTINUE

FIN:
mov al, '$'
mov buffer[si], al

POP AX
POP SI
endm

getChar macro;------------------------------
mov ah, 01h
int 21h
endm

printChar macro char;------------------------
mov ah, 02h
mov dl, char
int 21h
endm