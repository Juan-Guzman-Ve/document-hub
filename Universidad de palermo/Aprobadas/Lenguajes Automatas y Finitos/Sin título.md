# Repaso Teórico — Segundo Parcial (Módulos 6 a 9)

> [!important] Cómo leer este resumen Cada concepto aparece dos veces: primero la **definición formal** (como la pide el oral) y enseguida la explicación **en criollo** (para entenderla de verdad). Las **preguntas de oral** al final de cada módulo son las que tenés que poder responder sin dudar. Al final hay un repaso de M1–M5 con ejemplos de gramáticas por tipo.

---

## Referencia rápida — Tipos de gramática (Chomsky)

| Tipo  | Nombre               | Forma de producciones               | Clave para identificar                                                 | Reconocedor         |
| ----- | -------------------- | ----------------------------------- | ---------------------------------------------------------------------- | ------------------- |
| **3** | Regular              | `A → a`, `A → aB` (o `Ba`), `S → λ` | Izq: un no terminal. Der: un terminal ± un no terminal, **mismo lado** | Autómata Finito     |
| **2** | Libre de contexto    | `A → v`                             | Izq: **un solo no terminal**. Der: libre                               | Autómata de Pila    |
| **1** | Sensible al contexto | `xAy → xvy`                         | **Nunca acorta** (`\|izq\| ≤ \|der\|`); puede tener contexto           | Aut. lineal acotado |
| **0** | Sin restricciones    | `u → v`                             | **Acorta o borra**; varios símbolos a la izquierda                     | Máquina de Turing   |

Contención: **Tipo 3 ⊂ Tipo 2 ⊂ Tipo 1 ⊂ Tipo 0**.

> [!note] Cómo clasificar Chequeá de 3 a 0 y quedate con el **primero (más restrictivo)** que cumplan _todas_ las reglas:
> 
> 1. ¿Der. es `a`, `aB`/`Ba` o `λ`, mismo lado? → Tipo 3
> 2. ¿Izq. es un solo no terminal? → Tipo 2
> 3. ¿Nunca acorta (aunque haya contexto)? → Tipo 1
> 4. ¿Alguna regla acorta/borra? → Tipo 0

> [!warning] Trampas
> 
> - Mezclar lineal derecha e izquierda rompe el Tipo 3.
> - `A → BC` (dos no terminales) es Tipo 2, no Tipo 3.
> - `S → λ` se permite si S no aparece a la derecha de otra regla.
> - Clasificás la **gramática** por su forma, no el lenguaje.

---

## Hilo conductor del parcial

> [!note] La idea que une todo Un mismo lenguaje regular se puede describir de cuatro formas que valen exactamente lo mismo: una **expresión regular** (M6), una **gramática regular** (M7) y un **autómata finito** (M1–M5). Cuando el lenguaje es demasiado complejo para ser regular (hay que "contar y comparar"), subimos un escalón: **gramática libre de contexto + autómata de pila** (M8). Y el modelo más poderoso, capaz de simular cualquier algoritmo, es la **Máquina de Turing** (M9).

|Modelo|¿Qué hace?|Tipo de lenguaje|Memoria que tiene|
|---|---|---|---|
|Autómata Finito / ER / Gram. regular|reconoce/genera regulares|Tipo 3|ninguna (solo "se acuerda" del estado actual)|
|Autómata de Pila / Gram. libre de contexto|reconoce/genera libres de contexto|Tipo 2|una pila (LIFO: último en entrar, primero en salir)|
|Máquina de Turing|reconoce o transforma|Tipo 1 y 0|una cinta infinita donde lee y escribe|

> [!note] En criollo El salto importante es la **memoria**. El autómata finito no recuerda nada salvo en qué estado está, por eso no puede contar. La pila le da una memoria ordenada para comparar cantidades (aⁿbⁿ). La cinta de Turing le da memoria total, así que puede hacer cualquier cómputo.

---

# Módulo 6 — Expresiones Regulares

## 1. Definiciones

> [!important] Definición formal — Expresión Regular (ER) Una expresión regular sobre un alfabeto A se construye con estas reglas base:
> 
> ```
> ∅        es una ER que describe el lenguaje vacío
> λ        es una ER que describe { λ }   (solo la cadena vacía)
> a ∈ A    es una ER que describe { a }   (solo la cadena de un símbolo a)
> ```
> 
> Y si r y s ya son ER que describen los lenguajes L(r) y L(s):
> 
> ```
> r + s   describe   L(r) ∪ L(s)     unión
> r · s   describe   L(r) · L(s)     concatenación
> r*      describe   L(r)*           clausura de Kleene
> ```

