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
;000->VACIO 	001->F_BLANCA 	011->REINA_BLANCA 	100->F_NEGRA 	110->REINA_NEGRA
fila8 db 001b, 000b, 001b, 000b, 001b, 000b, 001b, 000b
fila7 db 000b, 001b, 000b, 001b, 000b, 001b, 000b, 001b
fila6 db 001b, 000b, 001b, 000b, 001b, 000b, 001b, 000b
fila5 db 000b, 000b, 000b, 000b, 000b, 000b, 000b, 000b
fila4 db 000b, 000b, 000b, 000b, 000b, 000b, 000b, 000b
fila3 db 000b, 100b, 000b, 100b, 000b, 100b, 000b, 100b
fila2 db 100b, 000b, 100b, 000b, 100b, 000b, 100b, 000b
fila1 db 000b, 100b, 000b, 100b, 000b, 100b, 000b, 100b 
;DETALLES JUEGO
turno db 0b
f1 db 0b
col1 db 0b
f2 db 0b
col2 db 0b
division db '--------------------------------', '$'
msg_errorC db '-- Atencion, Coordenadas Erroneas --', 10,13, '$'
;VARIABLES COMANDOS
comandoExit db 'E','X','I','T','$'
comandoSave db 'S','A','V','E','$'
comandoShow db 'S','H','O','W','$'
extension db '.arq', '$'
msg_salir db 0ah, 0dh, '-------- PARTIDA FINALIZADA --------', '$'

msg_guardar db 0ah, 0dh, '-------- GUARDANDO PARTIDA --------', 10,13,'$'
cinNomArch db 0ah, 0dh, '>Ingrese nombre para guardar: ', '$'
msg_guardad db 0ah, 0dh, '-------- ¡Partida Guardada Con Exito! --------', '$'

msg_generar db 0ah, 0dh, '-------- GENERANDO ARCHIVO --------', 10,13,'$'
infoNomArch db 0ah, 0dh, '>El nombre del archivo es: estadoTablero.html', '$'
msg_generad db 0ah, 0dh, '-------- ¡Visualización Generada Con Exito! --------', '$'

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
msg_carga db 0ah, 0dh, '-------- CARGANDO JUEGO --------', 10,13, '$'
msg6 db 0ah, 0dh, '-------- CARGANDO JUEGO6 --------', '$'

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
		je INGRESAR
		cmp al, '2'
		je CARGAR
		cmp al, '3'
		je SALIR
		;else
		jmp MenuPrincipal

	INGRESAR:
		print msg_nvo
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
		verifCoord f1, col1, f2, col2, bufferLectura, m1, m2, m3 
		mov turno, 1b
		jmp INGRESAR

	JUG_NEGRAS:
		print turnoNegras
		ObtenerTexto bufferLectura
		comparacion1 comandoExit, bufferLectura
		comparacion2 comandoSave, bufferLectura
		comparacion3 comandoShow, bufferLectura
		verifCoord f1, col1, f2, col2, bufferLectura, m1, m2, m3 
		mov turno, 0b
		jmp INGRESAR

	SAVE:
		print msg_guardar
		print cinNomArch
		ObtenerTexto bufferLectura
		;GUARDAD EL .ARQ
		print msg_guardad
		cmp turno, 0b
		je JUG_BLANCAS
		cmp turno, 1b
		je JUG_NEGRAS
		jmp MenuPrincipal

	SHOW:
		print msg_generar
		print infoNomArch
		;GENERACION DEL HTML
		print msg_generad
		cmp turno, 0b
		je JUG_BLANCAS
		cmp turno, 1b
		je JUG_NEGRAS
		jmp MenuPrincipal
		
	ERROR_COORD:
		print msg_errorC
		cmp turno, 0b
		je JUG_BLANCAS
		cmp turno, 1b
		je JUG_NEGRAS
		jmp MenuPrincipal

	CARGAR:
		print msg_carga
		getChar
		jmp MenuPrincipal

	SALIR:
		mov ah, 4ch
		int 21h

main endp

end