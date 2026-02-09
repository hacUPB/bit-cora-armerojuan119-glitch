@16384      
D=A
@pos        
M=D         // pos = 16384

// Dibujar la línea inicial
@pos
A=M
M=-1        // Pantalla[pos] = -1 (todos los píxeles en 1)

(LOOP)
    // Leer el teclado
    @24576      
    D=M         // D = RAM[24576] (código de la tecla)
    
    // Verificar si se presionó 'd' (100 en ASCII)
    @100
    D=D-A       // D = tecla - 100
    @DERECHA
    D;JEQ       // Si D==0, saltar a DERECHA
    
    // Verificar si se presionó 'i' (105 en ASCII)
    @24576
    D=M
    @105
    D=D-A       // D = tecla - 105
    @IZQUIERDA
    D;JEQ       // Si D==0, saltar a IZQUIERDA
    
    // Si no se presionó ninguna tecla válida, volver a LOOP
    @LOOP
    0;JMP

(DERECHA)
    // Borrar la posición actual
    @pos
    A=M
    M=0         // Pantalla[pos] = 0
    
    // Incrementar posición (mover derecha)
    @pos
    M=M+1       // pos = pos + 1
    
    // Dibujar en la nueva posición
    @pos
    A=M
    M=-1        // Pantalla[pos] = -1
    
    // Esperar a que se suelte la tecla
    @WAIT
    0;JMP

(IZQUIERDA)
    // Borrar la posición actual
    @pos
    A=M
    M=0         // Pantalla[pos] = 0
    
    // Decrementar posición (mover izquierda)
    @pos
    M=M-1       // pos = pos - 1
    
    // Dibujar en la nueva posición
    @pos
    A=M
    M=-1        // Pantalla[pos] = -1
    
    // Esperar a que se suelte la tecla
    @WAIT
    0;JMP

(WAIT)
    // Esperar hasta que NO haya ninguna tecla presionada
    @24576
    D=M
    @WAIT
    D;JNE       // Si D != 0 (hay tecla presionada), seguir esperando
    
    // Cuando se suelta la tecla, volver al loop principal
    @LOOP
    0;JMP