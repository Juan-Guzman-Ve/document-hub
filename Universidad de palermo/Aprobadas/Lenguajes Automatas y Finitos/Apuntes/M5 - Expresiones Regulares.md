

**Módulo:** 5  
**Tema:** Expresiones Regulares (ER)  
**Relación con otros módulos:** [[M3 - Autómatas Finitos Deterministas]] | [[M4 - Autómatas Finitos No Deterministas]]

---

## ¿Qué es una Expresión Regular?

Una ER es una **receta compacta para describir un lenguaje**. En vez de listar todas las cadenas posibles, escribís una expresión que las genera todas.

> Las ER describen exactamente los **lenguajes regulares** — los mismos que reconocen los autómatas finitos (AFD y AFND).

### Piezas base para construir una ER

| Expresión | Lenguaje que describe |
|-----------|----------------------|
| `∅` | Lenguaje vacío (ninguna cadena) |
| `λ` | Solo la cadena vacía `{ λ }` |
| `a` (símbolo del alfabeto) | Solo la cadena `{ a }` |
| Combinaciones con `r` y `s` | Ver operadores abajo |

---

## Operadores (de mayor a menor precedencia)

| Prioridad | Operador | Símbolo | Significa | Ejemplo |
|-----------|----------|---------|-----------|---------|
| 1° (mayor) | Clausura de Kleene | `r*` | 0 o más repeticiones de `r` | `a*` = λ, a, aa, aaa… |
| 2° | Concatenación | `r.s` | `r` seguido de `s` | `ab` = solo "ab" |
| 3° (menor) | Unión | `r+s` | `r` o `s` | `a+b` = "a" o "b" |

> ⚠️ **Cuidado con la precedencia:** `ab*` significa `a(b*)`, NO `(ab)*`. El `*` aplica solo a la `b`.

---

## Las 14 Propiedades / Leyes Algebraicas

Dos ER son **equivalentes** (`r ≡ s`) si describen el mismo lenguaje: `L(r) = L(s)`.

### Propiedades con `+` y concatenación

| # | Propiedad | En simple |
|---|-----------|-----------|
| 1 | `α+(β+γ) = α+β+γ` y `α.(β.γ) = α.β.γ` | Asociatividad: los paréntesis no importan |
| 2 | `α+β = β+α` y `α+α = α` | El orden en unión no importa; repetir es lo mismo |
| 3 | `α.(β+γ) = α.β + α.γ` y `(α+β).γ = α.γ + β.γ` | Distributiva (igual que en álgebra) |
| 4 | `α.λ = λ.α = α` y `α+∅ = ∅+α = α` | `λ` es neutro en concat.; `∅` es neutro en unión |
| 5 | `∅.α = α.∅ = ∅` | Concatenar con "imposible" = imposible |
| 6 | Si `λ ∈ L(α)` → `α+λ = α` | Si `α` ya acepta `λ`, agregarlo no cambia nada |

### Propiedades con clausura `*`

| # | Propiedad | En simple |
|---|-----------|-----------|
| 7 | `α* = λ + α.α*` | La clausura = vacío O (al menos uno seguido de más) |
| 8 | `λ* = λ` | Repetir vacío cualquier cantidad = vacío |
| 9 | `∅* = λ` | Clausura de imposible = solo el vacío |
| 10 | `α*.α* = α*` | Dos clausuras seguidas = una sola |
| 11 | `α.α* = α*.α` | Da igual si el `*` va antes o después |
| 12 | `(α*)* = α*` | Clausura de clausura = lo mismo |
| 13 | `(α*+β*)* = (α*.β*)* = (α+β)* = (α*.β)*.α*` | Mezcla de clausuras = clausura de la mezcla |
| 14 | `(α.β)*.α = α.(β.α)*` | Propiedad de "rotar" en clausura |

> 💡 **Truco estrella para simplificación:**
> - `(λ + α) . α* = α*`
> - `(λ + α) . (λ + α)* = α*`
> 
> Se usan muchísimo en el Ejercicio 6.

---

## Cómo LEER una ER (Ejercicio 2)

**Método:** Leer de adentro hacia afuera, respetando precedencia.

| Expresión | Cómo leerla | Lenguaje |
|-----------|-------------|---------|
| `0*` | Cero repetido 0 o más veces | λ, 0, 00, 000… |
| `(0+1)*` | Cualquier símbolo repetido | Todas las cadenas binarias (incluso λ) |
| `(10)*` | El bloque "10" repetido | λ, 10, 1010, 101010… |
| `(0+1)*1(1+0)*` | Cualquier cosa + un 1 fijo + cualquier cosa | Binarias con al menos un 1 |
| `1(0+1)*1` | Empieza en 1, algo en el medio, termina en 1 | Binarias que empiezan y terminan en 1 |
| `1*01*01*` | 1s opcionales, 0 fijo, 1s opcionales, 0 fijo, 1s opcionales | Exactamente dos 0s |
| `(0+1)*00(1+0)*` | Cualquier cosa + "00" fijo + cualquier cosa | Binarias que contienen "00" como subcadena |

---

## Cómo CONSTRUIR una ER desde descripción (Ejercicios 3, 4, 5)

**Preguntate:** ¿qué parte es **fija** y qué parte es **libre**?

**Patrón general:** `(libre)* + (fijo) + (libre)*`

