// Inicializar constantes
@1
D=A
@13
M=D        // RAM[13] = 1

@5
D=A
@14
M=D        // RAM[14] = 5

// Inicializar contador = 1
@13
D=M
@10
M=D        // RAM[10] = 1

// Inicializar suma = 0
@11
M=0

(LOOP)
    // suma = suma + contador
    @10
    D=M
    @11
    M=D+M

    // contador = contador + 1
    @10
    M=M+1

    // if contador > 5 goto END
    @10
    D=M
    @14
    D=D-M
    @END
    D;JGT

    // volver al ciclo
    @LOOP
    0;JMP

(END)
    // guardar resultado en RAM[12]
    @11
    D=M
    @12
    M=D

(ENDLOOP)
    @ENDLOOP
    0;JMP
