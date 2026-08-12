
Vamos de lo más simple a lo más complejo, mezclando la teoría formal con explicaciones que tienen sentido en la práctica.

---

##  1. Alfabeto (Σ)

**Formal:** Un alfabeto es cualquier conjunto finito y no vacío cuyos elementos se llaman símbolos.

**En criollo:** Es simplemente *el juego de piezas* con las que vas a armar palabras. Como el abecedario, pero puede tener lo que quieras.

> Σ = {a, b} → solo tenés dos piezas: la 'a' y la 'b'
> Σ = {0, 1} → el clásico binario

---

## 🧵 2. Cadena (o palabra)

**Formal:** Una cadena sobre Σ es cualquier secuencia finita de símbolos de Σ. La cadena sin ningún símbolo se llama **cadena vacía** y se escribe **λ**.

**En criollo:** Es simplemente *armar una palabra* usando las piezas del alfabeto. Podés repetirlas, combinarlas, o no poner nada (eso es λ).

> Con Σ = {a, b}: `aba`, `bbb`, `a`, `λ` son todas cadenas válidas

**Longitud** de una cadena: cuántos símbolos tiene.
> |aba| = 3 , |λ| = 0

---

## 📦 3. Los "universos" de cadenas: Σ⁰, Σ¹, Σ², Σ*, Σ⁺

Acá está la clave para entender el ejercicio 1. Pensalo así:

| Notación | Qué contiene | Ejemplo con Σ={a,b} |
|---|---|---|
| **Σ⁰** | Solo la cadena vacía | {λ} |
| **Σ¹** | Todas las cadenas de longitud 1 | {a, b} |
| **Σ²** | Todas las cadenas de longitud 2 | {aa, ab, ba, bb} |
| **Σ*** | TODAS las cadenas posibles (incluyendo λ) | {λ, a, b, aa, ab, ...} |
| **Σ⁺** | TODAS menos λ | {a, b, aa, ab, ...} |

**La regla de oro:** Σⁿ tiene exactamente **pˢ** cadenas, donde p = cantidad de símbolos del alfabeto.
> Σ = {a,b} tiene 2 símbolos → Σ² tiene 2² = 4 cadenas ✓

---

## 🔗 4. Concatenación

**Formal:** Unir dos cadenas u · v escribiendo los símbolos de u seguidos de los de v.

**En criollo:** Es pegar una cadena detrás de la otra, como unir palabras.

> u = "ab", v = "ba" → u·v = "abba"
> Cualquier cadena concatenada con λ da ella misma: u·λ = u

---

## 🌟 5. Lenguaje

**Formal:** Un lenguaje L sobre Σ es cualquier subconjunto de Σ*, es decir L ⊆ Σ*.

**En criollo:** Es un *grupo de cadenas* que cumplen alguna regla. Puede ser finito o infinito.

> L = {0ⁿ1ⁿ / n > 0} → cadenas con n ceros seguidos de n unos: {01, 0011, 000111, ...}

---

## ⚙️ 6. Operaciones entre lenguajes

Dados dos lenguajes A y B:

| Operación | Qué hace | Ejemplo |
|---|---|---|
| **A ∪ B** | Todo lo que está en A o en B | {a,ab} ∪ {ab,b} = {a,ab,b} |
| **A ∩ B** | Solo lo que está en ambos | {a,ab} ∩ {ab,b} = {ab} |
| **A − B** | Lo de A que NO está en B | {a,ab} − {ab} = {a} |
| **A · B** | Concatenar cada palabra de A con cada una de B | {a,b}·{c} = {ac,bc} |
| **A*** | Todas las concatenaciones posibles de A (incluyendo λ) | clausura de Kleene |
| **A⁺** | Igual pero sin λ | clausura positiva |
| **Aᴿ** | Cada palabra del revés | {ab,ba}ᴿ = {ba,ab} |

---

## 🚀 ¿Arrancamos con los ejercicios?

Te recomiendo este orden:

**Ejercicio 1** → Para entender Σ⁰, Σ¹, Σ*, Σ⁺ en la práctica
**Ejercicio 2** → Para afianzar qué pertenece a qué
**Ejercicio 3** → Operaciones entre alfabetos
**Ejercicios 4 y 5** → Descripción de lenguajes (lo más conceptual)
**Ejercicios 6, 7 y 8** → Aplicar todo junto
