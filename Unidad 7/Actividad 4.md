# Bitacora 1
## ¿En qué se diferencian una CPU y una GPU?

Después de haber visto las unidades 1 y 2, ya tengo una mejor idea de cómo funciona una CPU por dentro. En el Hack vi que la CPU tiene una ALU, unos registros y va ejecutando las instrucciones del programa **una por una, en orden**: agarra una instrucción, la entiende, la ejecuta, y pasa a la siguiente. Aunque las CPUs reales son muchísimo más rápidas y potentes que el Hack, la idea es la misma: hacen las cosas **en fila**, una detrás de otra.

La CPU es como el cerebro general del computador. Es buena para tareas variadas y complicadas: abrir programas, manejar archivos, responder a lo que hace el usuario, decidir qué camino tomar según un `if`, etc. Tiene pocos "trabajadores" (núcleos), pero cada uno es muy inteligente y puede hacer cosas muy distintas. Me lo imagino como un chef solo en la cocina: sabe hacer de todo, pero solo puede hacer una cosa a la vez.

La GPU es otra historia. En vez de tener pocos trabajadores muy inteligentes, tiene **miles de trabajadores más sencillos**, todos haciendo lo mismo al tiempo. Está hecha para cuando hay que hacer **la misma operación sobre muchísimos datos**, como pintar millones de píxeles en la pantalla. Sería como tener mil cocineros, cada uno menos hábil, pero todos picando cebolla a la vez. El resultado: terminan rapidísimo.

Cuando en la unidad 2 hice el programa que suma un arreglo con un `for`, la CPU del Hack iba **elemento por elemento**: leo el primero, sumo, leo el segundo, sumo... Si el arreglo tuviera un millón de números, le tocaría un millón de pasos en fila. Una GPU eso lo haría poniendo a miles de núcleos a sumar al mismo tiempo, y terminaría volando.

Lo mismo pasa con dibujar en la pantalla. En el Hack escribíamos un pixel a la vez, palabra por palabra en la memoria. Lento. Pero los gráficos modernos tienen millones de píxeles, y todos se calculan más o menos igual. Por eso existe la GPU: está hecha justo para eso, para pintar muchos píxeles al tiempo en vez de uno por uno.

**Para resumirlo**

La CPU es como un chef solo: sabe de todo, hace tareas variadas, pero una a la vez. La GPU es como un montón de cocineros sencillos haciendo todos lo mismo al tiempo. No es que una sea mejor que la otra, **se necesitan las dos**: la CPU dirige el programa, y cuando hay algo repetitivo y masivo (como dibujar gráficos), le pasa el trabajo a la GPU. Por eso en OpenGL los shaders corren en la GPU: porque pintar millones de píxeles es justo el tipo de trabajo en el que ella es buena, y a la CPU le tomaría una eternidad.

# Bitacora 2
## Reflexión sobre el pipeline de OpenGL y el video

### 1. ¿Cuáles son los tres pasos claves del pipeline de OpenGL?

Los tres pasos grandes son:

- **Vertex Shading (sombreado de vértices):** aquí se procesan los vértices de los modelos 3D. La idea es agarrar todos esos puntos que definen los objetos (que pueden ser millones) y moverlos al lugar correcto en la pantalla, usando matrices que tienen en cuenta dónde está el objeto, dónde está la cámara y cómo se ve el mundo. Es como pasar del mundo 3D al "mundo aplastado" de la pantalla.
- **Rasterización:** una vez que ya sé dónde quedan los triángulos en la pantalla, hay que decidir **qué píxeles de la pantalla le tocan a cada triángulo**. Es el paso que convierte la geometría (puntos, líneas, triángulos) en "candidatos a pixel".
- **Fragment Shading (sombreado de fragmentos):** este es el paso donde se le pone color y realismo a cada pixel. Se calcula la luz, las sombras, los reflejos, el material del objeto, etc. Aquí es donde la imagen se vuelve "bonita".

### 2. ¿Qué es el pipeline programable?

Significa que yo, como programador, puedo **escribir el código de algunos pasos del pipeline**, en vez de que la GPU haga todo "como ella quiera". En el pipeline fijo (el de OpenGL Legacy), la GPU tenía las etapas pre-armadas y uno solo podía configurar parámetros, pero no cambiar cómo se hacía el trabajo internamente. En el pipeline programable, yo puedo escribir mis propios programitas, los **shaders**, que le dicen a la GPU **cómo** transformar los vértices y **cómo** calcular el color de cada pixel.

