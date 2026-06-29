> [!important] Cómo funciona el oral
> 
> - Te hace **3 preguntas**. No te vas hasta responder **3 correctas**.
> - Distribución: **2 del primer parcial** (ecuaciones diferenciales, M1-M5) + **1 del segundo parcial** (integrales dobles y análisis vectorial, M6-M12).
> - Busca una **respuesta genérica de cómo se hace**, no un desarrollo completo. Conciso, pero diciendo lo esencial.
> - La pregunta de **vector tangente (significado físico)** se la hace a casi todos: tenela perfecta.

---

## PRIMER PARCIAL - Ecuaciones Diferenciales

### Qué es una ecuación diferencial y cómo se clasifica

**Para decir:** Una ecuación diferencial es una ecuación donde la incógnita es una **función**, no un número, y aparece relacionada con sus **derivadas**. Se clasifica por:

- **Tipo:** ordinaria (una sola variable independiente) o en derivadas parciales (varias).
- **Orden:** el de la derivada de mayor orden que aparece.
- **Linealidad:** lineal si la función incógnita y sus derivadas aparecen en primer grado, sin productos entre sí ni dentro de funciones no lineales.

**Por qué:** A diferencia de una ecuación algebraica, donde buscás un valor, acá buscás la función que satisface la relación entre ella y su tasa de cambio.

> [!note] De primer orden Es aquella donde aparece solo la **primera derivada**, ninguna de orden superior. Describe la relación entre una función y su tasa de cambio.

### Diferencial de una función en un punto

**Para decir:** El diferencial de $y = f(x)$ en un punto, respecto de un incremento $\Delta x$, es el **producto de la derivada por ese incremento**:

$$dy = df = f'(x)\cdot \Delta x$$

Y como caso particular, si $y = x$ entonces $dx = \Delta x$. Por eso se escribe $dy = f'(x),dx$.

**Por qué importa para EDO:** es lo que permite escribir una ecuación diferencial en la forma $M(x,y),dx + N(x,y),dy = 0$, manipular los diferenciales como objetos algebraicos (separar variables, por ejemplo) e integrar. Hereda las propiedades de la derivada: $d(k)=0$, $d(u\pm v)=du\pm dv$, $d(u\cdot v)=v,du+u,dv$.

### Tipos de solución

|Tipo|Qué es|
|---|---|
|**General**|Familia de todas las soluciones posibles. Contiene una **constante arbitraria** $C$.|
|**Particular**|Se obtiene de la general fijando $C$ con una **condición inicial**.|
|**Singular**|No sale de la general. Aparece al **anular el denominador** durante la separación de variables.|

**Por qué la general tiene $C$:** integrar introduce una constante; cada valor de $C$ da una curva distinta de la familia.

### Variables separables

**Para decir:** Es una EDO de primer orden donde puedo escribir la ecuación de modo que **cada variable quede de un lado** con su diferencial. Forma $\frac{dy}{dx} = f(x)\cdot g(y)$.

**Cómo se resuelve:**

1. Separo: todo lo de $y$ con $dy$, todo lo de $x$ con $dx$.
2. Integro ambos miembros por separado.
3. Despejo y obtengo la solución general (con $C$).

### Homogéneas

**Para decir:** Una EDO de primer orden es homogénea si $M,dx + N,dy = 0$ con $M$ y $N$ funciones **homogéneas del mismo grado**, o equivalentemente si $\frac{dy}{dx}$ depende solo de la razón $\frac{y}{x}$.

**Función homogénea de grado $n$:**

$$f(tx, ty) = t^n \cdot f(x, y) \quad \forall t \in \mathbb{R}$$

**Cómo se resuelve y para qué la sustitución:** Uso $v = \frac{y}{x}$ (es decir $y = vx$, $y' = v + xv'$). El objetivo es **transformarla en una de variables separables**, que sé resolver. Integro, y al final vuelvo a sustituir $v = y/x$.

> [!note] Idea clave de homogeneidad La solución depende de $x/y$ (o $y/x$), **no de $x$ e $y$ por separado**.

### Exactas

