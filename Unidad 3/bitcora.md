# Actividad 3
### Organización de Memoria en C++

| Segmento | Contenido | Descripción |
|----------|-----------|-------------|
| **SEGMENTO DE CÓDIGO (TEXT)** | `main()` | Función principal |
| | `suma(int, int)` | Función suma |
| | `crearArrayHeap(int)` | Función crear array |
| | `funcionConStatic()` | Función con variable estática |
| **VARIABLES GLOBALES Y ESTÁTICAS** | `global_inicializada = 42` | Variable global inicializada |
| | `global_no_inicializada` | Variable global sin inicializar |
| | `var_estatica (static) = 100` | Variable estática |
| | `mensaje_ro (puntero global)` | Puntero global a string |
| **HEAP** | `arrayHeap → new int[tamArray]` | Array dinámico |
| | `arr` (dentro de `crearArrayHeap()`) | Puntero que apunta al heap |
| **STACK** | **`main()`:** | |
| | `a` | Variable local |
| | `b` | Variable local |
| | `c` | Variable local |
| | `tamArray` | Variable local |
| | `arrayHeap` (puntero local) | Puntero local al heap |
| | **`suma()`:** | |
| | `a` (parámetro) | Parámetro de función |
| | `b` (parámetro) | Parámetro de función |
| | `c` (variable local) | Variable local |
| | **`crearArrayHeap()`:** | |
| | `tam` (parámetro) | Parámetro de función |
| | `arr` (puntero local) | Puntero local al heap |

# Actividad 4
### Experimento 1
```C++
#include <iostream>
#include <cstdlib>
using namespace std;

int main() {    
		// Variable local (stack)    
		int a = 10;    
		int b = 20;
    /**********************************************************        
    EXPERIMENTO 1    
    ***********************************************************/
    void* ptr = reinterpret_cast<void*>(&main);    
    cout << "Voy a modificar la memoria en la dirección: " << ptr << endl;    
    *reinterpret_cast<int*>(ptr) = 0;
    /********************************************************/
    return 0;
    }

```
El experimento compila pero automaticamente deja de funcionar porque en la linea ` *reinterpret_cast<int*>(ptr) = 0;`, el sistema operativo detecta que se está escribiendo en una zona que es solamente  de lectura y termina el programa.

### Experimento 2
```C++
#include <iostream>
#include <cstdlib>
using namespace std;
// Constante global
const char* const mensaje_ro = "Hola, memoria de solo lectura";

int main() {    
		// Variable local (stack)    
		int a = 10;    
		int b = 20;

    /**********************************************************        
    EXPERIMENTO 2    
    ***********************************************************/
    char* ptr = (char*)&mensaje_ro;    
    cout << "Voy a modificar la memoria en la dirección: " << ptr << endl;    
    *ptr = 0;
    /********************************************************/
    return 0;
    }
```
Está intentando encontrar una ubicacion con el puntero para escribir ahí y ese es un lugar en el que no se puede realizar la acción ya que es de solo lectura
### Experimento 3
```C++

```
### Experimento 4
```C++

```
### Experimento 5
```C++

```
### Experimento 5
```C++

```