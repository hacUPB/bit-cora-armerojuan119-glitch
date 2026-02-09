# ACTIVIDAD 1
Código ensamblador
```jv
@16384     
D=A    
@0     
A=D  
M=1 
0;JMP 
```

Código c++
```c++
class Program
{
    static void Main()
    {
        int[] RAM = new int[32768]; 
        int A = 16384;
        int D = A;
        A = 0;
        A = D;
        RAM[A] = 1;
        while (true)
        {
    
        }
        
        Console.WriteLine($"Valor escrito en RAM[{16384}] = {RAM[16384]}");
    }
}
```
Programa funcional sin errores, la guía fué clara por lo que se solucionó sin hacer pruebas.

![alt text](<imagenesun2/PROGRAMA1 NINGUN INCONVENIENTE.png>)
# ACTIVIDAD 2
 Código ensamblador
```
@16384 
D=A 
@0 
A=D 
M=-1 
0;JMP 
```
Código c++
```c++
int main() {

    int RAM[32768] = {0}; 

    int A = 0;

    int D = 0;

    A = 16384;

    D = A;

    A = 0;

    A = D;

    RAM[A] = -1;
    
    cout << "✓ Valor escrito en RAM[" << A << "] = " << RAM[A] << endl;
    
    return 0;
}
```
Primera y última predicción, supuse que guardando 15 en A y sumandole después 1 se iba a formar la línea por la cantidad de pixeles. 

![alt text](<imagenesun2/unidad 2 2.png>)

Programa funcional
![alt text](imagenesun2/ejercuni2solve.png)

# ACTIVIDAD 3

```jv


```
