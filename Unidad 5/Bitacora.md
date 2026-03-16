### Actividad 1
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