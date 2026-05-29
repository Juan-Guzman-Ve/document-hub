## Definicion

Una expresion regular (ER) sobre un alfabeto $A$ se construye con las siguientes reglas base:

|ER|Lenguaje que describe|
|---|---|
|$\emptyset$|Lenguaje vacio|
|$\lambda$|${\lambda}$ — solo la cadena vacia|
|$a \in A$|${a}$ — solo el simbolo $a$|
|$r + s$|$L(r) \cup L(s)$ — union|
|$r \cdot s$|$L(r) \cdot L(s)$ — concatenacion|
|$r^*$|$L(r)^*$ — clausura de Kleene (cero o mas repeticiones)|

**Precedencia (de mayor a menor):** $*$ > $.$ (concatenacion) > $+$ (union)

Ejemplo: $ab^_+c$ se lee $((a \cdot (b^_)) + c)$

Las ER describen exactamente los **lenguajes regulares** (los reconocidos por automatas finitos).

---

## Leyes Algebraicas

Dos ER son equivalentes ($r \equiv s$) si $L(r) = L(s)$.

### Operaciones $+$ y $\cdot$

|#|Ley|Expresion|
|---|---|---|
|1|Asociatividad|$\alpha+(\beta+\gamma) = \alpha+\beta+\gamma$ y $\alpha \cdot (\beta \cdot \gamma) = \alpha \cdot \beta \cdot \gamma$|
|2|Conmutatividad e idempotencia de $+$|$\alpha+\beta = \beta+\alpha$ y $\alpha+\alpha = \alpha$|
|3|Distributividad|$\alpha \cdot (\beta+\gamma) = \alpha\beta+\alpha\gamma$ y $(\alpha+\beta) \cdot \gamma = \alpha\gamma+\beta\gamma$|
|4|Elemento neutro|$\alpha \cdot \lambda = \lambda \cdot \alpha = \alpha$ y $\alpha+\emptyset = \alpha$|
|5|Elemento absorbente|$\emptyset \cdot \alpha = \alpha \cdot \emptyset = \emptyset$|
|6|Absorcion de $\lambda$|Si $\lambda \in L(\alpha)$, entonces $\alpha + \lambda = \alpha$|

### Operacion $*$

| #   | Ley                         | Expresion                                                                                 |
| --- | --------------------------- | ----------------------------------------------------------------------------------------- |
| 7   | Expansion                   | $\alpha^* = \lambda + \alpha \cdot \alpha^*$                                              |
| 8   | Clausura de $\lambda$       | $\lambda^* = \lambda$                                                                     |
| 9   | Clausura de $\emptyset$     | $\emptyset^* = \lambda$                                                                   |
| 10  | Idempotencia                | $\alpha^* \cdot \alpha^* = \alpha^*$                                                      |
| 11  | Conmutatividad con $\alpha$ | $\alpha \cdot \alpha^* = \alpha^* \cdot \alpha$                                           |
| 12  | Doble clausura              | $(\alpha^*)^* = \alpha^*$                                                                 |
| 13  | Clausura de union           | $(\alpha+\beta)^* = (\alpha^* \cdot \beta^*)^* = (\alpha^* \cdot \beta)^* \cdot \alpha^*$ |
| 14  | Intercambio                 | $(\alpha \cdot \beta)^* \cdot \alpha = \alpha \cdot (\beta \cdot \alpha)^*$               |

**Corolario importante:** $(\lambda + \alpha)^* \equiv \alpha^*$, porque $\lambda$ ya esta incluido en la clausura. Por tanto: $(\lambda + \alpha)(\lambda + \alpha)^* \equiv \alpha^*$

---

## Simplificacion de ER

### Receta

1. Aplicar distributividad para extraer factores comunes.
2. Reconocer el patron $(\lambda + \alpha)(\lambda + \alpha)^*$ y reducir a $\alpha^*$.
3. Recordar que $\alpha^+ \subseteq \alpha^*$, entonces $\alpha^+ + \alpha^* = \alpha^*$.
4. Si $\lambda \in L(\alpha)$, eliminar el $+\lambda$ sobrante.

### Ejemplos

**a)** $(a + \lambda),a^*,b$

$$= (aa^* + \lambda a^*),b = (a^+ + a^*),b = a^*b$$

**b)** $(\lambda + aa)(\lambda + aa)^*,a + a$

$$= [(\lambda + aa)(\lambda + aa)^* + \lambda],a = (\lambda + aa)^* \cdot a = (aa)^*a$$

**c)** $(\lambda + aa)(\lambda + aa)^*(ab + b) + (ab + b)$

$$= [(\lambda + aa)(\lambda + aa)^* + \lambda],(ab + b) = (aa)^*(ab + b)$$

**d)** $(a + b)(\lambda + aa)^*(\lambda + aa) + (a + b)$

$$= (a+b),[(\lambda + aa)^*(\lambda + aa) + \lambda] = (a+b)(\lambda + aa)^* = (a+b)(aa)^*$$

---

## AF a ER: Metodo de Ecuaciones Caracteristicas

### Pasos

