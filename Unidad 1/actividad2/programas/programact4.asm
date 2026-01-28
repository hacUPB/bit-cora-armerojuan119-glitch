@5
D=M        // D = valor en memoria 5

@10
D=D-A      // D = mem[5] - 10

@MENOR
D;JLT      // si D < 0, mem[5] < 10, saltar

// Caso: mayor o igual a 10
@0
D=A
@7
M=D        // mem[7] = 0
@FIN
0;JMP

(MENOR)
// Caso: menor que 10
@1
D=A
@7
M=D        // mem[7] = 1

(FIN)