> [!note] En criollo Una ER es una "fórmula" que describe un conjunto de cadenas usando solo tres herramientas: elegir entre opciones ( + ), pegar una cosa tras otra ( · ) y repetir cero o más veces ( * ). Empezás con piezas mínimas (∅, λ, un símbolo) y las vas combinando.

**Definiciones de apoyo que conviene tener a mano:**

- **Lenguaje**: cualquier conjunto de cadenas sobre Σ (un subconjunto de Σ*).
- **Concatenación de lenguajes** `L₁·L₂`: todas las cadenas formadas pegando una de L₁ seguida de una de L₂.
- **Clausura de Kleene** `L*`: concatenar L consigo mismo cero o más veces; siempre incluye λ.
- **Lenguaje regular**: el que puede describirse con una ER (equivalente: reconocido por un AF).
- **Equivalencia** `r ≡ s`: dos ER son equivalentes si describen el mismo lenguaje, es decir `L(r) = L(s)`.

> [!important] Precedencia de operadores De más fuerte a más débil: clausura ( * ) → concatenación ( · ) → unión ( + ). Por eso `ab*` significa `a·(b*)` y no `(ab)*`. La estrella "se pega" a lo que tiene inmediatamente a su izquierda.

## 2. Teoría — equivalencia entre Autómatas Finitos y ER

> [!note] Teorema de Análisis de Kleene (formal) Si L es aceptado por un autómata finito M, entonces existe una ER α tal que L(M) = L(α).

> [!note] Teorema de Síntesis de Kleene (formal) Si L está asociado a la ER α, entonces existe un autómata finito M tal que L(M) = L(α).

> [!note] En criollo Los dos teoremas dicen lo mismo en direcciones opuestas: **autómata y ER son intercambiables**. Análisis = "tengo el autómata, saco la fórmula". Síntesis = "tengo la fórmula, construyo el autómata". Juntos prueban que ER y AF describen exactamente la misma familia de lenguajes (los regulares).

**Cómo pasar de un AF a su ER (ecuaciones características + Lema de Arden):**

```
1. Por cada estado qi armo una ecuación:
   - lado izquierdo: qi
   - lado derecho: la suma de a·qj por cada transición δ(qi,a)=qj
   - si qi es estado final, le sumo λ al lado derecho
2. Resuelvo el sistema. Toda ecuación de la forma  x = α·x + β  es "fundamental".
   LEMA DE ARDEN:  su solución es  x = α*·β
   (uso también las leyes algebraicas para simplificar)
3. La ER del autómata es la solución del estado inicial q0.
```

> [!note] En criollo del Lema de Arden Una ecuación `x = α·x + β` dice "x es: o bien β, o bien α seguido de x otra vez" (definición circular). La solución `α*·β` la traduce a: "repetí α las veces que quieras y al final poné β". La estrella aparece justamente porque la x se llama a sí misma.

## 3. Propiedades (leyes algebraicas)

```
Sobre  +  y  ·
1.  α+(β+γ)=(α+β)+γ      α·(β·γ)=(α·β)·γ        asociativas
2.  α+β=β+α              α+α=α                  + conmutativa e idempotente
3.  α·(β+γ)=α·β+α·γ      (α+β)·γ=α·γ+β·γ          distributiva
4.  α·λ=λ·α=α            α+∅=∅+α=α               elementos neutros
5.  ∅·α=α·∅=∅                                    ∅ "mata" la concatenación
6.  si λ∈L(α)  ⇒  α+λ=α

Sobre  *
7.  α* = λ + α·α*
8.  λ* = λ
9.  ∅* = λ
10. α*·α* = α*
11. α·α* = α*·α
12. (α*)* = α*
13. (α*+β*)* = (α*·β*)* = (α+β)*
14. (α·β)*·α = α·(β·α)*
```

> [!warning] No confundir neutros Para la concatenación el neutro es λ (pegar λ no cambia nada). Para la unión el neutro es ∅ (unir el conjunto vacío no agrega nada). En cambio ∅ en una concatenación lo destruye todo (propiedad 5).

## 4. Ejemplos

```
(a+b)*            todas las cadenas posibles sobre {a,b}
0*                cero o más ceros (incluye λ)
1*01*             exactamente un 1, rodeado de cuantos 0 quieras
(0+1)*00(0+1)*    cadenas binarias que contienen la subcadena "00"
(b+c)*a(b+c)*     cadenas sobre {a,b,c} con exactamente una "a"
```

## 5. Ejercicios resueltos (apoyados en la teoría del módulo)

> [!example] Simplificación algebraica (TP5 nº6a) — usa propiedades 2, 3, 4
> 
> ```
> (a + λ)·a*·b
> = (a·a* + λ·a*)·b      distributiva (prop. 3)
> = (a·a* + a*)·b        λ es neutro (prop. 4)
> = (a⁺ + a*)·b          por definición a·a* = a⁺
> = a*·b                 a⁺ ya está dentro de a*, así que a⁺+a* = a*
> ```

