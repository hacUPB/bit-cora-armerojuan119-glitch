# Bitácora — Actividad 05

## 1. Modificación del código del triángulo

Para hacer el triángulo interactivo, agregué dos uniforms a los shaders y los actualizo cada frame con la posición del mouse.

**Vertex shader:** uniform `vec2 offset` que se suma a la posición del vértice.

```glsl
#version 460 core
layout(location = 0) in vec3 aPos;
uniform vec2 offset;
void main() {
    vec3 newPos = aPos;
    newPos.x += offset.x;
    newPos.y += offset.y;
    gl_Position = vec4(newPos, 1.0);
}
```

**Fragment shader:** uniform `vec4 ourColor` que reemplaza el color fijo.

```glsl
#version 460 core
out vec4 FragColor;
uniform vec4 ourColor;
void main() {
    FragColor = ourColor;
}
```

**En C++**, antes del loop obtengo las locations una sola vez, y dentro del loop leo el mouse cada frame, lo normalizo y lo envío como color y como offset:

```cpp
glUniform4f(colorLocation, x, y, 0.0f, 1.0f);
glUniform2f(offsetLocation, x * 2 - 1, 1 - y * 2);
```

El triángulo termina siguiendo al cursor mientras cambia de color según su posición.

## 2. Captura de pantalla

*(Aquí adjunto la captura del triángulo interactivo en ejecución.)*

## 3. Normalización de las coordenadas del mouse

`glfwGetCursorPos` da la posición en **píxeles desde la esquina superior izquierda**. Como OpenGL no trabaja en píxeles, divido por el tamaño de la ventana:

```cpp
float x = (float)xpos / (float)SCR_WIDTH;
float y = (float)ypos / (float)SCR_HEIGHT;
```

Esto deja los valores en el rango `[0, 1]`, independiente del tamaño de la ventana. El clamp con los ternarios evita que se desborden si el mouse sale de la ventana. Ese rango `[0, 1]` coincide con el rango de los canales de color en OpenGL, así que los puedo enviar directamente como R y G del color.

## 4. Normalización a coordenadas de dispositivo (NDC)

OpenGL posiciona geometría en **NDC**, que va de `-1` a `1`, con el origen en el centro y el eje Y apuntando hacia arriba (al revés del mouse). Por eso el rango `[0, 1]` no basta para usar como posición: hay que remapearlo.

```cpp
glUniform2f(offsetLocation, x * 2 - 1, 1 - y * 2);
```

- **`x * 2 - 1`** lleva `[0, 1]` → `[-1, 1]` (multiplicar expande, restar desplaza).
- **`1 - y * 2`** hace lo mismo **e invierte el eje Y** en una sola operación, para que arriba del mouse coincida con arriba en NDC.

Tras esa conversión, el `offset` queda en el mismo sistema que las coordenadas de los vértices del triángulo, y se puede sumar directamente en el vertex shader. El flujo total es **píxeles → `[0, 1]` → `[-1, 1]` con Y invertida**.