;==================== DECLARACION DE MACROS ====================

print macro cadena;*********************************************
	mov ah, 09h
	mov dx, offset cadena
	int 21h
endm

imprimir macro len, fb, fn, y, vc, f, ln, enter;*******************
	LOCAL DO, VERFN, VERFB, VERVC, FIN, COMPARE
	;print ln
	print y

	PUSH SI
	PUSH AX
	xor si, si
	DO:
		mov al, [f+si]
		cmp al, 001b
		je VERFB
		cmp al, 100b
		je VERFN
		jmp VERVC

	VERFB:
		print fb
		jmp COMPARE
	VERFN:
		print fn
		jmp COMPARE	
	VERVC:
		print vc
		jmp COMPARE

	COMPARE:
		inc si
		cmp si, len
		jb DO
		jmp FIN
	FIN:
		POP AX
		POP SI
		print enter
endm

ObtenerTexto macro buffer;*********************************************
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

getChar macro;*********************************************
	mov ah, 01h
	int 21h
endm

comparacion1 macro comandoE, buffer
	PUSH SI
	PUSH AX
	xor si, si

	mov CX, 50
	mov AX, DS
	mov ES, AX
	lea si, comandoE
	lea di, buffer
	repne cmpsw
	je MenuPrincipal
	;repe cmpsb
	;ja MenuPrincipal	;SE ACTIVA JA CUANDO ES IGUAL
						;SE ACTIVA JB CUANDO ES DISTINTO
	POP AX
	POP SI
endm

verifCoord macro f1, col1, f2, col2, buffer, m1, m2, m3;*******************
	LOCAL DO1, DO2, D03, LETRA1, NUM1, COMA, FIN, COMPARE

	PUSH SI
	PUSH AX
	xor si, si
	DO1:
		mov al, [buffer+si]
		cmp al, 41h
		je LETRA1
		cmp al, 42H
		je LETRA1
		cmp al, 43H
		je LETRA1
		cmp al, 44H
		je LETRA1
		cmp al, 45h
		je LETRA1
		cmp al, 46H
		je LETRA1
		cmp al, 47H
		je LETRA1
		cmp al, 48H
		je LETRA1
		jmp ERROR_COORD

	DO2:
		mov al, [buffer+si]
		cmp al, '0'
		je ERROR_COORD
		cmp al, '9'
		je ERROR_COORD
		jmp NUM1

	LETRA1:
		inc si
		mov col1, al
		jmp DO2

	NUM1:
		inc si
		mov f1, al
		jmp FIN

	COMA:
		print m3
		jmp FIN

	FIN:
		POP AX
		POP SI
endm


comparacion2 macro comandoS, buffer
	PUSH SI
	PUSH AX
	xor si, si

	mov CX, 50
	mov AX, DS
	mov ES, AX

	lea si, comandoS
	lea di, buffer
	repne cmpsw
	je SAVE
	;repe cmpsb
	;ja SAVE	;SE ACTIVA JA CUANDO ES IGUAL

	;xor si, si
	;lea si, comandoS
	;lea di, buffer
	;repe cmpsb
	;ja SAVE				;SE ACTIVA JB CUANDO ES DISTINTO
	POP AX
	POP SI
endm

printChar macro char;*********************************************
	mov ah, 02h
	mov dl, char
	int 21h
endm