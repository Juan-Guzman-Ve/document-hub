# Preguntas y Respuestas - Oral Análisis 3

> [!important] Cómo usar esta page Cada pregunta está en un callout **colapsable**: leés la pregunta, intentás responderla de memoria en voz alta, y recién después la expandís para verificar. Es la forma más parecida al oral real. Recordá el formato del examen: 3 preguntas, hay que acertar 3 (2 del primer parcial, 1 del segundo). Empezá siempre por la definición corta y seguí con el "cómo se hace / para qué sirve".

---

## Primer Parcial - Ecuaciones Diferenciales

### Conceptos generales

> [!question]- ¿Qué es una ecuación diferencial? Es una ecuación donde la incógnita es una **función**, no un número, y aparece relacionada con sus **derivadas**. A diferencia de una ecuación algebraica (donde buscás un valor), acá buscás la función que cumple cierta relación entre ella y su tasa de cambio.

> [!question]- ¿Qué es una ecuación diferencial de primer orden? Es aquella donde aparece solo la **primera derivada**, ninguna de orden superior. Describe la relación entre una función y su tasa de cambio.

> [!question]- ¿Cómo se clasifica una ecuación diferencial? Por tres criterios:
> 
> - **Tipo:** ordinaria (una sola variable independiente) o en derivadas parciales (varias).
> - **Orden:** el de la derivada de mayor orden que aparece.
> - **Linealidad:** lineal si la función y sus derivadas aparecen en primer grado, sin productos entre sí ni dentro de funciones no lineales (potencias, trigonométricas, etc.).

> [!question]- ¿Qué es el diferencial de una función en un punto? Es el producto de la derivada por un incremento: $dy = f'(x)\cdot \Delta x$. Como caso particular, si $y=x$ queda $dx = \Delta x$, por eso se escribe $dy = f'(x),dx$. Geométricamente es cuánto cambiaría la función si te movieras sobre la **recta tangente** en lugar de sobre la curva. Es lo que permite escribir una ED como $M,dx + N,dy = 0$ y manipular los diferenciales para separar e integrar.

### Tipos de solución

> [!question]- ¿Cuál es la solución general y en qué se diferencia de la particular? La **general** es la familia de todas las soluciones posibles: una relación entre las variables que contiene una **constante arbitraria** $C$. La **particular** se obtiene de la general fijando esa $C$ con una **condición inicial**. La constante aparece porque integrar siempre introduce una constante, y cada valor da una curva distinta de la familia.

> [!question]- ¿Cómo clasificás las soluciones de una ecuación diferencial? En tres tipos:
> 
> |Tipo|Qué es|
> |---|---|
> |General|Familia completa de soluciones, con constante $C$.|
> |Particular|Sale de la general fijando $C$ con una condición inicial.|
> |Singular|No sale de la general; aparece al anular el denominador al separar variables.|

> [!question]- ¿Qué es una solución singular y de dónde sale? Es una solución que **no se obtiene** de la general para ningún valor de $C$. Aparece cuando, al separar variables, dividís por una expresión y esa expresión igualada a cero (anular el denominador) también resuelve la ecuación. Ejemplo: en $y' = y^2$, al dividir por $y^2$ se pierde $y=0$, que es solución singular.

### Variables separables

> [!question]- ¿Qué es una ecuación de variables separables y cómo se resuelve? Es una EDO de primer orden que se puede escribir como $\frac{dy}{dx} = f(x)\cdot g(y)$, de modo que **cada variable queda de un lado** con su diferencial. Se resuelve: (1) separo todo lo de $y$ con $dy$ y todo lo de $x$ con $dx$, (2) integro ambos miembros por separado, (3) despejo y obtengo la general con $C$.

### Homogéneas

> [!question]- ¿Qué condición se tiene que cumplir para que una ED sea homogénea? Que $M$ y $N$ en $M,dx + N,dy = 0$ sean funciones homogéneas **del mismo grado**. Equivalentemente, que $\frac{dy}{dx}$ dependa **solo de la razón $y/x$**, no de $x$ e $y$ por separado.

