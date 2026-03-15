### Actividad de exploracion 3
Para esta actividad regresé a la aplicación de la **lista enlazada de la serpiente** y utilicé el **depurador** para observar cómo funcionan las diferentes partes del código durante la ejecución.

El objetivo fue entender mejor **cómo se conectan los nodos de la lista** y **cómo se actualizan sus posiciones** cuando el usuario mueve el mouse.

---

**1. Revisión de la función `setup()`**

Primero coloqué un **breakpoint** en la función `setup()`.

Observé que al iniciar la aplicación se ejecuta el siguiente ciclo:

```cpp
for (int i = 0; i < 20; i++) {
    snake.push_back(glm::vec2(ofGetWidth() / 2, ofGetHeight() / 2));
}
```

Durante la depuración pude ver que:

- Se crean **20 nodos**.
- Cada nodo se agrega al final de la lista usando `push_back()`.
- Todos los nodos comienzan en **el centro de la pantalla**.

También observé cómo cambian los punteros dentro de la lista:

- `head` apunta al **primer nodo**.
- `tail` apunta al **último nodo**.

Esto me ayudó a entender cómo se **construye una lista enlazada**, donde cada nodo apunta al siguiente nodo.

---

**2. Revisión de la función `update()`**

Luego utilicé el depurador en la función `update()`.

Aquí observé cómo se actualiza la posición de cada nodo con este ciclo:

```cpp
Node* current = snake.head;
while (current != nullptr) {
    current->position = glm::mix(glm::vec3(current->position, 0.0f), glm::vec3(target, 0.0f), interpolationFactor);
    target = current->position;
    current = current->next;
}
```

Durante la depuración noté que:

- `current` comienza en `snake.head`.
- En cada iteración el nodo se mueve un poco hacia el objetivo (`target`).
- Después de mover un nodo, el **objetivo cambia a la posición del nodo actual**.
- Esto hace que cada nodo **siga al nodo anterior**, generando el efecto de serpiente.

También pude ver cómo `current` avanza en la lista usando:

```cpp
current = current->next;
```

Este proceso continúa hasta que `current` llega a `nullptr`, lo que indica que ya se recorrió toda la lista.

---

**3. Revisión de la función `draw()`**

Después analicé la función `draw()`.

Primero se crea un **gradiente dinámico de fondo**:

```cpp
ofBackgroundGradient(color1, color2, OF_GRADIENT_LINEAR);
```

Este gradiente cambia de color gradualmente usando el valor `backgroundHue`.

Luego se recorre la lista para dibujar la serpiente.

Durante la depuración observé cómo se construye el `mesh`:

```cpp
mesh.addColor(...)
mesh.addVertex(...)
```

Esto conecta los nodos con una **línea continua**, creando la forma de la serpiente.

Después se dibujan círculos en cada nodo:

```cpp
ofDrawCircle(current->position.x, current->position.y, radius);
```

También observé cómo el **color y el tamaño de los círculos cambian** dependiendo de la posición del nodo dentro de la lista.

---

**4. Prueba de las teclas**

También probé las teclas definidas en la función `keyPressed()`.

**Tecla A**

```cpp
snake.push_back(...)
```

Agrega un nuevo nodo a la lista en una **posición aleatoria de la pantalla**.

---

**Tecla R**

```cpp
snake.pop_back()
```

Elimina el **último nodo de la lista**.

---

**Tecla C**

```cpp
snake.clear()
```

Elimina **todos los nodos de la lista**, dejando la serpiente vacía.

---

**Tecla S**

```cpp
ofSaveFrame()
```

Guarda una **imagen del frame actual** de la aplicación.

---

**Conclusión**

Usar el depurador me permitió entender mejor cómo funciona la **lista enlazada** en esta aplicación.

Pude observar cómo:

- Se **crean los nodos**.
- Se **conectan entre sí usando punteros**.
- Se **recorre la lista usando `next`**.
- Se **actualizan las posiciones de los nodos** para generar el movimiento de la serpiente.

Esto me ayudó a comprender cómo las **estructuras de datos pueden utilizarse para crear comportamientos visuales interactivos en programación creativa**.

