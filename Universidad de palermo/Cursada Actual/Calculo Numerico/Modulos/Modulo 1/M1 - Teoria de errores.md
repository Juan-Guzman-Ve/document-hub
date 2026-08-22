---
tags:
  - materia/calculo-numerico
  - modulo/m1
  - tipo/teoria
materia: Calculo Numerico
modulo: M1 - Introduccion
tipo: teoria
descripcion: Teoria de errores numericos — notacion de punto flotante, digitos significativos, truncamiento y redondeo, error absoluto y relativo con sus cotas, y aritmetica de digitos finitos en la computadora.
conceptos_clave:
  - punto flotante
  - digitos significativos
  - truncamiento
  - redondeo
  - error absoluto
  - error relativo
relacionados:
  - "[[M2 - Aplicacion del Diferencial al Calculo de Errores]]"
  - "[[M1 - Ejercicios]]"
  - "[[0 - Referencia Obsidian y LaTeX]]"
---

# Módulo 1 - Cálculo Numérico

## Introducción al cálculo numérico

El cálculo numérico consiste en el desarrollo de "métodos constructivos" para hallar la "solución aproximada" de problemas matemáticos.

De estos problemas, la matemática garantiza la existencia y unicidad de la solución (en algunos casos no provee el algoritmo para obtener la solución del problema).

**Observaciones:**
- Solución numérica en contraposición a solución exacta.
- Los métodos constructivos también reciben el nombre de "algoritmos".

### Ejemplo: existencia y unicidad de la solución

Hallar la solución de

$$f(x) = 0$$

en un intervalo $[a; b]$

- Si $f$ es continua en $[a; b]$ y $f(a) \cdot f(b) < 0$, existe $c \in (a; b)$ tal que $f(c) = 0$.
- Hay que ver la demostración para obtener una forma constructiva para encontrar la solución.
- Si además $f'(x) > 0$ para todo $x \in (a; b)$, la solución es única.

```mermaid
graph LR
    A["f continua en [a,b]"] --> B{"f(a)·f(b) < 0 ?"}
    B -->|Sí| C["Existe c en (a,b) tal que f(c) = 0"]
    C --> D{"f'(x) > 0 para todo x en (a,b) ?"}
    D -->|Sí| E["La solución c es única"]
    D -->|No| F["Puede haber más de una raíz"]
```

### Métodos constructivos (o algoritmos)

Procedimiento ordenado, secuencial que, para una dada precisión, determina la solución aproximada del problema en un número finito de pasos.

**Precisión:** proximidad entre lo que se puede hacer y lo que se desea encontrar.

Precisión, solución aproximada → ERROR.

### Tipos de error

```mermaid
graph TD
    A[ERROR] --> B["Error de aproximación"]
    A --> C["Error de redondeo"]
    B --> B1["Surgen de remplazar el problema por uno aproximado.
    Ejemplo: remplazar la derivada por el cociente incremental."]
    C --> C1["Relacionados con la forma en que se expresan
    los números en la computadora.
    Aritmética de dígitos finitos"]
```

### Ejemplo: remplazar la derivada por el cociente incremental

La derivada exacta se define como:

$$f'(x_0) = \lim_{\Delta x \to 0} \frac{f(x_0 + \Delta x) - f(x_0)}{\Delta x}$$

y se remplaza (aproxima) por el cociente incremental:

$$f'(x_0) \approx \frac{f(x_0 + \Delta x) - f(x_0)}{\Delta x}$$

```mermaid
graph LR
    A["Curva f(x)"] --> B["Recta Secante entre dos puntos de f
    (cociente incremental, aproximación)"]
    A --> C["Recta Tangente en un punto de f
    (derivada exacta)"]
    B -.->|"cuando Δx → 0"| C
```

### Ejemplo 2: cálculo aproximado de una integral (error de aproximación)

Calcular

$$\int_0^1 x^2 \, dx$$

Valor exacto:

$$\int_0^1 x^2 \, dx = \frac{1}{3}$$

Empleando la fórmula del trapecio:

$$T = \frac{f(a)+f(b)}{2} \cdot (b-a)$$

$$T = \frac{f(0)+f(1)}{2} \cdot (1-0) = \frac{1+0}{2} \cdot 1 = \frac{1}{2}$$

