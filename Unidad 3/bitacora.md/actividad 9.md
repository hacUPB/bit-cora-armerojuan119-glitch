# 🧪 Actividad 9: Miembros Estáticos

## Ubicación en memoria

| Elemento | Ubicación |
|----------|-----------|
| `c1` | Stack |
| `c2` | Stack |
| `c3` | Puntero en stack |
| Objeto de `c3` | Heap |
| `Contador::total` | Datos estáticos |

---

## Conclusión

- Miembros de instancia → dentro del objeto.
- Miembros estáticos → compartidos en segmento estático.

---

# 🧪 Actividad 10: Ciclo de vida

## Objeto en Stack

- Constructor al entrar.
- Destructor automático al salir del bloque.

## Objeto en Heap

- Constructor con `new`.
- Destructor solo con `delete`.

---

# 🎮 Actividad Integradora: Personaje

## Problemas detectados

### 1️⃣ Memory Leak
- Se usa `new int[3]`.
- No hay destructor.
- Nunca se hace `delete[]`.

### 2️⃣ Copia superficial
```cpp
Personaje copiaHeroe = heroe;
```
- Se copia el puntero.
- Ambos apuntan al mismo arreglo.
- Posible doble liberación si hubiera destructor.

---

## Solución sin Regla de los Tres

```cpp
class Personaje {
public:
    std::string nombre;
    int estadisticas[3];

    Personaje(std::string n, int vida, int ataque, int defensa)
        : nombre(n)
    {
        estadisticas[0] = vida;
        estadisticas[1] = ataque;
        estadisticas[2] = defensa;
        std::cout << "Constructor: nace " << nombre << std::endl;
    }

    void imprimir() {
        std::cout << "Personaje " << nombre
                  << " [Vida: " << estadisticas[0]
                  << ", ATK: " << estadisticas[1]
                  << ", DEF: " << estadisticas[2]
                  << "]" << std::endl;
    }
};
```

---

## ¿Por qué funciona?

- No se usa memoria dinámica.
- No hay punteros.
- Las copias son independientes.
- No hay fugas.
- No hay double free.

---

# 🧠 Concepto más crítico

Entender Stack vs Heap.

Porque determina:
- Ciclo de vida
- Destrucción
- Memory leaks
- Crashes

---

# 🎯 Diferencia clave C++ vs C#

En C++:
- El objeto puede vivir en stack.
- Control total.
- Mayor responsabilidad.

En C#:
- Objetos siempre en heap.
- Garbage Collector.
- Menos control manual.