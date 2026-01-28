// Inicialización
@i
M=1      // i = 1 (Contador)
@sum
M=0      // sum = 0 (Acumulador)

(LOOP)
    // Comprobar si i > 5
    @i
    D=M
    @5
    D=D-A    // D = i - 5
    @WRITE_RESULT
    D;JGT    // Si (i - 5) > 0, saltar a guardar resultado

    // Sumar: sum = sum + i
    @i
    D=M
    @sum
    M=D+M

    // Incrementar: i = i + 1
    @i
    M=M+1

    @LOOP
    0;JMP    // Repetir ciclo

(WRITE_RESULT)
    @sum
    D=M
    @12
    M=D      // Guardar el total en RAM[12]

(END)
    @END
    0;JMP    // Bucle infinito de seguridad
