@1
D=A
@0
M=D

@12
M=0

(LOOP)
    @0
    D=M
    @12
    M=D+M
    
    @0
    M=M+1

    @LOOP
    0;JMP
    