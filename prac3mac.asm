;///////////////////////// DECLARACION DE MACROS ////////////////////////


;********************** MACROS PARA MANEJO DE TEXTO ********************
	
	print macro cadena
		mov ah, 09h
		mov dx, offset cadena
		int 21h
	endm

	imprimir macro len, fb, fn, y, vc, f, ln, enter
		LOCAL DO, VERFN, VERFB, VERVC, FIN, COMPARE
		;print ln
		print y

		PUSH SI
		PUSH AX
		xor si, si
		DO:
			mov al, [f+si]		;AQUI
			cmp al, 001b
			je VERFB
			cmp al, 100b
			je VERFN
			jmp VERVC

		COMPARE:
			inc si 				;AQUI
			cmp si, len 		;AQUI
			jb DO
			jmp FIN

		VERFB:
			print fb
			jmp COMPARE
		VERFN:
			print fn
			jmp COMPARE	
		VERVC:
			print vc
			jmp COMPARE

		
		FIN:
			POP AX
			POP SI
			print enter
	endm

	ObtenerTexto macro buffer
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

	getChar macro
		mov ah, 01h
		int 21h
	endm


;********************* MACROS PARA MANEJO DE FICHEROS *******************

	getRuta macro buffer
		LOCAL INICIO,FIN
		xor si,si
		INICIO:
			getChar
			cmp al,0dh
			je FIN
			mov buffer[si],al
			inc si
			jmp INICIO
		FIN:
			mov buffer[si],00h;AÑADIR EL .ARQ
	endm

	crearF macro buffer,handle
		mov ah,3ch
		mov cx,00h
		lea dx,buffer
		int 21h
		mov handle,ax
		jc ErrorCrear
	endm

	abrirF macro ruta,handle
		mov ah,3dh
		mov al,10b
		lea dx,ruta
		int 21h
		mov handle,ax
		jc ErrorAbrir
	endm

	cerrarF macro handle
		mov ah,3eh
		mov handle,bx
		int 21h
	endm

	escribirF macro numbytes,buffer,handle
		mov ah, 40h
		mov bx,handle
		mov cx,numbytes
		lea dx,buffer
		int 21h
		jc ErrorEscribir
	endm


;******************** MACROS PARA OBTENER FECHA Y HORA ******************

	getHora macro bufferHora
		MOV AH,2CH    ; To get System Time
		INT 21H
		MOV AL,CH     ; Hour is in CH
		AAM
		MOV BX,AX
		
		PUSH SI
		PUSH AX
		xor si, si
		MOV DL,BH      ; Since the values are in BX, BH Part
		ADD DL,30H     ; ASCII Adjustment
		MOV bufferHora[si], DL
		inc si 

		MOV DL,BL      ; BL Part 
		ADD DL,30H     ; ASCII Adjustment
		MOV bufferHora[si], DL
		inc si 

		MOV AL, 3ah		; ':'
		MOV bufferHora[si], AL
		POP AX
		POP SI
	endm


;******************* MACROS PARA COMPARACION DE COMANDOS ****************

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
		
		POP AX
		POP SI
	endm

	comparacion3 macro comandoS, buffer
		PUSH SI
		PUSH AX
		xor si, si

		mov CX, 50
		mov AX, DS
		mov ES, AX

		lea si, comandoS
		lea di, buffer
		repne cmpsw
		je SHOW
		
		POP AX
		POP SI
	endm


;******************** MACROS PARA LA JUGABILIDAD *************************

	verifCoord macro f1, col1, f2, col2, buffer, m1, m2, m3
		LOCAL DO1, DO2, DO3, DO4, LETRA1, NUM1, COMA, LETRA2, NUM2, ULTIMO, FIN

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
			cmp al, '1'
			je NUM1
			cmp al, '2'
			je NUM1
			cmp al, '3'
			je NUM1
			cmp al, '4'
			je NUM1
			cmp al, '5'
			je NUM1
			cmp al, '6'
			je NUM1
			cmp al, '7'
			je NUM1
			cmp al, '8'
			je NUM1
			jmp ERROR_COORD

		LETRA1:
			inc si
			mov col1, al
			jmp DO2

		NUM1:
			inc si
			mov f1, al
			jmp COMA

		COMA:
			mov al, [buffer+si]
			cmp al, 2ch;','
			je DO3
			cmp al, 24h;'$'
			je FIN
			jmp ERROR_COORD

		DO3:
			inc si
			mov al, [buffer+si]
			cmp al, 41h
			je LETRA2
			cmp al, 42H
			je LETRA2
			cmp al, 43H
			je LETRA2
			cmp al, 44H
			je LETRA2
			cmp al, 45h
			je LETRA2
			cmp al, 46H
			je LETRA2
			cmp al, 47H
			je LETRA2
			cmp al, 48H
			je LETRA2
			jmp ERROR_COORD

		DO4:
			mov al, [buffer+si]
			cmp al, '1'
			je NUM2
			cmp al, '2'
			je NUM2
			cmp al, '3'
			je NUM2
			cmp al, '4'
			je NUM2
			cmp al, '5'
			je NUM2
			cmp al, '6'
			je NUM2
			cmp al, '7'
			je NUM2
			cmp al, '8'
			je NUM2
			jmp ERROR_COORD

		LETRA2:
			inc si
			mov col2, al
			jmp DO4

		NUM2:
			inc si
			mov f2, al
			jmp ULTIMO

		ULTIMO:
			mov al, [buffer+si]
			cmp al, 24h;'$'
			je FIN
			jmp ERROR_COORD

		FIN:
			POP AX
			POP SI
	endm


;************************* MACROS TEMPORALES *****************************

	printChar macro char
		mov ah, 02h
		mov dl, char
		int 21h
	endm

	