La ventaja grande es la flexibilidad: puedo hacer efectos personalizados, estilos visuales únicos (cel-shading, agua, fuego, distorsiones), y aprovechar la GPU como yo quiera. La desventaja es que es más complicado porque ahora me toca a mí escribir cosas que antes venían "regaladas".

¿Qué tengo que programar? Por lo menos dos shaders: el **vertex shader** (qué hago con cada vértice) y el **fragment shader** (qué color le pongo a cada pixel). Hay más etapas programables (geometry shader, tessellation, compute), pero esas dos son las obligatorias.

### 3. ¿Cómo describirías la rasterización?

La rasterización es el paso en el que la GPU agarra los triángulos que ya están "aplastados" en la pantalla y decide **qué píxeles de la pantalla quedan dentro de cada triángulo**. Es como cuando uno dibuja una figura en una hoja cuadriculada y tiene que decidir qué cuadritos pintar para representar esa figura. La pantalla es la hoja cuadriculada y los píxeles son los cuadritos. Por cada triángulo, la GPU calcula qué píxeles le corresponden y genera "fragmentos" que después pasan al siguiente paso.

### 4. ¿Qué son los fragmentos? ¿Es lo mismo un fragmento que un pixel?

**No son lo mismo, aunque están relacionados.** Un fragmento es como un "candidato a pixel": es la información que sale de la rasterización para una posición de la pantalla, pero todavía no se ha decidido si va a aparecer ahí o no. Un fragmento trae datos como la posición, la profundidad (qué tan lejos está de la cámara), las coordenadas de textura, las normales, etc.

Un pixel es lo que finalmente queda pintado en la pantalla. Puede pasar que **varios fragmentos compitan por el mismo pixel** (por ejemplo, cuando hay objetos uno detrás de otro), y ahí entra el Z-buffer a decidir cuál se queda. También puede pasar que un fragmento se descarte por otras razones (estaba detrás de algo, era transparente, etc.) y no llegue a ser pixel.

Resumiendo: muchos fragmentos pueden generarse para una sola posición de pantalla, pero solo uno (o una mezcla) termina siendo el pixel final.

### 5. ¿Qué problema resuelve el Z-buffer y qué es el depth test?

El problema que resuelve es el de **la visibilidad**: cuando hay varios objetos en la escena, ¿cuáles están adelante y cuáles atrás? ¿Cuáles se ven y cuáles quedan tapados?

El Z-buffer es una memoria del tamaño de la pantalla donde, para cada pixel, se guarda **qué tan cerca de la cámara está lo que se está dibujando ahí**. Cada vez que llega un fragmento nuevo, la GPU hace el **depth test**: compara la profundidad de ese fragmento con la que ya está guardada en el Z-buffer. Si el fragmento nuevo está más cerca, se queda y reemplaza al anterior. Si está más lejos, se descarta porque significa que hay algo tapándolo.

Gracias a esto, no importa en qué orden mande los objetos a la GPU: igual se ve correctamente cuál está adelante y cuál está atrás.

### 6. ¿Por qué pasa el aliasing y qué es el anti-aliasing?

El aliasing pasa porque la pantalla está hecha de **píxeles cuadrados** y los objetos del mundo 3D tienen bordes diagonales o curvos. Cuando intento dibujar una línea inclinada con cuadritos, queda con un efecto de "escalerita" (sierra) en los bordes. Es como tratar de dibujar un círculo perfecto en una hoja cuadriculada: siempre se va a notar la cuadrícula.

El **anti-aliasing** son técnicas para suavizar esos bordes. En vez de pintar el pixel completo de un color o del otro, se hace una **mezcla** según qué tanto del pixel está cubierto por el objeto. El video mencionaba el SSAA (Super Sampling Anti-Aliasing), que básicamente renderiza la escena a una resolución más alta y después la reduce, lo que hace que los bordes queden con tonos intermedios y se vean más suaves. Cuesta más, pero la imagen se ve mucho mejor.

### 7. ¿Qué relación hay entre iluminación y fragment shader?

