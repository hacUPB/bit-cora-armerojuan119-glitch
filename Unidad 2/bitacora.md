# ACTIVIDAD 1
## Código act1 ensamblador
```As
@16384     
D=A    
@0     
A=D  
M=1 
0;JMP 
```

## Código act1 c++
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
## programa funiconal
Programa funcional sin errores, la guía fué clara por lo que se solucionó sin hacer pruebas.

![alt text](<imagenesun2/PROGRAMA1 NINGUN INCONVENIENTE.png>)
# ACTIVIDAD 2
## Código act2 ensamblador
```As
@16384 
D=A 
@0 
A=D 
M=-1 
0;JMP 
```
## Código act2 c++
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

### Programa funcional
![alt text](imagenesun2/ejercuni2solve.png)

# ACTIVIDAD 3
## Código act3 ensamblador

```As
@20000
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

```
## Código act3 c++

```C++
using namespace std;

int main() {
    
    int RAM[32768] = {0};      
    const int SCREEN_START = 16384;  
    const int KEYBOARD = 24576;      
    
    int A = 0;
    int D = 0;

    D = SCREEN_START;
    RAM[0] = D;
    
    A = RAM[0];
    RAM[A] = -1;
    
    cout << "=== Simulador de Línea Horizontal ===" << endl;
    cout << "Presiona 'd' para mover a la DERECHA" << endl;
    cout << "Presiona 'i' para mover a la IZQUIERDA" << endl;
    cout << "Presiona 'q' para SALIR" << endl;
    cout << "\nPosición inicial: " << RAM[0] << endl;
    cout << "RAM[" << RAM[0] << "] = " << RAM[RAM[0]] << "\n" << endl;
    
    while (true) {
    
        if (_kbhit()) {
            char tecla = _getch();
            
            D = (int)tecla;
            
            if (tecla == 'q' || tecla == 'Q') {
                cout << "\n¡Programa terminado!" << endl;
                break;
            }
            
            RAM[1] = D;
            
            D = D - 100;
            if (D == 0) {

                A = RAM[0];
                RAM[A] = 0;
                
                RAM[0] = RAM[0] + 1;
                
                A = RAM[0];
                RAM[A] = -1;
                
                cout << "→ DERECHA | Posición: " << RAM[0] 
                     << " | RAM[" << RAM[0] << "] = " << RAM[RAM[0]] << endl;
                
                while (_kbhit()) {
                    _getch();
                }
                Sleep(150);
                continue;
            }
            
            D = RAM[1];
            D = D - 105;
            if (D == 0) {

                A = RAM[0];
                RAM[A] = 0;
                
                RAM[0] = RAM[0] - 1;
                

                A = RAM[0];
                RAM[A] = -1;
                
                cout << "← IZQUIERDA | Posición: " << RAM[0] 
                     << " | RAM[" << RAM[0] << "] = " << RAM[RAM[0]] << endl;
                
                while (_kbhit()) {
                    _getch(); 
                }
                Sleep(150);
                continue;
            }
        }
    }
    
    return 0;
}

```
Programa definitivo funcional

![alt text](<imagenesun2/programa 3 def.png>)

Predicciones
- 1. La línea debería borrarse de RAM[16384] y aparecer en RAM[16385].

![alt text](<imagenesun2/cambio de valor.png>)

Observar: La línea se movió correctamente.

Reflexión: El orden es crítico: primero borrar, luego incrementar, luego dibujar.

- 2. Al presionar 'i', debería moverse a la izquierda.

![alt text](<imagenesun2/error mov.png>)

Predicción: Al presionar 'i', D = 0 después de la resta.

Ejecución: D = -5 

Observación: ¡El salto NO ocurre!

Reflexión: ERROR, D ya había sido modificado en la comparación anterior con 'd'. 

Necesito volver a leer RAM[24576] o usar RAM[1].

- 3. borrador con lo necesario para mover con cualquier tecla  la derecha.

![alt text](<imagenesun2/intento act3.png>)

