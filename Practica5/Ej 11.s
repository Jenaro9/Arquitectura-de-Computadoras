# Escribir una subrutina que reciba como argumento una tabla de números terminada en 0. La subrutina debe contar la
# cantidad de números que son impares en la tabla. Ésta condición se debe verificar usando la subrutina ES_IMPAR. La
# subrutina ES_IMPAR debe devolver 1 si el número es impar y 0 si no lo es. 

.data
tabla: .word 3, 8, 12, 15, 20, 23, 0   # Ejemplo de tabla con números
resultado: .word 0                      # Para almacenar el resultado final

.code
    daddi $a0, $0, tabla    # Cargar la dirección de la tabla en $a0
    jal contar_impares       # Llamar a la subrutina para contar impares
fin: sd $v0, resultado($0)   # Guardar el resultado en la dirección de memoria resultado
    halt

contar_impares:
    dadd $v0, $0, $0        # Inicializar $v0 en 0 (contador de impares)
    daddi $t0, $0, 0        # Inicializar $t0 en 0 (índice de la tabla)

    loop:
    lw $t1, 0($a0)          # Cargar el número actual de la tabla
    beqz $t1, fin     # Si es 0, terminar la tabla y el bucle

    jal es_impar            # Llamar a la subrutina ES_IMPAR
    beq $v0, $0, no_impar   # Si no es impar, continuar con el siguiente número

    daddi $v0, $v0, 1       # Incrementar el contador de impares
    no_impar:

    daddi $t0, $t0, 1       # Mover al siguiente número de la tabla
    daddi $a0, $a0, 4       # Mover al siguiente número de la tabla
    j loop

    fin_tabla:
    j fin                  # Retornar al programa principal para guardar el resultado y terminar

    # Subrutina para verificar si un número es impar
    es_impar:
    dadd $v0, $0, $0        # Inicializar $v0 en 0

    andi $v0, $t1, 1        # Hacer AND entre el número y 1
    beqz $v0, par           # Si es 0, el número es par
    daddi $v0, $0, 1        # Si no es 0, establecer $v0 en 1 (es impar)
    jr $ra                  # Retornar a la subrutina llamadora

    par:
    daddi $v0, $0, 0        # Si es 0, el número es par
    jr $ra                  # Retornar a la subrutina llamadora
