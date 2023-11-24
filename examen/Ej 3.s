# implementar un programa para procesar cadenas. Para eso primero debe codificar una subrutina PROCESAR_CADENA  
# que reciba como parámetro las direcciones de dos cadenas de caracteres A y B.  la suburtina debe realizar dos cosas:
# a)Las letras mayúsculas de la cadena a deben convertirse en minúsculas. Los otros caracteres deben dejarse iguales.
# b)Cada vez que se convierte una mayúscula en minúscula debe guardarse la minúscula en la cadena B.
# A su vez al implementar PROCESAR_CADENA,  se debe implementar e invocar a las siguientes subrutinas:
# -ES_MAYU  que recibe como parámetro un carácter y retorna 1 si es una letra mayúscula y 0 en caso contrario
# -CONVERTIR_MINU  que recibe un carácter en mayúscula y devuelve la minúscula correspondiente.
# Por último el programa principal deberá invocar a PROCESAR_CADENA  enviándo los parámetros correspondientes y 
# luego imprimir A y B  con un mensaje de encabezado. Es decir, antes de imprimir la cadena se debe mostrar el mensaje
# “cadena_msj”  (cadena con reemplazos)  y antes de imprimir las letras convertidas se debe mostrar el mensaje 
# “minu_msj” (letras parámetros, la dir del msj del encabezado y la dirección de la cadena a implementar).
# Recordar que en ASCII  el rango de las minúsculas es 61h a 7Ah (97 a 122 en decimal).  
# el de las  mayúsculas es 41h a 5Ah (65 a 90 en decimal).

.data
cad_msg: .asciiz "Cadena con reemplazos: "
minu_msg: .asciiz "Letras convertidas en misnuscula: "
A: .asciiz "Cadena <enTRADa>!!! "
B: .asciiz ""
CONTROL: .word32 0x10000
DATA: .word32 0x10008
.code 
# En el programa principal
    # Llamar a PROCESAR_CADENA con las direcciones correspondientes de las cadenas A y B
    # Imprimir las cadenas A y B con mensajes de encabezado
    # Mostrar "cadena_msj" y la cadena A
    # Mostrar "minu_msj" y las letras convertidas en la cadena B
    lwu $s0,CONTROL($zero)
    lwu $s1,DATA($zero)

    daddi $a0,$zero,A
    daddi $a1,$zero,B

    # Llamar a PROCESAR_CADENA con las direcciones correspondientes de las cadenas A y B
    jal PROCESAR_CADENA

    # Imprimir las cadenas A y B con mensajes de encabezado
    # Mostrar "cadena_msj" y la cadena A
    sd $a0, 0($s1)  # Colocar la dirección de A en DATA
    daddi $t0, $zero, 4  # Función 4: salida de una cadena ASCII
    sd $t0, 0($s0)  # Enviar la función a CONTROL

    # Mostrar "minu_msj" y las letras convertidas en la cadena B
    sd $a1, 0($s1)  # Colocar la dirección de B en DATA
    daddi $t0, $zero, 4  # Función 4: salida de una cadena ASCII
    sd $t0, 0($s0)  # Enviar la función a CONTROL
    
    # Subrutina PROCESAR_CADENA
    PROCESAR_CADENA:
    # Iterar sobre la cadena A
        # Verificar si el carácter actual es mayúscula usando ES_MAYU
        # Si es mayúscula, convertirla a minúscula con CONVERTIR_MINU
        # Guardar la minúscula en la cadena B
    dadd $t2, $zero, $a0    # Puntero al inicio de la cadena A
    dadd $t3, $zero, $a1    # Puntero al inicio de la cadena B

    LOOP:
    lb $t0, 0($t2)         # Cargar un byte de la cadena A
    beqz $t0, FIN          # Si es el final de la cadena, terminar el bucle

    jal ES_MAYU            # Verificar si el byte es una letra mayúscula
    beqz $v0, NO_MAYUSCULA # Si no es mayúscula, saltar a NO_MAYUSCULA

    daddi $a0, $zero, $t0          # Pasar el carácter a CONVERTIR_MINU
    jal CONVERTIR_MINU     # Convertir la letra mayúscula a minúscula
    sb $v0, 0($t3)         # Guardar la letra minúscula en la cadena B

    daddi $t3, $t3, 1      # Mover el puntero de la cadena B


    # Subrutina ES_MAYU
    ES_MAYU:
    # Verificar si el carácter es mayúscula
    # (Implementar la lógica para retornar 1 si es mayúscula y 0 si no lo es)
    # Usar los rangos de ASCII para determinar si es mayúscula
    daddi $t0,$zero,65;Ascii de A
    daddi $t1,$zero,90;Ascii de Z

    slt $t2, $a0, $t0 # Si el carácter es menor que 'A', t2=1 no es mayúscula
    slt $t3, $a0, $t1   # Si el carácter es mayor que 'Z', t3=0 no es mayúscula

    bnez $t2,NO_ES_MAYU  
    beqz $t3,NO_ES_MAYU  

    daddi $v0,$zero,1
    jr $ra

    NO_ES_MAYU:
    daddi $v0,$zero,0
    jr $ra

    # Subrutina CONVERTIR_MINU
    CONVERTIR_MINU:
    daddi $t4, $zero, 32   # Diferencia entre mayúscula y minúscula en ASCII
    dadd $v0, $a0, $t4     # Convertir a minúscula sumando la diferencia
    jr $ra

    FIN:
    jr $ra