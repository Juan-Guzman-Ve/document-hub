## Idea Central

En el modulo anterior las integrales dobles se calculaban sobre rectangulos. Ahora se extiende el concepto a **regiones D de forma arbitraria** en el plano XY.

La estrategia es encerrar D dentro de un rectangulo R y definir una funcion auxiliar F:

$$ F(x; y) = \begin{cases} f(x; y) & \text{si } (x; y) \in D \ 0 & \text{si } (x; y) \in R - D \end{cases} $$

Con esto se define:

$$ \iint_D f(x; y), dA = \iint_R F(x; y), dA $$

Los puntos fuera de D contribuyen cero a la integral, por lo que no afectan el resultado.

> [!note] Interpretacion geometrica Cuando $f(x; y) \geq 0$, la integral doble sobre D sigue representando el **volumen del solido** ubicado por encima de D y por debajo de la superficie $z = f(x; y)$.

> [!important] Condicion de existencia Si $f$ es continua en D y la frontera de D se "comporta bien" (curva simple), entonces la integral doble sobre D existe.

---

## Tipos de Regiones Elementales

Las regiones mas comunes se clasifican en dos tipos segun como se describen sus fronteras.

### Regiones de Tipo 1

La region D esta acotada **en y** por dos funciones continuas de x.

$$ D = {(x; y) ;/; a \leq x \leq b;; g_1(x) \leq y \leq g_2(x)} $$

La integral doble se convierte en:

$$ \iint_D f(x; y), dA = \int_a^b \int_{g_1(x)}^{g_2(x)} f(x; y); dy; dx $$

**Lectura grafica:** trazar una flecha vertical dentro de D. La flecha parte de $y = g_1(x)$ (limite inferior) y termina en $y = g_2(x)$ (limite superior). Los extremos en x son $a$ y $b$.

### Regiones de Tipo 2

La region D esta acotada **en x** por dos funciones continuas de y.

$$ D = {(x; y) ;/; c \leq y \leq d;; h_1(y) \leq x \leq h_2(y)} $$

La integral doble se convierte en:

$$ \iint_D f(x; y), dA = \int_c^d \int_{h_1(y)}^{h_2(y)} f(x; y); dx; dy $$

**Lectura grafica:** trazar una flecha horizontal dentro de D. La flecha parte de $x = h_1(y)$ (limite inferior en x) y termina en $x = h_2(y)$ (limite superior en x). Los extremos en y son $c$ y $d$.

### Tabla comparativa

|Tipo 1|Tipo 2|
|---|---|---|
|Variable exterior|$x \in [a, b]$|$y \in [c, d]$|
|Limites interiores|funciones de $x$: $g_1(x)$, $g_2(x)$|funciones de $y$: $h_1(y)$, $h_2(y)$|
|Orden de integracion|$dy; dx$|$dx; dy$|
|Flecha de referencia|vertical|horizontal|

> [!note] Una misma region puede ser de ambos tipos Algunas regiones admiten descripcion como tipo 1 y como tipo 2. Elegir el tipo mas conveniente puede simplificar mucho el calculo.

---

## Como Determinar los Limites de Integracion

El procedimiento es siempre el mismo:

1. **Graficar la region D**: identificar todas las curvas que forman su frontera.
2. **Encontrar los puntos de interseccion** entre las curvas que delimitan D (igualando las ecuaciones).
3. **Elegir el tipo de region** (1 o 2) segun cual genere limites mas simples.
4. **Determinar los limites exteriores**: los valores minimo y maximo de la variable exterior.
5. **Determinar los limites interiores**: expresar las curvas de la frontera en funcion de la variable exterior.

> [!important] Regla de la flecha Dibujar una flecha en la direccion de la variable interior (vertical para tipo 1, horizontal para tipo 2) atravesando la region.
> 
> - Donde entra la flecha: limite inferior interior.
> - Donde sale la flecha: limite superior interior.

---

## Cambio del Orden de Integracion

En ocasiones la integral tal como esta planteada **no puede resolverse** porque el integrando no tiene primitiva en terminos elementales (en la variable de la integral interior). En esos casos es necesario cambiar el orden de integracion.

### Procedimiento

1. Identificar la region D a partir de los limites de la integral original.
2. Graficar D.
3. Reescribir D como region del tipo opuesto (si era tipo 1, escribirla como tipo 2, y viceversa).
4. Establecer los nuevos limites de integracion.
5. Reescribir la integral con el nuevo orden.

### Ejemplo canonico

$$ \int_0^1 \int_{x^2}^1 x \cdot \text{sen}(y^2); dy; dx $$

El integrando $\int \text{sen}(y^2); dy$ no tiene primitiva elemental. Se cambia el orden:

- **Como tipo 1:** $x \in [0, 1]$, $y \in [x^2, 1]$. Flecha vertical: sube de $y = x^2$ a $y = 1$.
- **Como tipo 2:** $y \in [0, 1]$, $x \in [0, \sqrt{y}]$. Flecha horizontal: va de $x = 0$ a $x = \sqrt{y}$.

La integral equivalente es:

$$ \int_0^1 \int_0^{\sqrt{y}} x \cdot \text{sen}(y^2); dx; dy $$

Ahora la integral interior (respecto de x) es directa, y la exterior resulta resoluble con sustitucion $t = y^2$.

> [!warning] No toda integral permite cambiarse trivialmente El cambio de orden requiere re-derivar los limites desde el grafico de la region. No se trata de simplemente invertir los simbolos de integracion.

