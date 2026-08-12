## Concepto de Integral Iterada

Sea $f$ una función continua de dos variables definida en el rectángulo $R = [a; b] \times [c; d]$.

La **integral iterada** se construye en dos pasos:

**Paso 1:** Integrar $f(x; y)$ respecto de $y$ (manteniendo $x$ fija):

$$A(x) = \int_c^d f(x; y)\, dy$$

**Paso 2:** Integrar $A(x)$ respecto de $x$:

$$\int_a^b A(x)\, dx = \int_a^b \left[ \int_c^d f(x; y)\, dy \right] dx$$

### Notación

$$\int_a^b \int_c^d f(x;y)\, dy\, dx \quad \Rightarrow \text{ primero integrar en } y, \text{ luego en } x$$

$$\int_c^d \int_a^b f(x;y)\, dx\, dy \quad \Rightarrow \text{ primero integrar en } x, \text{ luego en } y$$

> [!important] Orden de integración
> El diferencial mas cercano al integrando es el que se resuelve primero. Por ejemplo en $dy\,dx$, se integra primero respecto a $y$ (interior), luego respecto a $x$ (exterior).

---

## Teorema de Fubini

> [!note] Teorema de Fubini
> Sea $f$ continua en $R = [a; b] \times [c; d]$. Entonces:
>
> $$\iint_R f(x; y)\, dA = \int_a^b \int_c^d f(x; y)\, dy\, dx = \int_c^d \int_a^b f(x; y)\, dx\, dy$$

**Interpretacion geometrica:** Si $f \geq 0$, la integral doble representa el **volumen** del solido que se encuentra:
- **arriba** del rectangulo $R$
- **debajo** de la superficie $z = f(x; y)$

$$V = \iint_R f(x; y)\, dA$$

> [!important] Consecuencia clave
> El orden de integracion puede intercambiarse libremente cuando $f$ es continua en $R$. Elegir el orden mas conveniente simplifica el calculo.

---

## Procedimiento General de Resolucion

### Integrales iteradas (ejercicio tipo 1)

```
1. Identificar el orden de integracion por los diferenciales
2. Resolver la integral interior (tratar la otra variable como constante)
3. Evaluar en los limites de la integral interior → queda funcion de una sola variable
4. Resolver la integral exterior
5. Evaluar en sus limites → resultado final
```

### Integrales dobles sobre region R (ejercicio tipo 2)

```
1. Identificar la region R = [a; b] x [c; d]
2. Aplicar Fubini: convertir en integral iterada
3. Elegir el orden conveniente (el que evite metodos complicados)
4. Resolver como integral iterada
```

### Volumen de un solido (ejercicios tipo 3, 4, 5)

```
V = iint_R f(x; y) dA

donde f(x; y) es la superficie superior y R es la base (rectangulo dado)
```

---

## Tecnicas de Integracion Relevantes

| Situacion | Tecnica |
|---|---|
| Potencias de $x$ o $y$ | Regla de la potencia |
| Exponencial $e^{ax}$ | $\int e^{ax} dx = \frac{e^{ax}}{a}$ |
| Producto $x \cdot e^{x}$ | Integracion por partes |
| $\ln x$ aparece al integrar $\frac{1}{x}$ | $\int \frac{1}{x} dx = \ln|x|$ |
| $\sin(ax)$, $\cos(ax)$ | Reglas trigonometricas estandar |

> [!warning] Eleccion del orden de integracion
> Algunos integrandos son muy dificiles de resolver en un orden pero simples en el otro. Ejemplo: $y \cdot \text{sen}(xy)$ es mas facil integrando primero en $x$ (ya que $\int \text{sen}(xy)\, dx = -\frac{\cos(xy)}{y}$), evitando integracion por partes.

---

## Ejemplos Resueltos

### Ejemplo 1 - Integral iterada basica

$$\int_0^3 \int_1^2 x^2 y\, dy\, dx$$

**Paso 1** (integral interior en $y$, $x$ constante):

$$\int_1^2 x^2 y\, dy = x^2 \cdot \frac{y^2}{2}\Bigg|_1^2 = x^2 \cdot \frac{4-1}{2} = \frac{3x^2}{2}$$

**Paso 2** (integral exterior en $x$):

$$\int_0^3 \frac{3x^2}{2}\, dx = \frac{3}{2} \cdot \frac{x^3}{3}\Bigg|_0^3 = \frac{3}{2} \cdot 9 = \frac{27}{2}$$

---

### Ejemplo 2 - Integral doble sobre rectangulo

$$\iint_R (x - 3y^2)\, dA, \quad R = \{(x;y): 0 \leq x \leq 2;\ 1 \leq y \leq 2\}$$

**Aplicando Fubini** (primero en $y$):

$$\int_0^2 \int_1^2 (x - 3y^2)\, dy\, dx = \int_0^2 \left[ xy - y^3 \right]_1^2 dx = \int_0^2 (x \cdot 1 - 7)\, dx$$

$$= \frac{x^2}{2}\Bigg|_0^2 - 7x\Bigg|_0^2 = 2 - 14 = -12$$

---

### Ejemplo 3 - Eleccion de orden conveniente

$$\iint_R y \cdot \text{sen}(xy)\, dA, \quad R = \{(x;y): 1 \leq x \leq 2;\ 0 \leq y \leq \pi\}$$

**Conviene integrar primero en $x$** (evita integracion por partes):

$$\int_0^\pi \int_1^2 y \cdot \text{sen}(xy)\, dx\, dy = \int_0^\pi y \cdot \left(-\frac{\cos(xy)}{y}\right)\Bigg|_1^2 dy = -\int_0^\pi [\cos(2y) - \cos(y)]\, dy$$

$$= -\left[\frac{\text{sen}(2y)}{2} - \text{sen}(y)\right]_0^\pi = 0$$

---

## Calculo de Volumenes

> [!note] Formula de volumen
> El volumen del solido bajo $z = f(x;y)$ y sobre $R = [a;b] \times [c;d]$ es:
>
> $$V = \iint_R f(x; y)\, dA = \int_a^b \int_c^d f(x; y)\, dy\, dx$$

### Tipo: paraboloide sobre rectangulo

Para $z = x^2 + y^2$ sobre $R = [-2; 2] \times [-3; 3]$:

$$V = \int_{-2}^{2} \int_{-3}^{3} (x^2 + y^2)\, dy\, dx$$

- Integrar $x^2 + y^2$ en $y$: resultado es funcion de $x$
- Luego integrar en $x$

### Tipo: cilindro sobre rectangulo en el primer octante

Para $z = 9 - y^2$, plano $x = 2$ (primer octante: $x \geq 0$, $y \geq 0$, $z \geq 0$):

- Region: $R = [0; 2] \times [0; 3]$ (el cilindro toca $z=0$ cuando $y=3$)

$$V = \int_0^2 \int_0^3 (9 - y^2)\, dy\, dx$$

---

## Resumen de Tipos de Ejercicios del TP

| Tipo | Que se pide | Herramienta |
|---|---|---|
| Integral iterada | Calcular $\int\int f\, d\Box\, d\Box$ | Resolver de adentro hacia afuera |
| Integral doble sobre R | $\iint_R f\, dA$ con R rectangulo | Fubini → integral iterada |
| Volumen bajo superficie | $V$ del solido bajo $z=f(x,y)$ sobre $R$ | $V = \iint_R f\, dA$ |

> [!important] Regla practica para volumenes
> Si $f(x;y) \geq 0$ en toda la region $R$, la integral doble da directamente el volumen. Si $f$ toma valores negativos en parte de la region, la integral da el volumen neto (con signo).