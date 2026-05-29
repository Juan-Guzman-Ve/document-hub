## Definicion

Una expresion regular (ER) sobre un alfabeto A se construye con las siguientes reglas base:

|ER|Lenguaje que describe|
|---|---|
|∅|Lenguaje vacio|
|λ|{λ} — solo la cadena vacia|
|a ∈ A|{a} — solo el simbolo a|
|r + s|L(r) ∪ L(s) — union|
|r · s|L(r) · L(s) — concatenacion|
|r*|L(r)* — clausura de Kleene (cero o mas repeticiones)|

**Precedencia (de mayor a menor):** * > · (concatenacion) > + (union)

Ejemplo: $ab^*+c$ se lee $((a \cdot b^*) + c)$

Las ER describen exactamente los **lenguajes regulares** (los reconocidos por automatas finitos).

---

## Leyes Algebraicas

Dos ER son equivalentes si describen el mismo lenguaje: $r \equiv s \iff L(r) = L(s)$

### Operaciones + y ·

|#|Ley| |
|---|---|---|
|1|Asociatividad|$\alpha+(\beta+\gamma) = \alpha+\beta+\gamma$|
|||$\alpha \cdot (\beta \cdot \gamma) = \alpha \cdot \beta \cdot \gamma$|
|2|Conmutatividad|$\alpha+\beta = \beta+\alpha$|
||Idempotencia|$\alpha+\alpha = \alpha$|
|3|Distributividad|$\alpha \cdot (\beta+\gamma) = \alpha\beta+\alpha\gamma$|
|||$(\alpha+\beta) \cdot \gamma = \alpha\gamma+\beta\gamma$|
|4|Elemento neutro|$\alpha \cdot \lambda = \lambda \cdot \alpha = \alpha$|
|||$\alpha + \emptyset = \alpha$|
|5|Elemento absorbente|$\emptyset \cdot \alpha = \alpha \cdot \emptyset = \emptyset$|
|6|Absorcion de λ|Si $\lambda \in L(\alpha)$, entonces $\alpha + \lambda = \alpha$|

### Operacion *

|#|Ley| |
|---|---|---|
|7|Expansion|$\alpha^* = \lambda + \alpha \cdot \alpha^*$|
|8|Clausura de λ|$\lambda^* = \lambda$|
|9|Clausura de ∅|$\emptyset^* = \lambda$|
|10|Idempotencia|$\alpha^* \cdot \alpha^* = \alpha^*$|
|11|Conmutatividad con α|$\alpha \cdot \alpha^* = \alpha^* \cdot \alpha$|
|12|Doble clausura|$(\alpha^*)^* = \alpha^*$|
|13|Clausura de union|$(\alpha+\beta)^* = (\alpha^* \cdot \beta^*)^* = (\alpha^* \cdot \beta)^* \cdot \alpha^*$|
|14|Intercambio|$(\alpha \cdot \beta)^* \cdot \alpha = \alpha \cdot (\beta \cdot \alpha)^*$|

**Corolario importante:** $(\lambda + \alpha)^* \equiv \alpha^*$, porque λ ya esta incluido en la clausura.

Por tanto: $(\lambda + \alpha)(\lambda + \alpha)^* \equiv \alpha^*$

---

## Simplificacion de ER

### Receta

1. Aplicar distributividad para extraer factores comunes.
2. Reconocer el patron $(\lambda + \alpha)(\lambda + \alpha)^*$ y reducir a $\alpha^*$.
3. Recordar que $\alpha^+$ esta incluido en $\alpha^*$, entonces $\alpha^+ + \alpha^* = \alpha^*$.
4. Si $\lambda \in L(\alpha)$, eliminar el $+\lambda$ sobrante por la ley 6.

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

**1. Escribir una ecuacion por cada estado** $q_i$:

- Por cada transicion $\delta(q_i,, a) = q_j$, agregar el termino $a \cdot q_j$ al lado derecho.
- Si $q_i$ es estado final, agregar $\lambda$.

**2. Resolver el sistema con el Lema de Arden.**

