// ---------- Inicialización ----------

// RAM[13] = 1
@1
D=A
@13
M=D

// RAM[14] = 5
@5
D=A
@14
M=D

// contador = 1
@13
D=M
@10
M=D

// suma = 0
@11
M=0

// ---------- Ciclo ----------
(LOOP)
    // suma = suma + contador
    @10
    D=M
    @11
    M=M+D

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

    // volver al inicio del ciclo
    @LOOP
    0;JMP

// ---------- Fin ----------
(END)
    @11
    D=M
    @12
    M=D

(ENDLOOP)
    @ENDLOOP
    0;JMP
