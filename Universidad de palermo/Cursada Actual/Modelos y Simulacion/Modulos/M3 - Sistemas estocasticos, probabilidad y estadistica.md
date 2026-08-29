---
tags:
  - materia/modelos-simulacion
  - modulo/m3
  - tipo/teoria
materia: Modelos y Simulacion
modulo: M3 - Sistemas Estocasticos, Probabilidad y Estadistica
tipo: teoria
descripcion: Modelos deterministicos vs estocasticos, fundamentos de probabilidad (postulados, marginal/conjunta/condicional, Teorema de Bayes), variables aleatorias discretas y continuas, catalogo de distribuciones teoricas y empiricas, y resolucion de problemas de probabilidad mediante simulacion.
conceptos_clave:
  - modelo estocastico
  - espacio muestral
  - probabilidad condicional
  - teorema de bayes
  - variable aleatoria discreta
  - variable aleatoria continua
  - distribucion de probabilidad
  - simulacion de montecarlo
relacionados:
  - "[[M2 - Sistemas discretos deterministicos]]"
  - "[[M4 - Analisis de entradas]]"
---

## Mapa del módulo

- [[#1. Modelos determinísticos vs. estocásticos]]
- [[#2. Tipos de eventos]]
- [[#3. Probabilidad — conceptos base]]
- [[#4. Experimentos aleatorios]]
- [[#5. Postulados y definiciones de probabilidad]]
- [[#6. Probabilidad marginal y conjunta]]
- [[#7. Reglas de la suma de probabilidades]]
- [[#8. Reglas del producto de probabilidades]]
- [[#9. Probabilidad condicional y Teorema de Bayes]]
- [[#10. Ejemplo aplicado — publicidad y ventas]]
- [[#11. Variables aleatorias — definición]]
- [[#12. Variables aleatorias discretas]]
- [[#13. Variables aleatorias continuas]]
- [[#14. Distribuciones empíricas vs. teóricas]]
- [[#15. Catálogo de distribuciones de probabilidad]]
- [[#16. Resolver problemas de probabilidad por simulación]]
- [[#Repaso rápido (preguntas y respuestas)]]

---

## 1. Modelos determinísticos vs. estocásticos

> [!abstract] Definiciones clave
> - **Modelo causal determinístico**: en cualquier realización de un conjunto de condiciones Θ, el evento A ocurre siempre. Ejemplo: agua a 760 mm Hg calentada por encima de 100°C (Θ) se transforma en vapor (A). Ley de conservación de la materia.
> - **Modelo estocástico**: dado un conjunto de condiciones Θ, el evento A puede o no ocurrir (evento aleatorio). Cuando además se puede cuantificar la posibilidad de ocurrencia, se dice que la probabilidad de que A ocurra dado Θ es igual a p.

Ejemplo clásico: no se puede prever si una central telefónica recibirá una llamada en un intervalo de $t$ segundos, pero sí estimar su probabilidad: $p = 1 - e^{-\lambda t}$, donde $\lambda$ es un parámetro propio de cada central.

> [!tip] Conexión
> En un sistema estocástico, algún componente presenta conducta aleatoria (por ejemplo, el tiempo de atención de un médico) y generalmente también las variables de entrada (tiempos entre arribos de pacientes). Estos comportamientos se modelan con **distribuciones probabilísticas**, que pueden ser teóricas o empíricas.

## 2. Tipos de eventos

| Evento | Definición |
|---|---|
| Cierto | Ocurre inevitablemente siempre que se da el conjunto de condiciones Θ |
| Imposible | No puede ocurrir bajo el conjunto de condiciones Θ |
| Aleatorio (estocástico, randómico) | Dado Θ, el evento A puede o no ocurrir |

> [!note] Óptica determinística estricta
> Bajo esta óptica, la aleatoriedad de un evento se interpreta como que el conjunto de condiciones Θ no engloba la colección completa de razones necesarias y suficientes para que A ocurra.

## 3. Probabilidad — conceptos base

La estadística cuantifica y acota la incertidumbre sobre la ocurrencia de un evento; esa medida es la **probabilidad**. Es la base de la teoría de toma de decisiones: elegir un valor para un parámetro desconocido, o un conjunto de valores al que se asume que pertenece.

Para tratar la incertidumbre hace falta:
1. Una enumeración completa de los estados posibles del proceso.
2. Una medida de la posibilidad de ocurrencia de cada uno.

## 4. Experimentos aleatorios

> [!abstract] Definiciones
> - **Experimento aleatorio**: no se puede predecir con exactitud su resultado.
> - **Espacio muestral (Ω)**: conjunto de todos los resultados posibles.
> - **Evento simple**: cada resultado individual del espacio muestral.
> - **Evento compuesto**: subconjunto de eventos simples.

Ejemplo — tirar un dado:
- Aleatorio porque no se puede predecir el número.
- Ω = {1, 2, 3, 4, 5, 6}
- Evento simple: sale el 4.
- Evento compuesto: sale número par (2, 4 o 6).

## 5. Postulados y definiciones de probabilidad

> [!abstract] Postulados básicos
> - $0 \le P(A) \le 1$ (no existen probabilidades negativas ni mayores a 1)
> - $P(A) = \dfrac{\text{casos observados}}{\text{casos totales}}$
> - $P(\Omega) = 1$

**Definición clásica**: $P(A) = \dfrac{k}{K}$, donde $k$ son los casos exitosos y $K$ los casos totales.

**Definición frecuencial**: $P(X) = \displaystyle\lim_{r \to \infty} \dfrac{k}{r}$, donde $r$ es la cantidad de repeticiones del experimento y $k$ las veces que ocurrió $X$. Equivale a la frecuencia relativa de una serie infinita de realizaciones.

## 6. Probabilidad marginal y conjunta

| Concepto | Definición |
|---|---|
| Probabilidad marginal $P(A)$ | Probabilidad de que ocurra A sin importar qué pase con otro suceso B |
| Probabilidad conjunta $P(A \cap B)$ | Probabilidad de que ocurran A y B simultáneamente |

## 7. Reglas de la suma de probabilidades

> [!abstract] Sucesos mutuamente excluyentes
> $$P(A \cup B) = P(A) + P(B)$$
>
> Ejemplo: $P(\text{sacar 1 o 2 con un dado}) = \frac{1}{6} + \frac{1}{6} = \frac{1}{3}$

> [!abstract] Sucesos no mutuamente excluyentes
> $$P(A \cup C) = P(A) + P(C) - P(A \cap C)$$
>
> Ejemplo: en una baraja de 50 cartas españolas, $P(\text{espada o figura}) = \frac{12}{50} + \frac{12}{50} - \frac{3}{50} = \frac{21}{50} = 0,42$ (se resta la intersección — figuras de espada — para no contarla dos veces)

## 8. Reglas del producto de probabilidades

La dependencia entre sucesos implica que uno afecta la probabilidad de ocurrencia del otro. Cuando información adicional reduce el espacio muestral, se habla de **probabilidades condicionales** (Teorema de Bayes).

| Caso | Fórmula |
|---|---|
| Eventos dependientes | $P(X \cap Y) = P(X) \cdot P(Y\|X)$ |
| Eventos independientes | $P(X \cap Y) = P(X) \cdot P(Y)$, ya que $P(Y\|X) = P(Y)$ |

> [!tip] Notación
> El producto de probabilidades (conjunta) se denota con intersección, multiplicación o la letra "y", tanto para el caso independiente como el dependiente.

## 9. Probabilidad condicional y Teorema de Bayes

$$P(Y|X) = \frac{P(X \cap Y)}{P(X)}$$

Indica cómo se modifica la probabilidad de un evento a partir de información adicional. No siempre tiene sentido invertir el condicionamiento (ej. probabilidad de nubes dado que llueve, caso por caso).

**Ejemplo — bajada de precios de un competidor**:
- $P(X) = 0,6$ → probabilidad de que el competidor baje el precio
- $P(Y|X) = 0,9$ → probabilidad de impacto negativo en ventas, dado que bajó el precio
- $P(X \cap Y) = 0,6 \cdot 0,9 = 0,54$

## 10. Ejemplo aplicado — publicidad y ventas

Encuesta a 200 consumidores de lácteos sobre si compraron un yogurt nuevo y si les gustó la publicidad:

| | Compró (C) | No compró (Cc) | Total |
|---|---|---|---|
| Gustó (G) | 100 | 45 | 145 |
| No gustó (Gc) | 20 | 35 | 55 |
| Total | 120 | 80 | 200 |

Dividiendo por 200 se obtienen las probabilidades:

| | Compró (C) | No compró (Cc) | Total |
|---|---|---|---|
| Gustó (G) | 0,5 | 0,225 | 0,725 |
| No gustó (Gc) | 0,1 | 0,175 | 0,275 |
| Total | 0,6 | 0,4 | 1 |

- **Marginales**: $P(C) = 0,6$; $P(G) = 0,725$
- **Conjuntas**: $P(C \cap G) = 0,5$; $P(C^c \cap G^c) = 0,175$
- **Condicionales**: $P(C\|G) = 100/145 = 0,689$; $P(C\|G^c) = 20/55 = 0,363$

## 11. Variables aleatorias — definición

> [!abstract] Definición formal
> Una **variable aleatoria** $X$ es una función definida sobre el espacio muestral $\Omega$ que toma valores en los números reales $\mathbb{R}$: $X: \Omega \to \mathbb{R}$. Asocia un número real a cada resultado de un experimento aleatorio.

Puede ser:
- **Discreta**: toma un número finito o infinito numerable de valores (ej. resultado de un dado, cantidad de personas en un evento).
- **Continua**: toma cualquier valor de un intervalo real, como (a,b), (a,∞), (-∞,b) o (-∞,+∞) (ej. peso, tiempo de vida útil, altura, temperatura).

## 12. Variables aleatorias discretas

$R_X = \{x_1, x_2, x_3, \ldots, x_n\}$. Ejemplo: cantidad de clientes atendidos por semana, $R_X = \{0, 1, 2, \ldots, n\}$.

| Función | Definición |
|---|---|
| Función de densidad de probabilidad (fdp) | $p(x_i)$: probabilidad de que $X$ tome el valor particular $x_i$ |
| Función de Distribución Acumulada (FDA) | $F(x) = P(X \le x)$: probabilidad de que $X$ tome valores menores o iguales a $x$ |

> [!note] Distribuciones empíricas discretas
> Surgen de relevar datos reales y calcular frecuencias relativas (equivalen a fdp) y frecuencias acumuladas (equivalen a FDA). Ejemplo: 300 grupos que llegan a almorzar a un restaurante, clasificados por tamaño de grupo.

## 13. Variables aleatorias continuas

$R_X$ es un intervalo o conjunto de intervalos. La probabilidad de que $X$ pertenezca a $[a,b]$:

$$P(a \le X \le b) = \int_a^b f(x)\,dx$$

donde $f(x)$ es la fdp de $X$. La FDA para variables continuas: $F(x) = \displaystyle\int_{-\infty}^{x} f(t)\,dt$

Ejemplo: tiempo de vida de un rayo láser con vida media de 2 años, modelado con una fdp exponencial; permite calcular, por ejemplo, la probabilidad de que un equipo se repare en menos de 1,39 minutos.

> [!note] Distribuciones empíricas continuas
> En el diagrama de fdp, la variable toma los puntos medios de cada intervalo. En el de FDA, se toma el extremo superior de cada intervalo para el eje de abscisas.

## 14. Distribuciones empíricas vs. teóricas

Para identificar qué distribución teórica usar en un modelo hace falta:
1. Conocimiento previo sobre la naturaleza del proceso o fenómeno estudiado, y qué suelen representar las distribuciones candidatas.
2. La forma del histograma o gráfico característico de los datos.

Cuando no es posible o necesario asignar una distribución teórica conocida, se recurre a la **distribución empírica** (frecuencias relativas y acumuladas calculadas directamente de los datos).

## 15. Catálogo de distribuciones de probabilidad

| Distribución | Uso típico |
|---|---|
| Binomial | Número de éxitos en n pruebas independientes con probabilidad de éxito p (ej. disquetes defectuosos en un lote) |
| Binomial negativa | Número de pruebas requeridas para lograr k éxitos (ej. disquetes revisados hasta encontrar k defectuosos) |
| Normal | Proceso representable como suma de varios procesos; fenómenos cotidianos (calificaciones, peso, altura) |
| Poisson | Número de eventos independientes en una cantidad fija de tiempo o espacio (ej. clientes por hora, defectos por m²) |
| Lognormal | Proceso representable como producto de varios procesos (ej. retorno de una inversión con interés compuesto) |
| Exponencial | Tiempo entre eventos independientes, procesos sin memoria (ej. tiempo entre arribos de clientes); vínculo directo con Poisson |
| Beta | Variables limitadas a un intervalo, con sobredispersión (ej. pólizas con más de X reclamos, hospitalizaciones) |
| Gamma | Fallos en procesos industriales |
| Weibull | Tiempos entre fallas físicas de un componente (ej. disco rígido); también mortalidad infantil y envejecimiento operacional |
| Uniforme (continua o discreta) | Procesos completamente inciertos, todos los valores igualmente probables |
| Triangular | Procesos de los que solo se conocen mínimo, máximo y valor más probable (ej. duración de una prueba de producto) |
| Erlang | Suma de varios procesos con distribución exponencial (ej. red con computadora principal + 2 de respaldo); caso especial de Gamma |

## 16. Resolver problemas de probabilidad por simulación

> [!abstract] Idea central
> Un problema de probabilidad se resuelve por simulación cuando el problema original se transforma, mediante un generador de números aleatorios, en un **problema simulado** probabilísticamente equivalente. La respuesta del problema simulado permite inferir una respuesta para el problema original. La fiabilidad depende de la cantidad de ensayos realizados.

```mermaid
flowchart LR
    A[Problema original] -->|generador de<br/>numeros aleatorios| B[Problema simulado]
    B --> C[Solucion del<br/>problema simulado]
    C -->|traduccion /<br/>interpretacion| D[Solucion del<br/>problema original]
```

**Ejemplo — la colección de figuritas**: una pastelería regala 1 de 6 figuritas por pastel comprado. Pregunta original: ¿cuántos pasteles hay que comprar en promedio para tener la colección completa? (equivale a una cadena de Markov absorbente, fuera del nivel del curso).

- **Problema simulado**: ¿cuántos lanzamientos consecutivos de un dado hacen falta, en promedio, hasta que salgan las 6 caras al menos una vez?
- **Hipótesis del modelo**: equiprobabilidad de cada figurita/cara (1/6), distribución uniforme de las figuritas en los pasteles, independencia entre lanzamientos sucesivos.
- No hay una cantidad de simulaciones "correcta" universal: depende del analista y del grado de fiabilidad exigido a la respuesta (algunos métodos sugieren 50, 100 o 1000 corridas).

> [!tip] Por qué importa
> Este enfoque separa la "realidad" (problema original) del "modelo creado para simular" (problema simulado), y muestra a los generadores de aleatoriedad como herramientas para explorar información que no estaba disponible de otra forma — el mismo espíritu heurístico que sostiene a toda la simulación como disciplina.

---

## Repaso rápido (preguntas y respuestas)

**¿Qué diferencia a un modelo determinístico de uno estocástico?**
En el determinístico, dado un conjunto de condiciones Θ, el evento A ocurre siempre. En el estocástico, A puede o no ocurrir, y a veces se puede cuantificar esa probabilidad.

**¿Cuáles son los tres tipos de eventos?**
Cierto (ocurre siempre), imposible (nunca ocurre) y aleatorio (puede o no ocurrir), siempre en referencia a un conjunto de condiciones Θ.

**¿Cuál es la diferencia entre probabilidad marginal y conjunta?**
La marginal es $P(A)$ sin importar qué pase con otro suceso B. La conjunta es $P(A \cap B)$, la ocurrencia simultánea de ambos.

**¿Cuándo se resta la intersección al sumar probabilidades?**
Cuando los sucesos no son mutuamente excluyentes: $P(A \cup C) = P(A) + P(C) - P(A \cap C)$, para no contar dos veces la intersección.

**¿Cómo se calcula la probabilidad conjunta de eventos independientes?**
$P(X \cap Y) = P(X) \cdot P(Y)$, porque ningún evento condiciona al otro ($P(Y|X) = P(Y)$).

**¿Qué mide la Función de Distribución Acumulada (FDA)?**
La probabilidad de que la variable $X$ tome valores menores o iguales a $x$: $F(x) = P(X \le x)$.

**¿Qué distingue a una variable aleatoria discreta de una continua?**
La discreta toma un número finito o infinito numerable de valores ($R_X = \{x_1, x_2, \ldots\}$). La continua toma cualquier valor dentro de un intervalo real.

**¿Cuándo conviene usar una distribución empírica en lugar de una teórica?**
Cuando no es posible o necesario asignarle a la variable una distribución teórica conocida; se calculan directamente las frecuencias relativas (fdp) y acumuladas (FDA) de los datos observados.

**En el catálogo de distribuciones, ¿qué distingue a Poisson de Exponencial?**
Poisson modela el número de eventos independientes en un intervalo fijo de tiempo o espacio; Exponencial modela el tiempo entre esos eventos. Cuando el tiempo entre eventos es exponencial, el número de eventos en un intervalo fijo sigue Poisson.

**¿Qué es el "problema simulado" en la resolución de problemas de probabilidad por simulación?**
Es una transformación del problema original, probabilísticamente equivalente, generada con un generador de números aleatorios, cuya solución permite inferir una respuesta para el problema original.