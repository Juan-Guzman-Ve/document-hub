
---

## 🏗️ ¿Qué es una Gramática?

**Formal:** Una gramática es una cuádrupla G = (Σ_T, Σ_N, S, P)

**En criollo:** Es un *sistema de reglas* para construir cadenas válidas de un lenguaje. Como una receta: partís de un símbolo inicial y aplicás reglas hasta quedarte solo con símbolos terminales.

Los 4 ingredientes:

| Componente | Qué es | Ejemplo |
|---|---|---|
| **Σ_T** | Terminales — las letras "reales" del resultado final | {a, b} |
| **Σ_N** | No terminales — variables intermedias, "moldes" | {S, A, B} |
| **S** | Símbolo inicial — de donde arranca todo | S |
| **P** | Producciones — las reglas de reemplazo | S → aSb |

> **Clave:** Los no terminales (mayúsculas) son provisorios. Al final de una derivación, tienen que desaparecer todos y quedar solo terminales (minúsculas).

---

## ➡️ Cómo funciona una derivación

Partís de S y aplicás reglas hasta no tener más no terminales.

**Ejemplo** con G donde P = {S → aSb, S → ab}:

```
S → aSb → aaSbb → aaabbb
```

Cada flecha es "aplico una regla". El lenguaje que genera es {aⁿbⁿ / n ≥ 1}.

---

## 🏷️ Los 4 Tipos de Gramáticas (Chomsky)

Pensalo como niveles de restricción, del más libre al más estricto:

```
Tipo 0 ⊃ Tipo 1 ⊃ Tipo 2 ⊃ Tipo 3
```

### Tipo 0 — Sin restricciones
Cualquier regla vale: u → v, donde u y v son cualquier cadena.
> Es la más poderosa pero la más difícil de manejar. Equivale a una Máquina de Turing.

---

### Tipo 1 — Sensible al contexto
Las reglas tienen la forma: **xAy → xvy**

**En criollo:** Podés reemplazar A, pero *solo si está rodeado por x e y*. El contexto importa. Y la regla nunca puede *acortar* la cadena (|derecha| ≥ |izquierda|).

> Ejemplo: `aAb → avb` → reemplazás A pero solo cuando tiene 'a' a la izquierda y 'b' a la derecha.

---

### Tipo 2 — Libre de contexto ⭐ (la más usada en ejercicios)
Las reglas tienen la forma: **A → v**

**En criollo:** Un solo no terminal en la izquierda, lo que quieras en la derecha. No importa el contexto.

> Ejemplo: `S → aSb | ab` — siempre que veas S, lo podés reemplazar.

---

### Tipo 3 — Regular (la más restrictiva)
Solo dos formas posibles, y hay que elegir una de las dos variantes:

**Lineal por la derecha:** A → a ó A → aV *(el no terminal va a la derecha)*
**Lineal por la izquierda:** A → a ó A → Va *(el no terminal va a la izquierda)*

> Son las más simples. Las implementan los autómatas finitos.

---

## 📊 Tabla resumen rápida

| Tipo | Nombre | Regla | Autómata |
|---|---|---|---|
| 0 | Sin restricción | u → v | Máquina de Turing |
| 1 | Sensible al contexto | xAy → xvy | Autómata lineal acotado |
| 2 | Libre de contexto | A → v | Autómata de pila |
| 3 | Regular | A → a ó A → aB | Autómata finito |

---

## 🎯 El truco para clasificar una gramática

Cuando veas una gramática y tengas que clasificarla, seguí esta checklist de adentro hacia afuera:

1. ¿Todas las reglas son A → a ó A → aB (o Ba)? → **Tipo 3**
2. ¿Todas las reglas son A → (lo que sea)? → **Tipo 2**
3. ¿Todas las reglas cumplen |derecha| ≥ |izquierda|? → **Tipo 1**
4. Si no cumple nada de lo anterior → **Tipo 0**

---

## 🌳 ¿Qué es un árbol de derivación?

**En criollo:** En vez de escribir la cadena de flechas en línea, lo desplegás como un árbol. La raíz es siempre **S**, las ramas son las producciones que aplicás, y las hojas (lo que está abajo del todo) son los **terminales** — si los juntás de izquierda a derecha, te dan la palabra generada.

---

## Ejemplo 1 — Simple

Gramática: P = {S → aSb, S → ab} Palabra a derivar: **aabb**

**Derivación lineal:**

```
S → aSb → aabb
```

**Árbol de derivación:**

```
        S
       /|\
      a  S  b
        / \
       a   b
```

Las hojas de izquierda a derecha: **a a b b** ✓

---

## Ejemplo 2 — Un nivel más

Misma gramática, palabra: **aaabbb**

**Derivación lineal:**

```
S → aSb → aaSbb → aaabbb
```

**Árbol de derivación:**

```
           S
          /|\
         a  S  b
           /|\
          a  S  b
            / \
           a   b
```

Hojas: **a a a b b b** ✓

> Notás el patrón: cada vez que aplicás S → aSb, el árbol crece un nivel hacia adentro.

---

## Ejemplo 3 — Con dos ramas (más complejo)

Gramática del Ejercicio 3 del TP: P = {S → abAS, S → a, A → b, abA → baab}

Palabra: **a**

```
    S
    |
    a
```

Simple, S → a directo.

---

## Ejemplo 4 — Gramática con bifurcación real

Gramática: P = {S → AB, A → a, B → b} Palabra: **ab**

```
      S
     / \
    A   B
    |   |
    a   b
```

Acá se ve bien la bifurcación: S se parte en dos ramas independientes.

---

## 🔑 Reglas para construir el árbol

**1.** La raíz siempre es **S**

**2.** Cada vez que aplicás una producción A → XYZ, dibujás A con tres hijos: X, Y, Z

**3.** Los nodos terminales (minúsculas) son hojas — no tienen hijos

**4.** Leyendo las hojas de **izquierda a derecha** obtenés la palabra generada

---

## ¿Cuándo usar árbol vs derivación lineal?

|Situación|Usá|
|---|---|
|Gramática simple, una sola rama|Derivación lineal (más rápido)|
|Gramática con varias producciones aplicadas a la vez|Árbol (más claro)|
|El ejercicio pide "mostrar la derivación"|Ambas, el árbol refuerza|
|Gramática ambigua (una palabra tiene dos árboles distintos)|Árbol — es la única forma de verlo|

---
