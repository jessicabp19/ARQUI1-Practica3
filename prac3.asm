;==================== INCLUSIÓN DE MACROS ===============================
include prac3mac.asm

;==================== DECLARACION TIPO DE EJECUTABLE ====================
.model small	
.stack 100h		
 			
;==================== DECLARACION DE DATOS ==============================
.data
;VARIABLES GENERALES
encabezadoP1 db 0ah, 'UNIVERSIDAD DE SAN CARLOS DE GUATEMALA', 10, 'FACULTAD DE INGENIERIA', 10,13, 'CIENCIAS Y SISTEMAS', 10,13, 'ARQUITECTURA DE COMPUTADORES Y ENSAMBLADORES 1', '$'
encabezadoP2 db 0ah, 'NOMBRE: JESSICA ELIZABETH BOTON PEREZ', 10,13, 'CARNET: 201800535', 10,13, 'SECCION: A', 10,13, 10,13, 10,13, '$' 
menuOpciones db '========== MENU PRINCIPAL ==========', 10,13,'1) Iniciar Juego', 10,13,'2) Cargar Juego', 10,13,'3) Salir', 10,13,10,13,'>','$' 

;VARIABLES INICIAR JUEGO
msg1 db 0ah, 0dh, '--------- NUEVO JUEGO ---------', 10,13,10, '$'
y8 db '8	|', '$'
y7 db '7	|', '$'
y6 db '6	|', '$'
y5 db '5	|', '$'
y4 db '4	|', '$'
y3 db '3	|', '$'
y2 db '2	|', '$'
y1 db '1	|', '$'
fn db 'FN|', '$'
fb db 'FB|', '$'
rn db 'RN|', '$'
rb db 'RB|', '$'
vc db '  |', '$'
linea db 32,32,32,32,'--------------------------', '$'
xcord db 0ah, 0dh, 32,32,32,32,32,'A 	B 	C 	D 	E 	F 	G 	H', '$'
turnoBlancas db 0ah, 0dh, 'Turno Blancas: ', '$'
turnoNegras db 0ah, 0dh, 'Turno Negras: ', '$'
;000->VACIO 	001->F_NEGRA 	011->REINA_NEGRA 	100->F-BLANCA 	110->REINA_BLANCA
fila8 db 001b, 000b, 001b, 000b, 001b, 000b, 001b, 000b
fila7 db 000b, 001b, 000b, 001b, 000b, 001b, 000b, 001b
fila6 db 001b, 000b, 001b, 000b, 001b, 000b, 001b, 000b
fila5 db 000b, 000b, 000b, 000b, 000b, 000b, 000b, 000b 
fila4 db 000b, 000b, 000b, 000b, 000b, 000b, 000b, 000b
fila3 db 000b, 100b, 000b, 100b, 000b, 100b, 000b, 100b
fila2 db 100b, 000b, 100b, 000b, 100b, 000b, 100b, 000b
fila1 db 000b, 100b, 000b, 100b, 000b, 100b, 000b, 100b 

;VARIABLES FICHERO
dia db 3 dup('0')
mes db 3 dup('0')
anio db 5 dup('0')
hora db 3 dup('0')
minuto db 3 dup('0')
rutaArchivo db 100 dup('$')
bufferLectura db 200 dup('$')
bufferEscritura db 200 dup('$')
handleFichero dw ?

;VARIABLES CARGAR JUEGO
separador db 0ah, 0ah, 0dh, '$'
msg2 db 0ah, 0dh, '-------- CARGANDO JUEGO --------', '$'

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
		je INGRESAR
		cmp al, '2'
		je CARGAR
		cmp al, '3'
		je SALIR
		;else
		jmp MenuPrincipal


	INGRESAR:
		print msg1
		imprimir SIZEOF fila8, fn, fb, y8, vc, fila8
		print separador
		getChar
		jmp MenuPrincipal

	CARGAR:
		print msg2
		getChar
		jmp MenuPrincipal

	SALIR:
		mov ah, 4ch
		int 21h

main endp

end