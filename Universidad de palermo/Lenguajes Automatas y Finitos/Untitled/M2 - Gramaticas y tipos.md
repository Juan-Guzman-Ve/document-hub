# Modulo 2 - Gramaticas y Tipos

> [!note] Contexto
> Este modulo introduce las gramaticas formales como mecanismo para generar lenguajes, y la jerarquia de Chomsky que las clasifica en cuatro tipos segun la forma de sus reglas de produccion.

---

## Gramatica Formal

Una **gramatica** es una cuadrupla:

```
G = (Sigma_T, Sigma_N, S, P)
```

| Componente | Descripcion |
|---|---|
| `Sigma_T` | Alfabeto de **simbolos terminales** (los que aparecen en las cadenas del lenguaje) |
| `Sigma_N` | Alfabeto de **simbolos no terminales** (variables auxiliares usadas en las derivaciones) |
| `S` | **Simbolo inicial** (no terminal desde el que arrancan todas las derivaciones) |
| `P` | Conjunto de **producciones** (reglas de derivacion) sobre `Sigma = Sigma_T ∪ Sigma_N` |

> [!important] Rol de las producciones
> Las producciones son las reglas que se aplican desde el simbolo inicial para obtener las cadenas del lenguaje. Cada aplicacion de una produccion es un **paso de derivacion**.

### Lenguaje generado por una gramatica

El lenguaje `L(G)` es el conjunto de todas las cadenas de simbolos **terminales** que pueden derivarse desde `S` aplicando las producciones de `P`.

### Gramaticas equivalentes

Dos gramaticas `G1` y `G2` son **equivalentes** si generan el mismo lenguaje:

```
L(G1) = L(G2)
```

### Ejemplo

```
G = ({a, b}, {S}, S, P)
P:
  S -> ab
  S -> aSb
```

Genera: `L(G) = {a^n b^n / n >= 1}`

---

## Derivacion

Una **derivacion** es la secuencia de pasos de reemplazo desde `S` hasta una cadena de terminales, aplicando producciones de `P`.

### Notacion

```
S =>* w    (S deriva w en cero o mas pasos)
S =>+ w    (S deriva w en uno o mas pasos)
```

### Ejemplo de derivacion paso a paso

```
G = ({a,b,c,d}, {S,A,B}, S, P)
P: S -> ASB | d,  A -> b | aaA,  B -> dcd,  aa -> aA

Derivacion de "abddcd":
S => ASB => bSB => bdB => bddcd
```

---

## Jerarquia de Chomsky

Chomsky clasifico las gramaticas en 4 tipos segun la forma de sus producciones. Cada tipo es un **subconjunto** del anterior: Tipo 3 ⊂ Tipo 2 ⊂ Tipo 1 ⊂ Tipo 0.

### Resumen comparativo

| Tipo   | Nombre                        | Forma de produccion  | Restriccion sobre longitudes | Automata equivalente |      |                  |     |                         |
| ------ | ----------------------------- | -------------------- | ---------------------------- | -------------------- | ---- | ---------------- | --- | ----------------------- |
| Tipo 0 | Recursiva (sin restricciones) | `u -> v`             | Sin restricciones            | Maquina de Turing    |      |                  |     |                         |
| Tipo 1 | Sensible al contexto          | `xAy -> xvy`         | `                            | mu                   | <=   | phi              | `   | Automata lineal acotado |
| Tipo 2 | Libre de contexto             | `A -> v`             | `                            | mu                   | = 1` | Automata de pila |     |                         |
| Tipo 3 | Regular                       | `A -> a` / `A -> aB` | (ver abajo)                  | Automata finito      |      |                  |     |                         |

---

## Tipo 0 - Gramatica Sin Restricciones

```
u -> v
donde u, v ∈ (Sigma_T ∪ Sigma_N)*
```

No hay ninguna restriccion sobre la forma de las producciones. Cualquier gramatica es de tipo 0.

---

## Tipo 1 - Gramatica Sensible al Contexto

```
xAy -> xvy
donde:
  A ∈ Sigma_N
  x, y ∈ (Sigma_T ∪ Sigma_N)*
  v ∈ (Sigma_T ∪ Sigma_N)+
```

