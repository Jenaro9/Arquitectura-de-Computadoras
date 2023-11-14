# Usando la subrutina escrita en el ejercicio anterior, escriir la subrutina CONTAR_VOC, que recibe una cadena
# terminada en cero y devuelve la cantidad de vocales que tiene esa cadena. 

.data
letra: .ascii 'O'
vocales: .asciiz 'AEIOUaeiou'
result: .word 0

.code
 lbu $a0, letra($0); CARGO EN A0 EL CARACTER A COMPROBAR
 jal es_vocal
 sd $v0, result($zero); CARGO EN RESULT, EL VALOR RETORNADO DE LA SUBRUTINA
 halt

es_vocal: dadd $v0, $0, $0; INICIALIZO V0 EN 0
 daddi $t0, $0, 0; INICIALIZO T0 EN 0
 loop: lbu $t1, vocales($t0); COMPRUEBO SI NO SE LLEGO AL FIN DE LAS VOCALES 
 beqz $t1, fin_vocal; SI SE LLEGO AL FIN DE VOCALES SALTO A FIN VOCALES
 beq $a0, $t1, si_es_voc; COMPRUEBO LA VOCAL SELECCIONADA CON EL CARACTER A COMPROBAR
 daddi $t0, $t0, 1; MUEVO UNA POSICION PARA IR A LA SEGUNDA VOCAL A COMPROBAR
 j loop
 si_es_voc: daddi $v0, $0, 1; SI ES VOCAL SUMO 1 A V0
 fin_vocal: jr $ra; VUELVO AL PROGRAMA PRINCIPAL
