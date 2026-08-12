# 🤖 Módulo 4 — Autómatas Finitos No Deterministas

> **Materia:** Lenguajes Formales y Autómatas Finitos  
> **Módulo:** M4  
> **Tags:** #automatas #AFND #AFD #lambda #lenguajes-formales

---

## 🗺️ Mapa del módulo

```
AFND  →  Convertir AFND a AFD  →  AFND-λ  →  Convertir AFND-λ a AFND
```

---

## 1. Autómata Finito No Determinista (AFND)

### 💡 Idea clave (informal)
A diferencia del AFD donde leés un símbolo y vas a **exactamente un estado**, en el AFND podés ir a **varios estados a la vez** (o a ninguno). El autómata "se clona" y explora todos los caminos posibles simultáneamente.

### 📐 Definición formal
Un AFND es una quíntupla **M = (Q, Σ, q₀, δ, F)** donde:

| Componente | Descripción |
|---|---|
| **Q** | Conjunto finito de **estados** |
| **Σ** | **Alfabeto** de entrada |
| **q₀** | **Estado inicial** |
| **F ⊆ Q** | Conjunto de **estados finales** (no vacío) |
| **δ: Q × Σ → P(Q)** | **Función de transición** (va a un *conjunto* de estados) |

> ⚠️ **Diferencia clave con el AFD:**
> - AFD: `δ: Q × Σ → Q` (un solo estado destino)
> - AFND: `δ: Q × Σ → P(Q)` (un subconjunto de estados, incluyendo ∅)

### ✅ Condición de aceptación
Una palabra **u** es aceptada si existe **AL MENOS UN** cómputo completo que termina en un estado final.

$$L(M) = \{u \in \Sigma^* : \exists \text{ cómputo de } u \text{ que termina en } q \in F\}$$

> 🧠 Con que uno solo de los caminos llegue a buen puerto, la palabra se acepta. Puede haber caminos que rechacen o que se "corten" (∅) — no importa.

### 🖊️ Representación

**Con tabla:** igual que el AFD, pero cada celda contiene un *conjunto* de estados.
- Estado inicial → con flecha `→`
- Estados finales → con asterisco `*`

**Con diagrama:** si `δ(q, a) = {r, s}`, se dibujan **dos flechas** desde q, una hacia r y otra hacia s, ambas etiquetadas con `a`.

### 📋 Ejemplo
Sea M₅ con Q = {p, q, r, s}, Σ = {0, 1}, estado inicial p, F = {q, s}:

| δ | 0 | 1 |
|---|---|---|
| →p | {q, r} | ∅ |
| *q | {q} | {q, s} |
| r | ∅ | {s} |
| *s | {p} | ∅ |

Para `u = "01"`:
- Desde p con '0' → {q, r}
- Desde q con '1' → {q, s} ✅ (s es final)
- Desde r con '1' → {s} ✅ (s es final)
- **u es aceptada** ✅

---

## 2. Construcción de un AFD equivalente a un AFND

### 💡 Idea clave (informal)
Cada "conjunto de estados" donde puede estar el AFND simultáneamente lo tratamos como **un solo estado** del AFD nuevo. Se conoce como la **construcción del conjunto potencia**.

> 🎯 "Agarrás todos los clones del AFND en un momento dado y los metés en una sola caja. Esa caja es un estado del AFD."

### 📐 Definición formal
Dado AFND = (Q, Σ, δ, q₀, F), el AFD equivalente = (Q', Σ, δ', q₀', F') se construye:

| Componente | Construcción |
|---|---|
| **Q'** | P(Q) — los estados son subconjuntos de estados del AFND |
| **q₀'** | {q₀} — el inicial es el conjunto con solo el inicial del AFND |
| **F'** | { S ∈ P(Q) / S ∩ F ≠ ∅ } — finales son los que contienen algún estado final del AFND |
| **δ'(S, a)** | ⋃ δ(q, a) para todo q ∈ S — unión de transiciones de todos los estados del conjunto |

