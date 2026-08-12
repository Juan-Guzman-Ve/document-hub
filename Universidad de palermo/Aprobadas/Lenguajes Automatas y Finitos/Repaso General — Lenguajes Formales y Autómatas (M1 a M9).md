

> [!important] Cómo usar este documento Cada módulo lista solo lo imprescindible: definiciones, el método que entra en los ejercicios y un ejemplo corto. Pensado para repaso de oral.

## Tabla maestra (jerarquía de Chomsky)

|Tipo|Lenguaje|Forma de producción|Autómata que lo reconoce|
|---|---|---|---|
|0|Recursivamente enumerable|u → v (sin restricción)|Máquina de Turing|
|1|Sensible al contexto|xAy → xvy, con \|izq\| ≤ \|der\||Autómata linealmente acotado|
|2|Libre de contexto|A → v (un no terminal a la izquierda)|Autómata de pila|
|3|Regular|A → aB, A → a (o A → Ba)|Autómata finito|

> [!note] Inclusión Tipo 3 ⊆ Tipo 2 ⊆ Tipo 1 ⊆ Tipo 0. Cada clase es más restrictiva que la que la contiene.

---

## Módulo 1 — Alfabeto, Cadenas y Lenguajes

### Definiciones clave

- **Alfabeto Σ**: conjunto finito y no vacío de símbolos. Ej: `Σ = {a, b}`.
- **Cadena (string)**: secuencia finita de símbolos de Σ.
- **Cadena vacía λ**: cadena sin símbolos. `|λ| = 0`.
- **Longitud |w|**: cantidad de símbolos. Ej: `|aba| = 3`.
- **Σ***: todas las cadenas sobre Σ, incluida λ (clausura de Kleene).
- **Σ⁺**: todas las cadenas sobre Σ sin λ (clausura positiva). `Σ⁺ = Σ* − {λ}`.
- **Lenguaje L**: cualquier subconjunto de Σ* (`L ⊆ Σ*`).

### Operaciones que entran sí o sí

|Operación|Notación|Ejemplo|
|---|---|---|
|Concatenación de cadenas|uv|`ab · ba = abba`|
|Potencia de cadena|wⁿ|`(ab)² = abab`, `w⁰ = λ`|
|Unión de lenguajes|L₁ ∪ L₂|une cadenas de ambos|
|Concatenación de lenguajes|L₁L₂|`{a}{b,c} = {ab, ac}`|
|Potencia de lenguaje|Lⁿ|`L⁰ = {λ}`|
|Clausura de Kleene|L*|`L⁰ ∪ L¹ ∪ L² ∪ ...`|
|Clausura positiva|L⁺|sin L⁰|

> [!warning] Errores típicos de oral `∅` (lenguaje vacío, sin cadenas) NO es lo mismo que `{λ}` (lenguaje con una cadena, la vacía). `|∅| = 0` cadenas; `|{λ}| = 1` cadena.

---

## Módulo 2 — Gramáticas y Tipos

### Definición formal

```
G = { ΣT , ΣN , S , P }
ΣT : símbolos terminales
ΣN : símbolos no terminales
S  : símbolo inicial (no terminal)
P  : producciones (reglas de derivación)
```

- **Derivación** `⇒`: aplicar una producción. `⇒*`: cero o más pasos.
- **Lenguaje generado** `L(G)`: todas las cadenas de solo terminales derivables desde S.
- **Gramáticas equivalentes**: generan el mismo lenguaje.

### Formas de producción por tipo

```
Tipo 0:  u → v                  (u, v cualquier cadena)
Tipo 1:  xAy → xvy              (no acorta: |izq| ≤ |der|)
Tipo 2:  A → v                  (a la izquierda, un solo no terminal)
Tipo 3:  A → aB  /  A → a       (lineal por derecha, GLD)
         A → Ba  /  A → a       (lineal por izquierda, GLI)
         S → λ                  permitida
```

### Ejemplo

```
G = { {a,b}, {S}, S, P }
P: S → ab
   S → aSb
L(G) = { aⁿbⁿ | n ≥ 1 }   (libre de contexto, Tipo 2)
```

> [!warning] Clasificación correcta Una gramática se clasifica por el tipo MÁS restrictivo que cumplen TODAS sus producciones. No se pueden mezclar producciones por izquierda y por derecha en una misma gramática regular: si se mezclan, es de Tipo 2, no Tipo 3.

---

## Módulo 3 — Autómatas Finitos Deterministas (AFD)

### Definición formal

```
M = ( Q , Σ , δ , q0 , F )
Q  : conjunto finito de estados
Σ  : alfabeto de entrada
δ  : Q × Σ → Q   (función total y determinista)
q0 : estado inicial
F  : estados finales,  F ⊆ Q
```

> [!important] Clave del determinismo δ es una función: para cada (estado, símbolo) hay UN Y SOLO UN estado siguiente. Nunca dos transiciones con el mismo símbolo desde un mismo estado, ni transiciones con λ.

### Representaciones