### Actividad de aplicacion
## Código Off App h
```C++
#pragma once

#include "ofMain.h"

// Nodo de la cola
struct Node {

	float x, y;
	float radius;
	ofColor color;
	float opacity;
	Node * next;

	Node(float _x, float _y, float _radius, ofColor _color, float _opacity)
		: x(_x)
		, y(_y)
		, radius(_radius)
		, color(_color)
		, opacity(_opacity)
		, next(nullptr) { }
};

// Cola FIFO
class BrushQueue {

public:
	Node * front;
	Node * rear;
	int size;
	int maxSize;

	BrushQueue(int _maxSize);
	~BrushQueue();

	void enqueue(float x, float y, float radius, ofColor color, float opacity);
	void dequeue();
	void clear();
	bool isEmpty();
};

class ofApp : public ofBaseApp {

public:
	void setup();
	void update();
	void draw();

	void keyPressed(int key);
	void keyReleased(int key);
	void mouseMoved(int x, int y);
	void mouseDragged(int x, int y, int button);
	void mousePressed(int x, int y, int button);
	void mouseReleased(int x, int y, int button);
	void mouseEntered(int x, int y);
	void mouseExited(int x, int y);
	void windowResized(int w, int h);
	void dragEvent(ofDragInfo dragInfo);
	void gotMessage(ofMessage msg);

	BrushQueue strokes { 50 };
	float backgroundHue = 0;
};
```
## Código Off App cpp
```C++
#include "ofApp.h"

//--------------------------------------------------------------
BrushQueue::BrushQueue(int _maxSize)
	: front(nullptr)
	, rear(nullptr)
	, size(0)
	, maxSize(_maxSize) { }

//--------------------------------------------------------------
BrushQueue::~BrushQueue() {
	clear();
}

//--------------------------------------------------------------
void BrushQueue::enqueue(float x, float y, float radius, ofColor color, float opacity) {

	Node * newNode = new Node(x, y, radius, color, opacity);

	if (isEmpty()) {
		front = rear = newNode;
	} else {
		rear->next = newNode;
		rear = newNode;
	}

	size++;

	if (size > maxSize) {
		dequeue();
	}
}

//--------------------------------------------------------------
void BrushQueue::dequeue() {

	if (isEmpty()) return;

	Node * temp = front;
	front = front->next;

	delete temp;

	size--;

	if (front == nullptr) {
		rear = nullptr;
	}
}

//--------------------------------------------------------------
void BrushQueue::clear() {

	Node * current = front;

	while (current != nullptr) {

		Node * nextNode = current->next;
		delete current;
		current = nextNode;
	}

	front = nullptr;
	rear = nullptr;
	size = 0;
}

//--------------------------------------------------------------
bool BrushQueue::isEmpty() {
	return front == nullptr;
}

//--------------------------------------------------------------
void ofApp::setup() {

	ofBackground(0);

	strokes.clear();
	strokes.maxSize = 50;
}
//--------------------------------------------------------------
void ofApp::update() {

	backgroundHue += 0.2;

	if (backgroundHue > 255) {
		backgroundHue = 0;
	}
}

//--------------------------------------------------------------
void ofApp::draw() {

	ofColor color1, color2;

	color1.setHsb(backgroundHue, 150, 240);
	color2.setHsb(fmod(backgroundHue + 128, 255), 150, 240);

	ofBackgroundGradient(color1, color2, OF_GRADIENT_LINEAR);

	Node * current = strokes.front;

	int index = 0;

	while (current != nullptr) {

		float opacity = ofMap(index, 0, strokes.size, 50, 255);

		ofSetColor(current->color, opacity);

		ofDrawCircle(current->x, current->y, current->radius);

		current = current->next;
		index++;
	}
}

//--------------------------------------------------------------
void ofApp::keyPressed(int key) {

	if (key == 'c') {

		// solo limpiar
		strokes.clear();
	}

	if (key == 'a') {

		if (strokes.maxSize == 50) {
			strokes.maxSize = 100;
		} else {
			strokes.maxSize = 50;

			// eliminar exceso si hay más de 50
			while (strokes.size > strokes.maxSize) {
				strokes.dequeue();
			}
		}
	}

	if (key == 's') {
		ofSaveFrame();
	}
}
//--------------------------------------------------------------
void ofApp::keyReleased(int key) {
}

//--------------------------------------------------------------
void ofApp::mouseMoved(int x, int y) {
}

//--------------------------------------------------------------
void ofApp::mouseDragged(int x, int y, int button) {

	float radius = ofRandom(5, 20);

	ofColor color;
	color.setHsb(ofRandom(255), 200, 255);

	strokes.enqueue(x, y, radius, color, 200);
}

//--------------------------------------------------------------
void ofApp::mousePressed(int x, int y, int button) {
}

//--------------------------------------------------------------
void ofApp::mouseReleased(int x, int y, int button) {
}

//--------------------------------------------------------------
void ofApp::mouseEntered(int x, int y) {
}

//--------------------------------------------------------------
void ofApp::mouseExited(int x, int y) {
}

//--------------------------------------------------------------
void ofApp::windowResized(int w, int h) {
}

//--------------------------------------------------------------
void ofApp::gotMessage(ofMessage msg) {
}

//--------------------------------------------------------------
void ofApp::dragEvent(ofDragInfo dragInfo) {
}

```


## Código main cpp
```C++
#include "ofApp.h"
#include "ofMain.h"

//========================================================================
int main() {

	//Use ofGLFWWindowSettings for more options like multi-monitor fullscreen
	ofGLWindowSettings settings;
	settings.setSize(1024, 768);
	settings.windowMode = OF_WINDOW; //can also be OF_FULLSCREEN

	auto window = ofCreateWindow(settings);

	ofRunApp(window, std::make_shared<ofApp>());
	ofRunMainLoop();
}

```
### Qué aprendí
**2.¿Qué hice bien en esta unidad que debo continuar haciendo?**

Durante esta unidad intenté analizar primero el código antes de modificarlo, lo que me ayudó a entender mejor cómo funcionan las estructuras de datos.

También practiqué probar el programa constantemente mientras programaba, lo que facilitó encontrar errores más rápido.

Algo que funcionó bien fue comparar la implementación de la lista enlazada con la cola, porque me permitió transferir el conocimiento entre estructuras similares.

Debo continuar experimentando con el código y utilizando el depurador para entender mejor lo que ocurre internamente en los programas.

**3. ¿Qué debería comenzar a hacer para mejorar mi proceso?**

Para mejorar mi proceso debo empezar a planear más antes de programar, por ejemplo haciendo pequeños diagramas de cómo funcionan las estructuras de datos.

También debo practicar más gestión de memoria en **C++**, porque trabajar con punteros requiere cuidado para evitar errores o fugas de memoria.

Otra cosa que puedo mejorar es documentar mejor mi código, agregando comentarios que expliquen qué hace cada parte.

Finalmente, quiero empezar a experimentar más con openFrameworks, ya que permite crear aplicaciones visuales interesantes que combinan programación y creatividad.