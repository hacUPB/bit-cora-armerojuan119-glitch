Actividad 10 – Ciclo de vida
Stack

Constructor al entrar al bloque.

Destructor automático al salir.

Heap

Constructor con new.

Destructor solo con delete.

¿Por qué pBloque2 no se destruye?

Porque:

pBloque2 es solo un puntero.

El objeto está en el heap.

El heap no depende del bloque.

🎮 Actividad Integradora – Personaje
🔴 Problema 1: Memory leak

No hay destructor → nunca se hace delete[] estadisticas.

Consecuencia:

Fuga de memoria.

🔴 Problema 2: Copia superficial
Personaje copiaHeroe = heroe;

Se copia el puntero.

Ambos apuntan al mismo arreglo.

Si hubiera destructor → doble delete.

✅ Solución SIN usar regla de los tres

Evitar new completamente:

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
✅ ¿Por qué funciona?

No usamos heap.

No hay punteros.

Copias ahora son profundas automáticamente.

No hay fugas.

No hay double free.

🎯 Concepto Más Crítico

👉 Entender stack vs heap.

Porque:

Determina ciclo de vida.

Determina destrucción.

Determina errores como leaks y crashes.

🧠 Diferencia clave C++ vs C#

En C++:

Un objeto puede vivir en stack.

Tienes control total.

Pero también responsabilidad total.

En C#:

Todo vive en heap.

Hay Garbage Collector.

Menos control, menos errores manuales.