> [!example] AF → ER por Arden (ejemplo de la teoría del módulo) A1 = ({q0,q1,q2}, {0,1}, δ, q0, {q1}). Ecuaciones características:
> 
> ```
> (1) q0 = 0·q0 + 1·q1
> (2) q1 = 0·q0 + 1·q2 + λ      (q1 es final → se le suma λ)
> (3) q2 = 0·q2 + 1·q1
> ```
> 
> Resolución:
> 
> ```
> (3) por Arden:  q2 = 0*1·q1                       (4)
> (1) por Arden:  q0 = 0*1·q1                       (5)
> Reemplazo (4) y (5) en (2):
>   q1 = 0·(0*1·q1) + 1·(0*1·q1) + λ
>   q1 = (00*1 + 10*1)·q1 + λ      saco factor común q1
> Arden sobre q1:  q1 = (00*1 + 10*1)*              (6)
> Reemplazo (6) en (5):
>   q0 = 0*1·(00*1 + 10*1)*
> ```
> 
> **ER del autómata:** `0*1(00*1 + 10*1)*`

## 6. Preguntas de oral (M6)

> [!question] Tenés que saber responder
> 
> 1. Definí expresión regular con sus reglas base y sus tres operadores.
> 2. ¿Cuál es la precedencia de los operadores y por qué importa? (clausura, concatenación, unión)
> 3. ¿Qué familia de lenguajes describen las ER? (los regulares)
> 4. Enunciá y diferenciá los teoremas de Análisis y de Síntesis de Kleene.
> 5. ¿Qué es una ecuación fundamental y qué dice el Lema de Arden? (`x = α·x + β` ⇒ `x = α*·β`)
> 6. ¿Cuándo dos ER son equivalentes? Demostrá `α⁺ + α* = α*`.
> 7. ¿Por qué `α*` siempre incluye λ? (porque `α* = λ + α·α*`)

---

# Módulo 7 — Gramáticas Regulares

## 1. Definiciones

> [!important] Definición formal — Gramática regular (Tipo 3) Tiene un solo no terminal del lado izquierdo de cada producción, y del lado derecho solo aparece: λ, un terminal seguido de un no terminal, o un no terminal seguido de un terminal.
> 
> ```
> Gramática Lineal DERECHA (GLD)     Gramática Lineal IZQUIERDA (GLI)
>   A → b B                            A → B b
>   A → b                              A → b
>   A → λ                              A → λ
>   (A,B ∈ N ; b ∈ Σ)                  (A,B ∈ N ; b ∈ Σ)
> ```

> [!note] En criollo "Lineal derecha" = el no terminal siempre queda **a la derecha** del terminal, así la cadena se va construyendo de izquierda a derecha. "Lineal izquierda" = al revés. Lo importante: en una misma gramática regular no podés mezclar los dos estilos.

**Definiciones de apoyo:**

- **Gramática** (formal): cuádrupla `G = {Σ_T, Σ_N, S, P}` con terminales, no terminales, símbolo inicial S (el **axioma**) y producciones P.
- **Producción / regla de derivación**: una regla `izquierda → derecha` que dice cómo reescribir.
- **Derivación**: aplicar producciones paso a paso desde S hasta obtener una cadena de solo terminales.
- **Lenguaje generado** `L(G)`: todas las cadenas de terminales que se pueden derivar desde S.
- **Gramáticas equivalentes**: dos gramáticas que generan el mismo lenguaje.

## 2. Teoría

> [!important] Lenguaje regular — tres caras de la misma moneda Un lenguaje es regular si se cumple **cualquiera** de las tres (y entonces se cumplen las tres):
> 
> 1. se puede describir con una expresión regular, o
> 2. se puede generar con una gramática regular, o
> 3. se puede reconocer con un autómata finito.

**Relación Autómata Finito ⇄ Gramática Regular (es directa):**

```
AF → Gramática:   N = Q ;  S = q0 ;  por cada δ(qi,a)=qj  →  producción  qi → a·qj
Gramática → AF:   Q = N ;  q0 = S ;  por cada qi → a·qj   →  transición   δ(qi,a)=qj
```

> [!note] En criollo Un estado del autómata es lo mismo que un no terminal de la gramática, y una transición es lo mismo que una producción. Por eso convertir entre AF y gramática regular es casi una "traducción literal".

**Relación ER ⇄ Gramática Regular (NO es directa):**

> [!warning] Siempre se pasa por el autómata No hay una receta directa entre ER y gramática. El camino es: `ER → AF → Gramática` y a la inversa `Gramática → AF → ER`.

