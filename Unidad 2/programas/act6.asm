// sum = 0
@R1
M=0

// j = 0
@R0
M=0

// base del arreglo = 0
@0
D=A
@R2
M=D

(LOOP)
// if j == 10 goto END
@R0
D=M
@10
D=D-A
@END
D;JEQ

// sum = sum + arr[j]
@R2
D=M
@R0
A=D+M   // A = base + j
D=M     // D = arr[j]
@R1
M=+D M  // sum += arr[j]
s
// j++
@R0
M=M+1

@LOOP
0;JMP

(END)
// resultado final queda en R1 (RAM[1])
