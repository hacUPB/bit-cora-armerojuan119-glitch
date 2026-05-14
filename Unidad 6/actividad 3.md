## Actividad 3: Patrón Factory Method

### 1. Propósito del patrón Factory Method

El patrón Factory Method aborda el problema de centralizar y encapsular la creación de objetos. El código cliente no necesita saber *cómo* se construye un objeto ni qué configuración específica requiere; simplemente pide a la fábrica un objeto de cierto tipo y la fábrica se encarga del resto.

En mis palabras: es como pedir un platillo en un restaurante. Yo solo digo "quiero una pizza margarita" y la cocina (la fábrica) sabe exactamente cómo prepararla. No necesito conocer la receta.

### 2. Ventajas de usar `ParticleFactory` en `ofApp::setup`

Comparar los dos enfoques:

**Sin fábrica** (todo en `setup`):
```cpp
Particle* p = new Particle();
p->size = ofRandom(2.0f, 4.0f);
p->color = ofColor(255, 0, 0);
// repetido 100 veces para "star", luego diferente para "shooting_star", etc.
```

**Con fábrica:**
```cpp
Particle* p = ParticleFactory::createParticle("star");
```

Las ventajas que identifico:

- **Principio de Responsabilidad Única (SRP):** `ofApp::setup` solo organiza la escena; `ParticleFactory` se encarga de la construcción. Cada clase tiene una sola razón para cambiar.
- **Legibilidad:** el código de `setup` es mucho más claro y declarativo.
- **Facilidad de extensión:** si cambio cómo se crea una "star", solo modifico la fábrica, no `setup`.

### 3. Agregar el tipo `"black_hole"`

Para agregar una partícula `"black_hole"` con tamaño grande, color negro y velocidad muy lenta, los pasos serían:

1. **Modificar `ParticleFactory::createParticle`** en `ofApp.cpp`, añadiendo un nuevo bloque `else if` con la configuración del nuevo tipo:
   ```cpp
   else if (type == "black_hole") {
       particle->size = ofRandom(10.0f, 15.0f);
       particle->color = ofColor(20, 20, 20);
       particle->velocity *= 0.1f;
   }
   ```
2. **Agregar las llamadas en `ofApp::setup`** para crear e registrar las nuevas partículas:
   ```cpp
   for (int i = 0; i < 3; ++i) {
       Particle* p = ParticleFactory::createParticle("black_hole");
       particles.push_back(p);
       addObserver(p);
   }
   ```

Lo importante es que la lógica de construcción (tamaño, color, velocidad) queda encapsulada en la fábrica. `ofApp::setup` solo indica *cuántas* quiere y de *qué tipo*, sin preocuparse de cómo se configuran internamente. Si en el futuro cambio los parámetros del `"black_hole"`, solo toco la fábrica.

### 4. Método estático vs. método de instancia

El método `createParticle` en este caso es **estático**. Las implicaciones son:

| Aspecto | Estático | De instancia |
|---------|----------|--------------|
| Uso | `ParticleFactory::createParticle(type)` | `factory.createParticle(type)` |
| Estado | No puede guardar estado entre llamadas | Puede mantener configuración interna |
| Flexibilidad | Limitado: siempre el mismo comportamiento | Permite múltiples fábricas con distintos parámetros |
| Simplicidad | Mayor: no hay que instanciar | Menor: requiere crear y gestionar el objeto fábrica |

Para este caso de estudio el método estático es suficiente porque la fábrica no necesita estado propio. Sin embargo, si quisiera, por ejemplo, tener una fábrica que lleve un contador de partículas creadas o que permita configurar parámetros globales (como un rango de tamaño diferente), necesitaría una instancia con estado.