El no terminal `A` solo puede reemplazarse por `v` cuando esta rodeado por el contexto `x` (izquierda) e `y` (derecha). La parte derecha nunca puede ser mas corta que la izquierda: `|mu| <= |phi|`.

> [!important] Restriccion de longitud
> La produccion no puede hacer que la cadena se acorte. La unica excepcion permitida es `S -> λ` si `S` no aparece en el lado derecho de ninguna produccion.

---

## Tipo 2 - Gramatica Libre de Contexto

```
A -> v
donde:
  A ∈ Sigma_N
  v ∈ (Sigma_T ∪ Sigma_N)*
```

El lado izquierdo es siempre un **unico no terminal** (`|mu| = 1`). No hay contexto: `A` puede reemplazarse por `v` en cualquier posicion.

> [!note] Produccion lambda
> `v` puede ser `λ` (produccion nula), lo que permite que `A` desaparezca.

---

## Tipo 3 - Gramatica Regular

Las gramaticas de tipo 3 se dividen en dos variantes. **No se pueden mezclar** ambas variantes dentro de una misma gramatica.

### Lineal por la derecha

```
A -> a
A -> aV
S -> λ
donde a ∈ Sigma_T,  A, V, S ∈ Sigma_N
```

El no terminal (si lo hay) va siempre a la **derecha** del terminal.

### Lineal por la izquierda

```
A -> a
A -> Va
S -> λ
donde a ∈ Sigma_T,  A, V, S ∈ Sigma_N
```

El no terminal (si lo hay) va siempre a la **izquierda** del terminal.

> [!warning] No mezclar variantes
> Una gramatica que tenga producciones lineales por la derecha Y por la izquierda simultaneamente **no es de tipo 3**, aunque todas sus producciones individualmente tengan la forma correcta. Esto la deja en tipo 2.

---

## Procedimiento para clasificar una gramatica

> [!note] Receta mental - Clasificar una gramatica
> Revisar las producciones de la mas restrictiva a la menos restrictiva:
>
> 1. Verificar si todas las producciones son de la forma `A -> a` o `A -> aB` (o variante izquierda). Si ademas no mezclan variantes => **Tipo 3**.
> 2. Si no es tipo 3, verificar si todos los lados izquierdos son un unico no terminal `A`. Si es asi => **Tipo 2**.
> 3. Si no es tipo 2, verificar si todas las producciones cumplen `xAy -> xvy` con `|izq| <= |der|`. Si es asi => **Tipo 1**.
> 4. Si no cumple ninguna de las anteriores => **Tipo 0**.

---

## Procedimiento para construir una gramatica desde un lenguaje

> [!note] Receta mental - Construir una gramatica tipo 3 (lineal por la derecha)
> 1. Identificar el patron del lenguaje (prefijos fijos, sufijos, repeticiones).
> 2. Usar el simbolo inicial `S` para generar el primer simbolo o bloque.
> 3. Introducir no terminales adicionales para "recordar" en que parte de la cadena se esta.
> 4. Terminar con una produccion `A -> a` (sin no terminal) cuando se llega al final.
> 5. Agregar `S -> λ` solo si la cadena vacia pertenece al lenguaje.

> [!note] Receta mental - Construir una gramatica tipo 2
> 6. Identificar si el lenguaje tiene estructura anidada o balanceada (e.g., `a^n b^n`).
> 7. Usar producciones recursivas del tipo `S -> aSb` para generar la simetria.
> 8. Terminar la recursion con el caso base.

---

## Tabla de referencia rapida

| Tipo | Produccion caracteristica | Ejemplo de lenguaje | Notas clave |
|---|---|---|---|
| Tipo 0 | `u -> v` (libre) | `{a^n b^m / n != m}` | Sin restriccion alguna |
| Tipo 1 | `xAy -> xvy` | `{a^n b^n c^n / n >= 1}` | No puede acortar la cadena |
| Tipo 2 | `A -> v` | `{a^n b^n / n >= 0}` | Izq siempre un unico no terminal |
| Tipo 3 | `A -> a` o `A -> aB` | `{a^n / n >= 1}` | No mezclar lineal izq con lineal der |

---

## Ver tambien

- [[M1 - Alfabeto, Cadenas y Lenguajes]]