La iluminación se calcula **en el fragment shader** porque es ahí donde se decide el color de cada pixel, y la luz es uno de los factores que más afectan el color. El shader recibe información como la normal de la superficie (hacia dónde apunta), la dirección de la luz, el material del objeto, etc., y con esas operaciones matemáticas determina qué tan iluminado o en sombra está ese pixel.

¿Es obligatoria la iluminación? **No.** Puedo hacer un fragment shader que simplemente pinte todo de un color plano sin tener en cuenta luces, y funciona perfectamente. Las implicaciones son:

- **Sin iluminación:** todo se ve plano, como un dibujo animado simple o un estilo "flat". Es más rápido porque hay menos cuentas por pixel. Útil para interfaces, prototipos, juegos con estilo artístico minimalista.
- **Con iluminación:** la escena se ve realista, con volumen y profundidad, pero cuesta más procesamiento porque por cada pixel hay que hacer cálculos de vectores, ángulos, etc.

Es una decisión de diseño: depende del estilo que yo quiera y de cuánto rendimiento esté dispuesto a gastar.

### 8. ¿Qué implica tener múltiples fuentes de luz para la GPU?

Que **el trabajo se multiplica**. Por cada pixel, el fragment shader tiene que hacer los cálculos de iluminación **una vez por cada luz** que haya en la escena: calcular el ángulo entre la luz y la superficie, la distancia, la atenuación, etc., y luego sumar todas las contribuciones para sacar el color final.

Si tengo una escena con millones de píxeles y, digamos, 10 luces, eso son 10 veces más cuentas por pixel. La GPU lo aguanta porque es buenísima haciendo cosas en paralelo, pero igual hay un límite: si pongo demasiadas luces, los FPS empiezan a bajar. Por eso en los videojuegos se usan trucos como **luces precalculadas** (lightmaps), **deferred shading** (que separa la geometría de la iluminación para hacerlo más eficiente), o simplemente limitar cuántas luces dinámicas hay al tiempo. Es uno de los grandes retos del rendimiento gráfico.

# Bitacora 3
## Resúmenes en mis propias palabras (basados en mi código del triángulo)

### 1. ¿Qué necesito para dibujar un triángulo en OpenGL?

Mirando mi propio código, para dibujar el triángulo necesité varias cosas conectadas entre sí:

**Lo de "fondo" que hay que tener listo primero**

Antes de pensar en el triángulo, mi `main` arranca con la preparación del entorno. Inicializo GLFW con `glfwInit()`, le digo qué versión de OpenGL quiero (4.6 Core) con los `glfwWindowHint`, creo la ventana con `glfwCreateWindow`, hago que su contexto sea el actual con `glfwMakeContextCurrent`, y cargo las funciones modernas de OpenGL con `gladLoadGLLoader`. Sin todos estos pasos, no puedo llamar **ninguna** función de OpenGL. También leo el tamaño real del framebuffer con `glfwGetFramebufferSize` y configuro el viewport con `glViewport` para decirle a OpenGL en qué parte de la ventana va a pintar.

**Los datos del triángulo**

En mi función `setupTriangle()` defino las tres esquinas del triángulo en un arreglo:

```cpp
float vertices[] = {
    -0.5f, -0.5f, 0.0f,
     0.5f, -0.5f, 0.0f,
     0.0f,  0.5f, 0.0f
};
```

Esas coordenadas están en NDC (de -1 a 1). Pero el arreglo está en la RAM normal, así que tengo que **subirlo a la GPU**. Para eso:

- Genero un **VBO** con `glGenBuffers` y un **VAO** con `glGenVertexArrays`.
- Activo el VAO (`glBindVertexArray`) y el VBO (`glBindBuffer`).
- Subo los datos del arreglo a la GPU con `glBufferData`.
- Le explico a OpenGL **cómo leer esos datos** con `glVertexAttribPointer`: que cada vértice tiene 3 floats, que vienen seguidos en memoria, y que esto corresponde al atributo en `location = 0` del vertex shader.
- Activo el atributo con `glEnableVertexAttribArray(0)`.

El VBO es el "cajón" con los números crudos y el VAO es la "receta" que dice cómo leerlos.

**El shader program**

