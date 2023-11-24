# implementar un programa para procesar cadenas. Para eso primero debe codificar una subrutina PROCESAR_CADENA  que reciba como parámetro las direcciones de dos cadenas de caracteres A y B.  la subutina debe realizar dos cosas:
# Las letras mayúsculas de la cadena a deben convertirse en minúsculas. Los otros caracteres deben dejarse iguales.
# Cada vez que se convierte una mayúscula en minúscula debe guardarse la minúscula en la cadena B.
# A su vez al implementar PROCESAR_CADENA,  se debe implementar e invocar a las siguientes subrutinas:
# 	-ES_MAYU  que recibe como parámetro un carácter y retorna 1 si es una letra mayúscula y 0 en caso contrario
# 	-CONVERTIR_MINU  que recibe un carácter en mayúscula y devuelve la minúscula correspondiente.
#  Por último el programa principal deberá invocar a PROCESAR_CADENA  enviándo los parámetros correspondientes y luego imprimir A y B  con un mensaje de encabezado. Es decir, antes de imprimir la cadena se debe mostrar el mensaje “cadena_msj”  (cadena con reemplazos)  y antes de imprimir las letras convertidas se debe mostrar el mensaje “minu_msj” (letras parámetros, la dir del msj del encabezado y la dirección de la cadena a implementar).
# Recordar que en ASCII  el rango de las minúsculas es 61h a 7Ah (97 a 122 en decimal).  el de las  mayúsculas es 41h a 5Ah (65 a 90 en decimal).

.data
cad_msg: .asciiz "Cadena con reemplazos: "
minu_msg: .asciiz "Letras convertidas en minuscula: "
A: .asciiz "Cadena <enTRADa>!!! "
B: .asciiz ""
CONTROL: .word 0x10000
DATA: .word 0x10008

.code 
    # Inicialización de registros y llamada a PROCESAR_CADENA
    daddi $sp, $zero, 0x400
    lw $s0, CONTROL($zero)
    lw $s1, DATA($zero)
    daddi $a0, $zero, A
    daddi $a1, $zero, B
    jal PROCESAR_CADENA

    # Imprimir mensajes y cadenas A y B
    daddi $a0, $zero, cad_msg
    daddi $a1, $zero, A
    jal imprimir

    daddi $a0, $zero, minu_msg
    daddi $a1, $zero, B
    jal imprimir

    halt

PROCESAR_CADENA:
    daddi $sp, $sp, -8
    sd $ra, 0($sp)
    dadd $t0, $zero, $a0
    dadd $t1, $zero, $a1

    loop:
        lb $t2, 0($t0)
        beqz $t2, fin_loop

        dadd $a0, $zero, $t2
        jal ES_MAYU
        beqz $v0, no_mayuscula

        jal CONVERTIR_MINU
        sb $v0, 0($t0)
        sb $v0, 0($t1)
        daddi $t1, $t1, 1

        no_mayuscula:
        daddi $t0, $t0, 1
        j loop

   
ES_MAYU:
    daddi $v0, $zero, 0
    slti $t3, $a0, 0x41
    bnez $t3, fin_mayus
    slti $t4, $a0, 0x5B
    beqz $t4, fin_mayus
    daddi $v0, $v0, 1

    fin_mayus:
    jr $ra

CONVERTIR_MINU:
    daddi $v0, $a0, 0x20
    jr $ra

imprimir:
    sd $a0, 0($s1)    # Dirección del mensaje en DATA
    daddi $t0, $zero, 4
    sd $t0, 0($s0)    # Enviar la función a CONTROL

    sd $a1, 0($s1)    # Dirección de la cadena en DATA
    daddi $t0, $zero, 4
    sd $t0, 0($s0)    # Enviar la función a CONTROL

    jr $ra

    fin_loop:
    sb $zero, 0($t1)  # Marcador de final de cadena en B
    sb $zero, 0($t0)  # Marcador de final de cadena en B
    ld $ra, 0($sp)
    daddi $sp, $sp, 8
    jr $ra
