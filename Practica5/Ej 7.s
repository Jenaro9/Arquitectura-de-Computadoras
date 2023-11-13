.data
tabla:  .word   20, 25, 30, 35, 40, 45

.text
    lw      $a0, tabla           # Dirección de la tabla
    daddi   $a1, $0, 34           # Número positivo a comparar
    daddi   $a2, $0, 6            # Cantidad de valores en la tabla
    jal     contar_mayores        # Llamada a la subrutina
    halt

contar_mayores:
    daddi   $v0, $0, 0            # Inicializar el retorno en $v0 a 0
    daddi   $t0, $0, 0            # Inicializar la variable temporal $t0 a 0 (desplazamiento)

loop:
    beqz    $a2, fin              # Salir del bucle si no quedan más valores en la tabla
    lw      $t1, 0($a0)           # Cargar el valor actual de la tabla en $t1
    slt     $t2, $a1, $t1         # Comparar si el número positivo es menor que el valor actual en la tabla
    beqz    $t2, avanza           # Si $t2 es 0, salta a avanza, sino continua
    daddi   $v0, $v0, 1           # Sumar 1 al retorno porque el número positivo es menor que el valor actual en la tabla

avanza:
    daddi   $a0, $a0, 4           # Avanzar al siguiente valor en la tabla (incrementar la dirección en 4 bytes)
    daddi   $a2, $a2, -1          # Restar 1 a $a2 (número de valores restantes en la tabla)
    j       loop                   # Salto incondicional al inicio del bucle

fin:
    jr      $ra                   # Retornar
