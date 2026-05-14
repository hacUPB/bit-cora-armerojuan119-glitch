# Actividad 11: Autoevaluación  

### 1. ¿Qué es el stack y qué es el heap en C++?

El **stack** es la región de memoria donde se almacenan variables locales y llamadas a funciones. Su gestión es automática: cuando una función termina, la memoria se libera sola. Es rápida, pero limitada en tamaño.

El **heap** es la región de memoria dinámica. Aquí se almacenan los datos que yo mismo reservo usando `new`. A diferencia del stack, el heap no se libera automáticamente; yo debo liberar la memoria manualmente con `delete`. Es más flexible, pero también más propenso a errores como memory leaks.

---

### 2. Tres formas de pasar parámetros

**Paso por valor**

Se crea una copia del argumento en el stack.  
La función trabaja con esa copia.  
No modifica la variable original.

Lo usaría cuando no quiero que la función altere el valor original.

---

**Paso por referencia**

Se pasa un alias de la variable original.  
No se crea copia.  
Se trabaja directamente sobre el mismo espacio de memoria.

Lo usaría cuando quiero modificar la variable original de forma segura.

---

**Paso por puntero**

Se pasa la dirección de memoria.  
La función recibe un puntero y usa `*` para acceder al valor real.

Lo usaría cuando trabajo con memoria dinámica o necesito mayor control sobre memoria.

---

### 3. Diferencia entre variable local, global y local estática

**Variable local**
- Se declara dentro de una función.
- Vive en el stack.
- Se destruye cuando termina la función.

**Variable global**
- Se declara fuera de cualquier función.
- Vive durante todo el programa.
- Se almacena en el segmento de datos.

**Variable local estática**
- Se declara dentro de una función con `static`.
- Vive durante todo el programa.
- Se almacena en el segmento de datos.
- Conserva su valor entre llamadas.

---

### 4. ¿Qué es un objeto en memoria?

Un objeto en C++ es un bloque de memoria que contiene:

- Sus miembros de instancia (atributos normales).
- Posiblemente una tabla virtual si usa herencia virtual.

Los miembros de instancia se almacenan donde se cree el objeto:
- En el stack si el objeto es local.
- En el heap si se crea con `new`.

Los miembros estáticos no pertenecen a cada objeto, sino a la clase.  
Se almacenan en el segmento de datos.

---

# Parte 2: Transferencia y análisis de situación nueva

## 1. Análisis de problemas

### Problema 1: Memory leak

La clase reserva memoria dinámica:

```cpp
armas = new int[3];
```
Pero no existe un destructor que libere esa memoria con `delete[]`.

Cada vez que se crea un `Enemigo`, se reserva memoria que nunca se libera.  
Eso produce un **memory leak**, lo que puede causar crashes con el tiempo.

---

### Problema 2: Regla de los Tres

La clase tiene un puntero (`int* armas`) pero no define:

- Destructor  
- Constructor de copia  
- Operador de asignación  

Si el objeto se copiara, habría doble liberación o corrupción de memoria.  
Eso es muy peligroso en programas reales.

---

## 2. Predicción de comportamiento

En `crearEscuadron()` se crean 5 enemigos por llamada.

En `main()` se llama dos veces:
