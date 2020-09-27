;==================== INCLUSIÓN DE MACROS ===============================
include prac3mac.asm

;==================== DECLARACION TIPO DE EJECUTABLE ====================
.model small	
.stack 100h		
 			
;==================== DECLARACION DE DATOS ==============================
.data

;VARIABLES GENERALES
encabezadoP1 db 0ah, 0ah, 'UNIVERSIDAD DE SAN CARLOS DE GUATEMALA', 10, 'FACULTAD DE INGENIERIA', 10,13, 'CIENCIAS Y SISTEMAS', 10,13, 'ARQUITECTURA DE COMPUTADORES Y ENSAMBLADORES 1', '$'
encabezadoP2 db 0ah, 'NOMBRE: JESSICA ELIZABETH BOTON PEREZ', 10,13, 'CARNET: 201800535', 10,13, 'SECCION: A', 10,13, 10,13, '$' 
menuOpciones db 0ah, '========== MENU PRINCIPAL ==========', 10,13,'1) Iniciar Juego', 10,13,'2) Cargar Juego', 10,13,'3) Salir', 10,13,10,13,'>','$' 

;VARIABLES INICIAR JUEGO
	msg_nvo db 0ah, 0dh, '********** NUEVO JUEGO **********', 10,13, '$' ;10, TEMPORAL
	y8 db ' 8	|', '$'
	y7 db ' 7	|', '$'
	y6 db ' 6	|', '$'
	y5 db ' 5	|', '$'
	y4 db ' 4	|', '$'
	y3 db ' 3	|', '$'
	y2 db ' 2	|', '$'
	y1 db ' 1	|', '$'
	fb db 'FB|', '$'
	fn db 'FN|', '$'
	rb db 'RB|', '$'
	rn db 'RN|', '$'
	vc db '  |', '$'
	ln db '  	-------------------------', 10,13, '$'
	xcord db 0ah, 0dh, 32,32,32,32,32,32,32,32,'  A  B  C  D  E  F  G  H', 10,13,'$'
	turnoBlancas db 0ah, 0dh, ' > Turno Blancas: ', '$'
	turnoNegras db 0ah, 0dh, ' > Turno Negras: ', '$'
	saltoLinea db 0ah, 0dh, '$'
	salto db 0ah, 0dh, 00h

;000->VACIO 	001->F_BLANCA 	011->REINA_BLANCA 	100->F_NEGRA 	110->REINA_NEGRA
	fila8 db 001b, 000b, 001b, 000b, 001b, 000b, 001b, 000b
	fila7 db 000b, 001b, 000b, 001b, 000b, 001b, 000b, 001b
	fila6 db 001b, 000b, 001b, 000b, 001b, 000b, 001b, 000b
	fila5 db 000b, 111b, 000b, 111b, 000b, 111b, 000b, 111b
	fila4 db 111b, 000b, 111b, 000b, 111b, 000b, 111b, 000b
	fila3 db 000b, 100b, 000b, 100b, 000b, 100b, 000b, 100b
	fila2 db 100b, 000b, 100b, 000b, 100b, 000b, 100b, 000b
	fila1 db 000b, 100b, 000b, 100b, 000b, 100b, 000b, 100b 

	fil8 db 001b, 000b, 001b, 000b, 001b, 000b, 001b, 000b
	fil7 db 000b, 001b, 000b, 001b, 000b, 001b, 000b, 001b
	fil6 db 001b, 000b, 001b, 000b, 001b, 000b, 001b, 000b
	fil5 db 000b, 111b, 000b, 111b, 000b, 111b, 000b, 111b
	fil4 db 111b, 000b, 111b, 000b, 111b, 000b, 111b, 000b
	fil3 db 000b, 100b, 000b, 100b, 000b, 100b, 000b, 100b
	fil2 db 100b, 000b, 100b, 000b, 100b, 000b, 100b, 000b
	fil1 db 000b, 100b, 000b, 100b, 000b, 100b, 000b, 100b 

;DETALLES JUEGO
	turno db 0b
	f1 db 0b
	col1 db 0b
	pos1 db 0b
	f2 db 0b
	col2 db 0b
	pos2 db 0b
	temp db '$'
	bin db 000b
	separadorComa db ','
	separadorPC db ';'
	tipoCoord db 0b
	filaSelec1 db 8 dup(000b)
	filaSelec2 db 8 dup(000b)
	division db '--------------------------------', '$'
	msg_coord1 db '-- Casilla Destino --', 10,13, '$'
	msg_coord2 db '-- Casilla Fuente, Destino --', 10,13, '$'
	msg_movimiento db '-- Movimiento Realizado --', 10,13, '$'
	msg_errorC db '-- Atencion, Coordenadas Erroneas --', 10,13, '$'