- **Tabla de transición**: filas = estados, columnas = símbolos. Inicial con `→`, finales con `*`.
- **Diagrama**: inicial con flecha de entrada, final con doble círculo.

### Ejemplo (acepta cadenas con cantidad par de a sobre {a,b})

```
δ      a     b
→ *q0   q1    q0
   q1   q0    q1
```

`q0` inicial y final; cada `a` cambia de paridad, cada `b` no afecta.

---

## Módulo 4 — Autómatas Finitos No Deterministas (AFND y λ-AFND)

### Definiciones

```
AFND:    δ : Q × Σ        → P(Q)      (devuelve un CONJUNTO de estados)
λ-AFND:  δ : Q × (Σ ∪ {λ}) → P(Q)     (permite transiciones con λ)
```

- Desde un estado, con un símbolo, se puede ir a 0, 1 o varios estados.
- **Cadena aceptada**: si ALGÚN cómputo termina en estado final.
- **Clausura-λ(q)**: conjunto de estados alcanzables desde q usando solo arcos λ (q se incluye a sí mismo).

### Método 1 — Subconjuntos (AFND → AFD)

```
Q'  = P(Q)                     (subconjuntos de estados)
q0' = { q0 }
F'  = { S ∈ P(Q) | S ∩ F ≠ ∅ }
δ'(S, a) = ∪ δ(q, a)  para todo q ∈ S
```

Se construyen solo los subconjuntos alcanzables desde `{q0}`.

### Método 2 — Eliminar λ (λ-AFND → AFND)

```
1. Calcular Clausura-λ(q) para cada estado.
2. Si Clausura-λ(q0) ∩ F ≠ ∅  → q0 pasa a ser final.
3. δ(q, a) = Clausura-λ( { p | p ∈ δ(r, a),  r ∈ Clausura-λ(q) } )
```

> [!note] Equivalencia AFD ≡ AFND ≡ λ-AFND: los tres reconocen exactamente la misma clase (lenguajes regulares). El AFND es solo más cómodo para diseñar.

### Ejemplo de tabla AFND

```
δ      0          1
→ p    {q, r}     ∅
* q    {q}        {q, s}
  r    ∅          {s}
* s    {p}        ∅
```

---

## Módulo 5 — Expresiones Regulares (introducción)

### Definición recursiva

```
Bases:    ∅ ,  λ ,  a   (a ∈ Σ)  son ER
Reglas:   si r y s son ER, también lo son:
          r + s   (unión)
          r · s   (concatenación)
          r*      (clausura)
```

- **Precedencia**: `*` > concatenación > `+`.
- `L(r)` = lenguaje denotado por la ER r.

### Teoremas de Kleene

|Teorema|Dice|
|---|---|
|Síntesis|Toda ER tiene un AF que reconoce su lenguaje|
|Análisis|Todo AF tiene una ER que denota su lenguaje|

### Ejemplos

```
a*           → cero o más a:  { λ, a, aa, aaa, ... }
(a + b)*     → toda cadena sobre {a, b}
a(a + b)*b   → empieza con a y termina con b
(ab)*        → { λ, ab, abab, ... }
```

---

## Módulo 6 — Expresiones Regulares (avanzado) + AF → ER

### Leyes algebraicas que hay que tener a mano

```
r + s = s + r            r + r = r
r + ∅ = r                λ · r = r
∅ · r = ∅                (r*)* = r*
(r + s)* = (r* s*)* = (r* + s*)*
(rs)* r = r (sr)*
```

### Método AF → ER (ecuaciones características + Arden)

```
1. Una ecuación por estado qi.
   Por cada δ(qi, a) = qj  →  sumar término  a·qj
   Si qi es final, sumar λ.

2. Resolver el sistema con el Lema de Arden:
   Ecuación de la forma   X = αX + β
   tiene solución única    X = α* β     (si α no contiene λ)

3. La ER del autómata = solución para el estado INICIAL.
```

### Ejemplo (esqueleto del método)

```
Ecuaciones:
  q0 = 0·q0 + 1·q1
  q1 = 0·q0 + 1·q2 + λ
  q2 = 0·q2 + 1·q1

Arden en q2:  q2 = 0* 1 q1
Arden en q0:  q0 = 0* 1 q1
Sustituir en q1 y volver a aplicar Arden hasta despejar q1,
luego reemplazar y obtener la ER de q0.
```

> [!important] Lema de Arden — condición Solo da solución única cuando α (lo que multiplica a X por la izquierda) NO genera λ. Es la regla de oro del módulo.

---

## Módulo 7 — Gramáticas Regulares

### Definiciones (Tipo 3)

```
GLD (lineal por derecha):  A → aB ,  A → a ,  S → λ
GLI (lineal por izquierda): A → Ba ,  A → a ,  S → λ
```

### Lenguaje regular — tres caracterizaciones equivalentes

> [!important] Las tres puertas del mismo lenguaje Un lenguaje es regular si y solo si se puede: (1) describir con una expresión regular, (2) generar con una gramática regular, (3) reconocer con un autómata finito.