### 🛠️ Algoritmo paso a paso (solo estados alcanzables)

> No se construyen todos los 2ⁿ subconjuntos, solo los alcanzables desde el inicial.

1. Empezar con el estado **{q₀}**
2. Para cada estado-conjunto, calcular adónde va con cada símbolo → unión de transiciones
3. Si el conjunto resultante es **nuevo**, agregarlo a la tabla
4. Repetir hasta que no aparezcan conjuntos nuevos
5. Marcar como **finales** los conjuntos que contengan algún estado final del AFND
6. El conjunto **∅** es el estado trampa (se agrega si aparece)

### 📋 Ejemplo

AFND original:

| δ | a | b |
|---|---|---|
| →q0 | {q0,q1,q3} | ∅ |
| *q1 | {q1} | {q2} |
| q2 | ∅ | {q1,q2} |
| *q3 | ∅ | {q3} |

Estados finales AFND: q1, q3

**AFD resultante (solo alcanzables):**

| δ' | a | b | ¿Final? |
|---|---|---|---|
| →{q0} | {q0,q1,q3} | ∅ | No |
| {q0,q1,q3} | {q0,q1,q3} | {q2,q3} | ✅ (tiene q1, q3) |
| ∅ | ∅ | ∅ | No (estado trampa) |
| {q2,q3} | ∅ | {q1,q2,q3} | ✅ (tiene q3) |
| {q1,q2,q3} | {q1} | {q2,q3} | ✅ (tiene q1, q3) |
| {q1} | {q1} | {q2} | ✅ (tiene q1) |
| {q2} | ∅ | {q1,q2} | No |
| {q1,q2} | {q1} | {q1,q2} | ✅ (tiene q1) |

> 💡 Cómo se calcula `δ'({q0,q1,q3}, b)`:
> - δ(q0, b) = ∅
> - δ(q1, b) = {q2}
> - δ(q3, b) = {q3}
> - Unión = **{q2, q3}** ✅

---

## 3. AFND con λ-transiciones (AFND-λ)

### 💡 Idea clave (informal)
Ahora el autómata puede moverse a otro estado **sin leer ningún símbolo** — con una transición λ (lambda = palabra vacía).

> 🚪 "Es como un portal invisible: estás en un estado y automáticamente también estás en los estados a los que llegás por λ, sin consumir nada."

### 📐 Definición formal
Un **AFND-λ** es igual que el AFND, solo que la función de transición también acepta λ:

$$\delta: Q \times (\Sigma \cup \{\lambda\}) \rightarrow P(Q)$$

Además de `δ(q, a)` con a ∈ Σ, también puede haber `δ(q, λ) = {r, s, ...}`

### 🔑 Concepto clave: Clausura-λ

La **Clausura-λ de un estado q** (escrita `Cl-λ(q)`) es el conjunto de todos los estados alcanzables desde q siguiendo **solo arcos λ**.

> ⚠️ Siempre incluye al propio estado q (porque "quedarse" también cuenta).

**Propiedades:**
- `q ∈ Cl-λ(q)` siempre
- Si `δ(q, λ) = {r}` y `δ(r, λ) = {s}`, entonces `Cl-λ(q) = {q, r, s}`

### 📋 Ejemplo

| δ | 0 | 1 | λ |
|---|---|---|---|
| →p | {q,r} | ∅ | {r} |
| *q | {q} | {q,s} | {p} |
| r | ∅ | {s} | ∅ |
| *s | {p} | ∅ | ∅ |

Calculando clausuras:

| Estado | Clausura-λ | Cómo se calcula |
|---|---|---|
| p | {p, r} | p + δ(p,λ)={r}, r no tiene λ |
| q | {q, p, r} | q + δ(q,λ)={p} + Cl-λ(p)={p,r} |
| r | {r} | r + no tiene λ-transición |
| s | {s} | s + no tiene λ-transición |