;VARIABLES COMANDOS
	comandoExit db 'E','X','I','T','$'
	comandoSave db 'S','A','V','E','$'
	comandoShow db 'S','H','O','W','$'
	extension db '.arq', '$'

	char0 db '0'
	char1 db '1'
	char4 db '4'
	char7 db '7'
	msg_salir db 0ah, 0dh, '-------- PARTIDA FINALIZADA --------', '$'

	msg_guardar db 0ah, 0dh, '-------- GUARDANDO PARTIDA --------', 10,13,'$'
	cinNomArch db 0ah, 0dh, '>Ingrese nombre para guardar: ', '$'
	msg_guardad db 0ah, 0dh, '-------- Partida Guardada Con Exito --------', '$'

	msg_generar db 0ah, 0dh, '-------- GENERANDO ARCHIVO --------', 10,13,'$'
	infoNomArch db 0ah, 0dh, '>Nombre archivo: AETab.html', '$'
	msg_generad db 0ah, 0dh, '--- Visualizacion Generada Con Exito ---', 10,13, '$'

;VARIABLES FICHERO
	guion db ' - '
	bufferHora db 8 dup('0')
	bufferFecha db 8 dup('0')

	rutaArchivo db 100 dup('$')
	bufferLectura db 200 dup('$')
	bufferEscritura db 200 dup('$')
	rutaNomHtml db 'AETab.html', 00h
	handleFichero dw ?
	msmError1 db 0ah,0dh,'Error al abrir archivo','$'
	msmError2 db 0ah,0dh,'Error al leer archivo','$'
	msmError3 db 0ah,0dh,'Error al crear archivo','$'
	msmError4 db 0ah,0dh,'Error al Escribir archivo','$'

;VARIBLES HTML
	inicioHtml db '<html>', 10,13, '<head>', 10,13,9, '<title>201800535</title>', 10,13, '</head>', 10,13, '<body bgcolor=#20D08C>', 10,13,9, '<H1 align="center">', 00h ;20D08C;FED7CE
	cierreH1 db '</H1>', 10,13, 00h
	inicioTabla db 9, '<center>', 10,13, '<table border=0 cellspacing=2 cellpadding=2>', 10,13, 00h ; bgcolor=#005b96
	tr db 9,9, '<tr align=center>', 00h
	ctr db 0ah, 0dh, 9,9, '</tr>', 10,13, 00h
	finHtml db 9, '</table>', 10,13, '</center>', 10,13, '</body>', 10,13, '</html>', 00h
	fichaB db 0ah, 0dh, 9, '		<td bgcolor="brown"><img src="Fb.png" style=max-height:100%; max-width:100%/></td>', 00h
	fichaN db 0ah, 0dh, 9, '		<td bgcolor="brown"><img src="Fn.png" style=max-height:100%; max-width:100%/></td>', 00h
	ReinaB db 0ah, 0dh, 9, '		<td bgcolor="brown"><img src="Rb.png"></td>', 00h
	ReinaN db 0ah, 0dh, 9, '		<td bgcolor="brown"><img src="Rn.png"></td>', 00h
	VacioB db 0ah, 0dh, 9, '		<td bgcolor="white" width=47px; height=125px;></td>', 00h
	VacioN db 0ah, 0dh, 9, '		<td bgcolor="brown" width=47px; height=125px;></td>', 00h

	;VacioB db 0ah, 0dh, '<td bgcolor="white"><img src="Vb.png"></td>', '$'
	;VacioN db 0ah, 0dh, '<td bgcolor="black"><img src="Vn.png"></td>', '$'

;VARIABLES CARGAR JUEGO
	msg_carga db 0ah, 0dh, '-------- CARGANDO JUEGO --------', 10,13, '$'
	cinNomArchCarga db 0ah, 0dh, '>Ingrese nombre para cargar (.arq): ', '$'
	msg_cargad db 0ah, 0dh, '-------- Partida Cargada Con Exito --------', '$'

	m1 db 0ah, 0dh, '-------- 1 --------', '$'
	m2 db 0ah, 0dh, '-------- 2 --------', '$'
	m3 db 0ah, 0dh, '-------- 3 --------', '$'

;==================== DECLARACION DE CODIGO =============================
.code
main proc

	Inicio:
		mov dx, @data
		mov ds, dx
		print encabezadoP1
		print encabezadoP2
		je MenuPrincipal

	MenuPrincipal:
		print menuOpciones
		getChar
		cmp al, '1'
		je NUEVO
		cmp al, '2'
		je CARGAR
		cmp al, '3'
		je SALIR
		;else
		jmp NUEVO

