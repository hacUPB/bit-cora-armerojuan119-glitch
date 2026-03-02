# 📘 Unidad: Gestión de Memoria en C++

---

# 🧪 Actividad 5: Copia de objetos y ubicación en memoria

## 1️⃣ ¿Qué ocurre al copiar un objeto?

### 🔹 En C++

```cpp
Punto copia = original;
```

- Se crea un nuevo objeto en el stack.
- Se ejecuta el constructor de copia implícito.
- Se copian los valores de los atributos.
- `original` y `copia` son objetos distintos en memoria.
- Modificar `copia` NO afecta a `original`.

En memoria:
- `original` → dirección A (stack)
- `copia` → dirección B (stack)

Son independientes.

---

### 🔹 En C#

```csharp
Punto copia = original;
```

- NO se crea un nuevo objeto.
- Se copia la referencia.
- Ambos apuntan al mismo objeto en el heap.
- Modificar `copia` afecta a `original`.

En memoria:
- Objeto → heap
- `original` y `copia` → referencias al mismo objeto

---

## 2️⃣ ¿Qué es `copia`?

| Lenguaje | ¿Qué es? | ¿Es independiente? |
|----------|----------|-------------------|
| C++ | Objeto nuevo en el stack | ✅ Sí |
| C# | Referencia al mismo objeto | ❌ No |

---

# 🧪 Actividad Integradora – Predicción

## 🔮 Salida esperada

```
--- Experimento con paso de parámetros ---
Valor inicial de val_A: 20
  -> Dentro de sumaPorValor, 'a' ahora es: 30
Valor final de val_A: 20

Valor inicial de val_B: 20
  -> Dentro de sumaPorReferencia, 'a' ahora es: 30
Valor final de val_B: 30

Valor inicial de val_C: 20
  -> Dentro de sumaPorPuntero, '*a' ahora es: 30
Valor final de val_C: 30

--- Experimento con variables estáticas ---
  -> Llamada a ejecutarContador. Valor de contador_estatico: 1
  -> Llamada a ejecutarContador. Valor de contador_estatico: 2
  -> Llamada a ejecutarContador. Valor de contador_estatico: 3
```

---

## 🧠 Mapa conceptual de memoria

### Stack
- `val_A`
- `val_B`
- `val_C`
- Parámetros de funciones
- Variables locales

### Datos Globales / Estáticos
- `contador_global`
- `contador_estatico`

### Segmento de Código
- `main`
- Funciones del programa

---

## 🔎 ¿Por qué `contador_estatico` recuerda su valor?

- Vive en el segmento de datos estáticos.
- Se inicializa una sola vez.
- No se destruye al salir de la función.
- Dura todo el programa.