> [!question]- ¿Qué es una función homogénea de grado n? Es una función que, al escalar las dos variables por un factor $t$, queda multiplicada por una potencia fija: $f(tx,ty) = t^n,f(x,y)$ para todo $t$. Ese exponente $n$ es el grado. Truco rápido para polinomios: si todos los términos suman el mismo grado total, es homogénea de ese grado.

> [!question]- ¿Por qué M y N tienen que ser homogéneas del mismo grado? Porque la ecuación se reescribe como $\frac{dy}{dx} = -\frac{M}{N}$. Si $M$ es de grado $p$ y $N$ de grado $q$, al escalar por $t$ el cociente queda multiplicado por $t^{p-q}$. Para que dependa **solo de $y/x$** (grado 0), hace falta $p-q=0$, o sea $p=q$. Si los grados fueran distintos, el cociente seguiría dependiendo de la escala y no se podría reducir a $y/x$.

> [!question]- ¿Con qué fin se usa la sustitución v = y/x? ¿A qué tipo lleva la ecuación? Se usa para **transformar la homogénea en una de variables separables**, que sí se sabe resolver. Con $v=y/x$ (es decir $y=vx$, y por regla del producto $y'=v+xv'$), la ecuación pasa a depender solo de $v$ y $x$, separables. Se integra y al final se deshace la sustitución poniendo $v=y/x$.

> [!question]- ¿Una ecuación homogénea es siempre separable? No. Son categorías distintas. En las variables originales, una homogénea casi nunca es separable (depende de $y/x$, que mezcla $x$ e $y$). Lo que la homogeneidad garantiza es que **existe la sustitución $v=y/x$ que la convierte en separable**. Por eso la sustitución es necesaria: sin ella, en general, no podés separar.

### Exactas y factor integrante

> [!question]- ¿Qué condición se tiene que cumplir para que una ED sea exacta? Que sea de la forma $M,dx + N,dy = 0$ y se cumpla la igualdad de **derivadas cruzadas**: $\frac{\partial M}{\partial y} = \frac{\partial N}{\partial x}$. Si es exacta, existe una función potencial $F$ con $F_x'=M$ y $F_y'=N$, y la solución es $F(x,y)=C$.

> [!question]- Si una ED no es exacta, ¿cómo la transformo en exacta? Multiplico toda la ecuación por un **factor integrante** $\mu$, una función elegida para que, después de multiplicar, **sí se cumpla** la condición de exactitud ($M_y'=N_x'$). Luego la resuelvo como exacta.

> [!question]- ¿Cómo me doy cuenta de que un factor integrante depende solo de x (o solo de y)? Depende **solo de $x$** si la expresión $\frac{M_y'-N_x'}{N}$ queda escrita únicamente en función de $x$ (no aparece $y$). Depende **solo de $y$** si $\frac{N_x'-M_y'}{M}$ queda en función solo de $y$. En cada caso, $\mu$ se halla resolviendo una ecuación separable simple en $\mu$.

### Lineales

> [!question]- ¿Qué condición se tiene que cumplir para que una ED sea lineal? ¿Cuál es su forma canónica? Es lineal cuando $y$ e $y'$ aparecen en **primer grado**, sin productos entre sí ni dentro de funciones no lineales. Su forma canónica es $y' + P(x)y = Q(x)$.

> [!question]- Al resolver una lineal, ¿cómo tiene que quedar la parte izquierda para poder integrar? Después de multiplicar por el factor integrante $\mu(x)=e^{\int P(x),dx}$, el lado izquierdo tiene que quedar como la **derivada de un producto**: $\big(y\cdot\mu(x)\big)' = \mu(x),Q(x)$. Así se integra directo de ambos lados y se despeja $y$. Métodos: factor integrante (el estándar).

### Aplicaciones

