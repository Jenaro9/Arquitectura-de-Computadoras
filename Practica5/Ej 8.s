# *Escriba una subrutina que reciba como parámetros las direcciones del comienzo de dos cadenas terminadas en cero y
# retorne la posición en la que las dos cadenas difieren. En caso de que las dos cadenas sean idénticas, debe retornar -1.
.data
cadena1:    .asciiz "hola"     ; Definir la cadena 1
cadena2:    .asciiz "hola"     ; Definir la cadena 2
result:     .word 0            ; Resultado a almacenar

.code
    daddi   $a0, $0, cadena1   ; Cargar la dirección de cadena1 en $a0
    daddi   $a1, $0, cadena2   ; Cargar la dirección de cadena2 en $a1
    jal     compara             ; Llamada a la subrutina 'compara'
    sd      $v0, result($0)    ; Almacenar el resultado en result
    halt

compara:
    dadd    $v0, $0, $0         ; Inicializar el resultado en $v0
loop:
    lbu     $t0, 0($a0)         ; Cargar el byte actual de cadena1 en $t0
    lbu     $t1, 0($a1)         ; Cargar el byte actual de cadena2 en $t1

    beqz    $t0, fin_a0         ; Si llegamos al final de cadena1, ir a fin_a0
    beqz    $t1, final          ; Si llegamos al final de cadena2, ir a final
    bne     $t0, $t1, final     ; Si los bytes son diferentes, ir a final

    daddi   $v0, $v0, 1         ; Incrementar el resultado si los bytes son iguales
    daddi   $a0, $a0, 1         ; Avanzar al siguiente byte en cadena1
    daddi   $a1, $a1, 1         ; Avanzar al siguiente byte en cadena2
    j       loop                ; Volver al inicio del bucle

fin_a0:
    bnez    $t1, final          ; Si cadena1 llegó al final pero cadena2 no, ir a final
    daddi   $v0, $0, -1         ; Si ambas cadenas son idénticas, establecer el resultado en -1

final:
    jr      $ra                 ; Retornar de la subrutina
