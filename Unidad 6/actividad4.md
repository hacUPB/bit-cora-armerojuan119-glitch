## Actividad 4: Patrón State

### 1. Propósito del patrón State

El patrón State es útil cuando un objeto necesita cambiar su comportamiento dependiendo de su estado interno, y ese comportamiento cambia en tiempo de ejecución. En lugar de llenar la clase de condicionales (`if estado == "normal" ... else if estado == "attract" ...`), cada estado se encapsula en su propia clase con su propia lógica.

En mis palabras: el objeto delega su comportamiento al objeto de estado que tiene en ese momento. Cambiar el estado es tan simple como cambiar el objeto delegado. Es útil cuando hay múltiples estados claramente diferenciados y las transiciones entre ellos son frecuentes o complejas.

### 2. Diagrama de estados de `Particle`

![alt text](<imagenes/3 grafico.jpg>)

### 3. Ventajas del patrón State vs. `if/else` en `update()`

Si `Particle` usara un `std::string estadoActual` y un gran `switch` en `update()`:

```cpp
void Particle::update() {
    if (estadoActual == "normal") {
        position += velocity;
    } else if (estadoActual == "attract") {
        // lógica de atracción...
    } else if (estadoActual == "repel") {
        // lógica de repulsión...
    } // etc.
}
```

Los problemas serían:

- **Baja cohesión:** toda la lógica de todos los estados vive mezclada en una sola función de `Particle`.
- **Difícil de extender:** agregar un nuevo estado requiere modificar `Particle::update()`, violando el **Principio Abierto/Cerrado** (una clase debe estar abierta para extensión pero cerrada para modificación).
- **Propenso a errores:** si hay múltiples métodos dependientes del estado (`draw`, `onEnter`, etc.), hay que replicar el `switch` en cada uno.

Con el patrón State, agregar un estado nuevo (`GravityState`, por ejemplo) solo implica crear una nueva clase que hereda de `State`, sin tocar `Particle`. La clase `Particle` permanece cerrada a modificaciones.

### 4. Responsabilidad de `onEnter` y `onExit`

- **`onEnter`:** se ejecuta justo cuando se entra al nuevo estado. Es el lugar ideal para inicializar variables o configurar el objeto para ese estado.
- **`onExit`:** se ejecuta justo antes de abandonar el estado actual. Sirve para limpiar o restaurar valores.

En el caso de estudio, `NormalState::onEnter` asigna una nueva velocidad aleatoria a la partícula cada vez que regresa al estado normal, dándole una dirección fresca.

Ejemplos de uso que podría imaginar:

- **`AttractState::onEnter`:** podría cambiar el color de la partícula a amarillo para indicar visualmente que está en modo atracción.
- **`StopState::onExit`:** podría restaurar la velocidad original de la partícula antes de que entre al siguiente estado, para que no quede con velocidad cero al transicionar.
- **`RepelState::onEnter`:** podría aumentar el tamaño de la partícula momentáneamente para dar retroalimentación visual.

Estos hooks hacen que las transiciones sean más ricas y controladas, sin que `Particle` tenga que saber nada sobre la lógica interna de cada estado.
