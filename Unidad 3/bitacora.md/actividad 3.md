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