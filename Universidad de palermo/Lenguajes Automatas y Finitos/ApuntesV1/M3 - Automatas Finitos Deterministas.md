# Modulo 3 - Automatas Finitos Deterministas (AFD)

> [!note] Contexto
> Este modulo introduce los Automatas Finitos como maquinas de estados para reconocer lenguajes regulares. Se estudia su definicion formal, sus formas de representacion, el criterio de aceptacion de cadenas, y el algoritmo de minimizacion.

---

## Automata Finito (AF) - Concepto

Un **Automata Finito** es una maquina de estados que decide si una cadena pertenece o no a un lenguaje. Funciona leyendo los simbolos de la cadena de **izquierda a derecha** y transitando entre estados segun las reglas de la funcion de transicion.

- Tiene un **unico estado inicial**.
- Puede tener **uno o mas estados finales**.
- Si al terminar de leer la cadena el automata se encuentra en un **estado final**, la cadena **es aceptada**.
- Si al terminar NO esta en un estado final, la cadena **es rechazada**.

---

## Definicion Formal - Quintupla

Un AFD se define como un quinteto ordenado:

```
M = (Q, Sigma, delta, q0, F)
```

| Componente | Descripcion |
|---|---|
| `Q` | Conjunto finito de **estados** |
| `Sigma` | **Alfabeto** de entrada |
| `delta: Q x Sigma -> Q` | **Funcion de transicion** (mapeo de estado x simbolo -> estado siguiente) |
| `q0 ∈ Q` | **Estado inicial** |
| `F ⊆ Q` | Conjunto de **estados finales** (o de aceptacion) |

> [!important] Determinismo
> `delta` es una **funcion**, no una relacion. Esto significa que para cada par `(estado, simbolo)` existe **exactamente un** estado siguiente. Esta propiedad es el determinismo: siempre se sabe con certeza cual es el proximo estado.

### Regla de transicion individual

```
delta(q, a) = p
```

Lectura: "si el automata esta en el estado `q` y lee el simbolo `a`, pasa al estado `p`."

---

## Representaciones del AFD

### Tabla de transicion

- Filas: estados de `Q`
- Columnas: simbolos de `Sigma`
- Celda `(q, a)`: estado al que va `delta(q, a)`
- El estado inicial se marca con `->` o `>`
- Los estados finales se marcan con `*`

**Ejemplo:** `A1 = ({a,b}, {q0,q1,q2}, delta, q0, {q1})`

| delta | a  | b  |
|-------|----|----|
| ->q0  | q1 | q2 |
| *q1   | q0 | q1 |
| q2    | q2 | q2 |

### Diagrama de transicion

- Cada estado es un **circulo** con su nombre.
- El **estado inicial** tiene una flecha entrante `->` sin origen.
- Los **estados finales** se representan con **doble circulo**.
- Las transiciones son **flechas etiquetadas** con el simbolo leido.
- Si multiples simbolos llevan al mismo estado, se etiqueta la flecha con todos ellos separados por coma.

---

## Computo y Aceptacion de una cadena

### Funcion de transicion extendida

Para procesar cadenas completas (no solo simbolos individuales) se extiende `delta` a `delta*`:

```
delta*(q, lambda) = q
delta*(q, wa)     = delta(delta*(q, w), a)
```

Donde `w` es una cadena y `a` es un simbolo.

### Criterio de aceptacion

Una cadena `w` es **aceptada** por el AFD `M` si:

```
delta*(q0, w) ∈ F
```

El lenguaje aceptado por `M` es:

```
L(M) = {w ∈ Sigma* | delta*(q0, w) ∈ F}
```

### Como simular el computo manualmente

> [!note] Receta mental - Verificar si una cadena es aceptada
> 1. Partir del estado inicial `q0`.
> 2. Leer la cadena simbolo a simbolo de izquierda a derecha.
> 3. Para cada simbolo, aplicar `delta(estado_actual, simbolo)` para obtener el estado siguiente.
> 4. Al terminar la cadena, verificar si el estado actual pertenece a `F`.
>    - Si pertenece: la cadena es **aceptada**.
>    - Si no pertenece: la cadena es **rechazada**.

---

## Estado Trampa (o Estado Pozo)

Cuando ninguna transicion definida lleva a un estado valido, se usa un **estado trampa**: un estado no final al que van todas las transiciones indefinidas y del que no se puede salir. Permite que la tabla de transicion sea **total** (definida para todo par estado-simbolo).

