// --- Inicialización ---
@1      // Valor inicial
D=A
@0      // Usaremos RAM[0] como contador (i)
M=D

@12     // Usaremos RAM[12] como acumulador (sum)
M=0     // Limpiamos el resultado anterior por si acaso

(LOOP)
    // --- Condición: si i > 5, terminar ---
    @0
    D=M
    @5
    D=D-A    // D = i - 5
    @END_PROCESS
    D;JGT    // Si D > 0 (i > 5), saltar al final

    // --- Sumar: RAM[12] = RAM[12] + i ---
    @0
    D=M      // D = i
    @12
    M=D+M    // sum = sum + i

    // --- Incrementar: i = i + 1 ---
    @0
    M=M+1

    @LOOP
    0;JMP    // Repetir

(END_PROCESS)
    // --- Limpieza: Borrar el contador ---
    @0
    M=0      // Ponemos RAM[0] en 0 para que solo la RAM 12 tenga datos

(INFINITE_LOOP)
    @INFINITE_LOOP
    0;JMP    // Bloqueo final