---

## 4. Conversión AFND-λ → AFND

### 💡 Idea clave (informal)
Queremos eliminar las λ-transiciones. La clave: **antes de leer un símbolo `a` desde q, consideramos todos los estados alcanzables por λ; después de leer, también aplicamos clausura-λ al resultado.**

### 📐 Algoritmo

Dado el AFND-λ, el AFND equivalente se construye:

1. **Calcular Cl-λ(q) para cada estado q**
2. Si `Cl-λ(q₀) ∩ F ≠ ∅` → q₀ también es estado final en el nuevo autómata
3. Para cada estado q y símbolo a ∈ Σ, la nueva transición es:

$$\delta'(q, a) = Cl\text{-}\lambda\left(\bigcup_{r \in Cl\text{-}\lambda(q)} \delta(r, a)\right)$$

En criollo:
> **Paso 1:** Calculá Cl-λ(q) — todos los estados que alcanzás gratis desde q  
> **Paso 2:** Desde cada uno de esos estados, leé el símbolo `a` → juntá todos los resultados (unión)  
> **Paso 3:** Al conjunto resultado, aplicale Cl-λ otra vez

### 📋 Ejemplo

Calculamos `δ'(p, 0)` usando la tabla anterior:

1. Cl-λ(p) = {p, r}
2. δ(p, 0) = {q, r} y δ(r, 0) = ∅ → unión = {q, r}
3. Cl-λ({q, r}) = Cl-λ(q) ∪ Cl-λ(r) = {q,p,r} ∪ {r} = **{p, q, r}**

Por lo tanto: `δ'(p, 0) = {p, q, r}` ✅

---

## 🧩 Resumen comparativo

| Tipo | Transición | Desde un estado con un símbolo va a... | Acepta si... |
|---|---|---|---|
| **AFD** | `δ: Q×Σ → Q` | Exactamente 1 estado | Termina en estado final |
| **AFND** | `δ: Q×Σ → P(Q)` | Un conjunto de estados (o ∅) | Al menos 1 camino termina en estado final |
| **AFND-λ** | `δ: Q×(Σ∪{λ}) → P(Q)` | Un conjunto de estados, también sin leer | Al menos 1 camino termina en estado final |

> 🔁 **Equivalencia:** AFD ≡ AFND ≡ AFND-λ (todos reconocen los mismos lenguajes — los regulares)

---

## 📌 Recetas mentales para resolver ejercicios

### Leer un AFND y decir qué lenguaje reconoce
> Mirá los estados finales. ¿Qué palabras tienen aunque sea un camino que llegue ahí?

### Convertir AFND → AFD
> 1. Empezás con `{q₀}`
> 2. Para cada estado-conjunto, calculás `δ'(S, a) = ⋃ δ(q, a)` para todo q en S
> 3. Si el resultado es nuevo → lo agregás
> 4. Repetís hasta no tener estados nuevos
> 5. Marcás finales los que contengan algún estado final original

### Calcular Clausura-λ
> Desde el estado q, seguí todos los arcos λ que puedas (incluyendo los arcos λ de los estados que vayas alcanzando). El conjunto de todos los estados visitados (incluido q) es la clausura-λ.

### Eliminar λ-transiciones (AFND-λ → AFND)
> `δ'(q, a) = Cl-λ( δ(Cl-λ(q), a) )`  
> = Clausura del resultado de leer `a` desde todos los estados alcanzables por λ desde q

---

## 🔗 Conexión con otros módulos

- **M3** → [[M3_Automatas_Finitos_Deterministas]] (AFD, minimización)
- **M1** → [[M1_Cadenas_Alfabetos_Lenguajes]] (conceptos base: Σ, palabras, lenguajes)
- **Gramáticas** → [[Teoria_Gramatica_Tipos]] (los lenguajes regulares también son generados por gramáticas tipo 3)