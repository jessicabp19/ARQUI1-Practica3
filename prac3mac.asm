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

	imprimirHtml macro len, fb, fn, f, vb, vn, tr, ctr, handleFichero
		LOCAL DO, VERFN, VERFB, VERVB, VERVN, FIN, COMPARE
		PUSH SI
		PUSH AX
		xor si, si
		escribirF SIZEOF tr, tr, handleFichero
		DO:
			mov al, [f+si]		;AQUI
			cmp al, 001b
			je VERFB
			cmp al, 100b
			je VERFN
			cmp al, 000b
			je VERVB
			jmp VERVN
		COMPARE:
			inc si 				;AQUI
			cmp si, len 		;AQUI
			jb DO
			jmp FIN
		VERFB:
			escribirF SIZEOF fb, fb, handleFichero
			jmp COMPARE
		VERFN:
			escribirF SIZEOF fn, fn, handleFichero
			jmp COMPARE	
		VERVB:
			escribirF SIZEOF vb, vb, handleFichero
			jmp COMPARE
		VERVN:
			escribirF SIZEOF vn, vn, handleFichero
			jmp COMPARE
		FIN:
			escribirF SIZEOF ctr, ctr, handleFichero
			POP AX
			POP SI
	endm

	imprimirArq macro len, sc, spc, f, char0, char1, char4, char7, handleFichero
		LOCAL DO, VERFN, VERFB, VERVB, VERVN, FIN, COMPARE
		PUSH SI
		PUSH AX
		xor si, si

		mov al, [f+si]		;AQUI
		cmp al, 001b
		je VERFB
		cmp al, 100b
		je VERFN
		cmp al, 000b
		je VERVB
		jmp VERVN

		DO:
			escribirF SIZEOF sc, sc, handleFichero
			mov al, [f+si]		;AQUI
			cmp al, 001b
			je VERFB
			cmp al, 100b
			je VERFN
			cmp al, 000b
			je VERVB
			jmp VERVN
		COMPARE:
			inc si 				;AQUI
			cmp si, len 		;AQUI
			jb DO
			jmp FIN
		VERFB:
			escribirF SIZEOF char1, char1, handleFichero
			jmp COMPARE
		VERFN:
			escribirF SIZEOF char4, char4, handleFichero
			jmp COMPARE	
		VERVB:
			escribirF SIZEOF char0, char0, handleFichero
			jmp COMPARE
		VERVN:
			escribirF SIZEOF char7, char7, handleFichero
			jmp COMPARE
		FIN:
			escribirF SIZEOF spc, spc, handleFichero
			POP AX
			POP SI
	endm

	obtenerBinario macro col, pos
		LOCAL P1, P2, P3, P4, FIN ; P5, P6, P7, P8,
		mov al, col
		cmp al, '0'
		je P1
		cmp al, '1'
		je P2
		cmp al, '4'
		je P3
		cmp al, '7'
		je P4
		jmp ErrorAbrir
		P1:
			mov pos, 000b
			jmp FIN
		P2:
			mov pos, 001b
			jmp FIN
		P3:
			mov pos, 100b
			jmp FIN
		P4:
			mov pos, 111b
			jmp FIN
		;P5:
		;	mov pos, 100b
		;	jmp FIN
		;P6:
		;	mov pos, 101b
		;	jmp FIN

		FIN:
			;print pos
	endm

	procesoCarga macro buffer, fila8, fila7, fila6, fila5, fila4, fila3, fila2, fila1, temp, bin;, m1, m2, m3, tipoCoord
		LOCAL DO1,DO2,DO3,DO4,DO5,DO6,DO7,DO8, LETRA1,NUM1,SET_INDICE,SET_SUBINDICE,S2,SS2,S3,SS3,S4,SS4, LETRA2,NUM2, S5,SS5,S6,SS6, L3,N3,L4,N4, S7,SS7,S8,SS8, FIN
		PUSH SI
		PUSH AX
		PUSH DI
		xor di, di
		xor si, si
		DO1:
			mov al, buffer[si]
			cmp al, '0'
			je LETRA1
			cmp al, '1'
			je LETRA1
			cmp al, '4'
			je LETRA1
			cmp al, '7'
			je LETRA1
			cmp al, ','
			je SET_INDICE
			cmp al, ';'
			je SET_SUBINDICE
			jmp ERROR_COORD
		LETRA1:
			inc si
			mov temp, al
			obtenerBinario temp, bin
			mov al, bin
			mov fila8[di], al
			inc di
			jmp DO1
		SET_INDICE:
			inc si
			jmp DO1
		SET_SUBINDICE:
			inc si
			xor di, di
			jmp DO2

		DO2:
			mov al, buffer[si]
			cmp al, '0'
			je NUM1
			cmp al, '1'
			je NUM1
			cmp al, '4'
			je NUM1
			cmp al, '7'
			je NUM1
			cmp al, ','
			je S2
			cmp al, ';'
			je SS2
			jmp ERROR_COORD
		NUM1:
			mov temp, al
			obtenerBinario temp, bin
			mov al, bin
			mov fila7[di], al
			inc si
			inc di
			jmp DO2
		S2:
			inc si
			jmp DO2
		SS2:
			inc si
			xor di, di
			jmp DO3	

		DO3:
			mov al, buffer[si]
			cmp al, '0'
			je LETRA2
			cmp al, '1'
			je LETRA2
			cmp al, '4'
			je LETRA2
			cmp al, '7'
			je LETRA2
			cmp al, ','
			je S3
			cmp al, ';'
			je SS3
			jmp ERROR_COORD
		LETRA2:
			mov temp, al
			obtenerBinario temp, bin
			mov al, bin
			mov fila6[di], al
			inc si
			inc di
			jmp DO3
		S3:
			inc si
			jmp DO3
		SS3:
			inc si
			xor di, di
			jmp DO4
		DO4:
			mov al, [buffer+si]
			cmp al, '0'
			je NUM2
			cmp al, '1'
			je NUM2
			cmp al, '4'
			je NUM2
			cmp al, '7'
			je NUM2
			cmp al, ','
			je S4
			cmp al, ';'
			je SS4
			jmp ERROR_COORD
		NUM2:
			mov temp, al
			obtenerBinario temp, bin
			mov al, bin
			mov fila5[di], al
			inc si
			inc di
			jmp DO4
		S4:
			inc si
			jmp DO4
		SS4:
			inc si
			xor di, di
			jmp DO5	

		DO5:
			mov al, buffer[si]
			cmp al, '0'
			je L3
			cmp al, '1'
			je L3
			cmp al, '4'
			je L3
			cmp al, '7'
			je L3
			cmp al, ','
			je S5
			cmp al, ';'
			je SS5
			jmp ERROR_COORD
		L3:
			mov temp, al
			obtenerBinario temp, bin
			mov al, bin
			mov fila4[di], al
			inc si
			inc di
			jmp DO5
		S5:
			inc si
			jmp DO5
		SS5:
			inc si
			xor di, di
			jmp DO6
		DO6:
			mov al, [buffer+si]
			cmp al, '0'
			je N3
			cmp al, '1'
			je N3
			cmp al, '4'
			je N3
			cmp al, '7'
			je N3
			cmp al, ','
			je S6
			cmp al, ';'
			je SS6
			jmp ERROR_COORD
		N3:
			mov temp, al
			obtenerBinario temp, bin
			mov al, bin
			mov fila3[di], al
			inc si
			inc di
			jmp DO6
		S6:
			inc si
			jmp DO6
		SS6:
			inc si
			xor di, di
			jmp DO7

		DO7:
			mov al, buffer[si]
			cmp al, '0'
			je L4
			cmp al, '1'
			je L4
			cmp al, '4'
			je L4
			cmp al, '7'
			je L4
			cmp al, ','
			je S7
			cmp al, ';'
			je SS7
			jmp ERROR_COORD
		L4:
			mov temp, al
			obtenerBinario temp, bin
			mov al, bin
			mov fila2[di], al
			inc si
			inc di
			jmp DO7
		S7:
			inc si
			jmp DO7
		SS7:
			inc si
			xor di, di
			jmp DO8
		DO8:
			mov al, [buffer+si]
			cmp al, '0'
			je N4
			cmp al, '1'
			je N4
			cmp al, '4'
			je N4
			cmp al, '7'
			je N4
			cmp al, ','
			je S8
			cmp al, ';'
			je SS8
			jmp ERROR_COORD
		N4:
			mov temp, al
			obtenerBinario temp, bin
			mov al, bin
			mov fila1[di], al
			inc si
			inc di
			jmp DO8
		S8:
			inc si
			jmp DO8
		SS8:
			inc si
			xor di, di
			jmp FIN	
		FIN:
			POP DI
			POP AX
			POP SI
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
	leerF macro numbytes,buffer,handle
		mov ah,3fh
		mov bx,handle
		mov cx,numbytes
		lea dx,buffer
		int 21h
		jc ErrorLeer
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

	getDetalleFecha macro
		LOCAL getD, getM, getA
		PUSH SI
		PUSH AX
		xor si, si

		MOV AH,2AH    ; To get System Time
		INT 21H
		
		getD:
			MOV AL,DL     ; Hour is in CH
			CALL Siguiente
			MOV AL, 2fh		; '/'
			MOV bufferFecha[si], AL
			inc si
		getM:
			MOV AL,DH     ; Minutes is in CL
			CALL Siguiente
			MOV AL, 2fh		; '/'
			MOV bufferFecha[si], AL
			inc si
		getA:
			MOV AL,DH     ; Seconds is in DH
			ADD CX,0F830H ; To negate the effects of 16bit value,
			MOV AX,CX     ; since AAM is applicable only for AL (YYYY -> YY)
			CALL Siguiente

		POP AX
		POP SI
	endm

	getDetalleHora macro
		LOCAL getH, getM, getS
		PUSH SI
		PUSH AX
		xor si, si

		MOV AH,2CH    ; To get System Time
		INT 21H
		
		getH:
			MOV AL,CH     ; Hour is in CH
			CALL Sig
			MOV AL, 3ah		; ':'
			MOV bufferHora[si], AL
			inc si
		getM:
			MOV AL,CL     ; Minutes is in CL
			CALL Sig
			MOV AL, 3ah		; ':'
			MOV bufferHora[si], AL
			inc si
		getS:
			MOV AL,DH     ; Seconds is in DH
			CALL Sig

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

	verifCoord macro f1, col1, f2, col2, buffer, m1, m2, m3, tipoCoord
		LOCAL DO1, DO2, DO3, DO4, LETRA1, NUM1, COMA, LETRA2, NUM2, ULTIMO, FIN

		PUSH SI
		PUSH AX
		xor si, si
		DO1:
			mov tipoCoord, 0b
			mov al, buffer[si]
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
			xor al, 0
			mov al, buffer[si]
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
			mov al, buffer[si]
			cmp al, 2ch;','
			je DO3
			cmp al, 24h;'$'
			je FIN
			jmp ERROR_COORD

		DO3:
			mov tipoCoord, 1b
			inc si
			mov al, buffer[si]
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

	obtenerPos macro col, pos
		LOCAL P1, P2, P3, P4, P5, P6, P7, P8, FIN

		mov al, col
		cmp al, 41h
		je P1
		cmp al, 42H
		je P2
		cmp al, 43H
		je P3
		cmp al, 44H
		je P4
		cmp al, 45h
		je P5
		cmp al, 46H
		je P6
		cmp al, 47H
		je P7
		cmp al, 48H
		je P8

		P1:
			mov pos, 0b
			jmp FIN
		P2:
			mov pos, 1b
			jmp FIN
		P3:
			mov pos, 10b
			jmp FIN
		P4:
			mov pos, 11b
			jmp FIN
		P5:
			mov pos, 100b
			jmp FIN
		P6:
			mov pos, 101b
			jmp FIN
		P7:
			mov pos, 110b
			jmp FIN
		P8:
			mov pos, 111b
			jmp FIN

		FIN:
			;print pos
	endm

	findYAxis1 macro f1, pos1, f2, col2, fila8, fila7, fila6, fila5, fila4, fila3, fila2, fila1, turno
		LOCAL F8, F7, F6, F5, F4, F3, FIN, F22, F11
		cmp f1, '8'
		je F8
		cmp f1, '7'
		je F7
		cmp f1, '6'
		je F6
		cmp f1, '5'
		je F5
		cmp f1, '4'
		je F4
		cmp f1, '3'
		je F3
		cmp f1, '2'
		je F22
		cmp f1, '1'
		je F11
		jmp INGRESAR

		F8:
			findXAxis1 fila8, pos1, f2, col2, fila8, fila7, fila6, fila5, fila4, fila3, fila2, fila1, turno
			je FIN
		F7:
			findXAxis1 fila7, pos1, f2, col2, fila8, fila7, fila6, fila5, fila4, fila3, fila2, fila1, turno
			je FIN
		F6:
			findXAxis1 fila6, pos1, f2, col2, fila8, fila7, fila6, fila5, fila4, fila3, fila2, fila1, turno
			je FIN
		F5:
			findXAxis1 fila5, pos1, f2, col2, fila8, fila7, fila6, fila5, fila4, fila3, fila2, fila1, turno
			je FIN
		F4:
			findXAxis1 fila4, pos1, f2, col2, fila8, fila7, fila6, fila5, fila4, fila3, fila2, fila1, turno
			je FIN
		F3:
			findXAxis1 fila3, pos1, f2, col2, fila8, fila7, fila6, fila5, fila4, fila3, fila2, fila1, turno
			je FIN
		F22:
			findXAxis1 fila2, pos1, f2, col2, fila8, fila7, fila6, fila5, fila4, fila3, fila2, fila1, turno
			je FIN
		F11:
			findXAxis1 fila1, pos1, f2, col2, fila8, fila7, fila6, fila5, fila4, fila3, fila2, fila1, turno
			je FIN
		FIN:
			;MENSAJE
	endm

	findXAxis1 macro f, pos1, f2, col2, fila8, fila7, fila6, fila5, fila4, fila3, fila2, fila1, turno
		LOCAL VALIDACION1, CompBlanca, CompNegra, M1, FIN, M2
		PUSH SI
		PUSH DX
		xor si, si

		MOV DL, pos1
		MOV DH, 0
		MOV SI, DX
		;je VALIDACION1

		VALIDACION1:
			cmp turno, 0b
			je CompBlanca
			jmp CompNegra

		CompBlanca:
			;mov turno, 1b
			cmp f[si], 001b
			je M1;VALIDACION2
			jmp FIN
		CompNegra:
			;mov turno, 0b
			cmp f[si], 100b
			je M1;VALIDACION2
			jmp FIN

		M1:
			mov f[si], 111b
			jmp M2

		M2:
			findYAxis2 f, pos1, f2, col2, fila8, fila7, fila6, fila5, fila4, fila3, fila2, fila1, turno
			jmp FIN

		FIN:	
			;MENSAJE
			POP DX
			POP SI
	endm

	findYAxis2 macro f, pos1, f1, col2, fila8, fila7, fila6, fila5, fila4, fila3, fila2, fila1, turno
		LOCAL F8, F7, F6, F5, F4, F3, FIN, F22, F11
		cmp f1, '8'
		je F8
		cmp f1, '7'
		je F7
		cmp f1, '6'
		je F6
		cmp f1, '5'
		je F5
		cmp f1, '4'
		je F4
		cmp f1, '3'
		je F3
		cmp f1, '2'
		je F22
		cmp f1, '1'
		je F11
		jmp INGRESAR

		F8:
			findXAxis2 fila8, pos1, f2, col2, fila8, fila7, fila6, fila5, fila4, fila3, fila2, fila1, turno
			je FIN
		F7:
			findXAxis2 fila7, pos1, f2, col2, fila8, fila7, fila6, fila5, fila4, fila3, fila2, fila1, turno
			je FIN
		F6:
			findXAxis2 fila6, pos1, f2, col2, fila8, fila7, fila6, fila5, fila4, fila3, fila2, fila1, turno
			je FIN
		F5:
			findXAxis2 fila5, pos1, f2, col2, fila8, fila7, fila6, fila5, fila4, fila3, fila2, fila1, turno
			je FIN
		F4:
			findXAxis2 fila4, pos1, f2, col2, fila8, fila7, fila6, fila5, fila4, fila3, fila2, fila1, turno
			je FIN
		F3:
			findXAxis2 fila3, pos1, f2, col2, fila8, fila7, fila6, fila5, fila4, fila3, fila2, fila1, turno
			je FIN
		F22:
			findXAxis2 fila2, pos1, f2, col2, fila8, fila7, fila6, fila5, fila4, fila3, fila2, fila1, turno
			je FIN
		F11:
			findXAxis2 fila1, pos1, f2, col2, fila8, fila7, fila6, fila5, fila4, fila3, fila2, fila1, turno
			je FIN
		FIN:
			;je MENSAJE
	endm

	findXAxis2 macro f, pos1, f2, col2, fila8, fila7, fila6, fila5, fila4, fila3, fila2, fila1, turno
		LOCAL VALIDACION1, CompBlanca, CompNegra, M1, FIN, M2
		PUSH SI
		PUSH DX
		xor si, si

		MOV DL, col2
		MOV DH, 0
		MOV SI, DX
		;je VALIDACION1

		VALIDACION1:
			cmp turno, 0b
			je CompBlanca
			jmp CompNegra

		CompBlanca:
			;mov turno, 1b;***************************************************
			mov f[si], 001b
			jmp FIN

		CompNegra:
			;mov turno, 0b;***************************************************
			mov f[si], 100b
			;mov turno, 0b
			jmp FIN

		M1:
			;mov f[si], 111b
			;jmp M2

		M2:
			;findYAxis2 f, pos1, f2, col2, fila8, fila7, fila6, fila5, fila4, fila3, fila2, fila1, turno
			;jmp FIN

		FIN:	
			;MENSAJE_Correcto
			POP DX
			POP SI
	endm