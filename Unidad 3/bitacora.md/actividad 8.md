# Actividad 8: Paso por valor, referencia y puntero

### Paso por valor

```cpp
void cambiarNombre(Punto p, string nuevoNombre)
```

- Se crea una copia.
- Se destruye al salir.
- No modifica el original.

---

### Paso por referencia

```cpp
void cambiarNombre(Punto& p, string nuevoNombre)
```

- No hay copia.
- Modifica el original.

---

### Paso por puntero

```cpp
void cambiarNombre(Punto* p, string nuevoNombre)
```

- Se pasa la dirección.
- Modifica el original.

---

### Resumen

| Tipo | Copia | Modifica original |
|------|-------|------------------|
| Valor | Sí | No |
| Referencia | No | Sí |
| Puntero | No | Sí |

---
