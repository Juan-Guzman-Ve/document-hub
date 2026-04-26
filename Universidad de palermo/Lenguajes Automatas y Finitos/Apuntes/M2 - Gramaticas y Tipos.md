
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
## Gramáticas Equivalentes

**Formalmente:** Dos gramáticas G1 y G2 son equivalentes si generan el mismo lenguaje, es decir **L(G1) = L(G2)**.

**En criollo:** No importa que las reglas sean distintas o que los caminos de derivación sean diferentes — si al final el **conjunto de palabras que producen es idéntico**, son equivalentes.

---
## Ejemplo

**G1** con P = `{ S → aSb | λ }`

**G2** con P = `{ S → aAb | λ, A → aAb | λ }`

Derivaciones de G1:

```
S → λ
S → aSb → ab
S → aSb → aaSbb → aabb
```

Derivaciones de G2:

```
S → λ
S → aAb → aλb → ab
S → aAb → aaAbb → aaλbb → aabb
```

**Caminos distintos, mismo resultado** → L(G1) = L(G2) = { aⁿbⁿ / n ≥ 0 }

**→ G1 y G2 son equivalentes ✓**

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

[[M2.1 - Arboles Derivacion | Arboles Derivacion]]
[[M2.2 - Clasificacion de Gramaticas | Metodo Estructurado Para Clasificacion]]