---

## Automatas Equivalentes

Dos AFD `M1` y `M2` son **equivalentes** si aceptan exactamente el mismo lenguaje:

```
L(M1) = L(M2)
```

> [!note] Receta mental - Comprobar equivalencia
> Minimizar ambos automatas y comparar los AFD minimos resultantes. Si son isomorfos (misma estructura), son equivalentes.

---

## Minimizacion de un AFD - Algoritmo del Conjunto Cociente

El objetivo es obtener el **AFD minimo equivalente**, es decir, el que tiene la menor cantidad de estados posible para reconocer el mismo lenguaje.

### Algoritmo paso a paso

**Paso 1 - Particion inicial:**
```
Q/E0 = {F,  Q - F}
```
Se forman dos clases: los estados finales y los no finales.

**Paso 2 - Refinamiento iterativo:**

Generar `Q/E(i+1)` a partir de `Q/Ei`:

Dos estados `p` y `q` pertenecen a la **misma clase** en `Q/E(i+1)` si y solo si:
- `p` y `q` pertenecen a la misma clase en `Q/Ei`, **Y**
- Para todo `a ∈ Sigma`: `delta(p, a)` y `delta(q, a)` pertenecen a la misma clase en `Q/Ei`

Si alguna de estas condiciones falla, `p` y `q` deben separarse en clases distintas.

**Paso 3 - Criterio de parada:**
```
Si Q/E(i+1) = Q/Ei  =>  Q/E = Q/Ei  (convergencia, fin del algoritmo)
Si no, volver al paso 2.
```

**Paso 4 - Construccion del AFD minimo:**

Cada clase de equivalencia de `Q/E` se convierte en un **unico estado** del automata minimizado:
- Estado inicial: la clase que contiene a `q0`.
- Estados finales: las clases que contienen estados de `F`.
- Transiciones: `delta_min([q], a) = [delta(q, a)]`

> [!note] Receta mental - Minimizar un AFD
> 1. Separar estados finales de no finales (particion inicial).
> 2. Para cada clase, verificar si todos sus estados van al mismo grupo ante cada simbolo.
> 3. Si alguno va a un grupo distinto, dividir la clase.
> 4. Repetir hasta que ninguna clase se pueda dividir mas.
> 5. Cada clase resultante es un estado del AFD minimo.

> [!warning] Estados inaccesibles
> Antes de minimizar, conviene eliminar los **estados inaccesibles** (aquellos a los que no se puede llegar desde `q0`). Incluirlos no afecta la correccion pero genera clases espurias.

---

## Construccion de un AFD desde un lenguaje

> [!note] Receta mental - Disenar un AFD para un lenguaje
> 1. Identificar que "informacion" del pasado es relevante para decidir la aceptacion (esto define los estados).
> 2. Cada estado representa una "situacion" distinta de la lectura.
> 3. Marcar como estado final todo estado que represente una situacion de aceptacion.
> 4. Agregar un estado trampa para las transiciones que llevan a rechazo definitivo.
> 5. Verificar con cadenas de ejemplo que el automata acepta las correctas y rechaza las incorrectas.

**Patrones frecuentes en ejercicios:**

| Tipo de lenguaje | Estrategia de estados |
|---|---|
| Cadenas de longitud par/impar | 2 estados (par/impar), alternar con cada simbolo |
| Cantidad par/impar de un simbolo | 2 estados por simbolo rastreado |
| Combinacion de paridades | producto de estados (2 x 2 = 4 estados) |
| Cadenas que contienen subcadena fija | estados que registran cuanto del prefijo de la subcadena se ha leido |
| Cadenas que NO contienen subcadena | igual que el anterior, con estado trampa al completar la subcadena |

---

## Tabla de referencia rapida

| Concepto | Descripcion |
|---|---|
| AFD | Quintupla `(Q, Sigma, delta, q0, F)` con `delta` total y determinista |
| Aceptacion | `delta*(q0, w) ∈ F` |
| Rechazo | `delta*(q0, w) ∉ F` |
| Estado trampa | Estado no final al que van transiciones sin destino valido |
| Equivalencia | `L(M1) = L(M2)` |
| Minimizacion | Algoritmo del conjunto cociente por clases de equivalencia |
| AFD minimo | El de menor cantidad de estados que acepta el mismo lenguaje |

---

## Ver tambien

- [[M2 - Gramaticas y Tipos]]