$$Error = \left| \frac{1}{3} - \frac{1}{2} \right| = \frac{1}{6} = 0{,}167$$

Si reiteramos el método partiendo el intervalo en dos partes iguales:

$$T = \frac{f(0)+f\left(\frac{1}{2}\right)}{2} \cdot \left(\frac{1}{2}-0\right) + \frac{f\left(\frac{1}{2}\right)+f(1)}{2} \cdot \left(1-\frac{1}{2}\right)$$

$$= \frac{\frac{1}{4}}{2} \cdot \frac{1}{2} + \frac{\frac{1}{4}+1}{2} \cdot \frac{1}{2} = \frac{3}{8}$$

$$Error = \left| \frac{1}{3} - \frac{3}{8} \right| = \frac{1}{24} \approx 0{,}0417$$

**Observación:** al aumentar el número de subdivisiones del intervalo (reiterar el método), el error disminuye (de $0{,}167$ a $0{,}0417$), mostrando cómo mejora la aproximación al refinar el método constructivo.

```mermaid
graph TD
    A["Integral exacta = 1/3"] --> B["1 trapecio (T=1/2) - Error = 0,167"]
    A --> C["2 trapecios (T=3/8) - Error = 0,0417"]
    C --> D["A mayor número de subdivisiones,
    menor error de aproximación"]
```

---

## Notación de Punto Flotante, Dígitos Significativos y Errores

### Estructura general de un problema numérico

Todo problema numérico presenta la siguiente forma:

$$a \rightarrow F \rightarrow F(a)$$

donde "a" son los datos, F la fórmula (o algoritmo) y F(a) el resultado de aplicar F a "a".

```mermaid
graph LR
    A["a (datos)"] --> F["F (fórmula / algoritmo)"] --> R["F(a) (resultado)"]
```

**Existen tres tipos de errores:**
1. Errores en a (en la entrada de datos)
2. Errores en F (el algoritmo o método utilizado)
3. Errores en F(a) (errores de salida)

Ejemplo mencionado: si queremos evaluar el seno de un ángulo $\alpha$, en este caso $a = \alpha$, $F = \text{sen}$ y $F(a) = \text{sen}(\alpha)$.

### Notación de punto flotante normalizada

Los métodos numéricos permiten resolver ciertos problemas computacionales con rapidez y exactitud. Sin embargo, el uso de las computadoras presenta ciertas dificultades.

Las computadoras no almacenan números como $2$, $\frac{2}{3}$, $\pi$ porque tienen una capacidad limitada de almacenamiento. En su lugar, todas las computadoras utilizan lo que se conoce como números de punto flotante.

En este sistema, todos los números se representan en la forma:

$$fl(x) = 0.d_1 d_2 d_3 \cdots d_k \times 10^n$$

donde $d_1, d_2, d_3, \cdots, d_k$ son dígitos enteros no negativos, $d_1 \neq 0$, y $n$ es un número entero.

Cualquier número escrito de esta forma se llama "número normalizado de punto flotante" y se denota por $fl(x)$.

En la ecuación anterior:
- El número $d_1 d_2 d_3 \cdots d_k$ se llama **mantisa**.
- El número $n$ se llama **exponente**.

Se debe cumplir la relación:

$$\frac{1}{base} < d_1 d_2 d_3 \cdots d_k < 1$$

El número $k$ es el número de cifras o **dígitos significativos** de la expresión.

### Dígitos significativos

Un dígito significativo de un número aproximado es cualquier dígito no nulo en su representación decimal, o cualquier cero situado entre dígitos significativos, o utilizado como indicador posicional, para indicar determinado lugar.

Todos los ceros restantes del número aproximado que sirven solamente para fijar la posición de la coma no son dígitos significativos.

**Ejemplo 1:**

En el número $0{,}002080$:
- Los tres primeros ceros no son dígitos significativos, ya que únicamente sirven para fijar la posición de la coma e indicar el valor posicional de los otros dígitos.
- Los otros dos ceros sí son dígitos significativos: el primero cae entre los dígitos 2 y 8, y el segundo indica que se conserva el lugar decimal $10^{-6}$ en el número aproximado.
- Si el último dígito de $0{,}002080$ no fuera significativo, entonces el número debería escribirse de la forma $0{,}00208$.
- Desde este punto de vista, los números $0{,}002080$ y $0{,}00208$ no son iguales, ya que el primero tiene cuatro dígitos significativos y el segundo tiene tres.

