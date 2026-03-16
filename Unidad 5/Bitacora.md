## Actividad 1
### Parte 1: recordando los conceptos (en C#)
**1. ¿Qué es el encapsulamiento para ti?**

**Respuesta:** Es la seguridad en el acceso a los datos del objeto, esta puede ser: `Pública` `Privada` o `Protegida`, la unica manera en la que se tiene acceso al atributo encapsulado es con sus propios metodos los cuales son `getters` y `setters`.

- **Getters** → permiten **obtener** el valor de un atributo.
- **Setters** → permiten **modificar** el valor de un atributo.


**1.1. Describe una situación en la que te haya sido útil o donde hayas visto su importancia.**

**Respuesta:** Situación donde se ve la importancia del encapsulamiento

En un proyecto que hice en programación, me di cuenta de la importancia del **encapsulamiento** cuando estaba trabajando con clases que tenían atributos que no deberían modificarse directamente.

Por ejemplo, si tengo una clase que representa una **cuenta bancaria**, el saldo no debería poder cambiarse desde cualquier parte del programa, porque alguien podría asignarle cualquier valor, incluso uno negativo. Por eso, el saldo se puede mantener como un **atributo privado** y solo permitir que se modifique mediante métodos como `depositar()` o `retirar()`.

De esta forma, el programa controla cómo se modifican los datos y evita errores.

**2. ¿Qué es la herencia?**

**Respuesta:** Es la **transferencia de metodos y atributos** que reciben las `clase hijas` de la `clase padre` por lo que quedan con los **mismos datos** y se agiliza el ttrabajo.

 **2.1. ¿Por qué un programador decidiría usarla? Da un ejemplo simple.**

**Respuesta:** Porque **restaria tiempo** ya que es mas fácil crear algo y que se `herede`,porque **permite reutilizar código y evitar repetirlo**. Cuando varias clases tienen características en común, se puede crear una clase base con esas características y luego otras clases pueden heredarlas. **Esto hace que el código sea más organizado, fácil de mantener y más claro.**
 

**3. ¿Qué es el polimorfismo?**

**Respuesta:** Es la **capacidad** que tienen `objetos de distintas clases` para **responder a un mismo mensaje o método de manera única**, ninguno va a tener el mismo código.


**3.1. Describe con tus palabras qué significa que un código sea “polimórfico”.**

**Respuesta:** Un código es **polimórfico** cuando diferentes objetos pueden usar **el mismo método o la misma operación**, pero cada uno **lo ejecuta de manera diferente** según su propia clase.

En otras palabras, el programa puede llamar al mismo método en varios objetos, y cada objeto responde con un **comportamiento distinto**. Esto permite escribir código más **flexible y reutilizable**, porque no es necesario crear métodos completamente diferentes para cada tipo de objeto.

### Parte 2: análisis de código (en C#)
### Código c#
```csharp
using System;using System.Collections.Generic;
public abstract class Figura{    
		private string nombre;
    public string Nombre {        
		    get { return nombre;}
		    protected set { nombre = value; }    
		    }
    public Figura(string nombre)    {        
		    this.Nombre = nombre;    
		    }
    public abstract void Dibujar();
    }
public class Circulo : Figura{    
		public double Radio { get; private set; }
    public Circulo(double radio) : base("Círculo")    {        
		    this.Radio = radio;    
		    }
    public override void Dibujar()    {        
		    Console.WriteLine($"Dibujando un {Nombre} de radio {Radio}.");    
		    }
		}
public class Rectangulo : Figura{    
		public double Base { get; private set; }    
		public double Altura { get; private set; }
    public Rectangulo(double b, double h) : base("Rectángulo")    {        
		    this.Base = b;        
		    this.Altura = h;    
		    }
    public override void Dibujar()    {        
		    Console.WriteLine($"Dibujando un {Nombre} de {Base}x{Altura}.");    
		    }
		}
public class Programa{    
		public static void Main()    {        
				List<Figura> misFiguras = new List<Figura>();
        misFiguras.Add(new Circulo(5.0));        
        misFiguras.Add(new Rectangulo(4.0, 6.0));        
        misFiguras.Add(new Circulo(10.0));
        foreach (Figura fig in misFiguras) {            
		        fig.Dibujar();        
		        }    
		    }
		}
```
**Encapsulamiento:**

- Señala una línea de código que sea un ejemplo claro de encapsulamiento y explica por qué lo es.
```csharp
private string nombre;
```


- ¿Por qué crees que el campo nombre es private pero la propiedad Nombre es public? ¿Qué problema se evita con esto?

Por que se quiere **encapsular el atributo para que nadie tenga acceso a el** pero se **deja libre un espacio mendiante el** `public` para que los **metodos si puedan acceder a los atributos.**

