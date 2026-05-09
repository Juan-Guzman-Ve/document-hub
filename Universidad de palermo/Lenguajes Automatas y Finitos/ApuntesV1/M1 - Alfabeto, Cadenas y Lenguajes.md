# Modulo 1 - Alfabeto, Cadenas y Lenguajes

> [!note] Contexto
> Este modulo establece las definiciones fundamentales sobre las que se construye toda la teoria de Lenguajes Formales y Automatas Finitos. Dominar estas definiciones es indispensable para los modulos siguientes.

---

## Alfabeto

Un **alfabeto** es cualquier conjunto finito y no vacio cuyos elementos se llaman **simbolos**.

```
Sigma = {0, 1, 2, ..., 9}
Sigma = {a, b}
Sigma = {ab, c}   <- los elementos pueden ser cadenas, no solo letras
```

> [!important] Distincion clave
> El alfabeto es un **conjunto de simbolos atomicos**. Si `Sigma = {ab, c}`, entonces `ab` es un unico simbolo, no dos simbolos separados. Esto tiene impacto directo al verificar si una palabra pertenece a `Sigma*`.

---

## Cadenas

Una **cadena** sobre `Sigma` es cualquier secuencia finita de elementos de `Sigma`.

### Cadena vacia

La cadena que no tiene ningun simbolo se denota con `lambda` (λ).

### Longitud de una cadena

Sea `x ∈ Sigma*`, su longitud se denota `|x|` y es el numero de simbolos que contiene.

```
|aba|  = 3
|baaa| = 4
|λ|    = 0
```

### Concatenacion de cadenas

Dadas `u, v ∈ Sigma*`, la concatenacion `u · v` se define:

```
Si v = λ  =>  u · λ = λ · u = u
Si u = a1 a2 ... an  y  v = b1 b2 ... bm
  =>  u · v = a1 a2 ... an b1 b2 ... bm
```

### Potencia de una cadena

Dada `u ∈ Sigma*` y `n ∈ N`:

```
u^0 = λ
u^n = u · u · ... · u   (n veces)
```

Ejemplo:
```
(aab)^1 = aab
(aab)^5 = aabaabaabaabaab
```

### Reflexion o Inversa de una cadena

La inversa de `u ∈ Sigma*` se denota `u^R`:

```
Si u = λ          =>  u^R = λ
Si u = a1 a2 ... an  =>  u^R = an ... a2 a1
```

Ejemplo:
```
u = abc  =>  u^R = cba
```

---

## Conjuntos derivados del alfabeto

Sea `Sigma` un alfabeto:

| Notacion | Descripcion |
|---|---|
| `Sigma*` | Conjunto de **todas** las cadenas sobre `Sigma`, incluyendo `λ` |
| `Sigma+` | Conjunto de todas las cadenas **no vacias** sobre `Sigma` |
| `Sigma^0` | `{λ}` (solo la cadena vacia) |
| `Sigma^n` | Conjunto de todas las cadenas de longitud exactamente `n` |

```
Sigma = {a, b}
Sigma^0 = {λ}
Sigma^1 = {a, b}
Sigma^2 = {aa, ab, ba, bb}
Sigma* = {λ, a, b, aa, ab, ba, bb, aaa, ...}
```

> [!important] Distincion entre Sigma* y Sigma+
> `Sigma* = Sigma+ ∪ {λ}`
> `λ ∈ Sigma*`  pero  `λ ∉ Sigma+`

**Cantidad de palabras de longitud k** sobre un alfabeto de `p` simbolos: `p^k`

---

## Lenguajes

Un **lenguaje** `L` sobre un alfabeto `Sigma` es un subconjunto de `Sigma*`:

```
L ⊆ Sigma*
```

| Caso especial | Descripcion |
|---|---|
| `L = ∅` | Lenguaje vacio (no contiene ninguna cadena) |
| `L = {λ}` | Lenguaje que contiene solo la cadena vacia |

> [!warning] No confundir
> `∅ ≠ {λ}`. El lenguaje vacio no tiene elementos; `{λ}` tiene exactamente un elemento (la cadena vacia).

