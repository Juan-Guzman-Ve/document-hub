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

#### Ejercicio resuelto

Clasificar las siguientes ecuaciones.

**a)** $\dfrac{dy}{dx} + x^2 y = \sin x$

- Tipo: **ordinaria** (una sola variable independiente, $x$).
- Orden: **1** (la derivada de mayor orden es la primera).
- Linealidad: **lineal**, porque $y$ e $y'$ aparecen en primer grado y no están multiplicadas entre sí ni dentro de funciones no lineales.

**b)** $(y')^2 + y = x$

- Tipo: **ordinaria**. Orden: **1**.
- Linealidad: **no lineal**, porque $y'$ aparece **al cuadrado**.

**c)** $y'' + 3y' + 2y = 0$

- Tipo: **ordinaria**. Orden: **2**.
- Linealidad: **lineal** (todos los términos en $y$, $y'$, $y''$ son de primer grado).

### Diferencial de una función en un punto

**Para decir:** El diferencial de $y = f(x)$ en un punto, respecto de un incremento $\Delta x$, es el **producto de la derivada por ese incremento**:

$$dy = df = f'(x)\cdot \Delta x$$

Y como caso particular, si $y = x$ entonces $dx = \Delta x$. Por eso se escribe $dy = f'(x),dx$.

**Por qué importa para EDO:** es lo que permite escribir una ecuación diferencial en la forma $M(x,y),dx + N(x,y),dy = 0$, manipular los diferenciales como objetos algebraicos (separar variables, por ejemplo) e integrar. Hereda las propiedades de la derivada: $d(k)=0$, $d(u\pm v)=du\pm dv$, $d(u\cdot v)=v,du+u,dv$.

#### Ejercicio resuelto

Sea $f(x) = x^3 - 2x$. Calcular el diferencial en $x = 2$ para $\Delta x = 0.1$ y compararlo con el cambio real $\Delta y$.

**Paso 1 - Diferencial:** $$df = f'(x),\Delta x = (3x^2 - 2),\Delta x$$

**Paso 2 - Evalúo en $x=2$, $\Delta x = 0.1$:** $$df = (3\cdot 2^2 - 2)\cdot 0.1 = (12 - 2)\cdot 0.1 = 10 \cdot 0.1 = 1$$

**Paso 3 - Cambio real:** $$\Delta y = f(2.1) - f(2) = (9.261 - 4.2) - (8 - 4) = 5.061 - 4 = 1.061$$

El diferencial ($1$) aproxima al cambio real ($1.061$). La diferencia es el error de usar la recta tangente en lugar de la curva.

### Tipos de solución

|Tipo|Qué es|
|---|---|
|**General**|Familia de todas las soluciones posibles. Contiene una **constante arbitraria** $C$.|
|**Particular**|Se obtiene de la general fijando $C$ con una **condición inicial**.|
|**Singular**|No sale de la general. Aparece al **anular el denominador** durante la separación de variables.|

**Por qué la general tiene $C$:** integrar introduce una constante; cada valor de $C$ da una curva distinta de la familia.

#### Ejercicio resuelto

Dada $\dfrac{dy}{dx} = y^2$, hallar las soluciones general, particular (con $y(0)=1$) y singular.

**General:** separo variables (dividiendo por $y^2$): $$\frac{dy}{y^2} = dx ;\Rightarrow; \int y^{-2},dy = \int dx ;\Rightarrow; -\frac{1}{y} = x + C ;\Rightarrow; y = -\frac{1}{x + C}$$

**Particular:** uso $y(0) = 1$: $$1 = -\frac{1}{0 + C} ;\Rightarrow; C = -1 ;\Rightarrow; y = \frac{1}{1 - x}$$

**Singular:** al dividir por $y^2$ supuse $y \neq 0$. Pero $y = 0$ también verifica la ecuación ($0' = 0^2$) y **no se obtiene** de la general para ningún $C$. Es la solución singular.

### Variables separables

**Para decir:** Es una EDO de primer orden donde puedo escribir la ecuación de modo que **cada variable quede de un lado** con su diferencial. Forma $\frac{dy}{dx} = f(x)\cdot g(y)$.

**Cómo se resuelve:**

1. Separo: todo lo de $y$ con $dy$, todo lo de $x$ con $dx$.
2. Integro ambos miembros por separado.
3. Despejo y obtengo la solución general (con $C$).

#### Ejercicio resuelto

Resolver $\dfrac{dy}{dx} = \dfrac{x}{y}$.

**Paso 1 - Separo:** $$y,dy = x,dx$$

**Paso 2 - Integro ambos lados:** $$\int y,dy = \int x,dx ;\Rightarrow; \frac{y^2}{2} = \frac{x^2}{2} + C$$

**Paso 3 - Despejo (multiplico por 2 y renombro la constante):** $$y^2 - x^2 = C_1$$

La solución general es la familia de hipérbolas $y^2 - x^2 = C_1$.

### Homogéneas

**Para decir:** Una EDO de primer orden es homogénea si $M,dx + N,dy = 0$ con $M$ y $N$ funciones **homogéneas del mismo grado**, o equivalentemente si $\frac{dy}{dx}$ depende solo de la razón $\frac{y}{x}$.

**Función homogénea de grado $n$:**

$$f(tx, ty) = t^n \cdot f(x, y) \quad \forall t \in \mathbb{R}$$

**Cómo se resuelve y para qué la sustitución:** Uso $v = \frac{y}{x}$ (es decir $y = vx$, $y' = v + xv'$). El objetivo es **transformarla en una de variables separables**, que sé resolver. Integro, y al final vuelvo a sustituir $v = y/x$.

> [!note] Idea clave de homogeneidad La solución depende de $x/y$ (o $y/x$), **no de $x$ e $y$ por separado**.

#### Ejercicio resuelto

Resolver $\dfrac{dy}{dx} = \dfrac{x^2 + y^2}{xy}$.

**Paso 1 - Verifico que es homogénea.** Divido numerador y denominador por $x^2$: $$\frac{dy}{dx} = \frac{x^2 + y^2}{xy} = \frac{1 + (y/x)^2}{y/x}$$ Depende solo de $y/x$: es homogénea.

**Paso 2 - Sustituyo** $y = vx$, $\dfrac{dy}{dx} = v + x\dfrac{dv}{dx}$: $$v + x\frac{dv}{dx} = \frac{1 + v^2}{v}$$

**Paso 3 - Despejo la derivada:** $$x\frac{dv}{dx} = \frac{1 + v^2}{v} - v = \frac{1 + v^2 - v^2}{v} = \frac{1}{v}$$

**Paso 4 - Separo variables e integro:** $$v,dv = \frac{dx}{x} ;\Rightarrow; \frac{v^2}{2} = \ln|x| + C$$

**Paso 5 - Deshago la sustitución** ($v = y/x$): $$\frac{y^2}{2x^2} = \ln|x| + C ;\Rightarrow; y^2 = 2x^2\big(\ln|x| + C\big)$$

### Exactas

**Para decir:** La ecuación $M(x,y),dx + N(x,y),dy = 0$ es exacta si se cumple la igualdad de **derivadas cruzadas**:

$$\frac{\partial M}{\partial y} = \frac{\partial N}{\partial x}$$

**Por qué:** Si es exacta, existe una función potencial $F(x,y)$ tal que $\frac{\partial F}{\partial x} = M$ y $\frac{\partial F}{\partial y} = N$. La solución es $F(x,y) = C$. La condición de las cruzadas es justo la que garantiza que esa $F$ exista (igualdad de las segundas derivadas mixtas).

#### Ejercicio resuelto

Resolver $(2xy + 3),dx + (x^2 - 1),dy = 0$.

**Paso 1 - Verifico exactitud:** $$M = 2xy + 3 ;\Rightarrow; M_y' = 2x \qquad N = x^2 - 1 ;\Rightarrow; N_x' = 2x$$ Como $M_y' = N_x' = 2x$, **es exacta**.

**Paso 2 - Integro $M$ respecto de $x$:** $$F = \int (2xy + 3),dx = x^2 y + 3x + h(y)$$

**Paso 3 - Derivo respecto de $y$ y comparo con $N$:** $$F_y' = x^2 + h'(y) \stackrel{!}{=} N = x^2 - 1 ;\Rightarrow; h'(y) = -1 ;\Rightarrow; h(y) = -y$$

**Paso 4 - Armo $F$ y escribo la solución:** $$F(x,y) = x^2 y + 3x - y = C$$

### Factor integrante

**Para decir:** Si la ecuación **no es exacta**, la multiplico por una función $\mu$ (el factor integrante) elegida para que **después de multiplicar sí se cumpla** la condición de exactitud.

**Cómo sé de qué variable depende:**

- Si $\dfrac{M_y' - N_x'}{N}$ queda en función **solo de $x$**, entonces $\mu = \mu(x)$.
- Si $\dfrac{N_x' - M_y'}{M}$ queda en función **solo de $y$**, entonces $\mu = \mu(y)$.

**Por qué funciona:** El factor integrante es el mismo concepto que en las lineales: una función que reordena la ecuación para que quede "lista para integrar".

#### Ejercicio resuelto

Resolver $(y + \ln x),dx - x,dy = 0$.

**Paso 1 - No es exacta:** $$M = y + \ln x ;\Rightarrow; M_y' = 1 \qquad N = -x ;\Rightarrow; N_x' = -1 \quad (1 \neq -1)$$

**Paso 2 - Pruebo factor en $x$:** $$\frac{M_y' - N_x'}{N} = \frac{1 - (-1)}{-x} = -\frac{2}{x}$$ Depende solo de $x$, así que existe $\mu(x)$.

**Paso 3 - Hallo $\mu$** resolviendo $\dfrac{d\mu}{dx} = -\dfrac{2}{x}\mu$ (separable): $$\frac{d\mu}{\mu} = -\frac{2}{x},dx ;\Rightarrow; \ln|\mu| = -2\ln|x| ;\Rightarrow; \mu(x) = \frac{1}{x^2}$$

**Paso 4 - Multiplico y confirmo exactitud:** $$\frac{y + \ln x}{x^2},dx - \frac{1}{x},dy = 0$$ $$P = \frac{y + \ln x}{x^2} \Rightarrow P_y' = \frac{1}{x^2} \qquad Q = -\frac{1}{x} \Rightarrow Q_x' = \frac{1}{x^2} \quad \checkmark$$

**Paso 5 - Busco $F$** integrando $Q$ respecto de $y$: $F = -\dfrac{y}{x} + g(x)$. Derivo en $x$ e igualo a $P$: $$\frac{y}{x^2} + g'(x) = \frac{y}{x^2} + \frac{\ln x}{x^2} ;\Rightarrow; g'(x) = \frac{\ln x}{x^2}$$ Por partes: $g(x) = -\dfrac{\ln x}{x} - \dfrac{1}{x}$.

**Paso 6 - Solución general:** $$-\frac{y}{x} - \frac{\ln x}{x} - \frac{1}{x} = C ;\Rightarrow; y = Kx - \ln x - 1$$

> [!note] Caso factor en $y$ Si el cociente que da solo de $x$ falla, se prueba $\dfrac{N_x' - M_y'}{M}$; si ese depende solo de $y$, se obtiene $\mu(y)$ con el mismo procedimiento (separable en $\mu$).

### Lineales

**Para decir:** Es lineal cuando se escribe en la **forma canónica**:

$$y' + P(x)y = Q(x)$$

es decir, $y$ e $y'$ aparecen en **primer grado**, sin productos entre sí ni dentro de funciones no lineales.

**Cómo se resuelve (factor integrante):**

1. Calculo el factor integrante $\mu(x) = e^{\int P(x)dx}$.
2. Multiplico toda la ecuación por $\mu(x)$.
3. El **lado izquierdo se vuelve la derivada de un producto**: $\big(y\cdot\mu(x)\big)' = \mu(x)Q(x)$.
4. Integro ambos lados y despejo $y$.

> [!important] El punto que pregunta seguido Después de multiplicar por el factor integrante, el lado izquierdo tiene que quedar como $\big(y,\mu\big)'$ para poder integrar directo. Ese es el objetivo de todo el método.

#### Ejercicio resuelto

Resolver $y' + \dfrac{1}{x}y = x$.

**Paso 1 - Identifico** $P(x) = \dfrac{1}{x}$, $Q(x) = x$. Factor integrante: $$\mu(x) = e^{\int \frac{1}{x}dx} = e^{\ln x} = x$$

**Paso 2 - Multiplico por $\mu = x$:** $$xy' + y = x^2$$

**Paso 3 - El lado izquierdo es la derivada de un producto:** $$(xy)' = x^2$$

**Paso 4 - Integro ambos lados:** $$xy = \frac{x^3}{3} + C$$

**Paso 5 - Despejo $y$:** $$y = \frac{x^2}{3} + \frac{C}{x}$$

### Aplicaciones de las ecuaciones diferenciales

**Para decir:** Las EDO modelan **fenómenos donde una magnitud cambia en función de su propia tasa de cambio**. Casos típicos:

- **Crecimiento/decaimiento:** $\frac{dy}{dt} = k,y$ (poblaciones, desintegración radiactiva). Solución exponencial.
- **Enfriamiento de Newton:** la temperatura cambia proporcional a la diferencia con el ambiente, $\frac{dT}{dt} = k,(T - T_a)$.
- **Mezclas:** variación de la cantidad de sustancia en un tanque = lo que entra menos lo que sale.

**Idea para el oral:** identifico qué tipo de EDO es (separable, lineal, etc.), la resuelvo con el método correspondiente y uso la **condición inicial** para hallar la solución particular.

#### Ejercicio resuelto

Un cultivo de bacterias crece proporcional a su cantidad. Si parte de $P(0) = 500$ y a las 3 horas hay $P(3) = 2000$, hallar $P(t)$.

**Paso 1 - Planteo el modelo:** $\dfrac{dP}{dt} = kP$ (separable). 

$$\frac{dP}{P} = kdt \Rightarrow \ln P = kt + C \Rightarrow P(t) = P_0e^{kt}$$

**Paso 2 - Uso $P(0) = 500$:** $P_0 = 500$ entonces $P(t) = 500e^{kt}$.

**Paso 3 - Uso $P(3) = 2000$ para hallar $k$:** $$2000 = 500e^{3k} \Rightarrow e^{3k} = 4 \Rightarrow k = \frac{\ln 4}{3}$$

**Paso 4 - Solución:** $$P(t) = 500e^{\frac{\ln 4}{3}t} = 500 \cdot 4^{t/3}$$

---

## SEGUNDO PARCIAL - Integrales dobles y análisis vectorial

### Integrales de primer, segundo y tercer orden

|Orden|Expresión|Dominio|Significado geométrico|
|---|---|---|---|
|Primer|$\int f(x),dx$|intervalo (1D)|área bajo la curva|
|Segundo|$\iint_D f(x,y),dA$|región del plano (2D)|volumen bajo la superficie $z=f(x,y)$|
|Tercer|$\iiint_E f(x,y,z),dV$|sólido (3D)|masa/carga acumulada en el sólido|

**Diferencia:** cambia la **dimensión del dominio** y el elemento diferencial: $dx$, $dA$, $dV$.

#### Ejercicio resuelto

Calcular la integral triple $\displaystyle\int_0^1!\int_0^1!\int_0^1 (x + y + z),dz,dy,dx$.

**Integral interior (en $z$):** $$\int_0^1 (x + y + z),dz = \left[(x+y)z + \frac{z^2}{2}\right]_0^1 = (x + y) + \frac{1}{2}$$

**Integral media (en $y$):** $$\int_0^1 \left(x + y + \frac{1}{2}\right)dy = \left[xy + \frac{y^2}{2} + \frac{y}{2}\right]_0^1 = x + \frac{1}{2} + \frac{1}{2} = x + 1$$

**Integral exterior (en $x$):** $$\int_0^1 (x + 1),dx = \left[\frac{x^2}{2} + x\right]_0^1 = \frac{1}{2} + 1 = \frac{3}{2}$$

### Teorema de Fubini

**Para decir:** Si $f$ es **continua** en un rectángulo $R = [a,b]\times[c,d]$, la integral doble se puede calcular como una **integral iterada**, y el **orden no altera el resultado**:

$$\iint_R f(x,y),dA = \int_a^b!\int_c^d f(x,y),dy,dx = \int_c^d!\int_a^b f(x,y),dx,dy$$

**Por qué importa:** es el teorema que **justifica** que una integral doble (que en principio es un límite de sumas) se pueda resolver integrando una variable por vez. Geométricamente, calcula el volumen sumando áreas de secciones transversales.

> [!note] Cuidado En un **rectángulo** los dos órdenes dan lo mismo directamente. En una región general, antes de cambiar el orden hay que **re-describir la región** (no se intercambian los límites tal cual).

#### Ejercicio resuelto

Calcular $\displaystyle\iint_R xy,dA$ sobre $R = [0,2]\times[0,3]$ en **los dos órdenes** y verificar que coinciden.

**Orden $dy,dx$:** $$\int_0^2!\int_0^3 xy,dy,dx = \int_0^2 x\left[\frac{y^2}{2}\right]_0^3 dx = \int_0^2 x\cdot\frac{9}{2},dx = \frac{9}{2}\left[\frac{x^2}{2}\right]_0^2 = \frac{9}{2}\cdot 2 = 9$$

**Orden $dx,dy$:** $$\int_0^3!\int_0^2 xy,dx,dy = \int_0^3 y\left[\frac{x^2}{2}\right]_0^2 dy = \int_0^3 y\cdot 2,dy = 2\left[\frac{y^2}{2}\right]_0^3 = 2\cdot\frac{9}{2} = 9$$

Ambos dan $9$. Esto es Fubini en acción.

### Región tipo 1 vs tipo 2

**Para decir:**

- **Tipo 1:** la región está entre **dos funciones continuas de $x$**. Los límites de $x$ son fijos ($a$ y $b$), e $y$ varía entre $g_1(x)$ y $g_2(x)$.

$$D = {(x,y): a \le x \le b,\ g_1(x) \le y \le g_2(x)}$$

En la integral iterada, $dy$ va **adentro** y $dx$ afuera.

- **Tipo 2:** la región está entre **dos funciones continuas de $y$**. Los límites de $y$ son fijos, y $x$ varía entre $h_1(y)$ y $h_2(y)$. El gráfico **depende de $y$**, porque $x$ queda acotado entre funciones de $y$. Acá $dx$ va adentro.

#### Ejercicio resuelto

Describir como tipo 1 y como tipo 2 la región $D$ encerrada entre $y = x^2$ y $y = 2x$.

**Paso 1 - Intersecciones:** 
$$
\begin{aligned}
x^2 = 2x \\
\Rightarrow x^2 - 2x = 0  \\
\Rightarrow x(x - 2) = 0 \\
\Rightarrow x = 0\ x = 2
\end{aligned}
$$ Los puntos son $(0,0)$ y $(2,4)$.

**Paso 2 - Cuál curva está arriba** (valor de prueba $x = 1$): $y = x^2 = 1$ y $y = 2x = 2$. La recta $2x$ está arriba.

**Como tipo 1** ($x$ fijo entre $0$ y $2$, $y$ entre las curvas): $$D = {(x,y): 0 \le x \le 2,\ x^2 \le y \le 2x}$$

**Como tipo 2** (despejo $x$: de $y = x^2$ sale $x = \sqrt{y}$; de $y = 2x$ sale $x = y/2$). Prueba $y = 1$: $y/2 = 0.5$, $\sqrt{y} = 1$, así que $x$ va de $y/2$ a $\sqrt{y}$: $$D = {(x,y): 0 \le y \le 4,\ \tfrac{y}{2} \le x \le \sqrt{y}}$$

### Área con integral doble

**Para decir:** El área de $D$ se calcula con una integral doble cuyo **integrando es $1$**:

$$A(D) = \iint_D 1,dA$$

Así la integral solo "suma" áreas diferenciales dentro de $D$. Describo la región como tipo 1 o tipo 2 y armo la integral iterada correspondiente.

#### Ejercicio resuelto

Calcular el área de la región entre $y = x^2$ y $y = 2x$ (la misma de arriba).

$$A = \int_0^2!\int_{x^2}^{2x} 1,dy,dx = \int_0^2 \big(2x - x^2\big),dx$$ $$= \left[x^2 - \frac{x^3}{3}\right]_0^2 = 4 - \frac{8}{3} = \frac{4}{3}$$

### Orden de integración y por qué se cambia

**Para decir:** A veces el orden dado vuelve la integral **difícil o imposible** de calcular (por el integrando o por cómo queda descripta la región). Cambiando el orden, la región se describe más simple o el integrando se vuelve integrable.

> [!warning] Regla práctica El orden se lee **estrictamente** de la notación: el diferencial interior y sus límites definen la variable que se integra primero. No cambiar el orden sin re-describir la región (volver a leer los puntos de intersección y los límites).

#### Ejercicio resuelto

Calcular $\displaystyle\int_0^1\int_x^1 e^{y^2}dydx$.

**Problema:** $e^{y^2}$ no tiene primitiva elemental en $y$, así que en este orden no se puede.

**Paso 1 - Describo la región** del enunciado: $0 \le x \le 1$, $x \le y \le 1$. Es el triángulo con vértices $(0,0)$, $(0,1)$, $(1,1)$.

**Paso 2 - Re-describo invirtiendo el orden** (ahora $y$ afuera): para $0 \le y \le 1$, $x$ va de $0$ a $y$: $$\int_0^1\int_0^y e^{y^2}dxdy$$

**Paso 3 - Integro en $x$** (que ahora es trivial): $$\int_0^1 e^{y^2}\big[x\big]_0^ydy = \int_0^1 ye^{y^2}dy$$

**Paso 4 - Sustitución** $u = y^2$, $du = 2y,dy$: $$\frac{1}{2}\int_0^1 e^{u},du = \frac{1}{2}\big(e - 1\big)$$

El cambio de orden volvió integrable algo que no lo era.

### Cambio de variables y jacobiano

**Para decir:** Hago un cambio de variables para **simplificar la integral**: porque la región es complicada o porque el integrando se maneja mejor en las nuevas variables. Al cambiar, hay que multiplicar por el **factor jacobiano**.

**Qué es y cómo se calcula:** El jacobiano es el **determinante de la matriz de derivadas parciales** del cambio $x = x(u,v)$, $y = y(u,v)$:

$$J = \frac{\partial(x,y)}{\partial(u,v)} = \begin{vmatrix} \dfrac{\partial x}{\partial u} & \dfrac{\partial x}{\partial v} \\ \dfrac{\partial y}{\partial u} & \dfrac{\partial y}{\partial v} \end{vmatrix}$$

y la integral queda $\iint_D fdxdy = \iint_{D'} f\cdot|J|dudv$.

#### Ejercicio resuelto

Calcular $\displaystyle\iint_D (x+y),dA$, donde $D$ es el paralelogramo limitado por $x+y=1$, $x+y=2$, $x-y=0$, $x-y=1$.

**Paso 1 - Elijo el cambio** que endereza la región: $u = x+y$, $v = x-y$. Entonces $x = \dfrac{u+v}{2}$, $y = \dfrac{u-v}{2}$.

**Paso 2 - Calculo el jacobiano:** $$J = \begin{vmatrix} \dfrac{1}{2} & \dfrac{1}{2} \\ \dfrac{1}{2} & -\dfrac{1}{2} \end{vmatrix} = \left(\frac{1}{2}\right)\left(-\frac{1}{2}\right) - \left(\frac{1}{2}\right)\left(\frac{1}{2}\right) = -\frac{1}{2} ;\Rightarrow; |J| = \frac{1}{2}$$

**Paso 3 - La región en $(u,v)$** se vuelve un rectángulo: $1 \le u \le 2$, $0 \le v \le 1$. El integrando $x+y = u$.

**Paso 4 - Calculo:** 
$$
\begin{aligned}
\iint_D (x+y dA = 
\int_1^2!\int_0^1 u\cdot\frac{1}{2}dvdu = \frac{1}{2}\int_1^2 udu = \frac{1}{2}\left[\frac{u^2}{2}\right]_1^2 = \frac{1}{2}\cdot\frac{3}{2} = \frac{3}{4}
\end{aligned}
$$

### Significado geométrico del jacobiano y relación entre jacobianos

**Para decir (geométrico):** El jacobiano describe **cómo se deforma el área** al pasar del sistema $(u,v)$ al $(x,y)$. Indica cómo un **rectángulo chiquito** en $(u,v)$ se transforma en un **paralelogramo** en $(x,y)$. Su valor absoluto es el factor que ajusta el área.

**Relación entre los factores (jacobiano inverso):** El jacobiano de la transformación inversa es el **recíproco** del directo:

$$\frac{\partial(u,v)}{\partial(x,y)} = \frac{1}{\dfrac{\partial(x,y)}{\partial(u,v)}}$$

**Por qué:** ir y volver entre los dos sistemas no puede cambiar el área total; por eso un factor deshace al otro.

#### Ejercicio resuelto

Verificar la relación recíproca con las coordenadas polares.

**Directo** ($x = r\cos\theta$, $y = r\sin\theta$): $$\frac{\partial(x,y)}{\partial(r,\theta)} = \begin{vmatrix} \cos\theta & -r\sin\theta \ \sin\theta & r\cos\theta \end{vmatrix} = r\cos^2\theta + r\sin^2\theta = r$$

**Inverso** ($r = \sqrt{x^2+y^2}$, $\theta = \arctan(y/x)$). Sus derivadas dan: $$\frac{\partial(r,\theta)}{\partial(x,y)} = \begin{vmatrix} \cos\theta & \sin\theta \ -\dfrac{\sin\theta}{r} & \dfrac{\cos\theta}{r} \end{vmatrix} = \frac{\cos^2\theta}{r} + \frac{\sin^2\theta}{r} = \frac{1}{r}$$

Se cumple $\dfrac{\partial(r,\theta)}{\partial(x,y)} = \dfrac{1}{r} = \dfrac{1}{,\partial(x,y)/\partial(r,\theta),}$.

### Cambio a coordenadas polares (cambio "trigonométrico")

**Para decir:** Conviene cuando integro sobre una **región circular, anular (corona) o sectores**. El cambio es:

$$x = r\cos\theta, \quad y = r\sin\theta, \quad |J| = r$$

así $dA = rdrd\theta$.

**Por qué conviene:** transforma la región circular en un **rectángulo** en el plano $(r,\theta)$ y simplifica los límites y muchas veces el integrando.

#### Ejercicio resuelto


Calcular $\displaystyle\iint_D (x^2 + y^2)dA$, donde $D$ es el disco $x^2 + y^2 \le 4$.

**Paso 1 - Paso a polares:** $x^2 + y^2 = r^2$ y $dA = r dr d\theta$. El disco de radio $2$ es $0 \le r \le 2$, $0 \le \theta \le 2\pi$.

**Paso 2 - Reescribo y calculo:** $$\int_0^{2\pi}\int_0^2 r^2\cdot rdrd\theta = \int_0^{2\pi}\int_0^2 r^3drd\theta$$

**Paso 3 - Integro en $r$:** $$\int_0^2 r^3dr = \left[\frac{r^4}{4}\right]_0^2 = 4$$

**Paso 4 - Integro en $\theta$:** $$\int_0^{2\pi} 4d\theta = 8\pi$$

### Otros cambios de variable típicos

|Región limitada por...|Cambio que conviene|Resultado|
|---|---|---|
|Rectas tipo $x+y$|lineal: $u = x+y$, $v = x-y$|rectángulo en $(u,v)$|
|Hipérbolas|$u = xy$, $v = y/x$|rectas / rectángulo en $(u,v)$|
|Círculos, coronas|polares: $x = r\cos\theta$, $y = r\sin\theta$|rectángulo en $(r,\theta)$|

**Idea general:** elijo el cambio que **endereza la frontera** de la región hasta volverla un rectángulo.

#### Ejercicio resuelto

Calcular el área de la región $D$ del primer cuadrante limitada por $xy = 1$, $xy = 2$, $y = x$, $y = 2x$.

**Paso 1 - Elijo el cambio** sugerido por las curvas: $u = xy$, $v = \dfrac{y}{x}$. Las fronteras se vuelven $u = 1$, $u = 2$, $v = 1$, $v = 2$ (un rectángulo).

**Paso 2 - Calculo el jacobiano** (más fácil el inverso y después invierto): $$\frac{\partial(u,v)}{\partial(x,y)} = \begin{vmatrix} y & x \ -\dfrac{y}{x^2} & \dfrac{1}{x} \end{vmatrix} = \frac{y}{x} + \frac{y}{x} = \frac{2y}{x} = 2v$$ Entonces $\left|\dfrac{\partial(x,y)}{\partial(u,v)}\right| = \dfrac{1}{2v}$.

**Paso 3 - Calculo el área:** $$A = \iint_D 1,dA = \int_1^2!\int_1^2 \frac{1}{2v},du,dv = \int_1^2 \frac{1}{2v},dv = \frac{1}{2}\big[\ln v\big]_1^2 = \frac{\ln 2}{2}$$

### Integral doble respecto de una parábola

**Para decir (cómo se plantea):**

1. Identifico las curvas que limitan la región (ej. la parábola y una recta o eje).
2. **Calculo los puntos de intersección** resolviendo el sistema entre las curvas.
3. Indico el **intervalo** entre esas intersecciones y recién ahí decido si es tipo 1 o tipo 2.
4. Armo la integral iterada con esos límites y la calculo.

> [!warning] Orden correcto al describir la región Primero las intersecciones, después el intervalo, y solo entonces un valor de prueba para confirmar cuál curva está arriba/abajo. No elegir el valor de prueba antes de tener las intersecciones.

#### Ejercicio resuelto

Calcular $\displaystyle\iint_D x,dA$, donde $D$ está limitada por la parábola $y = x^2$ y la recta $y = x$.

**Paso 1 - Intersecciones:** $$x^2 = x ;\Rightarrow; x^2 - x = 0 ;\Rightarrow; x(x - 1) = 0 ;\Rightarrow; x = 0,\ x = 1$$

**Paso 2 - Intervalo y curva superior:** $x \in [0,1]$. Prueba $x = 0.5$: $y = x^2 = 0.25$, $y = x = 0.5$. La recta $y = x$ está arriba.

**Paso 3 - Armo la integral (tipo 1):** $$\iint_D x,dA = \int_0^1 x!\int_{x^2}^{x} 1,dy,dx = \int_0^1 x,(x - x^2),dx$$

**Paso 4 - Calculo:** $$\int_0^1 (x^2 - x^3),dx = \left[\frac{x^3}{3} - \frac{x^4}{4}\right]_0^1 = \frac{1}{3} - \frac{1}{4} = \frac{1}{12}$$

### Aplicación física: masa y centro de masa de una lámina

**Para decir:** Si una lámina ocupa una región $D$ con función de **densidad** $\rho(x,y)$ (masa por área), entonces:

**Masa:** $$m = \iint_D \rho(x,y),dA$$

**Centro de masa** $(\bar x, \bar y)$, el punto donde la lámina se equilibra (como si toda la masa estuviera concentrada ahí): $$\bar x = \frac{M_y}{m} = \frac{1}{m}\iint_D x,\rho(x,y),dA, \qquad \bar y = \frac{M_x}{m} = \frac{1}{m}\iint_D y,\rho(x,y),dA$$

donde $M_y$ y $M_x$ son los **momentos** respecto de los ejes (masa por distancia al eje).

> [!note] Conexión típica Si la región es circular o un sector, conviene resolver estas integrales en **polares** (recordando el $|J| = r$).

#### Ejercicio resuelto

Hallar la masa y el centro de masa de la lámina $[0,2]\times[0,1]$ con densidad $\rho(x,y) = x$.

**Masa:** $$m = \int_0^2!\int_0^1 x,dy,dx = \int_0^2 x,dx = \left[\frac{x^2}{2}\right]_0^2 = 2$$

**Momento $M_y$** (para $\bar x$): $$M_y = \int_0^2!\int_0^1 x\cdot x,dy,dx = \int_0^2 x^2,dx = \left[\frac{x^3}{3}\right]_0^2 = \frac{8}{3} ;\Rightarrow; \bar x = \frac{M_y}{m} = \frac{8/3}{2} = \frac{4}{3}$$

**Momento $M_x$** (para $\bar y$): $$M_x = \int_0^2!\int_0^1 y\cdot x,dy,dx = \int_0^2 x\left[\frac{y^2}{2}\right]_0^1 dx = \int_0^2 \frac{x}{2},dx = 1 ;\Rightarrow; \bar y = \frac{M_x}{m} = \frac{1}{2}$$

**Centro de masa:** $\left(\dfrac{4}{3},\ \dfrac{1}{2}\right)$. Tiene sentido: como la densidad crece con $x$, el centro se corre a la derecha del centro geométrico ($x = 1$); en $y$ queda en el medio porque la densidad no depende de $y$.

### Funciones vectoriales: derivada y segunda derivada

**Para decir:** Una función vectorial $\vec r(t)$ va de $\mathbb{R}$ a $\mathbb{R}^2$ o $\mathbb{R}^3$; el parámetro $t$ suele ser el **tiempo** y la imagen es una **curva**.

- $\vec r'(t)$ = **vector velocidad** (hacia dónde y a qué ritmo se mueve el punto).
- $\vec r''(t)$ = **vector aceleración** en ese punto.

> [!note] Imagen vs ecuación cartesiana Al eliminar el parámetro, la **curva cartesiana** suele tener **más puntos** que la imagen de la función vectorial, y además la función vectorial le agrega una **orientación** (sentido de recorrido) que la cartesiana no tiene.

#### Ejercicio resuelto

Dada $\vec r(t) = (t^2,\ t^3,\ t)$, hallar velocidad y aceleración en $t = 1$.

**Velocidad** (primera derivada componente a componente): $$\vec r,'(t) = (2t,\ 3t^2,\ 1) ;\Rightarrow; \vec r,'(1) = (2,\ 3,\ 1)$$

**Aceleración** (segunda derivada): $$\vec r,''(t) = (2,\ 6t,\ 0) ;\Rightarrow; \vec r,''(1) = (2,\ 6,\ 0)$$

En $t = 1$, el punto se mueve en la dirección $(2,3,1)$ y su velocidad cambia según $(2,6,0)$.

### Vector tangente - significado físico (LA pregunta de siempre)

> [!important] Tenela perfecta El vector tangente $\vec r'(t)$ representa la **velocidad instantánea** del punto que recorre la curva: indica la **dirección** en la que se mueve y **qué tan rápido** lo hace en ese instante. Su módulo es la rapidez; su dirección es tangente a la trayectoria.

#### Ejercicio resuelto

Para $\vec r(t) = (\cos t,\ \sin t)$ (recorrido sobre la circunferencia unidad), interpretar el vector tangente en $t = \pi/2$.

**Vector tangente:** $$\vec r,'(t) = (-\sin t,\ \cos t)$$

**Posición y tangente en $t = \pi/2$:** $$\vec r(\pi/2) = (0,\ 1) \qquad \vec r,'(\pi/2) = (-1,\ 0)$$

**Rapidez** (módulo): $$|\vec r,'(t)| = \sqrt{\sin^2 t + \cos^2 t} = 1 \quad (\text{constante})$$

**Interpretación física:** en el punto más alto de la circunferencia $(0,1)$, el móvil se desplaza hacia la izquierda (dirección $(-1,0)$), tangente al círculo, con rapidez constante $1$. El sentido del recorrido es antihorario.

### Longitud de una curva (longitud de arco)

**Para decir:** Se calcula **integrando la norma del vector derivada** entre los valores del parámetro:

$$L = \int_a^b |\vec r'(t)|,dt = \int_a^b \sqrt{x'(t)^2 + y'(t)^2 + z'(t)^2},dt$$

**Por qué (de dónde sale):** Por **Pitágoras** sobre un desplazamiento diferencial: $ds = \sqrt{dx^2 + dy^2 + dz^2}$. La norma de $\vec r'(t)$ mide cuánto "avanza" la curva por unidad de parámetro, y al integrarla sumo todos esos avances.

#### Ejercicio resuelto

Calcular la longitud de la hélice $\vec r(t) = (\cos t,\ \sin t,\ t)$ para $t \in [0, 2\pi]$.

**Paso 1 - Derivada:** $$\vec r,'(t) = (-\sin t,\ \cos t,\ 1)$$

**Paso 2 - Norma:** $$|\vec r,'(t)| = \sqrt{(-\sin t)^2 + (\cos t)^2 + 1^2} = \sqrt{\sin^2 t + \cos^2 t + 1} = \sqrt{2}$$

**Paso 3 - Integro:** $$L = \int_0^{2\pi} \sqrt{2},dt = \sqrt{2},\big[t\big]_0^{2\pi} = 2\pi\sqrt{2}$$

### Recta tangente a una curva (función vectorial)

**Para decir:** Evalúo la curva en $t_0$ para el **punto** $\vec r(t_0)$, y uso $\vec r'(t_0)$ como **vector director**:

$$L:\ \vec r(t_0) + \lambda,\vec r'(t_0), \quad \lambda \in \mathbb{R}$$

#### Ejercicio resuelto

Hallar la recta tangente a $\vec r(t) = (t,\ t^2,\ t^3)$ en $t_0 = 1$.

**Paso 1 - Punto:** $$\vec r(1) = (1,\ 1,\ 1)$$

**Paso 2 - Vector director (tangente):** $$\vec r,'(t) = (1,\ 2t,\ 3t^2) ;\Rightarrow; \vec r,'(1) = (1,\ 2,\ 3)$$

**Paso 3 - Recta:** $$L:\ (1,\ 1,\ 1) + \lambda,(1,\ 2,\ 3) ;\Rightarrow; \begin{cases} x = 1 + \lambda \ y = 1 + 2\lambda \ z = 1 + 3\lambda \end{cases}$$

### Plano normal a una curva en un punto

**Para decir:** Pasa por el punto $\vec r(t_0)$ y toma como **vector normal** al tangente $\vec r'(t_0)$. Su ecuación:

$$\big(\vec P - \vec r(t_0)\big)\cdot \vec r'(t_0) = 0$$

**Por qué:** el plano normal es perpendicular a la dirección de avance de la curva; por eso el tangente actúa como normal del plano.

#### Ejercicio resuelto

Hallar el plano normal a $\vec r(t) = (t,\ t^2,\ t^3)$ en $t_0 = 1$.

**Paso 1 - Punto y vector normal** (igual que arriba): $$\vec r(1) = (1,\ 1,\ 1) \qquad \vec r,'(1) = (1,\ 2,\ 3)$$

**Paso 2 - Ecuación** $\big((x,y,z) - (1,1,1)\big)\cdot(1,2,3) = 0$: $$1(x - 1) + 2(y - 1) + 3(z - 1) = 0$$

**Paso 3 - Simplifico:** $$x + 2y + 3z = 6$$

### Campo vectorial y campo gradiente

**Para decir:** Un **campo vectorial** asigna a cada punto del plano (o del espacio) un **vector**. En $\mathbb{R}^2$: $\vec F(x,y) = \big(P(x,y);\ Q(x,y)\big)$. Modela cosas como un campo de fuerzas o el flujo de un fluido.

**Campo gradiente:** dado un campo escalar $f$, su **gradiente** es el campo vectorial formado por las derivadas parciales: $$\nabla f = \big(f_x';\ f_y'\big) \quad \big(\text{en } \mathbb{R}^3:\ \nabla f = (f_x';\ f_y';\ f_z')\big)$$

#### Ejercicio resuelto

Dado el campo escalar $f(x,y) = x^2 y + y^3$, hallar el campo gradiente y evaluarlo en $(1,1)$.

**Paso 1 - Derivadas parciales:** $$f_x' = 2xy \qquad f_y' = x^2 + 3y^2$$

**Paso 2 - Campo gradiente:** $$\nabla f(x,y) = \big(2xy,\ x^2 + 3y^2\big)$$

**Paso 3 - En el punto $(1,1)$:** $$\nabla f(1,1) = \big(2,\ 4\big)$$

### Integral de línea: escalar vs vectorial

**Para decir:** Son integrales sobre una **curva** $C$ en lugar de sobre un intervalo o una región.

|Tipo|Fórmula|Qué calcula|
|---|---|---|
|**Escalar**|$\displaystyle\int_C f,ds = \int_a^b f(\vec r(t)),\|\vec r'(t)\|,dt$|suma de un campo escalar a lo largo de la curva (ej. masa de un alambre)|
|**Vectorial**|$\displaystyle\int_C \vec F\cdot d\vec r = \int_a^b \vec F(\vec r(t))\cdot \vec r'(t),dt$|el **trabajo** de un campo de fuerzas que mueve una partícula a lo largo de $C$|

**Clave:** en la escalar uso $ds = |\vec r'(t)|,dt$ (un escalar); en la vectorial proyecto el campo sobre la dirección de avance ($\vec F\cdot\vec r'$).

#### Ejercicio resuelto

Sobre la curva $\vec r(t) = (t,\ t)$ con $t \in [0,1]$:

**Integral escalar** de $f(x,y) = x + y$: $$\vec r,'(t) = (1,\ 1) ;\Rightarrow; |\vec r,'(t)| = \sqrt{2}$$ $$\int_C f,ds = \int_0^1 (t + t),\sqrt{2},dt = \sqrt{2}\int_0^1 2t,dt = \sqrt{2},\big[t^2\big]_0^1 = \sqrt{2}$$

**Integral vectorial** del campo $\vec F(x,y) = (y,\ x)$: $$\vec F(\vec r(t)) = (t,\ t), \quad \vec r,'(t) = (1,\ 1) ;\Rightarrow; \vec F\cdot\vec r,' = t + t = 2t$$ $$\int_C \vec F\cdot d\vec r = \int_0^1 2t,dt = \big[t^2\big]_0^1 = 1$$

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
> - Misma idea: en exactas existe $F$ con $F_x' = M$, $F_y' = N$ y la solución es $F(x,y) = C$; en conservativos existe la función potencial $f$ con $\nabla f = \vec F$. Reconocer esto muestra que entendés la materia de fondo, no de memoria.

#### Ejercicio resuelto

Dado $\vec F(x,y) = (2xy,\ x^2 + 1)$, verificar que es conservativo, hallar la función potencial y calcular el trabajo desde $A = (0,0)$ hasta $B = (1,2)$.

**Paso 1 - Criterio** ($M = 2xy$, $N = x^2 + 1$): $$M_y' = 2x \qquad N_x' = 2x ;\Rightarrow; M_y' = N_x' ;\Rightarrow; \text{es conservativo}$$

**Paso 2 - Función potencial.** Integro $M$ respecto de $x$: $$f = \int 2xy,dx = x^2 y + g(y)$$ Derivo respecto de $y$ e igualo a $N$: $$f_y' = x^2 + g'(y) \stackrel{!}{=} x^2 + 1 ;\Rightarrow; g'(y) = 1 ;\Rightarrow; g(y) = y$$ $$f(x,y) = x^2 y + y$$

**Paso 3 - Trabajo por el teorema fundamental** ($f(B) - f(A)$): $$\int_C \vec F\cdot d\vec r = f(1,2) - f(0,0) = \big(1^2\cdot 2 + 2\big) - 0 = 4$$

El trabajo es $4$, sin importar el camino que una $A$ con $B$.

---

> [!note] Estrategia para el día
> 
> 1. Si te dan a elegir o podés guiar la respuesta, andá a los temas que tenés más sólidos.
> 2. Empezá siempre por la **definición corta** y después el **cómo se hace / para qué sirve**. Eso es lo que busca.
> 3. Mayor probabilidad: vector tangente físico, jacobiano (qué es + significado geométrico), las 4 familias de EDO, y región tipo 1/tipo 2. Tenelas redondas.
> 4. Carta para el 10: la **conexión exactas ↔ conservativos** (misma condición $M_y' = N_x'$, misma función potencial). Si podés deslizarla, te separa del resto.