**Para decir:** La ecuación $M(x,y),dx + N(x,y),dy = 0$ es exacta si se cumple la igualdad de **derivadas cruzadas**:

$$\frac{\partial M}{\partial y} = \frac{\partial N}{\partial x}$$

**Por qué:** Si es exacta, existe una función potencial $F(x,y)$ tal que $\frac{\partial F}{\partial x} = M$ y $\frac{\partial F}{\partial y} = N$. La solución es $F(x,y) = C$. La condición de las cruzadas es justo la que garantiza que esa $F$ exista (igualdad de las segundas derivadas mixtas).

### Factor integrante

**Para decir:** Si la ecuación **no es exacta**, la multiplico por una función $\mu$ (el factor integrante) elegida para que **después de multiplicar sí se cumpla** la condición de exactitud.

**Cómo sé de qué variable depende:**

- Si $\dfrac{M_y - N_x}{N}$ queda en función **solo de $x$**, entonces $\mu = \mu(x)$.
- Si $\dfrac{N_x - M_y}{M}$ queda en función **solo de $y$**, entonces $\mu = \mu(y)$.

**Por qué funciona:** El factor integrante es el mismo concepto que en las lineales: una función que reordena la ecuación para que quede "lista para integrar".

### Lineales

**Para decir:** Es lineal cuando se escribe en la **forma canónica**:

$$y' + P(x),y = Q(x)$$

es decir, $y$ e $y'$ aparecen en **primer grado**, sin productos entre sí ni dentro de funciones no lineales.

**Cómo se resuelve (factor integrante):**

1. Calculo el factor integrante $\mu(x) = e^{\int P(x),dx}$.
2. Multiplico toda la ecuación por $\mu(x)$.
3. El **lado izquierdo se vuelve la derivada de un producto**: $\big(y\cdot\mu(x)\big)' = \mu(x),Q(x)$.
4. Integro ambos lados y despejo $y$.

> [!important] El punto que pregunta seguido Después de multiplicar por el factor integrante, el lado izquierdo tiene que quedar como $\big(y,\mu\big)'$ para poder integrar directo. Ese es el objetivo de todo el método.

### Aplicaciones de las ecuaciones diferenciales

**Para decir:** Las EDO modelan **fenómenos donde una magnitud cambia en función de su propia tasa de cambio**. Casos típicos:

- **Crecimiento/decaimiento:** $\frac{dy}{dt} = k,y$ (poblaciones, desintegración radiactiva). Solución exponencial.
- **Enfriamiento de Newton:** la temperatura cambia proporcional a la diferencia con el ambiente, $\frac{dT}{dt} = k,(T - T_a)$.
- **Mezclas:** variación de la cantidad de sustancia en un tanque = lo que entra menos lo que sale.

**Idea para el oral:** identifico qué tipo de EDO es (separable, lineal, etc.), la resuelvo con el método correspondiente y uso la **condición inicial** para hallar la solución particular.

---

## SEGUNDO PARCIAL - Integrales dobles y análisis vectorial

### Integrales de primer, segundo y tercer orden

|Orden|Expresión|Dominio|Significado geométrico|
|---|---|---|---|
|Primer|$\int f(x),dx$|intervalo (1D)|área bajo la curva|
|Segundo|$\iint_D f(x,y),dA$|región del plano (2D)|volumen bajo la superficie $z=f(x,y)$|
|Tercer|$\iiint_E f(x,y,z),dV$|sólido (3D)|masa/carga acumulada en el sólido|

**Diferencia:** cambia la **dimensión del dominio** y el elemento diferencial: $dx$, $dA$, $dV$.

### Teorema de Fubini

**Para decir:** Si $f$ es **continua** en un rectángulo $R = [a,b]\times[c,d]$, la integral doble se puede calcular como una **integral iterada**, y el **orden no altera el resultado**:

$$\iint_R f(x,y),dA = \int_a^b!\int_c^d f(x,y),dy,dx = \int_c^d!\int_a^b f(x,y),dx,dy$$

**Por qué importa:** es el teorema que **justifica** que una integral doble (que en principio es un límite de sumas) se pueda resolver integrando una variable por vez. Geométricamente, calcula el volumen sumando áreas de secciones transversales.