Los ceros a la derecha de un número grande pueden servir tanto para indicar dígitos significativos como para fijar la posición de los otros dígitos. Esto puede ocasionar confusión al escribir los números en forma ordinaria.

En el número $689.000$ no queda claro cuántos dígitos significativos hay, aunque podemos afirmar que al menos hay tres. La ambigüedad puede evitarse utilizando la notación de punto flotante, escribiendo el número como $0{,}689 \times 10^6$ si tiene tres dígitos significativos, o $0{,}68900 \times 10^6$ si tiene cinco.

**Ejemplo 2:** los siguientes números se expresan en forma normalizada de punto flotante:

$$x = \frac{1}{4} \quad \Rightarrow \quad fl(x) = 0.25$$

$$x = 2378 \quad \Rightarrow \quad fl(x) = 0.2378 \times 10^4$$

$$x = -0.000816 \quad \Rightarrow \quad fl(x) = -0.816 \times 10^{-3}$$

$$x = 83.27 \quad \Rightarrow \quad fl(x) = 0.8327 \times 10^2$$

### Truncamiento y redondeo

Si el número de dígitos significativos fuera ilimitado no habría problema, pero casi siempre que se introducen números en la computadora los errores comienzan a acumularse. Esto puede ocurrir de dos maneras:

**Truncamiento a $k$ dígitos significativos:** todos los dígitos significativos después de $k$ de ellos simplemente "se eliminan". Por ejemplo, si se trunca

$$\frac{2}{3} = 0{,}66666\cdots$$

a 8 dígitos significativos, se guarda como

$$fl\left(\frac{2}{3}\right) = 0.66666666 \times 10^0$$

**Redondeo a $k$ dígitos significativos:**
- Si $d_{k+1} \geq 5$, entonces se suma "1" a $d_k$ y se trunca el número resultante.
- Si $d_{k+1} < 5$, el número simplemente se trunca.

Por ejemplo, si se redondea $\frac{2}{3} = 0{,}66666\cdots$ a 8 dígitos significativos, se guarda como

$$fl\left(\frac{2}{3}\right) = 0.66666667 \times 10^0$$

```mermaid
graph TD
    A["Número real con infinitos dígitos"] --> B{"¿Truncamiento o redondeo a k dígitos?"}
    B -->|Truncamiento| C["Se eliminan todos los dígitos
    después del k-ésimo"]
    B -->|Redondeo| D{"d(k+1) >= 5 ?"}
    D -->|Sí| E["Se suma 1 al dígito k-ésimo
    y se trunca"]
    D -->|No| F["Se trunca directamente"]
```

> [!example] Ejercitación (P1, Ejercicios 1 a 5)
> **1 y 2) Dígitos significativos de:**
> $$0{,}006540 \to k=4 \qquad 12370 \to k=5 \qquad 50{,}0072 \to k=6$$
> $$12370{,}0 \to k=6 \qquad 0{,}00123700 \to k=6 \qquad 12300134 \to k=8$$
>
> **3) Redondeo a cuatro dígitos significativos:**
> $$12{,}7684 \to 12{,}77 \qquad 0{,}1428576 \to 0{,}1429 \qquad 4{,}00250 \to 4{,}003$$
> $$7{,}99951 \to 8{,}000 \qquad 9! \to 362900$$
>
> **4 y 5) Redondeo (Ej. 4) vs. truncamiento (Ej. 5):**
>
> | $x$ | Redondeo, 2 dec. | Redondeo, 4 cifras sig. | Truncamiento, 2 dec. | Truncamiento, 4 cifras sig. |
> |---|---|---|---|---|
> | $555{,}666$ | $555{,}67$ | $555{,}7$ | $555{,}66$ | $555{,}6$ |
> | $2222{,}333$ | $2222{,}33$ | $2222$ | $2222{,}33$ | $2222$ |
> | $333{,}00$ | $333{,}00$ | $333{,}0$ | $333{,}00$ | $333{,}0$ |
> | $9{,}9950$ | $10{,}00$ | $9{,}995$ | $9{,}99$ | $9{,}995$ |
> | $0{,}005000$ | $0{,}00$ | $0{,}005000$ | $0{,}00$ | $0{,}005000$ |
>
> En $9{,}9950$ y $0{,}005000$ el dígito a descartar es exactamente 5 seguido de ceros (empate exacto): se redondea al par más cercano, por eso $9$ (impar) sube a $10$ y $0$ (par) se mantiene.