**Herencia:**

- ¿Cómo se evidencia la herencia en la clase Circulo?
```csharp
public class Circulo : Figura{
```
Aquí la clase `Circulo` está heredando de la clase `Figura`. Esto significa que Circulo **obtiene las propiedades y métodos definidos en Figura**, como `Nombre` y el **método** `Dibujar`
- Un objeto de tipo Circulo, además de Radio, ¿Qué otros datos almacena en su interior gracias a la herencia?

Almacena también el **método** `Dibujar` y el **atributo** `Nombre`

**Polimorfismo:**

- Observa el bucle `foreach`. La variable `fig` es de tipo Figura, pero a veces contiene un Circulo y otras un Rectangulo. Cuando se llama a `fig.Dibujar()`, el programa ejecuta la versión correcta.

 En tu opinión, ¿Cómo crees que funciona esto “por debajo”? No necesitas saber la respuesta correcta, solo quiero que intentes razonar cómo podría ser.

 **Respuesta:** Yo creo que el programa revisa **qué tipo real de objeto está guardado en esa variable en ese momento**.  
Si el objeto es un `Circulo`, ejecuta el método `Dibujar()` de **Circulo**; y si es un `Rectangulo`, ejecuta el método `Dibujar()` de **Rectangulo**.

Es como si el programa **identificara el tipo real del objeto en tiempo de ejecución** y luego llamara a la versión del método que corresponde a esa clase.  

Esto permite que **diferentes objetos respondan de forma distinta a la misma llamada de método**, lo cual es justamente lo que se conoce como **polimorfismo**.

### Parte 3: hipótesis sobre la implementación

- **Memoria y herencia: cuando creas un objeto Rectangulo, este tiene Base, Altura y también Nombre. ¿Cómo te imaginas que se organizan esos tres datos en la memoria del computador para formar un solo objeto?**

**Respuesta:** Cuando se crea un objeto `Rectangulo`, yo me imagino que en la memoria del computador se guarda todo como **un solo bloque de datos**. En ese bloque se almacenan tanto los atributos que vienen de la **clase padre** como los que pertenecen a la **clase hija**.

Por ejemplo, el objeto podría tener primero el dato que hereda de `Figura`, que es `Nombre`, y después los atributos propios de `Rectangulo`, que son `Base` y `Altura`.

De esta manera todo queda **dentro del mismo objeto en memoria**, pero incluyendo también los datos heredados de la clase padre.

Algo así como una **estructura continua en memoria** que contiene todos los valores del objeto.

- **El mecanismo del polimorfismo: pensemos de nuevo en la llamada fig.Dibujar(). El compilador solo sabe que fig es una Figura. ¿Cómo decide el programa, mientras se está ejecutando, si debe llamar al Dibujar del Circulo o al del Rectangulo? Lanza algunas ideas o hipótesis.**

**Respuesta:** Cuando el programa ejecuta `fig.Dibujar()`, aunque la variable `fig` sea de tipo `Figura`, en realidad puede estar apuntando a un objeto de tipo `Circulo` o `Rectangulo`.

Yo creo que el programa revisa **el tipo real del objeto en ese momento de la ejecución**. Dependiendo del tipo que encuentre, llama a la versión correcta del método `Dibujar()`.

Es decir, si el objeto realmente es un `Circulo`, se ejecuta `Circulo.Dibujar()`, y si es un `Rectangulo`, se ejecuta `Rectangulo.Dibujar()`.

Es como si cada objeto guardara **alguna información interna que indica a qué clase pertenece**, y con eso el programa sabe qué método usar.

- **La barrera del encapsulamiento: ¿Cómo crees que el compilador logra que no puedas acceder a un miembro private desde fuera de la clase? ¿Es algo que se revisa cuando escribes el código, o es una protección que existe mientras el programa se ejecuta? ¿Por qué piensas eso?**

**Respuesta:** Yo pienso que el compilador revisa esto **cuando se está escribiendo y compilando el código**. Si un atributo está marcado como `private`, el compilador simplemente **no permite que otra clase lo use directamente**.

Por ejemplo, si desde otra clase se intenta acceder a un atributo `private`, el compilador genera un **error de compilación** y el programa ni siquiera se ejecuta.

Creo que esto ocurre principalmente en la **etapa de compilación**, porque el lenguaje ya conoce las reglas de acceso (`public`, `private`, `protected`) y puede verificarlas antes de que el programa se ejecute.

De esta manera se **protege la información del objeto** y se obliga a que los datos se manipulen solamente mediante **métodos controlados**, como propiedades, *getters* o *setters*.

### Parte 4: y tu autoevaluación y primeras preguntas
Voy a seguir la ruta guiada