> [!note] Cuidado En un **rectángulo** los dos órdenes dan lo mismo directamente. En una región general, antes de cambiar el orden hay que **re-describir la región** (no se intercambian los límites tal cual).

### Región tipo 1 vs tipo 2

**Para decir:**

- **Tipo 1:** la región está entre **dos funciones continuas de $x$**. Los límites de $x$ son fijos ($a$ y $b$), e $y$ varía entre $g_1(x)$ y $g_2(x)$.

$$D = {(x,y): a \le x \le b,\ g_1(x) \le y \le g_2(x)}$$

En la integral iterada, $dy$ va **adentro** y $dx$ afuera.

- **Tipo 2:** la región está entre **dos funciones continuas de $y$**. Los límites de $y$ son fijos, y $x$ varía entre $h_1(y)$ y $h_2(y)$. El gráfico **depende de $y$**, porque $x$ queda acotado entre funciones de $y$. Acá $dx$ va adentro.

### Área con integral doble

**Para decir:** El área de $D$ se calcula con una integral doble cuyo **integrando es $1$**:

$$A(D) = \iint_D 1 , dA$$

Así la integral solo "suma" áreas diferenciales dentro de $D$. Describo la región como tipo 1 o tipo 2 y armo la integral iterada correspondiente.

### Orden de integración y por qué se cambia

**Para decir:** A veces el orden dado vuelve la integral **difícil o imposible** de calcular (por el integrando o por cómo queda descripta la región). Cambiando el orden, la región se describe más simple o el integrando se vuelve integrable.

> [!warning] Regla práctica El orden se lee **estrictamente** de la notación: el diferencial interior y sus límites definen la variable que se integra primero. No cambiar el orden sin re-describir la región (volver a leer los puntos de intersección y los límites).

### Cambio de variables y jacobiano

**Para decir:** Hago un cambio de variables para **simplificar la integral**: porque la región es complicada o porque el integrando se maneja mejor en las nuevas variables. Al cambiar, hay que multiplicar por el **factor jacobiano**.

**Qué es y cómo se calcula:** El jacobiano es el **determinante de la matriz de derivadas parciales** del cambio $x=x(u,v),\ y=y(u,v)$:

$$J = \frac{\partial(x,y)}{\partial(u,v)} = 

\begin{vmatrix}
	\dfrac{ \partial x}{\partial u} & \dfrac{\partial x}{\partial v} 
	\\
	\dfrac{\partial y}{\partial u} & \dfrac{\partial y}{\partial v} 
\end{vmatrix}
$$




