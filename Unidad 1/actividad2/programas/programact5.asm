// --- CÓDIGO CON ERROR FATAL 3 ---
@1
D=A
@0
M=D      // RAM[0] = 1 (Contador)

@12
M=0      // RAM[12] = 0 (Acumulador)

(LOOP)
    @0
    D=M
    @5
    D=D-A
    @END
    D;JGT    // Salida del ciclo (esto está bien)

    // ERROR FATAL AQUÍ:
    @0
    D=A      // <--- ¡ERROR! Estoy guardando el número 0 (la dirección), no el valor de i
    @12
    M=D+M    // sum = sum + 0 (No suma nada o suma la dirección)

    @0
    M=M+1    // i = i + 1
    
    @LOOP
    0;JMP

(END)
    @END
    0;JMP
    