Lema de Arden: si la ecuacion tiene la forma $x = \alpha \cdot x + \beta$, la solucion es

$$x = \alpha^* \cdot \beta$$

**3. La ER del automata es la solucion para el estado inicial** $q_0$.

### Estrategia

- Resolver primero los estados con ecuaciones recursivas (que se referencian a si mismos).
- Sustituir las ecuaciones resueltas en las demas para eliminar variables.
- Continuar hasta obtener la expresion para $q_0$.

### Ejemplo

Automata: $A_1 = ({q_0, q_1, q_2},; {0,1},; \delta,; q_0,; {q_1})$

**Ecuaciones:**

$$q_0 = 0 \cdot q_0 + 1 \cdot q_1 \tag{1}$$

$$q_1 = 0 \cdot q_0 + 1 \cdot q_2 + \lambda \tag{2}$$

$$q_2 = 0 \cdot q_2 + 1 \cdot q_1 \tag{3}$$

**Resolucion:**

Arden en (3):

$$q_2 = 0^* \cdot 1 \cdot q_1 \tag{4}$$

Arden en (1):

$$q_0 = 0^* \cdot 1 \cdot q_1 \tag{5}$$

Sustituir (4) y (5) en (2):

$$q_1 = 0 \cdot (0^* 1 \cdot q_1) + 1 \cdot (0^* 1 \cdot q_1) + \lambda = (00^*1 + 10^*1) \cdot q_1 + \lambda$$

Arden:

$$q_1 = (00^* 1 + 10^*1)^* \tag{6}$$

Sustituir (6) en (5):

$$q_0 = 0^* \cdot 1 \cdot (00^*1 + 10^*1)^*$$

---

## Patrones Frecuentes para Construir ER

| Descripcion                   | ER (texto plano)                    |
| ----------------------------- | ----------------------------------- |
| Solo λ                        | λ                                   |
| Longitud exacta n sobre {a,b} | (a+b) repetido n veces              |
| Longitud multiplo de n        | bloque de n simbolos con clausura * |
| Termina en x                  | (a+b)*x                             |
| Empieza en x                  | x(a+b)*                             |
| Contiene x como subcadena     | (a+b)_x(a+b)_                       |
| Exactamente una a en {a,b}*   | b_ab_                               |
| Exactamente una a en {a,b,c}* | (b+c)_a(b+c)_                       |
| Longitud par                  | ((a+b)(a+b))*                       |
| a^2n · b^(2m+1), n,m >= 0     | (aa)*(bb)*b                         |

r* incluye λ. r+ = r·r* no incluye λ. Si el lenguaje incluye λ, usar r* o agregar +λ explicitamente.

---

## Ejercicios Tipicos

### Obtener ER dado el lenguaje

**L = { (ab)^i | i >= 0 }** — repeticiones de ab, incluyendo λ:

$$ER = (ab)^*$$

**L = { a^(2n) b^(2m+1) | n,m >= 0 }** — pares de a seguidos de cantidad impar de b:

$$ER = (aa)^*(bb)^*b$$

**Cadenas binarias con al menos dos ceros consecutivos:**

$$ER = (0+1)^*00(0+1)^*$$

**Cadenas sobre {a,b} cuya longitud es multiplo de 3:**

$$ER = ((a+b)(a+b)(a+b))^*$$

**Cadenas sobre {a,b} de longitud par (equivalente a $n_a + n_b$ par):**

$$ER = ((a+b)(a+b))^*$$

**Cadenas sobre {a,b,c} con exactamente una a:**

$$ER = (b+c)^* , a , (b+c)^*$$

### Describir con palabras el lenguaje de una ER

$0^*$ — cadenas de ceros de cualquier longitud, o λ.

$(0+1)^*$ — todas las cadenas binarias, incluyendo λ.

$(10)^*$ — cadenas donde cada 1 va seguido de un 0, o λ.

$(0+1)^*1(1+0)^*$ — cadenas binarias con al menos un 1.

$1^*01^*01^*$ — cadenas binarias con exactamente dos ceros.

$(0+1)^*00(1+0)^*$ — cadenas binarias que contienen la subcadena 00.