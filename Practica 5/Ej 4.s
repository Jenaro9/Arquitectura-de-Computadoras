#  El índice de masa corporal (IMC) es una medida de asociación entre el peso y la talla de un individuo.
# Se calcula a partir del peso (expresado en kilogramos, por ejemplo: 75,7 kg) y la estatura (expresada en metros,
# por ejemplo 1,73 m), usando la fórmula:
# IMC = peso / (estatura)^2


.data
peso:       .double 75.7
altura:     .double 1.73
imc:        .double 0.0
estado:     .word   0
infrapeso:  .double 18.5
normal:     .double 25.0
sobrepeso:  .double 30.0

.code
l.d     f1, peso($zero)       # Cargar el peso en f1
l.d     f2, altura($zero)     # Cargar la altura en f2
l.d     f3, imc($zero)        # Cargar la dirección de memoria de imc en f3
l.d     f10, infrapeso($zero) # Cargar el límite inferior de peso normal en f10
l.d     f11, normal($zero)    # Cargar el límite superior de peso normal en f11
l.d     f12, sobrepeso($zero) # Cargar el límite inferior de sobrepeso en f12

mul.d f2, f2, f2            # Calcular la estatura al cuadrado
div.d f3, f1, f2            # Calcular el IMC: peso / (estatura)^2
s.d f3, imc($zero)          # Almacenar el resultado en la dirección de memoria apuntada por f3

c.lt.d  f3, f10             # Comparar con límite inferior de peso normal
bc1f normal            # Saltar a siguiente si no se cumple la condición
daddi $v0, $zero, 1         # Asignar 1 (Infrapeso)
j fin                       # Saltar a fin

normal: c.lt.d f3, f11
bc1f sobrepeso
daddi $v0, $zero, 2         # Asignar 2 (Normal)
j fin                       # Saltar a fin

sobrepeso: c.lt.d f3, f12
bc1f obeso
daddi $v0, $zero, 3         # Asignar 3 (Sobrepeso)
j fin                       # Saltar a fin

obeso:
daddi $v0, $zero, 4         # Asignar 4 (Obeso)

fin:
sw $v0, estado($zero)       # Almacenar el estado en la dirección de memoria estado
halt