y la integral queda $\iint_D f,dx,dy = \iint_{D'} f \cdot |J|,du,dv$.

### Significado geométrico del jacobiano y relación entre jacobianos

**Para decir (geométrico):** El jacobiano describe **cómo se deforma el área** al pasar del sistema $(u,v)$ al $(x,y)$. Indica cómo un **rectángulo chiquito** en $(u,v)$ se transforma en un **paralelogramo** en $(x,y)$. Su valor absoluto es el factor que ajusta el área.

**Relación entre los factores (jacobiano inverso):** El jacobiano de la transformación inversa es el **recíproco** del directo:

$$\frac{\partial(u,v)}{\partial(x,y)} = \frac{1}{\dfrac{\partial(x,y)}{\partial(u,v)}}$$

**Por qué:** ir y volver entre los dos sistemas no puede cambiar el área total; por eso un factor deshace al otro.

### Cambio a coordenadas polares (cambio "trigonométrico")

**Para decir:** Conviene cuando integro sobre una **región circular, anular (corona) o sectores**. El cambio es:

$$x = r\cos\theta, \quad y = r\sin\theta, \quad |J| = r$$

así $dA = r,dr,d\theta$.

**Por qué conviene:** transforma la región circular en un **rectángulo** en el plano $(r,\theta)$ y simplifica los límites y muchas veces el integrando.

### Otros cambios de variable típicos

|Región limitada por...|Cambio que conviene|Resultado|
|---|---|---|
|Rectas tipo $x+y$|lineal: $u = x+y$, $v = x-y$|rectángulo en $(u,v)$|
|Hipérbolas|$u = xy$, $v = x/y$|rectas / rectángulo en $(u,v)$|
|Círculos, coronas|polares: $x=r\cos\theta,\ y=r\sin\theta$|rectángulo en $(r,\theta)$|

**Idea general:** elijo el cambio que **endereza la frontera** de la región hasta volverla un rectángulo.

### Integral doble respecto de una parábola

**Para decir (cómo se plantea):**

1. Identifico las curvas que limitan la región (ej. la parábola y una recta o eje).
2. **Calculo los puntos de intersección** resolviendo el sistema entre las curvas.
3. Indico el **intervalo** entre esas intersecciones y recién ahí decido si es tipo 1 o tipo 2.
4. Armo la integral iterada con esos límites y la calculo.

> [!warning] Orden correcto al describir la región Primero las intersecciones, después el intervalo, y solo entonces un valor de prueba para confirmar cuál curva está arriba/abajo. No elegir el valor de prueba antes de tener las intersecciones.

### Aplicación física: masa y centro de masa de una lámina

**Para decir:** Si una lámina ocupa una región $D$ con función de **densidad** $\rho(x,y)$ (masa por área), entonces:

**Masa:** $$m = \iint_D \rho(x,y),dA$$

**Centro de masa** $(\bar x, \bar y)$, el punto donde la lámina se equilibra (como si toda la masa estuviera concentrada ahí): $$\bar x = \frac{M_y}{m} = \frac{1}{m}\iint_D x,\rho(x,y),dA, \qquad \bar y = \frac{M_x}{m} = \frac{1}{m}\iint_D y,\rho(x,y),dA$$

donde $M_y$ y $M_x$ son los **momentos** respecto de los ejes (masa por distancia al eje).

> [!note] Conexión típica Si la región es circular o un sector, conviene resolver estas integrales en **polares** (recordando el $|J| = r$). Es un ejercicio clásico: densidad proporcional a la distancia al centro sobre una lámina semicircular.

### Funciones vectoriales: derivada y segunda derivada

**Para decir:** Una función vectorial $\vec r(t)$ va de $\mathbb{R}$ a $\mathbb{R}^2$ o $\mathbb{R}^3$; el parámetro $t$ suele ser el **tiempo** y la imagen es una **curva**.

- $\vec r'(t)$ = **vector velocidad** (hacia dónde y a qué ritmo se mueve el punto).
- $\vec r''(t)$ = **vector aceleración** en ese punto.

> [!note] Imagen vs ecuación cartesiana Al eliminar el parámetro, la **curva cartesiana** suele tener **más puntos** que la imagen de la función vectorial, y además la función vectorial le agrega una **orientación** (sentido de recorrido) que la cartesiana no tiene.

### Vector tangente - significado físico (LA pregunta de siempre)

> [!important] Tenela perfecta El vector tangente $\vec r'(t)$ representa la **velocidad instantánea** del punto que recorre la curva: indica la **dirección** en la que se mueve y **qué tan rápido** lo hace en ese instante. Su módulo es la rapidez; su dirección es tangente a la trayectoria.

### Longitud de una curva (longitud de arco)

**Para decir:** Se calcula **integrando la norma del vector derivada** entre los valores del parámetro:

$$L = \int_a^b |\vec r'(t)|,dt = \int_a^b \sqrt{x'(t)^2 + y'(t)^2 + z'(t)^2},dt$$

**Por qué (de dónde sale):** Por **Pitágoras** sobre un desplazamiento diferencial: $ds = \sqrt{dx^2+dy^2+dz^2}$. La norma de $\vec r'(t)$ mide cuánto "avanza" la curva por unidad de parámetro, y al integrarla sumo todos esos avances.

### Recta tangente a una curva (función vectorial)

**Para decir:** Evalúo la curva en $t_0$ para el **punto** $\vec r(t_0)$, y uso $\vec r'(t_0)$ como **vector director**:

$$L:\ \vec r(t_0) + \lambda,\vec r'(t_0), \quad \lambda \in \mathbb{R}$$

### Plano normal a una curva en un punto

**Para decir:** Pasa por el punto $\vec r(t_0)$ y toma como **vector normal** al tangente $\vec r'(t_0)$. Su ecuación:

