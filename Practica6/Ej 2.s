# Escriba un programa que utilice sucesivamente dos subrutinas: ingreso y muestra
# Establezca el pasaje de parámetros entre subrutinas respetando las convenciones para el uso de los 
# registros y minimice las detenciones del cauce (ejercicio similar al ejercicio 6 de Práctica 2). 

.data
CONTROL: .word 0x10000
DATA: .word 0x10008
NUMERO: .word 0
textoUno: .asciiz "Uno"
textoDos: .asciiz "Dos"
textoTres: .asciiz "Tres"
textoCuatro: .asciiz "Cuatro"
textoCinco: .asciiz "Cinco"
textoSeis: .asciiz "Seis"
textoSiete: .asciiz "Siete"
textoOcho: .asciiz "Ocho"
textoNueve: .asciiz "Nueve"
textoError: .asciiz "Error"

.code

jal ingreso
jal muestra
halt

ingreso:
    # Solicita el ingreso por teclado de un número entero (de un dígito)
    # Verifica que el valor ingresado realmente sea un dígito
   
    lw $s0, CONTROL($zero)
    lw $s1, DATA($zero)
   
    daddi $t1,$zero,8
    daddi $t2,$zero,30; Ascii 0
    daddi $t3,$zero,39; Ascii 9
    sd $t1,0($s0); lee un caracter
    lbu $t1, 0($s1); tomo el caracter en $t1

    slt $t2, $t1, $t2  # Si el número ingresado es menor que '0', t2 = 1 (debe saltar)
    slt $t3, $t3, $t1 # Si el número '9' es menor que el numero ingresado t2 = 1 ( no debe saltar )
    
    # bnez $t2,noNumero
    # beqz $t3,noNumero
    daddi $t1,$t1,-30   
    sb $t1,NUMERO($zero); guardo el caracter en NUMERO
    jr $ra

muestra:
    daddi $s3,$zero,NUMERO; pongo la direccion de caracter en s3
    ld $t2,NUMERO($zero)
    sd $s3,0($s1); mando la direccion del caracter a data
    daddi $t1,$zero,4
    sd $t1,0($s0); imprimo caracter
    jr $ra

noNumero: 
    # daddi $s3,$zero,textoError; pongo la direccion de caracter en s3
    # dadd $s3,$s3,$t5; pongo la direccion de caracter en s3
    # sd $s3,0($s1); mando la direccion del caracter a data
    # daddi $t1,$zero,4
    # sd $t1,0($s0); imprimo caracter
    halt    