# Modulo 8 - Aplicaciones Fisicas e Integrales Dobles con Cambio de Variables

---

## Tema 1: Aplicaciones Fisicas de las Integrales Dobles

### Masa de una Lamina

Una lamina ocupa una region $D$ del plano $xy$ con funcion de densidad $\rho(x; y)$ (masa por unidad de area).

**Definicion de densidad:** $$\rho(x; y) = \lim_{\Delta A \to 0} \frac{\Delta m}{\Delta A}$$

**Masa total:** $$m = \iint_D \rho(x; y) , dA$$

> [!note] Idea clave Se subdivide la region en subrectangulos $R_{ij}$, se aproxima la masa de cada uno como $m_{R_{ij}} \approx \rho(x_{ij}^*; y_{ij}^*) \cdot \Delta A$, y se toma el limite cuando el numero de subrectangulos tiende a infinito.

---

### Momentos de una Lamina

El **momento** de una particula respecto a un eje = masa x distancia al eje.

|Momento|Formula|
|---|---|
|Respecto al eje $x$|$M_x = \iint_D y \cdot \rho(x; y) , dA$|
|Respecto al eje $y$|$M_y = \iint_D x \cdot \rho(x; y) , dA$|

> [!important] Atencion a la convencion $M_x$ usa la coordenada $y$ (distancia al eje $x$) y $M_y$ usa la coordenada $x$ (distancia al eje $y$). Es al reves de lo que parece intuitivo.

---

### Centro de Masa

El centro de masa $(\bar{x}; \bar{y})$ es el punto donde se equilibra la lamina. Cumple: $$m \cdot \bar{x} = M_y \qquad m \cdot \bar{y} = M_x$$

**Formulas:** $$\bar{x} = \frac{M_y}{m} = \frac{1}{m} \iint_D x \cdot \rho(x; y) , dA$$ $$\bar{y} = \frac{M_x}{m} = \frac{1}{m} \iint_D y \cdot \rho(x; y) , dA$$

**Procedimiento general:**

1. Calcular $m = \iint_D \rho , dA$
2. Calcular $M_y = \iint_D x \cdot \rho , dA$
3. Calcular $M_x = \iint_D y \cdot \rho , dA$
4. Obtener $\bar{x} = M_y / m$ y $\bar{y} = M_x / m$

---

### Ejemplo: Lamina Semicircular

**Datos:** lamina semicircular de radio $a$, densidad $\rho(x; y) = k\sqrt{x^2 + y^2}$ (proporcional a la distancia al centro).

**Cambio a polares:** $x = r\cos\theta$, $y = r\sin\theta$, con $0 \le r \le a$, $0 \le \theta \le \pi$.

**Masa:** $$m = \int_0^\pi \int_0^a k \cdot r \cdot r , dr , d\theta = \frac{1}{3} k a^3 \pi$$

**Centro de masa:** Por simetria $\bar{x} = 0$, y: $$\bar{y} = \frac{3a}{2\pi}$$

> [!tip] Cuando usar polares en aplicaciones fisicas Siempre que la region sea circular, semicircular, o el anillo, conviene cambiar a coordenadas polares antes de integrar.

---

## Tema 2: Cambio de Variables en la Integral Doble

### Motivacion

Se hace un cambio de variables para:

- Simplificar el **integrando**
- Simplificar la **region de integracion** (convertirla en rectangulo)

**Analogia con integral simple:** en $\int_a^b f(x) , dx$ se llama $x = g(u)$ y aparece el factor $g'(u)$. En la integral doble, el factor analogo es el **Jacobiano**.

---

### Jacobiano de la Transformacion

Dado el cambio $x = g(u; v)$, $y = h(u; v)$, el Jacobiano es:

$$J\frac{x; y}{\partial(u; v)} = \begin{vmatrix} x'_u & x'_v \ y'_u & y'_v \end{vmatrix} = x'_u \cdot y'_v - y'_u \cdot x'_v$$

> [!note] Propiedad util Si es dificil despejar $x$ e $y$ en funcion de $u$ y $v$, se puede calcular el jacobiano inverso y usar: $$J\frac{x; y}{\partial(u; v)} = \left( J\frac{u; v}{\partial(x; y)} \right)^{-1}$$

---

### Teorema del Cambio de Variables

Sean $R$ (plano $xy$) y $S$ (plano $uv$) regiones relacionadas por $x = g(u; v)$, $y = h(u; v)$, biyectivas. Si $f$ es continua en $R$ y el Jacobiano es no nulo en $S$:

$$\iint_R f(x; y) , dA = \iint_S f(g(u;v); h(u;v)) \cdot \left| J\frac{x; y}{\partial(u; v)} \right| , du , dv$$

> [!important] El Jacobiano va siempre en valor absoluto

---

### Cambio a Coordenadas Polares

Es el caso mas frecuente del teorema de cambio de variables.

**Transformacion:** $$x = r\cos\theta \qquad y = r\sin\theta$$

**Jacobiano:** $$J\frac{x; y}{\partial(r; \theta)} = \begin{vmatrix} \cos\theta & -r\sin\theta \ \sin\theta & r\cos\theta \end{vmatrix} = r$$

**Formula:** $$\iint_R f(x; y) , dA = \iint_S f(r\cos\theta; r\sin\theta) \cdot r , dr , d\theta$$

> [!tip] Cuando usar polares
> 
> - Region circular, semicircular, corona o sector
> - Integrando con $x^2 + y^2$
> - Circunferencias como bordes de la region

**Correspondencias utiles:**