$$\big(\vec P - \vec r(t_0)\big)\cdot \vec r'(t_0) = 0$$

**Por qué:** el plano normal es perpendicular a la dirección de avance de la curva; por eso el tangente actúa como normal del plano.

### Campo vectorial y campo gradiente

**Para decir:** Un **campo vectorial** asigna a cada punto del plano (o del espacio) un **vector**. En $\mathbb{R}^2$: $\vec F(x,y) = \big(P(x,y);,Q(x,y)\big)$. Modela cosas como un campo de fuerzas o el flujo de un fluido.

**Campo gradiente:** dado un campo escalar $f$, su **gradiente** es el campo vectorial formado por las derivadas parciales: $$\nabla f = \big(f_x';,f_y'\big) \quad (\text{en } \mathbb{R}^3:\ \nabla f = (f_x';,f_y';,f_z'))$$

### Integral de línea: escalar vs vectorial

**Para decir:** Son integrales sobre una **curva** $C$ en lugar de sobre un intervalo o una región.

|Tipo|Fórmula|Qué calcula|
|---|---|---|
|**Escalar**|$\displaystyle\int_C f,ds = \int_a^b f(\vec r(t)),\|\vec r'(t)\|,dt$|suma de un campo escalar a lo largo de la curva (ej. masa de un alambre)|
|**Vectorial**|$\displaystyle\int_C \vec F\cdot d\vec r = \int_a^b \vec F(\vec r(t))\cdot \vec r'(t),dt$|el **trabajo** de un campo de fuerzas que mueve una partícula a lo largo de $C$|

**Clave:** en la escalar uso $ds = |\vec r'(t)|,dt$ (un escalar); en la vectorial proyecto el campo sobre la dirección de avance ($\vec F\cdot\vec r'$).

### Campos conservativos e independencia de la trayectoria

**Para decir:** Un campo es **conservativo** si es el **gradiente de una función potencial** $f$, es decir $\vec F = \nabla f$. En ese caso la integral de línea **no depende del camino**, solo de los puntos inicial y final.

**Criterio para saber si es conservativo:**

- En $\mathbb{R}^2$, con $\vec F = (M;N)$: es conservativo si y solo si $\dfrac{\partial M}{\partial y} = \dfrac{\partial N}{\partial x}$.
- En $\mathbb{R}^3$: es conservativo si y solo si $\text{rot},\vec F = \vec 0$.

**Cómo hallar la función potencial $f$:** integro $M$ respecto de $x$, derivo el resultado respecto de $y$ y lo igualo a $N$ para descubrir la parte que falta. Así reconstruyo $f$ tal que $\nabla f = \vec F$.

**Teorema fundamental de las integrales de línea:** si $\vec F = \nabla f$, entonces $$\int_C \nabla f\cdot d\vec r = f(B) - f(A)$$

es decir, basta evaluar la potencial en los extremos.

> [!important] La conexión que vale oro en el oral Las **ecuaciones exactas** y los **campos conservativos** son el mismo concepto:
> 
> - Misma condición: exacta pide $M_y' = N_x'$; conservativo en $\mathbb{R}^2$ pide $M_y' = N_x'$.
> - Misma idea: en exactas existe $F$ con $F_x' = M$, $F_y' = N$ y la solución es $F(x,y)=C$; en conservativos existe la función potencial $f$ con $\nabla f = \vec F$. Reconocer esto muestra que entendés la materia de fondo, no de memoria.

---

> [!note] Estrategia para el día
> 
> 1. Si te dan a elegir o podés guiar la respuesta, andá a los temas que tenés más sólidos.
> 2. Empezá siempre por la **definición corta** y después el **cómo se hace / para qué sirve**. Eso es lo que busca.
> 3. Mayor probabilidad: vector tangente físico, jacobiano (qué es + significado geométrico), las 4 familias de EDO, y región tipo 1/tipo 2. Tenelas redondas.
> 4. Carta para el 10: la **conexión exactas ↔ conservativos** (misma condición $M_y'=N_x'$, misma función potencial). Si podés deslizarla, te separa del resto.