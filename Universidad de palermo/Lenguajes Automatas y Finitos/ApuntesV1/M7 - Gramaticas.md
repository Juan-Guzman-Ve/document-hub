# Modulo 7 - Gramaticas Regulares

## Indice

- [[#Que es una Gramatica Regular]]
- [[#Tipos de Gramaticas Regulares]]
- [[#Lenguaje Regular]]
- [[#Gramatica ↔ Automata Finito]]
- [[#Gramatica ↔ Expresion Regular]]
- [[#Conversion Lineal Derecha a Izquierda]]
- [[#Conversion Lineal Izquierda a Derecha]]
- [[#Recetas para los ejercicios]]

---

## Que es una Gramatica Regular

Una **Gramatica Regular** (o Tipo 3) es un tipo especial de gramatica donde:

- La **parte izquierda** de cada produccion tiene exactamente **un no terminal**
- La **parte derecha** es una de estas formas: terminal solo, terminal + no terminal, o lambda

Es la gramatica mas restringida de la jerarquia de Chomsky. Ver [[M2_Gramaticas_y_Tipos]].

---

## Tipos de Gramaticas Regulares

|Tipo|Nombre|Forma de las producciones|
|---|---|---|
|Lineal Derecha|El no terminal queda a la derecha|`A → bB`, `A → b`, `A → λ`|
|Lineal Izquierda|El no terminal queda a la izquierda|`A → Bb`, `A → b`, `A → λ`|

Donde `A, B ∈ N` (no terminales) y `b ∈ Σ` (terminal).

> [!important] Regla clave En una **lineal derecha**, el no terminal siempre va al FINAL. En una **lineal izquierda**, el no terminal siempre va al INICIO. NO se pueden mezclar ambos tipos en la misma gramatica (si se mezclan, pasa a ser Tipo 2).

### Ejemplo rapido

```
Lineal Derecha:
S → 1A
A → 0B | 0
B → 1

Lineal Izquierda:
S → A1
A → S0 | 1
```

---

## Lenguaje Regular

Un lenguaje es **regular** si se puede representar de alguna de estas tres formas equivalentes:

```
Expresion Regular  ⟺  Gramatica Regular  ⟺  Automata Finito
```

> [!note] Las tres son equivalentes Si tenes cualquiera de las tres representaciones, podes obtener las otras dos. El modulo trabaja con las conversiones entre estas formas.

---

## Gramatica ↔ Automata Finito

Esta es la conversion mas directa del modulo. Se basa en una correspondencia exacta estado-a-estado con no terminal-a-no terminal.

### De Automata a Gramatica (lineal derecha)

Dado un AFD/AFND `M = (Q, Σ, δ, q0, F)`, construir `G = (Σ, N, S, P)`:

|Elemento del automata|Elemento de la gramatica|
|---|---|
|`Q` (estados)|`N` (no terminales)|
|`q0` (estado inicial)|`S` (simbolo inicial)|
|`δ(qi, a) = qj` (transicion)|`qi → a qj` (produccion)|
|`qi ∈ F` (estado final)|Agregar `qi → λ`|

> [!important] Estados finales Por cada estado final `qi`, se agrega la produccion `qi → λ`. Esto permite que la derivacion "termine" en ese punto.

**Ejemplo:**

```
Transicion: δ(q0, 1) = q1  →  Produccion: q0 → 1 q1
Estado final: q1            →  Produccion: q1 → λ
```

---

### De Gramatica a Automata (lineal derecha)

Dada una gramatica regular lineal derecha `G = (Σ, N, S, P)`, construir `M = (Q, Σ, δ, q0, F)`:

|Elemento de la gramatica|Elemento del automata|
|---|---|
|`N` (no terminales)|`Q` (estados)|
|`S` (simbolo inicial)|`q0` (estado inicial)|
|`qi → a qj` (produccion)|`δ(qi, a) = qj` (transicion)|
|`qi → λ` o `qi → a`|`qi ∈ F` (estado final)|

> [!note] Produccion de la forma `A → b` (sin no terminal al final) Esto equivale a: ir al estado final con el simbolo `b`. Se puede modelar con un estado especial de aceptacion.

---

## Gramatica ↔ Expresion Regular

La conversion **no es directa**: siempre pasa por el automata como intermediario.

```
Expresion Regular
       ↓  (Teorema de Sintesis de Kleene)
  Automata Finito
       ↓  (conversion automata → gramatica)
 Gramatica Regular
```

```
Gramatica Regular
       ↓  (conversion gramatica → automata)
  Automata Finito
       ↓  (Teorema de Analisis de Kleene / Lema de Arden)
Expresion Regular
```

Ver [[M5_Expresiones_Regulares]] y [[M6_Expresiones_Regulares]] para el metodo de ecuaciones caracteristicas y Lema de Arden.

---

## Conversion Lineal Derecha a Izquierda

Para convertir una gramatica lineal derecha `GD` en una lineal izquierda `GI` equivalente:

### Paso 1 - Eliminar reglas de la forma `A → aS`

Obtener una gramatica `G'D` equivalente que **no tenga producciones donde el axioma `S` aparezca en la parte derecha**.

> [!warning] Por que eliminar `A → aS`? El algoritmo de inversion del grafo requiere que `S` sea un nodo "fuente" puro. Si `S` aparece en la derecha de alguna produccion, la inversion del grafo no funciona correctamente.

### Paso 2 - Construir el grafo dirigido de `G'D`

Los **nodos** son: todos los no terminales `∑N` mas el nodo especial `λ`.

|Tipo de produccion|Arco a agregar|
|---|---|
|`A → aB`|De `A` a `B`, etiquetado con `a`|
|`A → a`|De `A` a `λ`, etiquetado con `a`|
|`S → λ`|De `S` a `λ`, sin etiqueta|

### Paso 3 - Invertir el grafo

- Intercambiar los nodos `S` y `λ` (es decir, `λ` pasa a ser el nuevo punto de inicio, y `S` pasa a ser el nuevo nodo de aceptacion)
- Invertir el sentido de **todos** los arcos

### Paso 4 - Leer la nueva gramatica

Del grafo invertido, leer las producciones de la gramatica lineal izquierda `GI`.

> [!note] Resultado El grafo invertido genera directamente la gramatica lineal izquierda equivalente.

---

## Conversion Lineal Izquierda a Derecha

El proceso es analogo al anterior pero en sentido inverso: se parte de la lineal izquierda, se construye el grafo, se invierte, y se lee la lineal derecha.

> [!important] Teorema (ambos sentidos) Para toda gramatica lineal derecha existe una izquierda equivalente, y viceversa. Ambas generan exactamente el mismo lenguaje.

---

## Recetas para los ejercicios

### Ejercicio tipo: "Obtener la gramatica a partir del automata"

1. Identificar los estados → son los no terminales. El estado inicial es `S`.
2. Por cada transicion `δ(qi, a) = qj` → escribir produccion `qi → a qj`.
3. Por cada estado final `qi` → agregar produccion `qi → λ`.

### Ejercicio tipo: "Obtener el automata a partir de la gramatica"

1. Los no terminales son los estados. El axioma `S` es el estado inicial.
2. Por cada produccion `qi → a qj` → crear transicion `δ(qi, a) = qj`.
3. Los estados finales son aquellos con produccion `qi → λ` o `qi → a` (sin no terminal al final).

### Ejercicio tipo: "Obtener la expresion regular a partir de la gramatica"

1. Convertir la gramatica en un automata (usando la receta anterior).
2. Obtener las ecuaciones caracteristicas del automata (una ecuacion por estado).
3. Resolver el sistema con el **Lema de Arden**: si `x = α·x + β`, entonces `x = α*·β`.
4. La solucion para el estado inicial es la expresion regular buscada.

### Ejercicio tipo: "Convertir lineal derecha a izquierda"

1. Verificar que no hay producciones `A → aS`. Si las hay, eliminarlas generando producciones equivalentes sin `S` en la derecha.
2. Dibujar el grafo dirigido con los no terminales mas el nodo `λ`.
3. Invertir: cambiar `S` ↔ `λ` y dar vuelta todas las flechas.
4. Leer las producciones del grafo invertido como gramatica lineal izquierda.

### Ejercicio tipo: "Obtener la gramatica a partir de una expresion regular"

1. Construir el automata finito que reconoce la expresion regular (Teorema de Sintesis de Kleene).
2. Convertir el automata en gramatica usando la receta de automata → gramatica.

---

## Resumen de equivalencias

```
          Expresion Regular
         /                 \
        ↕                   ↕
 Automata Finito  ←——→  Gramatica Regular
  (AFD / AFND)         (Lineal D. o Izq.)
```

Todos representan exactamente los **Lenguajes Regulares** (Tipo 3 en la jerarquia de Chomsky).