**1. Escribir una ecuacion por cada estado $q_i$:**

- Por cada transicion $\delta(q_i, a) = q_j$, agregar el termino $a \cdot q_j$ al lado derecho.
- Si $q_i$ es estado final, agregar $\lambda$.

**2. Resolver el sistema con el Lema de Arden.**

**Lema de Arden:** si la ecuacion tiene la forma $x = \alpha \cdot x + \beta$, la solucion es $x = \alpha^* \cdot \beta$.

**3. La ER del automata es la solucion para el estado inicial $q_0$.**

### Estrategia de resolucion

- Resolver primero los estados con ecuaciones recursivas (aquellos que se referencian a si mismos).
- Sustituir las ecuaciones resueltas en las demas para eliminar variables.
- Continuar hasta obtener la expresion para $q_0$.

### Ejemplo

**Automata:** $A_1 = ({q_0, q_1, q_2},\ {0,1},\ \delta,\ q_0,\ {q_1})$

**Ecuaciones:**

$$q_0 = 0 \cdot q_0 + 1 \cdot q_1 \tag{1}$$

$$q_1 = 0 \cdot q_0 + 1 \cdot q_2 + \lambda \tag{2}$$

$$q_2 = 0 \cdot q_2 + 1 \cdot q_1 \tag{3}$$

**Resolucion:**

Arden en $(3)$:

$$q_2 = 0^* \cdot 1 \cdot q_1 \tag{4}$$

Arden en $(1)$:

$$q_0 = 0^* \cdot 1 \cdot q_1 \tag{5}$$

Sustituir $(4)$ y $(5)$ en $(2)$:

$$q_1 = 0 \cdot (0^*1 \cdot q_1) + 1 \cdot (0^*1 \cdot q_1) + \lambda = (00^*1 + 10^*1) \cdot q_1 + \lambda$$

Arden:

$$q_1 = (00^*1 + 10^1)^* \tag{6}$$

Sustituir $(6)$ en $(5)$:

$$q_0 = 0^* \cdot 1 \cdot (00^* 1 + 10^_1)^*$$

---

## Patrones Frecuentes para Construir ER

|Descripcion|ER|
|---|---|
|Solo $\lambda$|$\lambda$|
|Longitud exacta $n$ sobre ${a,b}$|$(a+b)$ repetido $n$ veces|
|Longitud multiplo de $n$|bloque de $n$ simbolos $(a+b)$, con clausura $*$|
|Termina en $x$|$(a+b)^* x$|
|Empieza en $x$|$x(a+b)^*$|
|Contiene $x$ como subcadena|$(a+b)^* x (a+b)^*$|
|Exactamente una $a$ en ${a,b}^*$|$b^* a b^*$|
|Exactamente una $a$ en ${a,b,c}^*$|$(b+c)^* a (b+c)^*$|
|Longitud par (o suma de ocurrencias par)|$((a+b)(a+b))^*$|
|$a^{2n}b^{2m+1}$, con $n,m \geq 0$|$(aa)^*(bb)^*b$|

**Sobre $r^*$ vs $r^+$:** $r^_$ incluye $\lambda$; $r^+ = r \cdot r^_$ no incluye $\lambda$. Si el lenguaje incluye $\lambda$, usar $r^*$ o agregar $+\lambda$ explicitamente.

### Ejercicios tipicos

**Dado $\Sigma = {a,b}$, obtener una ER para cada lenguaje:**

$L = {(ab)^i \mid i \geq 0}$ — cadenas que son repeticiones de $ab$, incluyendo $\lambda$:

$$ER = (ab)^*$$

$L = {a^{2n}b^{2m+1} \mid n \geq 0,\ m \geq 0}$ — pares de $a$ seguidos de cantidad impar de $b$:

$$ER = (aa)^*(bb)^*b$$

$L = {w \in {0,1}^* \mid w \text{ tiene al menos dos ceros consecutivos}}$:

$$ER = (0+1)^_00(0+1)^_$$

$L = {w \in {a,b}^* \mid |w| \bmod 3 = 0}$ — cadenas cuya longitud es multiplo de 3:

$$ER = ((a+b)(a+b)(a+b))^*$$

$L = {w \in {a,b}^* \mid n_a(w) + n_b(w) \text{ es par}}$ — cadenas de longitud par:

$$ER = ((a+b)(a+b))^*$$

**Dado $\Sigma = {a,b,c}$, todas las cadenas con exactamente una $a$:**

$$ER = (b+c)^_,a,(b+c)^_$$

**Describir con palabras que lenguaje representa cada ER:**

$0^*$ — cadenas de ceros de cualquier longitud, o $\lambda$.

$(0+1)^*$ — todas las cadenas binarias, incluyendo $\lambda$.

$(10)^*$ — cadenas donde cada $1$ va seguido de un $0$, o $\lambda$.

$(0+1)^_1(1+0)^_$ — cadenas binarias con al menos un $1$.

$1^*01^_01^_$ — cadenas binarias con exactamente dos ceros.

$(0+1)^_00(1+0)^_$ — cadenas binarias que contienen la subcadena $00$.