| Descripción | Razonamiento | ER |
|-------------|-------------|-----|
| Termina en 0 | Cualquier cosa antes + el 0 fijo al final | `(0+1)*0` |
| Solo un 0 | Muchos 1s, luego UN 0 fijo, luego muchos 1s | `1*01*` |
| No contiene "000" | En cada bloque de 0s hay máximo dos seguidos | `(1+01+001)*(0+00)?` … ver solución |
| Única "a" (entre b,c) | Cualquier (b+c)*, luego la `a` fija, luego cualquier (b+c)* | `(b+c)*a(b+c)*` |
| `a²ⁿ b²ᵐ⁺¹` (n≥0, m≥0) | Pares de `a` (0 o más) + pares de `b` (0 o más) + una `b` obligatoria | `(aa)*(bb)*b` |
| Al menos dos 0s consecutivos | Cualquier cosa + "00" fijo + cualquier cosa | `(0+1)*00(0+1)*` |
| `\|w\|` mod 3 = 0 | Longitud múltiplo de 3 → grupos de 3 símbolos | `((a+b)(a+b)(a+b))*` |
| `nₐ(w) + n_b(w)` es par | Cantidad total de símbolos es par | `((a+b)(a+b))*` |

---

## Simplificación de ER (Ejercicio 6)

**Estrategia:** Aplicar propiedades para reducir la expresión al mínimo.

### Propiedades más usadas para simplificar

```
(λ + α) α* = α*          ← prop 6 + 7
α + α = α                ← prop 2
α*.α* = α*               ← prop 10
(λ + α)(λ + α)* = α*     ← truco estrella
```

### Ejemplos resueltos

**a)** `(a + λ) a* b`
```
= (aa* + λa*) b          ← distribuir sobre a*
= (aa* + a*) b           ← λa* = a*
= (a⁺ + a*) b            ← aa* = a⁺
= a* b                   ← a⁺ + a* = a*  (prop 6)
```

**b)** `(λ + aa)(λ + aa)*a + a`
```
= [(λ + aa)(λ + aa)* + λ] a     ← sacar factor a
= [(λ + aa)*] a                  ← truco estrella
= (aa)*a
```

**c)** `(λ + aa)(λ + aa)*(ab + b) + (ab + b)`
```
= [(λ + aa)(λ + aa)* + λ](ab + b)    ← sacar factor (ab+b)
= (λ + aa)*(ab + b)                   ← truco estrella
= (aa)*(ab + b)
```

**d)** `(a + b)(λ + aa)*(λ + aa) + (a + b)`
```
= (a+b)[(λ + aa)*(λ + aa) + λ]    ← sacar factor (a+b)
= (a+b)(λ + aa)*                   ← truco estrella (al revés)
= (a+b)(aa)*
```

---

## Algoritmo AF → ER (Ejercicio 7 / Lema de Arden)

> **Teorema de Análisis de Kleene:** Si `L` es aceptado por un AF, existe una ER `α` tal que `L(AF) = L(α)`.

### Pasos

**Paso 1 — Escribir ecuaciones características**

Para cada estado `qᵢ`, escribí su ecuación mirando las transiciones que *salen* de él:
- Si `δ(qᵢ, a) = qⱼ` → sumás el término `a·qⱼ` al lado derecho
- Si `qᵢ` es estado **final** → sumás `λ` al lado derecho

**Paso 2 — Resolver el sistema**

Cuando una ecuación tiene la forma:
$$X = \alpha \cdot X + \beta$$

Aplicás el **Lema de Arden**:
$$X = \alpha^* \cdot \beta$$

**Paso 3 — Resultado**

La ER del autómata es la expresión que resuelve `q₀` (estado inicial).

### Ejemplo desarrollado

Autómata: `A = ({q0,q1,q2}, {0,1}, δ, q0, {q1})`

```
Ecuaciones:
(1) q0 = 0·q0 + 1·q1
(2) q1 = 0·q0 + 1·q2 + λ       ← q1 es final, se suma λ
(3) q2 = 0·q2 + 1·q1
```

```
Resolver (3): tiene forma X = α·X + β → Arden
    q2 = 0*·1·q1                                   ...(4)

Resolver (1): tiene forma X = α·X + β → Arden
    q0 = 0*·1·q1                                   ...(5)

Reemplazar (4) y (5) en (2):
    q1 = 0·(0*·1·q1) + 1·(0*·1·q1) + λ
    q1 = (0·0*·1 + 1·0*·1)·q1 + λ
    q1 = (00*1 + 10*1)·q1 + λ      ← forma Arden, aplicar

    q1 = (00*1 + 10*1)*             ...(6)

Reemplazar (6) en (5):
    q0 = 0*·1·(00*1 + 10*1)*

ER final: 0*1(00*1 + 10*1)*
```

---

## Tabla resumen: qué hacer en cada ejercicio

| Ejercicio | Tarea | Herramienta clave |
|-----------|-------|------------------|
| Ej 1 | Listar cadenas → ver patrón → escribir ER | Unión y concatenación directa |
| Ej 2 | Leer la ER → describir con palabras | Precedencia + intuición |
| Ej 3 | Descripción → identificar parte fija y libre | Patrón: `libre* + fijo + libre*` |
| Ej 4 | Igual que Ej 3, alfabeto de 3 letras | Complemento del símbolo restringido |
| Ej 5 | Lenguaje formal → traducir condición a ER | Grupos repetidos, mod, paridad |
| Ej 6 | Simplificar usando propiedades | Props 2, 4, 6, 7, 10 + truco `(λ+α)α*=α*` |
| Ej 7 | ER → AFD / AF → ER (Arden) | Ecuaciones características + Lema de Arden |

---

## Equivalencia ER ↔ AF

```
    ER  ──[Síntesis de Kleene]──→  AF
    AF  ──[Análisis de Kleene]──→  ER
```

- **AF → ER:** Ecuaciones características + Lema de Arden (ver arriba)
- **ER → AF:** Construcción del autómata desde la estructura de la ER

---

*Apunte generado para Obsidian — Módulo 5*