# actividad 4




















# actividad 5
## traducción programa 1.
```As
@10
D=A
@16        
M=D       
@16        
D=A        
M=D        

@20
D=A        
@17        
A=M        
M=D      
(END)
@END
0;JMP 

```
### Paso a paso
- PASO 1: Crear variable a = 10

PREDICCIÓN: La variable a debe valer 10

EJECUCIÓN:

![alt text](<imagenesun2/paso 1.png>)

OBSERVACIÓN:

RAM[16] = 10 

REFLEXION: La variable a está en la dirección de memoria 16 y contiene el valor 10.

- PASO 2: Hacer que p apunte a a (p = &a)

PREDICCIÓN: El puntero p debe guardar el número 16 (que es la dirección donde está a)

EJECUCIÓN:

![alt text](imagenesun2/PASO2.png)

OBSERVACIÓN:

RAM[16] = 10 (la variable a)

RAM[17] = 16 (el puntero p contiene "16")

REFLEXIÓN:

Usamos D=A porque queremos la DIRECCIÓN (16), no el contenido (10)
El puntero p ahora "apunta" a a porque contiene su dirección


- PASO 3: Modificar a través del puntero (*p = 20)

PREDICCIÓN: La variable a debe cambiar de 10 a 20

EJECUCIÓN:

![alt text](<imagenesun2/PASO 3.png>)

OBSERVACIÓN:

RAM[16] = 20  (cambió de 10 a 20)

RAM[17] = 16 (el puntero sigue igual)

REFLEXIÓN:

A=M es la INDIRECCIÓN: lee el puntero (16) y lo usa como dirección

Modificamos a sin tocarla directamente, usando el puntero p

## traducción programa 2.
```As
@10
D=A
@16
M=D

@5
D=A
@17
M=D

@16
D=A
@18
M=D


@18
A=M
D=M
@17
M=D

(END)
@END
0;JMP
```
### Paso a paso
- PASO 1: Crear variable a = 10

PREDICCIÓN: La variable a debe valer 10

EJECUCIÓN:

![alt text](<imagenesun2/PASO 1ACT2.png>)

OBSERVACIÓN: RAM[16] = 10 

REFLEXIÓN: La variable a está en la dirección de memoria 16 y contiene el valor 10.

- PASO 2: Crear variable b = 5

PREDICCIÓN: La variable b debe valer 5

EJECUCIÓN:

![alt text](<imagenesun2/PASO2 ACT2.png>)

OBSERVACIÓN:

RAM[16] = 10 (la variable a)
RAM[17] = 5 (la variable b)

REFLEXIÓN: Ahora tenemos dos variables: a en RAM[16] y b en RAM[17].

- PASO 3: Hacer que p apunte a a (p = &a)

PREDICCIÓN: El puntero p debe guardar el número 16 (que es la dirección donde está a)

EJECUCIÓN:

![alt text](<imagenesun2/PASO 3 ACT3.png>)

OBSERVACIÓN:

RAM[16] = 10 (la variable a)
RAM[17] = 5 (la variable b)
RAM[18] = 16 (el puntero p contiene "16")

REFLEXIÓN: Usamos D=A porque queremos la DIRECCIÓN (16), no el contenido (10) y el puntero p ahora "apunta" a a porque contiene su dirección.


- PASO 4: Leer a través del puntero (b = *p)

PREDICCIÓN: La variable b debe cambiar de 5 a 10 (copiando el valor de a)

EJECUCIÓN:

![alt text](<imagenesun2/PASO 4 ACT4.png>)

OBSERVACIÓN:

RAM[16] = 10 (la variable a sigue igual)
RAM[17] = 10 (b cambió de 5 a 10)
RAM[18] = 16 (el puntero sigue igual)

REFLEXIÓN:

A=M es la INDIRECCIÓN: lee el puntero (16) y lo usa como dirección

D=M lee el contenido de la dirección apuntada (lee el valor de a) y copiamos el valor de a a b usando el puntero p

# actividad 6

