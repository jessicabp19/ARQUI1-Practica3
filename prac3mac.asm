;==================== DECLARACION DE MACROS ====================

print macro cadena;*********************************************
mov ah, 09h
mov dx, offset cadena
int 21h
endm

imprimir macro len, fb, fn, y, vc, f, ln, enter;*******************
LOCAL lp, VERFN, VERFB, VERVC, FINISH
print ln
print y

PUSH SI
PUSH AX
xor si, si
lp:
	mov al, [f+si]
	cmp al, 001b
	je VERFB
	cmp al, 100b
	je VERFN
	jmp VERVC
VERFB:
	inc si
	print fb
	cmp si, len
	jb lp
	jmp FINISH

VERFN:
	inc si
	print fn
	cmp si, len
	jb lp
	jmp FINISH

VERVC:;VER VACIO
	inc si
	print vc
	cmp si, len
	jb lp

FINISH:
	POP AX
	POP SI
	print enter

endm


ObtenerTexto macro buffer;------------------
LOCAL CONTINUE, FIN
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