### Error Absoluto

Si $x$ es el valor real de un número y $x^*$ es el número que aparece en la computadora o el "número aproximado", entonces el error absoluto $E_a$ está definido por:

$$E_a(x) = |x - x^*|$$

**Observación:** cuando se escribe un número aproximado procedente de una medida, es común dar una "cota" del error absoluto. Una cota del error absoluto es cualquier número positivo $\alpha$ tal que

$$|x - x^*| \leq \alpha$$

Por propiedad del valor absoluto:

$$-\alpha \leq x - x^* \leq \alpha$$

Despejando el valor verdadero $x$:

$$x^* - \alpha \leq x \leq x^* + \alpha$$

**Ejemplo 3:** si utilizamos $x^* = 3{,}14$ como aproximación de $\pi$, el error absoluto será:

$$E_a(\pi) = |\pi - 3{,}14| \approx 0{,}00159$$

Una cota del error absoluto es, por ejemplo, $0{,}01$, ya que

$$E_a(\pi) = |\pi - 3{,}14| \leq 0{,}01$$

**Ejemplo 4:** si la longitud de un segmento es $l^* = 214$ cm con un error de $0{,}5$ cm, se escribe:

$$l = 214 \pm 0{,}5 \text{ cm}$$

En este caso, la cota del error absoluto es $0{,}5$ cm y significa que la magnitud exacta de la longitud está dentro del margen

$$213{,}5 \text{ cm} \leq l \leq 214{,}5 \text{ cm}$$

### Error Relativo

En la mayoría de las situaciones es más útil el error relativo $E_r$, definido por:

$$E_r(x) = \frac{|x - x^*|}{|x|} = \frac{E_a(x)}{|x|}$$

El error relativo da idea de la precisión de un número o una medida y se suele manejar en forma de porcentaje (error porcentual).

**Ejemplo 5:** sea $x = 2$ y $x^* = 2{,}1$, entonces

$$E_a(x) = 0{,}1 \qquad E_r(x) = \frac{0{,}1}{2} = 0{,}05$$

Si $x = 2000$ y $x^* = 2000{,}1$, entonces

$$E_a(x) = 0{,}1 \qquad E_r(x) = \frac{0{,}1}{2000} = 0{,}00005$$

El error absoluto de $0{,}1$ en el primer caso es más significativo que el error de $0{,}1$ en el segundo, ya que representa un 5% del valor real, mientras que en el segundo caso representa un 0,005%.

A menudo no conocemos el valor exacto de $x$. En ese caso, para hallar el error relativo se divide el error absoluto (o una cota del error absoluto) por el valor aproximado, considerado como valor verdadero:

$$E_r(x) = \frac{|x - x^*|}{|x|} \approx \frac{\alpha}{|x^*|}$$

**Ejemplo 6:** ¿en cuál de las siguientes medidas hay mayor error?

$$A = 100 \pm 1 \text{ km} \qquad B = 5 \pm 0{,}5 \text{ km}$$

Los errores absolutos son:

$$E_a(A) = 1 \text{ km} \qquad E_a(B) = 0{,}5 \text{ km}$$

El error absoluto en $A$ es mayor que el error absoluto en $B$, pero esto no da mucha idea de la comparación porque depende de sobre qué cantidades se calculen dichos errores.

Calculemos los errores relativos:

$$E_r(A) = \frac{E_a(A)}{A} = \frac{1}{100} = 0{,}01 = 1\%$$

$$E_r(B) = \frac{E_a(B)}{B} = \frac{0{,}5}{5} = 0{,}1 = 10\%$$

Por lo tanto, la medida $B$ tiene menor precisión porque tiene un error relativo mayor.

```mermaid
graph TD
    A["Medida A = 100 +/- 1 km"] --> A1["Ea(A) = 1 km"]
    A1 --> A2["Er(A) = 1/100 = 1%"]
    B["Medida B = 5 +/- 0,5 km"] --> B1["Ea(B) = 0,5 km"]
    B1 --> B2["Er(B) = 0,5/5 = 10%"]
    A2 --> C["Er(B) > Er(A) => B tiene menor precisión"]
    B2 --> C
```

