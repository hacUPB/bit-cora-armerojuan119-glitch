// Inicializar la primera línea en la posición inicial (fila 0)
@16384      // Dirección base de la pantalla
D=A
@pos        // Variable para guardar la posición actual
M=D

(LOOP)
    // Leer el teclado
    @24576      // Dirección del teclado
    D=M
    
    // Verificar si se presionó 'd' (100 en ASCII)
    @100
    D=D-A
    @MOVER_DERECHA
    D;JEQ
    
    // Verificar si se presionó 'i' (105 en ASCII)
    @24576
    D=M
    @105
    D=D-A
    @MOVER_IZQUIERDA
    D;JEQ
    
    @LOOP
    0;JMP

(MOVER_DERECHA)
    // Borrar posición actual
    @pos
    A=M
    M=0
    
    // Incrementar posición
    @pos
    M=M+1
    
    // Dibujar en nueva posición
    @pos
    A=M
    M=-1
    
    @ESPERAR_SOLTAR
    0;JMP

(MOVER_IZQUIERDA)
    // Borrar posición actual
    @pos
    A=M
    M=0
    
    // Decrementar posición
    @pos
    M=M-1
    
    // Dibujar en nueva posición
    @pos
    A=M
    M=-1
    
    @ESPERAR_SOLTAR
    0;JMP

(ESPERAR_SOLTAR)
    @24576
    D=M
    @ESPERAR_SOLTAR
    D;JNE
    
    @LOOP
    0;JMP