> [!question]- ¿Para qué sirven las ecuaciones diferenciales? Dame ejemplos. Modelan fenómenos donde una magnitud cambia según su propia tasa de cambio: crecimiento/decaimiento de poblaciones o desintegración radiactiva ($\frac{dy}{dt}=ky$), enfriamiento de Newton ($\frac{dT}{dt}=k(T-T_a)$) y problemas de mezclas en tanques (lo que entra menos lo que sale). En la práctica: identifico el tipo de ED, la resuelvo y uso la condición inicial para la solución particular.

---

## Segundo Parcial - Integrales dobles y análisis vectorial

### Integrales dobles - conceptos

> [!question]- Integrales de primer, segundo y tercer orden: ¿cómo se diferencian? Cambia la dimensión del dominio y el elemento diferencial:
> 
> |Orden|Expresión|Dominio|Geométricamente|
> |---|---|---|---|
> |Primer|$\int f(x),dx$|intervalo (1D)|área bajo la curva|
> |Segundo|$\iint_D f,dA$|región plana (2D)|volumen bajo $z=f(x,y)$|
> |Tercer|$\iiint_E f,dV$|sólido (3D)|masa/carga acumulada|

> [!question]- ¿Qué dice el teorema de Fubini? Que si $f$ es continua en un rectángulo $R=[a,b]\times[c,d]$, la integral doble se puede calcular como una **integral iterada** y el **orden no altera el resultado**. Es lo que justifica resolver una integral doble integrando una variable por vez (en una región general, antes de cambiar el orden hay que re-describir la región).

> [!question]- ¿Cómo se calcula el área de una región con integrales dobles? Con una integral doble cuyo **integrando es 1**: $A(D)=\iint_D 1,dA$. Así la integral solo "suma" áreas diferenciales dentro de $D$. Después describo la región como tipo 1 o tipo 2 y armo la integral iterada.

### Regiones

> [!question]- ¿Qué es una región de tipo 1? ¿Y de tipo 2?
> 
> - **Tipo 1:** está entre dos funciones continuas de $x$. Los límites de $x$ son fijos ($a$ y $b$) e $y$ varía entre $g_1(x)$ y $g_2(x)$. En la iterada, $dy$ va adentro.
> - **Tipo 2:** está entre dos funciones continuas de $y$. Los límites de $y$ son fijos y $x$ varía entre $h_1(y)$ y $h_2(y)$. Acá $dx$ va adentro.

> [!question]- En una integral doble de tipo 2, ¿de qué variable depende el gráfico? Depende de la variable $y$, porque es $x$ quien queda acotado entre funciones de $y$. Los límites exteriores (fijos) son los de $y$.

> [!question]- ¿Cómo planteás una integral doble sobre una región limitada por una parábola? 
> (1) Identifico las curvas que limitan la región. 
> (2) **Calculo los puntos de intersección** resolviendo el sistema. 
> (3) Indico el intervalo entre intersecciones y recién ahí, con un valor de prueba, decido cuál curva está arriba/abajo y si es tipo 1 o 2. 
> (4) Armo la iterada con esos límites y la calculo. El orden importa: primero intersecciones, después valor de prueba.

### Orden de integración

> [!question]- ¿Por qué es necesario cambiar el orden de integración? Porque a veces el orden dado hace la integral **difícil o imposible** (por el integrando o por cómo queda descripta la región), y al invertirlo se simplifica. Ejemplo clásico: $\int_0^1\int_x^1 e^{y^2},dy,dx$ no se puede en ese orden ($e^{y^2}$ no tiene primitiva elemental), pero al invertir el orden queda $\int_0^1 y,e^{y^2},dy$, que sí se resuelve.

### Cambio de variables y jacobiano

> [!question]- ¿Con qué objetivo hacés un cambio de variable? Para **simplificar la integral**: porque la región es complicada (y el cambio la convierte en un rectángulo) o porque el integrando se maneja mejor en las nuevas variables.

> [!question]- ¿Por qué factor hay que multiplicar al cambiar de variable y cómo se calcula? Por el **factor jacobiano**, que es el determinante de la matriz de derivadas parciales del cambio. Ese valor ajusta cómo se deforma el área al pasar de un sistema al otro. Se multiplica su valor absoluto: $dxdy = |J|du,dv$.