> [!note] Receta — convertir GLD en GLI (método de inversión de grafo)
> 
> 1. Conseguir G'D equivalente sin reglas del tipo `A → aS`.
> 2. Armar un grafo dirigido:
>     - nodos = Σ_N ∪ { λ }
>     - `A → aB` → arco de A a B etiquetado con a
>     - `A → a` → arco de A a λ etiquetado con a
>     - `S → λ` → arco de S a λ sin etiqueta
> 3. Construir el grafo inverso:
>     - intercambiar los nodos S y λ
>     - invertir el sentido de todas las flechas
> 4. Leer las producciones nuevas desde el grafo invertido (quedan lineales izquierdas).

> [!note] Teorema (ambos sentidos) Para toda GLD existe una GLI equivalente, y para toda GLI existe una GLD equivalente. Es decir: las dos generan exactamente la misma familia (los regulares).

## 3. Propiedades

- Las gramáticas regulares generan exactamente los lenguajes regulares (ni más ni menos).
- GLD y GLI tienen el mismo poder expresivo.
- Desde una gramática regular se construye un AFD, que luego se puede **minimizar** por clases de equivalencia (partición refinada: se separan estados que se comportan distinto y se reagrupan los que no).

## 4. Ejemplos

```
GLD que genera (10)*1 :
  S → 1 | 1B
  B → 0A
  A → 1 | 1B

GLD que genera a⁺ (una o más a) :
  S → aS | a
```

## 5. Ejercicios resueltos

> [!example] GLD → ER (Modelo de Parcial, Ej.2) — usa Gramática→AF y luego AF→ER por Arden `G = ({0,1}, {S,A,B,C}, S, P)` con
> 
> ```
> P = { S→1A | 1B ,  A→0A | 0C | 1C | 1 ,  B→1A | 1C | 1 ,  C→1 }
> ```
> 
> Paso 1 — cada no terminal es un estado; una regla `→ terminal` aporta ese terminal final:
> 
> ```
> S = 1A + 1B
> A = 0A + 0C + 1C + 1
> B = 1A + 1C + 1
> C = 1
> ```
> 
> Paso 2 — reemplazo C = 1:
> 
> ```
> A = 0A + (01 + 11 + 1)
> B = 1A + 11 + 1
> ```
> 
> Paso 3 — Arden sobre A (forma `x = α·x + β`):
> 
> ```
> A = 0*(01 + 11 + 1)
> ```
> 
> Paso 4 — reemplazo en B y luego en S:
> 
> ```
> S = 1A + 1B = 1A + 1(1A + 11 + 1)
> α = (λ + 1)(1·0*(01 + 11 + 1)) + 11 + 1
> ```
> 
> (Coincide con la solución oficial: `α = (λ+1)(10*(01+11+1)) + 11 + 1`.)

