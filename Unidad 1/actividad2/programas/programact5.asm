@1
D=A
@0
M=D

(LOOP)
    @5
    D=D-A
    @END
    D;JGT

    // ERROR AQUÍ:
    @0
    M=M+M    // Intenté sumar el contador a sí mismo directamente
    
    @12
    M=M+0    // Intenté sumar RAM[0] a RAM[12] sin usar D
    
    @LOOP
    0;JMP
    