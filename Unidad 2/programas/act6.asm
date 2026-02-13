@16
M=1
@17
M=2
@18
M=3
@19
M=4
@20
M=5
@21
M=6
@22
M=7
@23
M=8
@24
M=9
@25
M=10

@sum
M=0

@j
M=0

@ptr
M=16

(LOOP)

@j
D=M
@10
D=D-A
@END
D;JGE      

@ptr
D=M
@j
A=D+M
D=M

@sum
M=M+D

@j
M=M+1

@LOOP
0;JMP

(END)
@END
0;JMP
