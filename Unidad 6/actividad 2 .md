## Actividad 2: Patrón Observer

### 1. Propósito del patrón Observer

El patrón Observer resuelve el problema de la comunicación entre objetos de forma desacoplada. En lugar de que un objeto central tenga que conocer y llamar directamente a cada objeto que depende de él, los objetos interesados se suscriben como "observadores". Cuando el estado del objeto central cambia, este simplemente notifica a todos los suscritos sin importarle quiénes son ni cuántos hay.

En mis palabras: es como un sistema de notificaciones. El `Subject` es el emisor y los `Observer`s son los suscriptores. El emisor no sabe ni le importa quién está escuchando; simplemente publica el evento y cada suscriptor reacciona a su manera.

### 2. Diagrama de relaciones

![alt text](<imagenes/1 grafico.png>)

`Subject` guarda una lista de punteros `Observer*`. Cuando `ofApp::keyPressed` llama a `notify("attract")`, `Subject` itera esa lista y llama a `onNotify("attract")` en cada `Particle` registrada.

- **`ofApp`** es el ConcreteSubject: hereda de `Subject` y dispara `notify()` ante eventos de teclado.
- **`Particle`** es el ConcreteObserver: hereda de `Observer` e implementa `onNotify()` reaccionando con un cambio de estado.

### 3. Diagrama de secuencia al presionar una tecla

![alt text](<imagenes/2 grafico.png>)

### 4. Ventajas del patrón Observer vs. variable global

Si `ofApp::update` usara una variable global `estadoActual` y recorriera todas las partículas diciéndoles directamente qué hacer, tendría estos problemas:

- **Alto acoplamiento:** `ofApp` necesitaría conocer los detalles internos de `Particle` para modificar su comportamiento.
- **Difícil de extender:** si quisiera añadir un nuevo tipo de objeto reactivo (por ejemplo, obstáculos), tendría que modificar `ofApp::update`.
- **Responsabilidades mezcladas:** `ofApp` estaría tanto gestionando la lógica de la app como controlando el comportamiento de cada partícula.

Con el patrón Observer, `ofApp` solo dice *qué pasó* ("attract"), y cada `Particle` decide por sí misma cómo reaccionar. Agregar un nuevo tipo de observador no requiere tocar `ofApp` en absoluto.