|En el plano $r-\theta$|En el plano $xy$|
|---|---|
|$r = k$ (recta horizontal)|$x^2 + y^2 = k^2$ (circunferencia)|
|$\theta = \theta_0$ (recta vertical)|$y = \tan(\theta_0) \cdot x$ (recta radial)|

---

### Cambio de Variables General: Como Elegirlo

Cuando los bordes de la region tienen la forma $f_1(x,y) = c_1$ y $f_2(x,y) = c_2$, conviene llamar: $$u = f_1(x, y) \qquad v = f_2(x, y)$$

Esto transforma la region en un **rectangulo** en el plano $uv$.

**Procedimiento:**

1. Graficar la region $R$ en el plano $xy$
2. Identificar la estructura de los bordes
3. Definir $u$ y $v$ segun esa estructura
4. Calcular los limites de $u$ y $v$ (forman un rectangulo en $S$)
5. Despejar $x$ e $y$ en funcion de $u$ y $v$ (o usar la propiedad del jacobiano inverso)
6. Calcular el Jacobiano
7. Aplicar el teorema

---

### Ejemplos Clave

**Ejemplo 1 - Region definida por rectas:**

Region $R$ limitada por $x+y=0$, $x+y=6$, $x-y=1$, $x-y=3$.

Llamar $u = x+y$, $v = x-y$ convierte $R$ en el rectangulo $0 \le u \le 6$, $1 \le v \le 3$.

Despejando: $x = \frac{u+v}{2}$, $y = \frac{u-v}{2}$.

Jacobiano: $J = \frac{1}{2}$.

$$\iint_R (x^2 - y^2) , dA = \int_1^3 \int_0^6 v \cdot u \cdot \frac{1}{2} , du , dv = 36$$

---

**Ejemplo 2 - Region definida por hiperbolas:**

Region limitada por $xy=1$, $xy=2$, $y=x$, $y=3x$.

Llamar $u = xy$, $v = y/x$ convierte $R$ en el rectangulo $1 \le u \le 2$, $1 \le v \le 3$.

Para el Jacobiano, se calcula $J(u;v)/\partial(x;y)$ y se invierte: $$J\frac{x; y}{\partial(u; v)} = \frac{1}{2v}$$

$$\iint_R x^2 y^2 , dA = \frac{7}{6} \ln 3$$

---

## Resumen de Formulas

**Masa:** $$m = \iint_D \rho(x; y) , dA$$

**Momentos:** $$M_x = \iint_D y \cdot \rho(x; y) , dA \qquad M_y = \iint_D x \cdot \rho(x; y) , dA$$

**Centro de masa:** $$\bar{x} = \frac{M_y}{m} \qquad \bar{y} = \frac{M_x}{m}$$

**Jacobiano:** $$J\frac{x; y}{\partial(u; v)} = \begin{vmatrix} x'_u & x'_v \ y'_u & y'_v \end{vmatrix}$$

**Propiedad del jacobiano inverso:** $$J\frac{x; y}{\partial(u; v)} = \left( J\frac{u; v}{\partial(x; y)} \right)^{-1}$$

**Teorema de cambio de variables:** $$\iint_R f(x; y) , dA = \iint_S f(g(u;v); h(u;v)) \cdot \left| J\frac{x; y}{\partial(u; v)} \right| , du , dv$$

**Coordenadas polares** (Jacobiano $= r$): $$\iint_R f(x; y) , dA = \iint_S f(r\cos\theta;, r\sin\theta) \cdot r , dr , d\theta$$

---

## Ejercicios de Practica

### Aplicaciones Fisicas

1. Encontrar masa y centro de masa de laminas con distintas regiones y densidades:
    
    - $D = {-1 \le x \le 1; 0 \le y \le 1}$, $\rho = x^2$ $\Rightarrow$ $m = 2/3$, $(\bar{x}; \bar{y}) = (0; 1/2)$
    - $D$ triangular con vertices $(0;0)$, $(2;1)$, $(0;3)$, $\rho = x+y$ $\Rightarrow$ $m = 6$, $(\bar{x}; \bar{y}) = (3/4; 3/2)$
    - $D$ entre $y = x^2$ e $y = 1$ (1er cuadrante), $\rho = xy$ $\Rightarrow$ $m = 1/6$, $(\bar{x}; \bar{y}) = (4/7; 3/4)$
2. Lamina en el primer cuadrante del disco $x^2 + y^2 \le 1$, densidad proporcional a distancia al eje $x$: $\Rightarrow$ $(\bar{x}; \bar{y}) = (3/8; \pi/16)$
    

### Cambio de Variables

|Ejercicio|Respuesta|
|---|---|
|$\iint 4(x^2+y^2)dA$, cuadrado vertices $(\pm 1, 0)$, $(0, \pm 1)$|$8/3$|
|$\iint y(x-y)dA$, paralelogramo dado|$36$|
|$\iint y\sin(xy)dA$, region entre hiperbolas $xy=1$, $xy=4$ y rectas $y=1$, $y=4$|$3(\cos 1 - \cos 4)$|
|$\iint y , dA$, anillo $1 \le x^2+y^2 \le 4$ (polares)|$0$|
|$\iint y , dA$, cuarto de disco $x^2+y^2 \le 9$ (polares)|$9$|
|Volumen bajo $z = \sqrt{16-x^2-y^2}$ sobre $x^2+y^2 \le 4$|$\frac{2}{3}\pi(64 - 24\sqrt{3})$|
|$\iint (x^2+y^2)^{3/2} dA$, semicirculo $x^2+y^2 \le 9$, $y \ge 0$|$\frac{243}{5}\pi$|