### Correspondencia AF ↔ Gramática regular

```
AF → GLD:   por cada δ(qi, a) = qj   →   producción  qi → a qj
            estados finales            →   producción  qi → λ
            (N = Q,  S = q0)

GLD → AF:   por cada producción qi → a qj  →  transición δ(qi, a) = qj
            (Q = N,  q0 = S)
```

- **GLD ↔ GLI**: pasar de una a otra vía el autómata (o método de inversión de grafo): se invierten los arcos, se intercambian inicial y final.
- **Minimización de AFD** (refinamiento de particiones):

```
1. Partir en 2 grupos: finales y no finales.
2. En cada ronda, dos estados quedan juntos solo si,
   para cada símbolo, sus transiciones caen en el MISMO grupo.
3. Si un grupo se parte, RE-evaluar todos los grupos en la ronda siguiente.
4. Repetir hasta que ninguna partición cambie.
```

> [!warning] Minimización Tras cada división de un grupo, hay que reevaluar TODOS los grupos desde cero en la ronda siguiente. No se saltean pasos ni se arrastran agrupamientos viejos.

---

## Módulo 8 — Autómatas de Pila (AP)

### Definición formal

```
M = ( Σ , Q , Γ , z0 , q0 , δ , F )
Σ  : alfabeto de entrada
Q  : estados
Γ  : alfabeto de la pila
z0 : símbolo inicial de la pila  (z0 ∈ Γ)
q0 : estado inicial
δ  : función de transición
F  : estados finales
```

### Notación de transiciones (clave para leer y diseñar)

```
a, A ; γ     leo 'a', tope de pila 'A', lo reemplazo por γ
a, Z ; AZ    leo 'a', pila vacía (tope Z), apilo A
a, A ; AA    leo 'a', tope A, apilo otra A
b, A ; λ     leo 'b', tope A, desapilo (borro el tope)
λ, Z ; Z     sin leer entrada, tope Z (fin de cadena)
```

### Aceptación (dos formas)

- Por **estado final**.
- Por **pila vacía**.

### Estrategia de diseño

> [!important] La pila cuenta Para lenguajes con anidamiento o balanceo (igual cantidad de símbolos, paréntesis bien formados), se usa la pila como contador: apilar una marca al leer la primera parte y desapilarla al leer la segunda. Reconocen lenguajes libres de contexto (Tipo 2).

### Ejemplo: L = { aⁿbⁿ | n ≥ 0 }

```
q0 --(a, Z ; AZ)--> q0      apila A por cada a (primera a)
q0 --(a, A ; AA)--> q0      sigue apilando A
q0 --(b, A ; λ)--> q1       primera b: empieza a desapilar
q1 --(b, A ; λ)--> q1       una b por cada A
q1 --(λ, Z ; Z)--> q2 *     pila en su base → acepta
```

---

## Módulo 9 — Máquinas de Turing (MT)

### Definición formal

```
MT = < E , Σ , C , δ , e0 , B , F >
E  : estados
Σ  : alfabeto de entrada
C  : alfabeto de cinta,  C = Σ ∪ {B} ∪ auxiliares
δ  : E × C → E × C × {D, I, N}     (estado, escribe símbolo, mueve)
e0 : estado inicial
B  : símbolo blanco  (B ∉ Σ)
F  : estados finales
```

- Movimientos: **D** = derecha, **I** = izquierda, **N** = no mueve.
- Cinta infinita; el cabezal lee/escribe y se desplaza.
- Si no hay transición definida, la máquina **se detiene**.

### Dos tipos de MT

|Tipo|Qué hace|
|---|---|
|Transductor|Modifica el contenido de la cinta (calcula una salida)|
|Reconocedor|Acepta o rechaza una cadena (reconoce un lenguaje)|

### Cómo leer un arco del diagrama

```
símbolo leído ; símbolo escrito , dirección
Ej:  0 ; 1 , D    leo 0, escribo 1, muevo a la derecha
```

### Ejemplo: transductor que invierte bits (0↔1)

```
e0 --(0 ; 1 , D)--> e0
e0 --(1 ; 0 , D)--> e0
e0 --(B ; B , N)--> e1 *    al llegar al blanco, termina
```

> [!note] Poder de cómputo La MT reconoce los lenguajes recursivamente enumerables (Tipo 0): es el modelo más general de la jerarquía.

---

## Anexo — Preguntas frecuentes de oral

> [!note] Repaso rápido
> 
> - Diferencia ∅ vs {λ}.
> - ¿Por qué AFD ≡ AFND? (misma clase: lenguajes regulares).
> - Tres caracterizaciones del lenguaje regular (ER, gramática regular, AF).
> - Condición del Lema de Arden (α sin λ → solución única).
> - ¿Qué reconoce cada autómata? AF→regulares, AP→libres de contexto, MT→recursiv. enumerables.
> - Transductor vs reconocedor en MT.
> - Por qué no se mezclan producciones GLD y GLI en una gramática regular.