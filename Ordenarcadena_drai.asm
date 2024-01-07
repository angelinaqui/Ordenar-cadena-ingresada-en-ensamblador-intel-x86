title "Tarea 5"	;codigo opcional. Descripcion breve del programa, el texto entrecomillado se imprime como cabecera en cada pagina de codigo
	.model small;directiva de modelo de memoria, small => 64KB para memoria de programa y 64KB para memoria de datos
	.386		;directiva para indicar version del procesador
	.stack 64 	;Define el tamano del segmento de stack, se mide en bytes
imprime macro
	lea dx,[cadena]
	mov ax,0900h
	int 21h
endm
	.data		;Definicion del segmento de datos
msg    db   "Ingresar cadena: ",0Dh,0Ah,"$" ;mensaje a imprimir
cadena db 	100 dup(' '),0Dh,0Ah,"$"        ;cadena ingresada desde el teclado
i      db    ?
j      db    ?
len    db    ?    							;longitud
lenm1  db    ?								;longitud-1
	.code				;segmento de codigo
inicio:					;etiqueta inicio
	mov ax,@data		;AX = directiva @data, @data es una variable de sistema que contiene la direccion del segmento de datos 
	mov ds,ax			;DS = AX, inicializa segmento de datos
	lea dx,[msg]        ;imprimir mensaje
	mov ax,0900h
	int 21h

	mov ah,3fh  		;capturar cadena
	mov bx,00
	mov cx,100
	mov dx, offset[cadena]
	int 21h
	mov bx,0d
	lon: 				 	;iteraciones para determinar la longitud
		mov dl,[cadena+bx]
		mov len,dl
		inc bx
		cmp len,0Dh
		jne lon
		mov len,bl
		dec len
		mov dl,len
		mov lenm1,dl
		dec lenm1
	call bubblesort 		;llamando al procedimiento
	imprime                 ;imprime la cadena

salir:					;inicia etiqueta salir
	mov ah,4Ch			;AH = 4Ch, opcion para terminar programa
	mov al,0        	;AL = 0, Exit Code, codigo devuelto al finalizar el programa
	int 21h	     		;señal 21h de interrupcion, pasa el control al sistema operativo
bubblesort proc
	mov i,1d
	flujo1:             ;inicia for i hasta len
		mov al,i
		mov di,ax
		mov j,0d
		flujo2:         ;inicia for j hasta len-1
			mov bl,j
			mov si,bx
			mov cl,[cadena+si]
			cmp cl,[cadena+si+1]   ;[cadena+si]<[cadena+si+1]?
			jb jfor
			mov dl,[cadena+si+1]   ;intercambiando los valores
			mov [cadena+si],dl
			mov [cadena+si+1],cl
			jfor:
			inc j
			mov bl,j
			cmp bl,lenm1      		;determina si seguir con el ciclo o terminarlo
			jne flujo2
		inc i
		mov al,i
		cmp al,len                  ;determina si seguir con el ciclo o terminarlo
		jne flujo1
	ret
	endp
	end inicio