;-----------------------------JUEGO--------------------------------
	
	NUEVO:
		print msg_nvo
		;LIMPIAR
		limpiar SIZEOF fil8, fila8, fil8
		limpiar SIZEOF fil8, fila7, fil7
		limpiar SIZEOF fil8, fila6, fil6
		limpiar SIZEOF fil8, fila5, fil5
		limpiar SIZEOF fil8, fila4, fil4
		limpiar SIZEOF fil8, fila3, fil3
		limpiar SIZEOF fil8, fila2, fil2
		limpiar SIZEOF fil8, fila1, fil1
		mov turno, 0b
		jmp INGRESAR

	INGRESAR:
		
		imprimir SIZEOF fila8, fb, fn, y8, vc, fila8, ln, saltoLinea
		imprimir SIZEOF fila7, fb, fn, y7, vc, fila7, ln, saltoLinea
		imprimir SIZEOF fila6, fb, fn, y6, vc, fila6, ln, saltoLinea
		imprimir SIZEOF fila5, fb, fn, y5, vc, fila5, ln, saltoLinea
		imprimir SIZEOF fila4, fb, fn, y4, vc, fila4, ln, saltoLinea
		imprimir SIZEOF fila3, fb, fn, y3, vc, fila3, ln, saltoLinea
		imprimir SIZEOF fila2, fb, fn, y2, vc, fila2, ln, saltoLinea
		imprimir SIZEOF fila1, fb, fn, y1, vc, fila1, ln, saltoLinea
		print ln
		print xcord
		print division
		cmp turno, 0b
		je JUG_BLANCAS
		cmp turno, 1b
		je JUG_NEGRAS
		jmp MenuPrincipal

	JUG_BLANCAS:
		print turnoBlancas
		ObtenerTexto bufferLectura
		comparacion1 comandoExit, bufferLectura
		comparacion2 comandoSave, bufferLectura
		comparacion3 comandoShow, bufferLectura
		verifCoord f1, col1, f2, col2, bufferLectura, m1, m2, m3, tipoCoord
		cmp tipoCoord, 0b
		je COORD_T1
		jmp COORD_T2
		;mov turno, 1b
		;jmp INGRESAR

	JUG_NEGRAS:
		print turnoNegras
		ObtenerTexto bufferLectura
		comparacion1 comandoExit, bufferLectura
		comparacion2 comandoSave, bufferLectura
		comparacion3 comandoShow, bufferLectura
		verifCoord f1, col1, f2, col2, bufferLectura, m1, m2, m3, tipoCoord
		cmp tipoCoord, 0b
		je COORD_T1
		jmp COORD_T2
		;mov turno, 0b
		;jmp INGRESAR

	COORD_T1:
		print msg_coord1
		jmp VolverTurno

	COORD_T2:
		print msg_coord2
		obtenerPos col1, pos1
		obtenerPos col2, pos2
		findYAxis1 f1, pos1, f2, pos2, fila8, fila7, fila6, fila5, fila4, fila3, fila2, fila1, turno
		findYAxis2 f1, pos1, f2, pos2, fila8, fila7, fila6, fila5, fila4, fila3, fila2, fila1, turno
		jmp CAMBIAR_TURNO
		;jmp INGRESAR

	CAMBIAR_TURNO:
		cmp turno, 1b
		je A_BLANCAS
		cmp turno, 0b
		je A_NEGRAS

	A_BLANCAS:
		mov turno, 0b
		jmp INGRESAR

	A_NEGRAS:
		mov turno, 1b
		jmp INGRESAR

	VolverTurno:
		cmp turno, 0b
		je JUG_BLANCAS
		cmp turno, 1b
		je JUG_NEGRAS
		jmp MenuPrincipal