> [!question]- ¿Cómo se define el jacobiano de un cambio de variables? Para $x=x(u,v)$, $y=y(u,v)$, es el determinante $J=\dfrac{\partial(x,y)}{\partial(u,v)}=\det\begin{pmatrix} x_u & x_v \ y_u & y_v \end{pmatrix}$, armado con las derivadas parciales de $x$ e $y$ respecto de $u$ y $v$.

> [!question]- ¿Cuál es el significado geométrico de la matriz jacobiana? Describe **cómo se deforma una pequeña región** al pasar del sistema original al nuevo: indica cómo un rectángulo muy chico en $(u,v)$ se transforma en un paralelogramo en $(x,y)$. Su determinante (en valor absoluto) es el factor por el que cambia el área.

> [!question]- ¿Qué relación hay entre los factores de las matrices jacobianas (directo e inverso)? El jacobiano de la transformación inversa es el **recíproco** del directo: $\dfrac{\partial(u,v)}{\partial(x,y)} = \dfrac{1}{,\partial(x,y)/\partial(u,v),}$. Tiene sentido porque ir y volver entre los dos sistemas no puede cambiar el área total; un factor deshace al otro.

> [!question]- Si integro sobre una región circular o anular, ¿qué cambio conviene? Coordenadas **polares**: $x=r\cos\theta$, $y=r\sin\theta$, con $|J|=r$, así $dA=r,dr,d\theta$. Conviene porque transforma el círculo o la corona en un rectángulo en el plano $(r,\theta)$ y simplifica límites e integrando. Es el típico cambio "trigonométrico".

> [!question]- Si integro sobre una región limitada por rectas tipo x+y, ¿qué cambio tomo? Un cambio **lineal**, por ejemplo $u=x+y$, $v=x-y$. Endereza esas rectas y convierte la región en un rectángulo en $(u,v)$.

> [!question]- Si integro sobre una región limitada por hipérbolas, ¿qué cambio tomo? $u=xy$, $v=y/x$. Transforma las hipérbolas en rectas y la región en un rectángulo en el plano $(u,v)$.

### Aplicaciones físicas

> [!question]- ¿Cómo calculás la masa y el centro de masa de una lámina? Con densidad $\rho(x,y)$: la masa es $m=\iint_D \rho dA$. El centro de masa $(\bar x,\bar y)$ es $\bar x=\frac{1}{m}\iint_D x\rho dA$ y $\bar y=\frac{1}{m}\iint_D y\rho dA$. El numerador de cada uno es el **momento** respecto del eje correspondiente (masa por distancia al eje). Es el punto donde la lámina se equilibra.

### Funciones vectoriales

> [!question]- ¿Qué representa la derivada de una función vectorial? El **vector velocidad** de la curva: indica hacia dónde se mueve el punto y a qué ritmo cambia su posición en cada instante del recorrido.

> [!question]- ¿Cuál es el significado físico del vector tangente a una función vectorial? Representa la **velocidad instantánea** del punto que recorre la curva: su dirección es tangente a la trayectoria (hacia dónde se mueve) y su módulo es la rapidez (qué tan rápido lo hace en ese instante). Esta es la pregunta que aparece casi siempre.

> [!question]- ¿Qué representa la segunda derivada de una función vectorial? El **vector aceleración** en ese punto: cómo cambia el vector velocidad a lo largo del recorrido.

> [!question]- ¿Qué diferencia hay entre la imagen de una función vectorial y la curva cartesiana? Al eliminar el parámetro, la **curva cartesiana suele tener más puntos** que la imagen de la función vectorial (el parámetro puede recorrer solo un tramo). Además, la función vectorial le da una **orientación** (un sentido de recorrido) que la ecuación cartesiana por sí sola no tiene.

> [!question]- ¿Cómo se calcula la longitud de una curva en R3? ¿Por qué se usa la norma de la derivada? Integrando la norma del vector derivada: $L=\int_a^b |\vec r'(t)|,dt = \int_a^b \sqrt{x'^2+y'^2+z'^2},dt$. Sale de **Pitágoras** sobre un desplazamiento diferencial ($ds=\sqrt{dx^2+dy^2+dz^2}$): la norma mide cuánto "avanza" la curva por unidad de parámetro, y al integrarla se suman todos esos avances.