> [!example] Ejercitación (P1, Ejercicio 6)
> Error absoluto y relativo de $x$ aproximado por $x^*$, conociendo el valor exacto $x$:
>
> | $x$ | $x^*$ | $E_a$ | $E_r$ |
> |---|---|---|---|
> | $\pi$ | $22/7$ | $0{,}735\times10^{-5}$ | $0{,}234\times10^{-5}$ |
> | $\sqrt{2}$ | $1{,}414$ | $0{,}214\times10^{-3}$ | $0{,}151\times10^{-3}$ |
> | $e^{10}$ | $22000$ | $0{,}265\times10^{2}$ | $0{,}120\times10^{-2}$ |
> | $8!$ | $39900$ | $0{,}420\times10^{3}$ | $0{,}104\times10^{-1}$ |

### Error de redondeo y cotas

Es el error que se comete al reemplazar el número por su forma de punto flotante (sea por truncamiento o redondeo).

**Cotas del error absoluto:**

- El máximo error absoluto de truncamiento es:

$$E_a(t) = |x - fl(x)| \leq 1 \times 10^{n-k+1}$$

donde $n$ es la potencia de 10 del primer dígito significativo de $x$ y $k$ es el número de dígitos significativos.

  **Definición:** si $k$ es el mínimo número entero para el cual se cumple esta cota del error absoluto de truncamiento, se dice que $fl(x)$ es una aproximación de $x$ con $k$ dígitos exactos en sentido amplio.

- El máximo error absoluto de redondeo es:

$$E_a(red) = |x - fl(x)| \leq 0{,}5 \times 10^{n-k+1}$$

  **Definición:** si $k$ es el mínimo número entero para el cual se cumple esta cota del error absoluto de redondeo, se dice que $fl(x)$ es una aproximación de $x$ con $k$ dígitos exactos en sentido estricto.

**Cotas del error relativo:**

- El máximo error relativo de truncamiento con $k$ dígitos es:

$$E_r(t) = \frac{|x - fl(x)|}{|x|} \leq 1 \times 10^{-k+1}$$

- El máximo error relativo de redondeo con $k$ dígitos es:

$$E_r(red) = \frac{|x - fl(x)|}{|x|} \leq 0{,}5 \times 10^{-k+1}$$

- El número aproximado $x^*$ tendrá con toda seguridad $k$ dígitos exactos en sentido estricto si

$$E_r(x) < 0{,}5 \times 10^{-k+1}$$

**Ejemplo 7:** obtener una aproximación de $\pi$ con cinco dígitos significativos exactos. Hallar el error absoluto y el error relativo.

$$\pi = 3{,}14159265\cdots$$

$$\pi^* = 3{,}1416$$

$$E_a = |\pi - 3{,}1416| = 0{,}00000735$$

$$E_r = \frac{|\pi - 3{,}1416|}{\pi} = 0{,}00000234 < 0{,}000005 = 0{,}5 \times 10^{-4}$$

$$\Rightarrow -k+1 = -4 \Rightarrow k = 5$$

> [!example] Ejercitación (P1, Ejercicios 7 y 8)
> **7) Aproximar $e$ por $p^*=2{,}718$. Dígitos exactos:**
> $$E_a(e) = |e-2{,}718| = 0{,}282\times10^{-3} \qquad E_r(e) = \frac{E_a(e)}{e} = 0{,}104\times10^{-3}$$
> $$E_r(e) < 0{,}5\times10^{-k+1} \;\Rightarrow\; k = 4 \text{ dígitos exactos}$$
>
> **8) Dígitos necesarios en $\sqrt{20}$ para que el error relativo no supere 0,1 por ciento:**
> $$E_r < 1\times10^{-3}$$
> $$0{,}5\times10^{-k+1} \leq 1\times10^{-3} \;\Rightarrow\; k \geq 4$$

### Aritmética en la computadora

Además de la representación poco exacta de los números, la aritmética efectuada en una computadora no es exacta. Esta aritmética requiere el manejo de dígitos binarios con varias operaciones lógicas.