---

## Propiedades de la Integral Doble

Estas propiedades valen para integrales sobre regiones generales D.

**1. Linealidad (suma/resta):** $$ \iint_D [f(x; y) \pm g(x; y)], dA = \iint_D f(x; y), dA \pm \iint_D g(x; y), dA $$

**2. Linealidad (escalar):** $$ \iint_D k \cdot f(x; y), dA = k \cdot \iint_D f(x; y), dA $$

**3. Aditividad en la region:**

Si $D = D_1 \cup D_2$ y $D_1 \cap D_2 = \emptyset$ entonces: $$ \iint_D f(x; y), dA = \iint_{D_1} f(x; y), dA + \iint_{D_2} f(x; y), dA $$

**4. Area de D:** $$ \iint_D 1 \cdot dA = A(D) $$

Esta propiedad se deduce directamente de la definicion. Para una region tipo 1:

$$ A(D) = \int_a^b \int_{g_1(x)}^{g_2(x)} 1; dy; dx = \int_a^b [g_2(x) - g_1(x)]; dx $$

---

## Calculo de Volumenes

Si $f(x; y) \geq 0$ sobre D, el volumen del solido acotado superiormente por $z = f(x; y)$ y con base D es:

$$ V = \iint_D f(x; y), dA $$

El procedimiento es:

1. Determinar la region D proyectada en el plano XY (la base del solido).
2. Verificar que la superficie es positiva sobre D.
3. Establecer los limites de integracion a partir de D.
4. Calcular la integral doble.

---

## Calculo de Areas por Integrales Dobles

La propiedad 4 ($\iint_D 1, dA = A(D)$) permite calcular areas de regiones planas mediante integrales iteradas.

Para una region acotada por dos curvas $y = g_1(x)$ y $y = g_2(x)$ con $g_1(x) \leq g_2(x)$ en $[a, b]$:

$$ A(D) = \int_a^b \int_{g_1(x)}^{g_2(x)} dy; dx = \int_a^b [g_2(x) - g_1(x)]; dx $$

> [!note] Ventaja del enfoque con integrales dobles Algunas regiones son mas simples de describir como tipo 2 (en funcion de y), en cuyo caso conviene plantear la integral con orden $dx; dy$ para calcular el area con una sola integral iterada en lugar de dos.

---

## Ejemplos Tipo del Modulo

### Ejemplo 1 - Region tipo 1 entre dos parabolas

Evaluar $\iint_D (x + 2y), dA$ donde D es la region entre $y = 2x^2$ e $y = x^2 + 1$.

Intersecciones: $2x^2 = x^2 + 1 \Rightarrow x = \pm 1$.

Region tipo 1: $x \in [-1, 1]$, $y \in [2x^2,; x^2 + 1]$.

$$ \iint_D (x + 2y), dA = \int_{-1}^1 \int_{2x^2}^{x^2+1} (x + 2y); dy; dx = \frac{32}{15} $$

---

### Ejemplo 2 - Region tipo 2, frontera mixta (recta y parabola)

Evaluar $\iint_D x \cdot y, dA$ donde D esta limitada por $y = x - 5$ e $y^2 = x + 1$.

Las curvas se expresan en funcion de $y$:

- De $y^2 = x + 1$: $x = y^2 - 1$ (limite interior izquierdo)
- De $y = x - 5$: $x = y + 5$ (limite interior derecho)

Intersecciones: $y \in [-2, 3]$.

$$ \iint_D x \cdot y, dA = \int_{-2}^3 \int_{y^2-1}^{y+5} x \cdot y; dx; dy = \frac{1375}{24} $$

---

### Ejemplo 3 - Cambio de orden por integral no elemental

$$ \int_0^1 \int_{x^2}^1 x \cdot \text{sen}(y^2); dy; dx = \int_0^1 \int_0^{\sqrt{y}} x \cdot \text{sen}(y^2); dx; dy = \frac{1}{4}(1 - \cos 1) $$

---

### Ejemplo 4 - Area con integral doble (tipo 2 conveniente)

Area de la region entre $f(x) = \frac{1}{2}x^2$ e $y = 4 - x$.

Se plantea como tipo 2 (una sola integral):

- $y \in [0, 2]$, $x \in [\sqrt{2y},; y + 4]$

$$ A = \int_0^2 \int_{\sqrt{2y}}^{y+4} dx; dy = \frac{26}{6} $$

---

### Ejemplo 5 - Area entre parabola y recta (tipo 1)

Region entre $y = x^2$ e $y = 2x$. Interseccion: $x = 0$ y $x = 2$.

$$ A(D) = \int_0^2 \int_{x^2}^{2x} dy; dx = \int_0^2 (2x - x^2); dx = \frac{4}{3} $$

---

## Resumen de Estrategia General

```
1. Graficar la region D
2. Encontrar intersecciones de las curvas de la frontera
3. Elegir tipo 1 o tipo 2 segun conveniencia
4. Trazar la flecha en la direccion de la integral interior
5. Leer los limites desde el grafico
6. Si la integral interior no es elemental -> cambiar orden
7. Calcular de adentro hacia afuera
```

> [!important] Criterio para elegir el tipo de region Elegir el tipo que haga los limites interiores mas simples. Si con un tipo los limites se expresan con una sola funcion y con el otro se necesitan tramos, preferir el primero. Si la funcion integranda no tiene primitiva en una variable, forzar el cambio al otro tipo.