También necesito tener listo el programa de shaders, que en mi código lo armo con `buildShaderProgram()` antes del game loop. Sin shader, no puedo dibujar nada en OpenGL moderno. En este código mis shaders son sencillos: el vertex shader solo pasa la posición tal cual, y el fragment shader pinta todo de un color naranja fijo (`vec4(1.0, 0.5, 0.2, 1.0)`).

**El game loop (donde realmente se dibuja)**

Mientras la ventana no se cierre, en cada vuelta:

1. `glfwPollEvents()` para que la ventana responda al usuario.
2. `processInput()` para revisar si presionaron ESC.
3. `glClearColor` y `glClear(GL_COLOR_BUFFER_BIT)` para borrar lo del cuadro anterior y dejar el fondo en un color gris-verdoso.
4. `glUseProgram(shaderProg)` para decirle a OpenGL qué shader usar.
5. `glBindVertexArray(VAO)` para activar la "receta" del triángulo.
6. `glDrawArrays(GL_TRIANGLES, 0, 3)` para mandar la orden: "dibuja un triángulo con 3 vértices empezando desde 0".
7. `glfwSwapBuffers(mainWindow)` para mostrar en pantalla lo que acabo de dibujar (sin esto, todo quedaría invisible).

Y al final, cuando termina el programa, hago la limpieza con `glDeleteVertexArrays`, `glDeleteBuffers`, `glDeleteProgram` y cierro GLFW.

---

### 2. ¿Qué necesito para poder usar un shader en OpenGL?

En mi código, todo el manejo de shaders está concentrado en la función `buildShaderProgram()`. Mirándola, los pasos son:

**Primero escribir el código GLSL**

Yo tengo dos shaders escritos como strings en C++ (`vertexShaderSrc` y `fragmentShaderSrc`):

- El **vertex shader** recibe la posición del vértice en `aPos` (que viene del VBO, en `location = 0`) y la pasa directamente a `gl_Position`. Se ejecuta una vez por cada vértice.
- El **fragment shader** simplemente devuelve un color naranja fijo. Se ejecuta una vez por cada fragmento.

**Después meterlos a la GPU**

Para cada shader (vertex y fragment) hago lo mismo:

1. `glCreateShader(GL_VERTEX_SHADER)` o `GL_FRAGMENT_SHADER` para crear un shader vacío en la GPU.
2. `glShaderSource` para pasarle el código fuente.
3. `glCompileShader` para compilarlo.
4. Reviso con `glGetShaderiv` si la compilación falló, y si falló saco el log con `glGetShaderInfoLog` y lo muestro en consola (esto me ha salvado un montón cuando me equivoco escribiendo GLSL).

**Después unirlos en un program**

1. `glCreateProgram()` para crear el "paquete" donde van a vivir juntos.
2. `glAttachShader(prog, vs)` y `glAttachShader(prog, fs)` para meterle los dos shaders.
3. `glLinkProgram(prog)` para enlazarlos.
4. Reviso si el enlace falló (similar a la compilación).
5. `glDeleteShader(vs)` y `glDeleteShader(fs)` para borrar los shaders sueltos, porque ya están dentro del program y no los necesito por separado.

La función retorna el ID del program (un `unsigned int`), que guardo en la variable global `shaderProg`.

**Activarlo cuando voy a dibujar**

Dentro del game loop, antes de dibujar el triángulo, llamo `glUseProgram(shaderProg)`. Eso le dice a OpenGL: "para lo que viene, usa estos shaders". A partir de ahí, cualquier `glDrawArrays` que haga va a pasar por mi vertex shader y mi fragment shader.

En este código no estoy usando uniforms, pero si quisiera (como pasarle un color que cambie con el tiempo o una posición desde el mouse), tendría que:

- Declarar la variable como `uniform` dentro del shader en GLSL.
- Pedir su ubicación con `glGetUniformLocation(shaderProg, "nombreDelUniform")`.
- Mandarle un valor en cada frame con funciones como `glUniform1f`, `glUniform2f`, etc.

**En resumen:** usar un shader en OpenGL es: escribirlo en GLSL, compilarlo, enlazarlo dentro de un program, y activarlo con `glUseProgram` antes de dibujar. Sin ese proceso, la GPU no sabría cómo procesar los vértices ni cómo pintar los fragmentos.

# Bitacora 4