Supongamos que se dan las representaciones de punto flotante $fl(x)$ y $fl(y)$ de los números $x$ e $y$. Se supone una aritmética de dígitos finitos dada por:

$$fl(x+y) = fl(fl(x) + fl(y))$$

$$fl(x-y) = fl(fl(x) - fl(y))$$

$$fl(x \times y) = fl(fl(x) \times fl(y))$$

$$fl\left(\frac{x}{y}\right) = fl\left(\frac{fl(x)}{fl(y)}\right)$$

Esta aritmética equivale a realizar las operaciones exactas sobre las representaciones de punto flotante de $x$ e $y$, y luego convertir el resultado exacto en su representación de punto flotante con finitos dígitos.

```mermaid
graph LR
    X["x"] --> FX["fl(x)"]
    Y["y"] --> FY["fl(y)"]
    FX --> OP["Operación exacta:
    +, -, x, /"]
    FY --> OP
    OP --> RES["Resultado exacto"]
    RES --> FRES["fl(resultado)
    (se redondea/trunca a k dígitos)"]
```

**Ejemplo 8:** $x = \frac{1}{3}$, $y = \frac{5}{7}$, con un redondeo a 5 dígitos, entonces:

$$fl(x) = 0{,}33333$$

$$fl(y) = 0{,}71429$$

| Operación | Resultado en $fl$ | Valor real | Error absoluto | Error relativo |
|---|---|---|---|---|
| $x + y$ | $1{,}0746$ | $\frac{22}{21}$ | $0{,}000019$ | $0{,}000018$ |
| $x - y$ | $-0{,}38096$ | $-\frac{8}{21}$ | $0{,}00000762$ | $0{,}00002$ |
| $x \times y$ | *(no consta en el archivo)* | *(no consta en el archivo)* | *(no consta en el archivo)* | *(no consta en el archivo)* |
| $x \div y$ | *(no consta en el archivo)* | *(no consta en el archivo)* | *(no consta en el archivo)* | *(no consta en el archivo)* |

**Nota:** en el archivo original, las filas correspondientes a $x \times y$ y $x \div y$ de la tabla, así como el valor final del "máximo error relativo", aparecen sin completar (en blanco), y la conclusión indicada en el material es que "la aritmética produce resultados satisfactorios de 5 dígitos".

> [!example] Ejercitación (P1, Ejercicios 9 y 10) — redondeo vs. corte a tres dígitos
>
> | Operación | Valor real | $fl$ redondeo | $E_a$ red. | $E_r$ red. | $fl$ corte | $E_a$ corte | $E_r$ corte |
> |---|---|---|---|---|---|---|---|
> | $133+0{,}921$ | $133{,}921$ | $0{,}134\times10^3$ | $0{,}79\times10^{-1}$ | $0{,}593\times10^{-3}$ | $0{,}133\times10^3$ | $0{,}921$ | $0{,}688\times10^{-2}$ |
> | $(121-0{,}327)-119$ | $1{,}673$ | $0{,}167\times10^1$ | $0{,}3\times10^{-2}$ | $0{,}179\times10^{-2}$ | $0{,}167\times10^1$ | $0{,}3\times10^{-2}$ | $0{,}179\times10^{-2}$ |
> | $\dfrac{13/14-6/7}{2e-5{,}4}$ | $1{,}953540$ | $0{,}18\times10^1$ | $0{,}154$ | $0{,}788\times10^{-1}$ | $0{,}355\times10^1$ | $0{,}154$ | $0{,}817$ |
> | $(2/9)\cdot(9/7)$ | $0{,}28571$ | $0{,}286$ | $0{,}29\times10^{-3}$ | $0{,}102\times10^{-2}$ | $0{,}284$ | $0{,}171\times10^{-2}$ | $0{,}599\times10^{-2}$ |
>
> En la tercera fila el corte da un error mucho mayor que el redondeo ($0{,}817$ vs. $0{,}0788$): esa cuenta involucra una resta de números casi iguales ($13/14 - 6/7$), y el corte amplifica esa pérdida de dígitos significativos más que el redondeo (cancelación catastrófica, se retoma en M2).

---

> [!note] Ejercicios 11 a 15 del P1
> Quedan pendientes porque requieren el diferencial aplicado a la propagación de errores, tema desarrollado en `M2_Presentacion.pdf` (Módulo 2), no en el material de este módulo.