> [!example] Lenguaje → ER + AF (Modelo Ej.3) L = { w | w tiene un número múltiplo de 3 de a's } sobre Σ={a,b}. Las b's son libres; hay que contar a's de a tres.
> 
> ```
> ER:  (b* a b* a b* a b*)*       (o equivalente  b*(a b* a b* a b*)* )
> ```
> 
> AF que cuenta a's módulo 3 (q0 inicial y final):
> 
> ```
>          a      b
> →*q0     q1     q0
>   q1     q2     q1
>   q2     q0     q2
> ```
> 
> Cada a avanza el contador; cada b no lo cambia; se acepta en q0 (cero a's módulo 3).

## 6. Preguntas de oral (M7)

> [!question] Tenés que saber responder
> 
> 1. Definí gramática regular y distinguí lineal derecha de lineal izquierda con ejemplos.
> 2. Enunciá las tres caracterizaciones equivalentes de lenguaje regular.
> 3. ¿Cómo paso de AF a gramática regular y al revés? (N=Q, S=q0, δ↔producción)
> 4. ¿Por qué para ir de ER a gramática hay que pasar por el autómata?
> 5. Explicá el método de inversión de grafo para pasar de GLD a GLI.
> 6. ¿GLD y GLI tienen el mismo poder? Justificá.

---

# Módulo 8 — Autómatas de Pila

## 1. Definiciones

> [!important] Definición formal — Gramática Libre de Contexto (GLC) Cada producción es de la forma `A → v`, donde A es un no terminal y v una cadena de terminales y/o no terminales (`v ∈ (T ∪ N)*`). Un lenguaje es libre de contexto si existe una GLC que lo genera.

> [!note] En criollo "Libre de contexto" = a la izquierda hay **un solo** no terminal, así que A se puede reemplazar por v sin importar qué tiene alrededor. Esto permite estructuras anidadas (paréntesis, aⁿbⁿ) que un lenguaje regular no puede.

Ejemplo clásico (lenguaje **no regular**):

```
S → aSb | λ      genera  { aⁿbⁿ | n ≥ 0 }
```

> [!important] Definición formal — Autómata de Pila (AP) Séptupla `M = (Σ, Q, Γ, z0, q0, δ, F)`:
> 
> ```
> Σ    alfabeto de entrada
> Q    conjunto finito de estados
> Γ    alfabeto de la pila (los símbolos que puedo apilar)
> z0   símbolo inicial de la pila   (z0 ∈ Γ)
> q0   estado inicial               (q0 ∈ Q)
> δ    función de transición
> F    conjunto de estados finales
> ```

**Definiciones de apoyo:**

- **Pila**: estructura de memoria LIFO (Last In, First Out): el último símbolo que apilo es el primero que saco.
- **Tope de la pila**: el símbolo de más arriba, el único que puedo "ver" y manipular.
- **z0**: marca el fondo de la pila; sirve para saber cuándo quedó vacía.
- **Apilar (push)**: agregar un símbolo al tope. **Desapilar (pop)**: sacar el tope.

## 2. Teoría — cómo leer las transiciones

> [!note] Formato de una transición: símbolo_entrada , tope_pila ; lo_que_dejo_en_la_pila
> 
> ```
> a, Z ; AZ     leo a; la pila tenía Z (fondo); apilo A, queda AZ
> a, A ; AA     leo a; el tope es A; apilo otra A
> a, b ; λ      desapilo el tope (lo reemplazo por λ = lo borro)
> λ, ... ; ...  (λ a la izquierda de la coma) significa "fin de la entrada"
> ```

> [!important] Formas de aceptación Un AP puede aceptar una cadena de **dos** maneras: **por pila vacía** o **por estado final**. (En los TP suele pedirse "por estado final y pila vacía".)

> [!note] Estrategia general de diseño (en criollo) Usá la pila como cuaderno de anotaciones. En la primera mitad de la cadena **apilás** un testigo por cada símbolo. En la segunda mitad **desapilás** uno por cada símbolo que cierra. Si al terminar la entrada la pila quedó vacía (solo z0), aceptás. Así "contás" sin tener un contador.

## 3. Propiedades

- Los AP reconocen exactamente los lenguajes libres de contexto (Tipo 2).
- Son estrictamente más potentes que los AF: reconocen aⁿbⁿ, palíndromos, paréntesis balanceados, que NO son regulares.
- La diferencia clave con un AF es la **memoria**: un AF solo recuerda el estado; el AP además tiene la pila, que le permite comparar cantidades.

## 4. Ejemplo (AP para aⁿbⁿ, del apunte del módulo)

Por cada `a` apilo una `A`; por cada `b` desapilo una `A`; acepto si la pila vuelve a z0.

```
δ:
(q0)  a,Z;AZ → q0     apila la 1ª A (la pila estaba vacía)
(q0)  a,A;AA → q0     sigue apilando A's
(q0)  b,A;λ  → q1     1ª b: empieza a desapilar
(q1)  b,A;λ  → q1     sigue desapilando
(q1)  λ,Z;Z  → q2     terminó la entrada y solo queda z0: ACEPTA
```

## 5. Ejercicios resueltos

> [!example] AP para { aⁱb²ⁱ | i ≥ 0 } (TP7 nº1a) — ratio 1:2 Por cada `a` apilo **dos** A (AA); por cada `b` desapilo **una** A. Así i a's dejan 2i A's, borradas por 2i b's.
> 
> ```
> M = ({q0,q1,q2}, {a,b}, {z,A}, δ, q0, {q2})
> (q0) a,Z;AAZ → q0      por cada a apilo AA
> (q0) a,A;AAA → q0
> (q0) b,A;λ   → q1      1ª b: empiezo a desapilar
> (q1) b,A;λ   → q1
> (q1) λ,Z;Z   → q2      ACEPTA
> ```

> [!example] AP para { aⁿbᵐcᵐdⁿ | n>0, m>0 } (Modelo Ej.4) — anidamiento doble Las d cierran las a (más externo) y las c cierran las b (más interno).
> 
> ```
> (q0) a,Z;AZ  → q0      apila A's
> (q0) a,A;AA  → q0
> (q0) b,A;BA  → q1      empiezan las b: apila B sobre A
> (q1) b,B;BB  → q1
> (q1) c,B;λ   → q2      las c desapilan B
> (q2) c,B;λ   → q2
> (q2) d,A;λ   → q3      las d desapilan A
> (q3) d,A;λ   → q3
> (q3) λ,Z;Z   → q4      ACEPTA (estructura bien anidada)
> ```

## 6. Preguntas de oral (M8)

> [!question] Tenés que saber responder
> 
> 1. Definí gramática libre de contexto. ¿Por qué se llama "libre de contexto"?
> 2. Dá la séptupla de un AP y explicá cada componente.
> 3. ¿Qué significa `a, A ; AA`? ¿Y `a, b ; λ`?
> 4. ¿Cuáles son las dos formas de aceptación de un AP?
> 5. ¿Por qué aⁿbⁿ no es regular pero sí libre de contexto? (el AF no tiene memoria para contar; la pila sí)
> 6. ¿Qué clase de lenguajes reconoce un AP y cómo se relaciona con los AF?

---

# Módulo 9 — Máquinas de Turing

## 1. Definiciones

> [!note] Idea (informal) Descrita por Alan Turing en 1936. Es una cinta infinita dividida en celdas, con un cabezal de lectura/escritura que se mueve sobre ella, controlado por un autómata (la unidad de control). Puede simular la lógica de **cualquier** algoritmo de una computadora.

> [!important] Definición formal — Máquina de Turing (MT) 7-upla `MT = (E, Σ, C, δ, e0, B, F)`:
> 
> ```
> E    conjunto finito de estados
> Σ    alfabeto de entrada    (Σ ⊆ C)
> C    alfabeto de la cinta:  C = Σ ∪ {B} ∪ símbolos auxiliares
> e0   estado inicial
> B    símbolo blanco         (B ∉ Σ, B ∈ C)
> δ    E × C → E × C × {D, I, N}   (Derecha, Izquierda, No mover)
> F    conjunto de estados finales   (F ⊆ E)
> ```

> [!note] En criollo de la función δ En cada paso, la MT mira (estado actual, símbolo bajo el cabezal) y decide tres cosas: a qué estado pasa, qué símbolo escribe en esa celda (puede pisar lo que había), y hacia dónde mueve el cabezal (izquierda, derecha o se queda). Si para esa combinación no hay regla definida, la máquina **se detiene**.

**Definiciones de apoyo:**

- **Cinta**: memoria infinita en ambas direcciones; cada celda guarda un símbolo de C.
- **Símbolo blanco B**: lo que hay en las celdas vacías; no es parte del alfabeto de entrada.
- **Símbolos auxiliares**: marcas que la propia MT escribe para "recordar" (por ejemplo X, Y para tachar).
- **Configuración**: foto completa del cómputo en un instante (contenido de la cinta + estado + posición del cabezal).

## 2. Teoría

> [!important] Representación La función de transición se da como una **tabla de transición** o un **diagrama de estados**. En el diagrama, cada arco lleva tres datos: símbolo leído ; símbolo que reescribe , dirección del movimiento.

## 3. Propiedades — tipos de Máquina de Turing

> [!important] Dos tipos
> 
> - **Transductor**: modifica el contenido de la cinta (calcula una función, produce una salida).
> - **Reconocedor (o aceptor)**: decide si una cadena pertenece o no a un lenguaje (responde sí/no).

**Diferencias clave con AF y AP (las tres que se preguntan):**

1. El cabezal puede **retroceder** (moverse a izquierda y derecha); en un AF/AP solo avanza.
2. La MT puede **escribir** sobre la cinta; un AF/AP solo lee.
3. Por eso la MT es el modelo más general: puede simular cualquier algoritmo.

## 4. Ejemplo (transductor: invertir bits, de los ejemplos del módulo)

MT que cambia 0 por 1 y 1 por 0 (complemento a 1):

```
(q0) 0;1,R → q0     recorre la cinta invirtiendo cada bit, moviéndose a la derecha
(q0) 1;0,R → q0
(q0) B;B,L → q1     llega al blanco final: cambia de fase y empieza a volver
(q1) 0;0,L → q1     regresa al inicio sin tocar nada
(q1) 1;1,L → q1
(q1) B;B,R → q2     llega al blanco inicial: se posiciona y ACEPTA
```

## 5. Ejercicios resueltos

> [!example] Reconocedor de { aⁿbⁿ | n>0 } (TP8 nº3) — técnica de "tachar de a pares" Marca cada a con X y su b correspondiente con Y, hasta agotar ambas.
> 
> ```
> (q0) a;X,R → q1     marca una a con X y avanza
> (q1) a;a,R → q1     salta las a's restantes
> (q1) Y;Y,R → q1     salta las Y's ya marcadas
> (q1) b;Y,L → q2     marca la b correspondiente con Y y vuelve
> (q2) a;a,L → q2     regresa hacia el inicio
> (q2) Y;Y,L → q2
> (q2) X;X,R → q0     llegó a la X: reinicia el ciclo con la próxima a
> (q0) Y;Y,R → q3     ya no quedan a's: a verificar
> (q3) Y;Y,R → q3
> (q3) B;B,N → q4     solo había Y's hasta el blanco: ACEPTA
> ```

> [!example] Transductor: predecesor en unario (TP8 nº2) En unario el número n se escribe con n marcas; el predecesor n−1 = borrar una marca.
> 
> ```
> 1. Avanzar a la derecha hasta el blanco final.
> 2. Retroceder una posición (la última marca) y reemplazarla por B.
> 3. Detenerse.   (Si la entrada estaba vacía, queda igual.)
> ```

## 6. Preguntas de oral (M9)

> [!question] Tenés que saber responder
> 
> 1. ¿Qué es una Máquina de Turing y de qué partes consta?
> 2. Dá la 7-upla de una MT y explicá `C = Σ ∪ {B} ∪ auxiliares`.
> 3. ¿Qué devuelve δ? (estado nuevo, símbolo a escribir, dirección D/I/N)
> 4. ¿Cuándo se detiene una MT? (cuando no hay transición definida)
> 5. Diferenciá transductor de reconocedor.
> 6. ¿En qué se diferencia una MT de un AF y de un AP? (retrocede el cabezal y escribe)
> 7. ¿Por qué es el modelo más potente?

---









# Apéndice — Repaso del Primer Parcial (M1–M5) con ejemplos por tipo

> [!note] Por si cae teoría base en el oral Todo lo de M6–M9 se apoya en estos conceptos. La estrella de este apéndice es la **jerarquía de Chomsky con un ejemplo de gramática por tipo**.

## M1 — Alfabetos, cadenas y lenguajes

```
Alfabeto (Σ): conjunto finito de símbolos.
Cadena: secuencia finita de símbolos.   λ = cadena vacía (longitud 0).
|w| = longitud de la cadena w.
Σ* = clausura de Kleene = todas las cadenas posibles (incluye λ).
Σ⁺ = clausura positiva = Σ* sin λ.
Lenguaje: cualquier subconjunto de Σ*.
```

## M2 — Gramáticas y la jerarquía de Chomsky

> [!important] Definición formal — Gramática Cuádrupla `G = {Σ_T, Σ_N, S, P}`: terminales, no terminales, símbolo inicial S (axioma) y producciones P sobre `Σ = Σ_T ∪ Σ_N`.

**Definiciones de apoyo (cómo "funciona" una gramática):**

- **Derivación directa** (`⇒`): un solo paso, aplicar una producción una vez. Ej.: con `S → aSb`, `aSb ⇒ aaSbb`.
- **Derivación** (`⇒*`): cero o más pasos encadenados, desde S hasta una cadena.
- **Forma sentencial**: cualquier cadena (con terminales y/o no terminales) que se obtiene en el camino desde S. Si es solo de terminales, es una **sentencia** (pertenece al lenguaje).
- **Lenguaje generado** `L(G)`: el conjunto de todas las sentencias derivables desde S.
- **Gramática ambigua**: la que permite derivar una misma cadena con dos árboles de derivación distintos.
- **Recursividad**: una producción es recursiva si el no terminal reaparece a la derecha (ej. `S → aSb`); es lo que permite generar lenguajes infinitos.

Chomsky clasificó las gramáticas en 4 tipos según la forma de sus producciones. Cada tipo es más restrictivo (y menos potente) que el anterior.

|Tipo|Nombre|Forma de las producciones|Reconocedor|
|---|---|---|---|
|0|Sin restricciones (recursivamente enumerables)|`u → v`, con u,v ∈ (T∪N)* y u con al menos un no terminal|Máquina de Turing|
|1|Sensible al contexto|`xAy → xvy` (no se acorta: \|izq\| ≤ \|der\|)|Autómata lineal acotado|
|2|Libre de contexto|`A → v` (un solo no terminal a la izquierda)|Autómata de Pila|
|3|Regular|`A → aB`, `A → a`, `S → λ` (o su versión izquierda)|Autómata Finito|

> [!important] Contención de los tipos Tipo 3 ⊂ Tipo 2 ⊂ Tipo 1 ⊂ Tipo 0. Toda gramática regular es libre de contexto, toda libre de contexto es sensible al contexto, etc.

### Ejemplo de gramática por cada tipo

> [!example] Tipo 3 — Regular Ejemplo A — genera a⁺b (una o más a seguidas de una b), lineal derecha:
> 
> ```
> S → aS | aB
> B → b
> ```
> 
> Ejemplo B — genera (ab)* (cero o más "ab"), lineal derecha:
> 
> ```
> S → aA | λ
> A → bS
> ```
> 
> Ejemplo C — lineal IZQUIERDA (no terminal a la izquierda del terminal), genera b·a⁺:
> 
> ```
> S → Aa
> A → Aa | b
> ```
> 
> Forma típica: "un terminal + un no terminal" (derecha) o "un no terminal + un terminal" (izquierda), o un terminal solo. La reconoce un autómata finito.

> [!example] Tipo 2 — Libre de contexto Ejemplo A — genera aⁿbⁿ (n ≥ 0):
> 
> ```
> S → aSb | λ
> ```
> 
> Ejemplo B — genera los palíndromos sobre {a,b}:
> 
> ```
> S → aSa | bSb | a | b | λ
> ```
> 
> Ejemplo C — genera paréntesis balanceados:
> 
> ```
> S → (S) | SS | λ
> ```
> 
> En todos hay un solo no terminal a la izquierda. Son no regulares (hay que recordar la primera mitad para cerrar la segunda): los reconoce un autómata de pila.

> [!example] Tipo 1 — Sensible al contexto Ejemplo A — genera aⁿbⁿcⁿ (n ≥ 1):
> 
> ```
> S  → aSBC | aBC
> CB → BC
> aB → ab
> bB → bb
> bC → bc
> cC → cc
> ```
> 
> Ejemplo B — ilustra la forma con contexto `x A y → x v y` (A solo se reescribe si tiene "a" antes y "b" después):
> 
> ```
> aAb → aSb        ← A se vuelve S, pero únicamente en el contexto a_b
> ```
> 
> Lo importante de Tipo 1: ninguna regla acorta la cadena (|izq| ≤ |der|), y puede haber contexto `x A y → x v y`. aⁿbⁿcⁿ NO es libre de contexto: necesita este nivel. Lo reconoce un autómata lineal acotado.

> [!example] Tipo 0 — Sin restricciones (forma más general) Ejemplo A — muestra la regla que borra (lo que lo hace Tipo 0):
> 
> ```
> S  → ABC
> AB → λ        ← lado izquierdo más largo que el derecho: ACORTA (prohibido en Tipo 1)
> C  → c
> ```
> 
> Ejemplo B — regla con varios símbolos a la izquierda que se reescriben libremente:
> 
> ```
> S   → aTb
> aTb → λ       ← reemplaza tres símbolos por λ
> ```
> 
> En Tipo 0 el lado izquierdo puede ser cualquier cadena (con al menos un no terminal) y puede **acortar o borrar**. Lo reconoce una Máquina de Turing. (Ejemplos ilustrativos de la forma; lo que importa es la regla que acorta.)

> [!note] En criollo Mirá solo la **forma** de las reglas para clasificar: ¿la izquierda tiene un solo no terminal y nada más? → Tipo 2 o 3. ¿Hay contexto alrededor pero nunca acorta? → Tipo 1. ¿Acorta o borra con varios símbolos a la izquierda? → Tipo 0. El **lenguaje** y la **gramática** son cosas distintas: un mismo lenguaje puede tener gramáticas de varios tipos; se clasifica por la gramática más simple posible.

## M3 — Autómatas Finitos Deterministas (AFD)

```
AFD = (Q, Σ, δ, q0, F)   con  δ: Q × Σ → Q   (función total y determinista)
```

> [!warning] Regla de oro del AFD Desde cada estado, para cada símbolo, hay **a lo sumo una** transición (en el AFD completo, exactamente una). Nunca dos flechas con el mismo símbolo saliendo del mismo estado.

## M4 — Autómatas Finitos No Deterministas (AFND / AFND-λ)

```
AFND:    δ: Q × Σ → P(Q)     (devuelve un conjunto de estados posibles)
AFND-λ:  además permite transiciones con λ (sin consumir entrada)
```

- **Construcción de subconjuntos (conjunto potencia)**: convierte un AFND en un AFD equivalente; cada estado del AFD es un subconjunto de estados del AFND.
- AFD, AFND y AFND-λ tienen el **mismo poder**: todos reconocen exactamente los lenguajes regulares. El no determinismo facilita el diseño pero no agrega potencia.

## M5 — Introducción a las Expresiones Regulares

Antesala de M6: la definición de ER y el paso lenguaje → ER. Toda la potencia algebraica y la equivalencia con autómatas se profundiza en M6.

---

> [!important] Checklist final antes del oral
> 
> - Sé moverme entre las 4 representaciones de un regular: ER ⇄ AF ⇄ gramática (siempre por el autómata).
> - Sé aplicar el Lema de Arden a un sistema de ecuaciones.
> - Sé clasificar una gramática por la forma de sus reglas y dar un ejemplo de cada tipo.
> - Sé diseñar un AP por matching con la pila y nombrar las dos formas de aceptación.
> - Sé diseñar una MT (transductor y reconocedor) y dar las tres diferencias con AF/AP.
> - Conozco la jerarquía de Chomsky y qué modelo reconoce cada tipo.