Todo lenguaje satisface: `∅ ⊆ L ⊆ Sigma*`. Puede ser finito o infinito.

---

## Operaciones entre Lenguajes

Sean `A, B ⊆ Sigma*`:

### Union

```
A ∪ B = {x | x ∈ A  o  x ∈ B}
```

Ejemplo: `{a, ab} ∪ {ab, aab} = {a, ab, aab}`

### Interseccion

```
A ∩ B = {x | x ∈ A  y  x ∈ B}
```

Ejemplo: `{a, ab} ∩ {ab, aab} = {ab}`

### Complemento

```
~A = {x ∈ Sigma* | x ∉ A} = Sigma* - A
```

### Diferencia

```
A - B = {x | x ∈ A  y  x ∉ B}
```

### Concatenacion de lenguajes

```
A · B = {uv : u ∈ A  y  v ∈ B}
```

Ejemplo:
```
Sigma = {a, b, c},  A = {a, ab, ac},  B = {b, b^2}
A · B = {ab, ab^2, abb, ab^3, acb, acb^2}
```

> [!warning] La concatenacion NO es conmutativa
> En general `A · B ≠ B · A`

### Potencia de un lenguaje

```
A^0 = {λ}
A^n = A · A · ... · A   (n veces)
```

### Clausura de Kleene

```
A* = ⋃(i≥0) A^i = A^0 ∪ A^1 ∪ A^2 ∪ ... ∪ A^n ∪ ...
   = {u1 u2 ... un : ui ∈ A,  n ≥ 0}
```

Incluye `λ` (porque `A^0 = {λ}`).

### Clausura Positiva

```
A+ = ⋃(i≥1) A^i = A^1 ∪ A^2 ∪ ... ∪ A^n ∪ ...
   = {u1 u2 ... un : ui ∈ A,  n ≥ 1}
```

No incluye `λ` salvo que `λ ∈ A`.

```
A* = A+ ∪ {λ}
A* = A+  si y solo si  λ ∈ A
```

### Propiedades de * y +

Sea `A ⊆ Sigma*`:

```
1.  A+ = A* · A = A · A*
2.  A* · A* = A*
3.  (A*)^n = A*        para todo n ≥ 1
4.  (A*)* = A*
5.  A+ · A+ ⊆ A+
6.  (A*)+ = A*
7.  (A+)* = A*
8.  (A+)+ = A+
```

### Reflexion o Inverso de un Lenguaje

```
A^(-1) = {u^(-1) : u ∈ A}
```

Ejemplo:
```
Sigma = {a, b},  L = {ab, abb, abc, cca}
L^(-1) = {ba, bba, cba, acc}
```

---

## Tabla de referencia rapida

| Concepto | Notacion | Descripcion breve |
|---|---|---|
| Alfabeto | `Sigma` | Conjunto finito no vacio de simbolos |
| Cadena vacia | `λ` | Cadena sin simbolos, longitud 0 |
| Todas las cadenas | `Sigma*` | Incluye `λ` |
| Cadenas no vacias | `Sigma+` | Excluye `λ` |
| Cadenas de longitud n | `Sigma^n` | Exactamente n simbolos |
| Lenguaje | `L ⊆ Sigma*` | Subconjunto de cadenas sobre `Sigma` |
| Clausura de Kleene | `A*` | Cero o mas concatenaciones de `A` |
| Clausura positiva | `A+` | Una o mas concatenaciones de `A` |
| Inverso de lenguaje | `A^(-1)` | Cada cadena de `A` invertida |

---

## Receta mental para ejercicios

> [!note] Verificar si una palabra pertenece a un lenguaje
> 1. Identificar el alfabeto `Sigma` (ojo si los simbolos son cadenas).
> 2. Descomponer la palabra en simbolos del alfabeto (si es posible, la palabra pertenece a `Sigma*`).
> 3. Verificar si la descomposicion satisface la condicion del lenguaje.

> [!note] Clausura positiva L+
> Una palabra `w` pertenece a `L+` si puede escribirse como concatenacion de una o mas palabras de `L`. Buscar todas las formas posibles de partir `w` en segmentos que esten en `L`.