;---------------------------COMANDOS-------------------------------
	SAVE:
		print msg_guardar
		print cinNomArch
		getRuta rutaArchivo
		crearF rutaArchivo,handleFichero
		abrirF rutaArchivo,handleFichero

	SAVE_CONT:
		imprimirArq SIZEOF fila8, separadorComa, separadorPC, fila8, char0, char1, char4, char7, handleFichero
		imprimirArq SIZEOF fila7, separadorComa, separadorPC, fila7, char0, char1, char4, char7, handleFichero
		imprimirArq SIZEOF fila6, separadorComa, separadorPC, fila6, char0, char1, char4, char7, handleFichero
		imprimirArq SIZEOF fila5, separadorComa, separadorPC, fila5, char0, char1, char4, char7, handleFichero
		imprimirArq SIZEOF fila4, separadorComa, separadorPC, fila4, char0, char1, char4, char7, handleFichero
		imprimirArq SIZEOF fila3, separadorComa, separadorPC, fila3, char0, char1, char4, char7, handleFichero
		imprimirArq SIZEOF fila2, separadorComa, separadorPC, fila2, char0, char1, char4, char7, handleFichero
		imprimirArq SIZEOF fila1, separadorComa, separadorPC, fila1, char0, char1, char4, char7, handleFichero
		cerrarF handleFichero
		print msg_guardad
		jmp VolverTurno

	SHOW:
		print msg_generar
		print infoNomArch
		crearF rutaNomHtml,handleFichero;INICIA LA GENERACION DEL HTML
		abrirF rutaNomHtml,handleFichero

	SHOW_SUPERIOR:
		escribirF  SIZEOF inicioHtml, inicioHtml, handleFichero
		getDetalleFecha
		getDetalleHora
		escribirF SIZEOF bufferFecha, bufferFecha, handleFichero
		escribirF SIZEOF guion, guion, handleFichero
		escribirF SIZEOF bufferHora, bufferHora, handleFichero
		escribirF SIZEOF cierreH1, cierreH1, handleFichero

	SHOW_MEDIO:
		escribirF SIZEOF inicioTabla, inicioTabla, handleFichero
		imprimirHtml SIZEOF fila8, fichaB, fichaN, fila8, VacioB, VacioN, tr, ctr, handleFichero
		imprimirHtml SIZEOF fila7, fichaB, fichaN, fila7, VacioB, VacioN, tr, ctr, handleFichero
		imprimirHtml SIZEOF fila6, fichaB, fichaN, fila6, VacioB, VacioN, tr, ctr, handleFichero
		imprimirHtml SIZEOF fila5, fichaB, fichaN, fila5, VacioB, VacioN, tr, ctr, handleFichero
		imprimirHtml SIZEOF fila4, fichaB, fichaN, fila4, VacioB, VacioN, tr, ctr, handleFichero
		imprimirHtml SIZEOF fila3, fichaB, fichaN, fila3, VacioB, VacioN, tr, ctr, handleFichero
		imprimirHtml SIZEOF fila2, fichaB, fichaN, fila2, VacioB, VacioN, tr, ctr, handleFichero
		imprimirHtml SIZEOF fila1, fichaB, fichaN, fila1, VacioB, VacioN, tr, ctr, handleFichero

	SHOW_FINAL:
		escribirF  SIZEOF finHtml, finHtml, handleFichero
		cerrarF handleFichero
		print msg_generad
		jmp VolverTurno


;--------------------------CONFIRMACIONES-----------------------------
	CONF_COORD:
		print msg_coord1
		jmp INGRESAR

	MENSAJE:
		;print saltoLinea
		;mov turno, 1b
	    ;print msg_movimiento
	    print m1
	    getChar

	    jmp INGRESAR

	MENSAJE_Corecto:
		;print saltoLinea
		;mov turno, 1b
	    print msg_movimiento
	    getChar

	    jmp INGRESAR
	
;----------------------------ERRORES-------------------------------
	ERROR_COORD:
		print msg_errorC
		jmp VolverTurno ;ACA MODIFIQUE

	ErrorCrear:
	    print msmError3
	    getChar
	    jmp VolverTurno

	ErrorAbrir:
	    print msmError1
	   	getChar
	   	jmp VolverTurno

	ErrorEscribir:
	    print msmError4
	   	getChar
	   	jmp VolverTurno

	ErrorLeer:
	    print msmError2
	   	getChar
	   	jmp VolverTurno

;-----------------------------CARGAR-----------------------------
	CARGAR:
		print msg_carga
		print cinNomArchCarga
		getRuta rutaArchivo
		abrirF rutaArchivo,handleFichero
		leerF SIZEOF bufferLectura, bufferLectura, handleFichero
		;PROCESO DE CARGA
		procesoCarga bufferLectura, fila8, fila7, fila6, fila5, fila4, fila3, fila2, fila1, temp, bin ;f1, col1, f2, col2, bufferLectura;  m1, m2, m3, tipoCoord
		cerrarF handleFichero
		print msg_cargad
		getChar
		mov turno, 0b
		jmp INGRESAR

	SALIR:
		mov ah, 4ch
		int 21h

main endp

Siguiente proc
	AAM
	MOV BX,AX
	MOV DL,BH      ; Since the values are in BX, BH Part
	ADD DL,30H     ; ASCII Adjustment
	MOV bufferFecha[si], DL
	inc si 

	MOV DL,BL      ; BL Part 
	ADD DL,30H     ; ASCII Adjustment
	MOV bufferFecha[si], DL
	inc si 

	ret
Siguiente endp

Sig proc
	AAM
	MOV BX,AX
	MOV DL,BH      ; Since the values are in BX, BH Part
	ADD DL,30H     ; ASCII Adjustment
	MOV bufferHora[si], DL
	inc si 

	MOV DL,BL      ; BL Part 
	ADD DL,30H     ; ASCII Adjustment
	MOV bufferHora[si], DL
	inc si 

	ret
Sig endp

end