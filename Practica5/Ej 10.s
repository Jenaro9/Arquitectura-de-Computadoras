.data
cadena: .asciiz "Hola Mundo"
vocales: .asciiz 'AEIOUaeiou'
result: .word 0

.code
    daddi $a0, $0, cadena     # Cargar la dirección de la cadena en $a0
    jal contar_vocales        # Llamar a la subrutina para contar vocales
    sd $v0, result($0)        # Almacenar el resultado en result
    halt

contar_vocales:
    dadd $v0, $0, $0          # Inicializar $v0 en 0
    daddi $t0, $0, 0          # Inicializar $t0 en 0

loop:
    lbu $t1, 0($a0)           # Cargar el siguiente carácter de la cadena sin extender el signo
    beqz $t1, fin_cadena      # Si se llegó al final de la cadena, salir del bucle
    jal es_vocal              # Llamar a la subrutina para determinar si es vocal
    beq $v0, $0, no_es_voc    # Si no es vocal, continuar con el siguiente carácter
    daddi $v0, $v0, 1         # Sumar 1 al contador de vocales
    no_es_voc:
        daddi $a0, $a0, 1     # Mover a la siguiente posición de la cadena
        j loop

fin_cadena:
    jr $ra                     # Retornar al programa principal

es_vocal:
    dadd $v0, $0, $0          # Inicializar $v0 en 0
    daddi $t1, $0, 0          # Inicializar $t1 en 0

loop_vocal:
    lbu $t2, vocales($t1)      # Cargar la siguiente vocal de la cadena de vocales
    beqz $t2, fin_vocal       # Si se llegó al final de las vocales, salir del bucle
    beq $t2, $t1, si_es_voc   # Si es vocal, ir a si_es_voc
    daddi $t1, $t1, 1         # Mover a la siguiente posición de la cadena de vocales
    j loop_vocal

si_es_voc:
    daddi $v0, $0, 1           # Si es vocal, establecer $v0 en 1
    jr $ra                     # Retornar a la subrutina llamadora

fin_vocal:
    j loop                     # Retornar al bucle principal
