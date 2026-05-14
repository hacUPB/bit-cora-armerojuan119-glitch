# Actividad 2
## Parte 1: Predicción de la Salida

### ¿Qué se imprimirá dentro de cada función?

**Llamada a `modificarPorValor(a)`**

Cuando analizo esta función, entiendo que el parámetro se pasa por valor, es decir, se crea una copia.

Dentro de la función se imprimirá:


Dentro de modificarPorValor, valor inicial: 10
Dentro de modificarPorValor, valor modificado: 15


Pero cuando regrese a `main()`, el valor de `a` seguirá siendo:


Después de modificarPorValor, valor de a: 10


Porque solo se modificó una copia.

---

### Llamada a `modificarPorReferencia(b)`

Aquí veo que el parámetro se pasa por referencia (`int &n`), lo que significa que no se crea copia.

Dentro de la función se imprimirá:


Dentro de modificarPorReferencia, valor inicial: 10
Dentro de modificarPorReferencia, valor modificado: 15


Y cuando vuelva a `main()`:


Después de modificarPorReferencia, valor de b: 15


Porque sí se modificó la variable original.

---

### Llamada a `modificarPorPuntero(&c)`

En este caso se pasa la dirección de memoria de `c`.

Dentro de la función se imprimirá:


Dentro de modificarPorPuntero, valor inicial: 10
Dentro de modificarPorPuntero, valor modificado: 15


Y en `main()`:


Después de modificarPorPuntero, valor de c: 15


Porque al usar `*n` se está modificando directamente el valor original.

---

## Parte 2: Diferencias que observo**

Después de analizarlo, noto que:

- `a` no cambia.
- `b` sí cambia.
- `c` sí cambia.

La diferencia está en cómo se pasan los parámetros.

---

## Parte 3: ¿Por qué ocurre esta diferencia?

**Paso por Valor**

Yo entiendo que aquí se crea una copia de la variable.  
La función trabaja sobre esa copia y no sobre el valor original.

Por eso `a` sigue valiendo 10.

---

**Paso por Referencia**

Aquí no se crea copia.  
`n` es simplemente otro nombre para la misma variable.

Entonces cuando se modifica `n`, realmente estoy modificando `b`.

---

**Paso por Puntero**

En este caso se pasa la dirección de memoria.

El puntero guarda dónde está la variable, y al usar `*` accedo directamente al valor original.

Por eso `c` también cambia.

---

## Parte 4: Actividad Swap – Resultados

**Valores iniciales:**


x = 5
y = 10


---

**Después de `swapPorValor(x, y)`**


x = 5
y = 10


Yo concluyo que no se intercambian porque la función solo trabaja con copias.

---

**Después de `swapPorReferencia(x, y)`**


x = 10
y = 5


Aquí sí se intercambian porque estoy trabajando directamente con las variables originales.

---

**Después de `swapPorPuntero(&x, &y)`**

Si lo ejecuto después del swap por referencia:


x = 5
y = 10


Se vuelven a intercambiar porque el puntero modifica directamente los valores originales.

---

## Parte 5: Respuestas a las Preguntas

**1. ¿Por qué `swapPorValor` no intercambia realmente los valores?**

Porque solo modifica copias locales dentro de la función.  
Las variables originales nunca cambian.

---

**2. Diferencia conceptual entre referencia y puntero**

Yo lo entiendo así:

- La referencia es un alias.
- El puntero es una variable que guarda una dirección.

La referencia es más simple y limpia.  
El puntero me da más control sobre memoria.

---

**3. ¿Cuál es más seguro?**

Para mí, la referencia es más segura porque:

- No puede ser nula.
- No necesito usar `*`.
- Es más clara de leer.

---

**4. ¿Cuál es más flexible?**

El puntero, porque:

- Puede cambiar a qué apunta.
- Puede ser nulo.
- Se usa mucho en memoria dinámica.

---

**5. ¿Cuándo usar cada uno?**

Yo usaría:

- Paso por valor → cuando no quiero modificar la variable original.
- Paso por referencia → cuando sí quiero modificarla de forma segura.
- Paso por puntero → cuando trabajo con memoria dinámica o estructuras complejas.

---

**Parte 6: ¿Qué ocurre en memoria?**

**Paso por valor**

Se crea un nuevo espacio en memoria (stack) con una copia del valor.


a = 10
n = 10 (copia)


---

**Paso por referencia**

No se crea copia.


b ─┐

n ─┘ → 10


Ambos nombres apuntan al mismo espacio.

---

**Paso por puntero**

Se guarda la dirección de memoria.


c = 10
n = dirección de c
*n = 10


Al modificar `*n`, modifico `c`.

---

**Reflexión Final**

Después de hacer esta actividad, entiendo claramente que:

- Paso por valor no modifica la variable original.
- Paso por referencia sí la modifica directamente.
- Paso por puntero permite mayor control sobre memoria.

Personalmente, me parece más intuitivo el paso por referencia.

Creo que en proyectos grandes se usan más referencias por seguridad y claridad, y punteros cuando se necesita mayor control o memoria dinámica.

