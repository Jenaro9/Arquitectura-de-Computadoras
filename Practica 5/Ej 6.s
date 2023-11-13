# 6) Como ya se observó anteriormente, muchas instrucciones que normalmente forman parte del repertorio de un
# procesador con arquitectura CISC no existen en el MIPS64. En particular, el soporte para la invocación a subrutinas
# es mucho más simple que el provisto en la arquitectura x86 (pero no por ello menos potente). El siguiente programa
# muestra un ejemplo de invocación a una subrutina. 

 .data
valor1: .word 16
valor2: .word 4
result: .word 0

 .text
ld $a0, valor1($zero)
ld $a1, valor2($zero)
jal a_la_potencia
sd $v0, result($zero)
halt
a_la_potencia: daddi $v0, $zero, 1
 lazo: slt $t1, $a1, $zero
bnez $t1, terminar
daddi $a1, $a1, -1
dmul $v0, $v0, $a0
j lazo
 terminar: jr $ra 


# a) ¿Qué hace el programa? ¿Cómo está estructurado el código del mismo?
# el programa utiliza 2 valores (valor1) y (valor2), elevando el primero al segundo en los registros $a0 y $a1
# b) ¿Qué acciones produce la instrucción jal? ¿Y la instrucción jr?
# la instruccion realiza un salto a una dirección de memoria específicay guarda la dirección de retorno en $ra 
# jr Realiza un salto a la dirección almacenada en un registro
# c) ¿Qué valor se almacena en el registro $ra? ¿Qué función cumplen los registros $a0 y $a1? ¿Y el registro $v0?
# $ra (registro de retorno): Almacena la dirección de retorno cuando se realiza una llamada a una subrutina mediante jal.
# $a0 y $a1: Registros de argumentos. Se utilizan para pasar parámetros a subrutinas.
# $v0: Registro de valores de retorno. Se utiliza para almacenar el resultado de una subrutina.
# d) ¿Qué sucedería si la subrutina a_la_potencia necesitara invocar a otra subrutina para realizar la multiplicación,
# por ejemplo, en lugar de usar la instrucción dmul? ¿Cómo sabría cada una de las subrutinas a que dirección de
# memoria deben retornar?
# Si la subrutina a_la_potencia necesitara invocar otra subrutina para realizar la multiplicación, 
# la dirección de retorno se guardaría en el registro $ra antes de realizar la llamada (jal). 
# La subrutina invocada también debería seguir el mismo protocolo, 
# guardando su propia dirección de retorno en $ra antes de realizar su llamada.

