## 🤖 ¿Qué es un Autómata Finito Determinista (AFD)?

**Formal:** Es una máquina que decide si una cadena pertenece o no a un lenguaje. Se define como un quinteto:

**(Q, Σ, δ, q₀, F)**

**En criollo:** Imaginá una máquina de estados como un semáforo con memoria. Lee letra por letra tu cadena y va cambiando de "estado" según las reglas. Al final, si terminó en un estado "aceptado" → la cadena pertenece al lenguaje. Si no → la rechaza.

Cada parte del quinteto significa:

**Q** → todos los estados posibles (ej: {q0, q1, q2})
**Σ** → el alfabeto que usa (ej: {a, b})
**δ** → la función de transición: "si estoy en estado X y leo símbolo Y, voy al estado Z"
**q₀** → el estado donde arranca siempre
**F** → los estados finales/de aceptación (doble círculo en el diagrama)

---

## 🔑 Concepto clave: el Determinismo

Lo que hace *determinista* a un AFD es que para cada estado + símbolo, **hay exactamente UN solo estado siguiente**. No hay ambigüedad: siempre sabés adónde vas.

---

## 📊 Dos formas de representarlo

**1. Tabla de transición** — una tabla donde las filas son estados y las columnas son símbolos:

| δ   | a   | b   |
| --- | --- | --- |
| q0  | q1  | q2  |
| q1  | q0  | q1  |
| q2  | q2  | q2  |

**2. Diagrama de transición** — un grafo con flechas. El estado inicial tiene una flecha entrante sin origen, y los estados finales tienen doble círculo.

---

## ✅ ¿Cómo se "corre" una cadena en el autómata?

Ejemplo simple: tenés el autómata de arriba con q0 inicial y q1 como estado final. ¿La cadena "ab" es aceptada?

- Arrancás en **q0**
- Leés **'a'** → δ(q0, a) = q1 → pasás a **q1**
- Leés **'b'** → δ(q1, b) = q1 → quedás en **q1**
- Terminaste de leer. ¿Estás en un estado final? **Sí, q1 ∈ F** → ✅ ACEPTADA

---