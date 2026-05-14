@16384
D=A
@0
M=D         

@0
A=M
M=-1

(LOOP)
   
    @24576
    D=M
    
    @LOOP
    D;JEQ
    
    @1
    M=D
    

    @100
    D=D-A
    @MOVER_D
    D;JEQ
    

    @1
    D=M
    @105
    D=D-A
    @MOVER_I
    D;JEQ
    
    @LOOP
    0;JMP

(MOVER_D)

    @0
    A=M
    M=0
    
 
    @0
    M=M+1
    
    @0
    A=M
    M=-1
    
    @ESPERAR
    0;JMP

(MOVER_I)
    @0
    A=M
    M=0
    

    @0
    M=M-1
    

    @0
    A=M
    M=-1
    
    @ESPERAR
    0;JMP

(ESPERAR)
  
    @24576
    D=M
    @ESPERAR
    D;JNE
    
    @LOOP
    0;JMP