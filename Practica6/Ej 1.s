# El siguiente programa produce la salida de un mensaje preor teclado en lugar de ser un mensaje fijo. 

.data
CONTROL: .word32 0x10000
DATA: .word32 0x10008
CARACTER: .ascii 

.code   
lwu $s0, CONTROL($zero) ; $s0 = dirección de CONTROL
lwu $s1,DATA($zero);$s1 = dirección de DATA
daddi $s4,$zero,13; s4 = ascii enter

loop:
 daddi $t1,$zero,9

 sd $t1,0($s0); lee un caracter

 lbu $t1, 0($s1); tomo el caracter en $t1

 beq $t1,$s4, fin; si el caraceter tomado es el enter salto a fin

 sb $t1,CARACTER($zero); guardo el caracter en CARACTER

 daddi $s3,$zero,CARACTER; pongo la direccion de caracter en s3

 sd $s3,0($s1); mando la direccion del caracter a data

 daddi $t1,$zero,4
 sd $t1,0($s0); imprimo caracter
 
 j loop

fin:
halt 