> [!question]- ¿Cómo se calcula la recta tangente a una curva dada por una función vectorial? Se evalúa la curva en $t_0$ para el punto $\vec r(t_0)$ y se usa $\vec r'(t_0)$ como **vector director**: $L:\ \vec r(t_0)+\lambda,\vec r'(t_0)$, con $\lambda\in\mathbb{R}$.

> [!question]- ¿Cómo se obtiene el plano normal a una curva en un punto? Pasa por el punto $\vec r(t_0)$ y toma como **vector normal** al tangente $\vec r'(t_0)$. Su ecuación es $\big(\vec P-\vec r(t_0)\big)\cdot\vec r'(t_0)=0$. El plano es perpendicular a la dirección de avance de la curva, por eso el tangente hace de normal.

### Campos vectoriales y conservativos

> [!question]- ¿Qué es un campo vectorial? ¿Y un campo gradiente? Un **campo vectorial** asigna a cada punto del plano o el espacio un vector: $\vec F(x,y)=(P;Q)$. Modela, por ejemplo, un campo de fuerzas o el flujo de un fluido. Un **campo gradiente** es el que se obtiene del gradiente de un campo escalar $f$: $\nabla f=(f_x';f_y')$.

> [!question]- ¿Qué diferencia hay entre una integral de línea escalar y una vectorial? La **escalar** $\int_C f,ds=\int_a^b f(\vec r(t)),|\vec r'(t)|,dt$ suma un campo escalar a lo largo de la curva (ej. masa de un alambre). La **vectorial** $\int_C \vec F\cdot d\vec r=\int_a^b \vec F(\vec r(t))\cdot\vec r'(t),dt$ calcula el **trabajo** de un campo de fuerzas al mover una partícula por la curva. En la escalar uso $ds$ (un escalar); en la vectorial proyecto el campo sobre la dirección de avance.

> [!question]- ¿Qué relación hay entre un campo conservativo y la integral de trayectoria? En un campo conservativo, la integral de línea **no depende del camino**, solo de los puntos inicial y final, porque el campo proviene del **gradiente de una función potencial** $f$. Por el teorema fundamental: $\int_C \vec F\cdot d\vec r=f(B)-f(A)$.

> [!question]- ¿Cómo verificás si un campo es conservativo? En $\mathbb{R}^2$, con $\vec F=(M;N)$: es conservativo si y solo si $\frac{\partial M}{\partial y}=\frac{\partial N}{\partial x}$. En $\mathbb{R}^3$: si y solo si $\text{rot},\vec F=\vec 0$.

> [!question]- ¿Cómo hallás la función potencial de un campo conservativo? Integro $M$ respecto de $x$ (queda una "constante" $g(y)$), después derivo ese resultado respecto de $y$ y lo igualo a $N$ para descubrir $g'(y)$, e integro. Así reconstruyo $f$ tal que $\nabla f=\vec F$.

> [!important] La conexión que vale oro: exactas ↔ conservativos Las **ecuaciones exactas** y los **campos conservativos** son el mismo concepto en dos módulos distintos:
> 
> - Misma condición: exacta pide $M_y'=N_x'$; conservativo en $\mathbb{R}^2$ pide $M_y'=N_x'$.
> - Misma idea: en exactas existe $F$ con $F_x'=M$, $F_y'=N$ y la solución es $F(x,y)=C$; en conservativos existe la función potencial $f$ con $\nabla f=\vec F$. Mencionar esto en el oral muestra que entendés la materia de fondo, no de memoria.

---

> [!note] Recordatorio final El examinador busca respuestas **genéricas de cómo se hace**, no desarrollos completos. Definición corta primero, después el procedimiento o el para qué sirve. Las tres de mayor probabilidad: vector tangente físico, jacobiano (definición + significado geométrico) y reconocer las cuatro familias de EDO.