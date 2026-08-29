---
tags:
  - materia/calculo-numerico
  - modulo/m1
  - tipo/ejercicios
materia: Calculo Numerico
modulo: M1 - Introduccion
tipo: ejercicios
descripcion: Practico N1 resuelto (ejercicios 1-10) — digitos significativos, redondeo, truncamiento, error absoluto y relativo, aritmetica de computadora con 3 digitos. Ejercicios 11-15 requieren diferencial (ver M2).
conceptos_clave:
  - digitos significativos
  - redondeo
  - truncamiento
  - error absoluto
  - error relativo
  - aritmetica de digitos finitos
relacionados:
  - "[[M1 - Teoria de errores]]"
  - "[[M2 - Aplicacion del Diferencial al Calculo de Errores]]"
---

# Práctico N°1 — Ejercicios resueltos (contenido cubierto en Módulo 1)

> [!note] Alcance
> Se resuelven los Ejercicios 1 a 10, que corresponden al contenido visto en la clase de Módulo 1 (dígitos significativos, truncamiento, redondeo, error absoluto, error relativo y aritmética en la computadora). Los Ejercicios 11 a 15 requieren el uso del diferencial para propagación de errores, tema no cubierto todavía en el material de M1.

---

## Ejercicio 1 (y Ejercicio 2, idéntico)

**Pregunta:** Indicar cuántos dígitos significativos tienen los siguientes números.

**a)** 0,006540

$$k = 4$$

**b)** 12370

$$k = 5$$

**c)** 50,0072

$$k = 6$$

**d)** 12370,0

$$k = 6$$

**e)** 0,00123700

$$k = 6$$

**f)** 12300134

$$k = 8$$

---

## Ejercicio 3

**Pregunta:** Redondear los siguientes números a cuatro dígitos significativos. Verificar que los cuatro dígitos obtenidos por redondeo son correctos.

**a)** 12,7684

$$12,7684 \approx 12,77$$

**b)** 0,1428576

$$0,1428576 \approx 0,1429$$

**c)** 4,00250

$$4,00250 \approx 4,003$$

**d)** 7,99951

$$7,99951 \approx 8,000$$

**e)** 9!

$$9! = 362880 \approx 362900$$

---

## Ejercicio 4

**Pregunta:** Redondee los siguientes números a: a) dos cifras decimales, b) cuatro dígitos significativos.

### i) 555,666

**Respuesta a (dos cifras decimales):**

$$555,666 \approx 555,67$$

**Respuesta b (cuatro dígitos significativos):**

$$555,666 \approx 555,7$$

### ii) 2222,333

**Respuesta a (dos cifras decimales):**

$$2222,333 \approx 2222,33$$

**Respuesta b (cuatro dígitos significativos):**

$$2222,333 \approx 2222 \times 10^{0}$$

### iii) 333,00

**Respuesta a (dos cifras decimales):**

$$333,00 \approx 333,00$$

**Respuesta b (cuatro dígitos significativos):**

$$333,00 \approx 333,0$$

### iv) 9,9950

**Respuesta a (dos cifras decimales):**

$$9,9950 \approx 10,00$$

> [!tip] Por qué sube a 10,00
> El tercer decimal a descartar es exactamente 5 seguido de ceros (empate exacto). La regla de redondeo al par más cercano indica que si el dígito que se conserva es impar (acá 9), se redondea hacia arriba.

**Respuesta b (cuatro dígitos significativos):**

$$9,9950 \approx 9,995$$

### v) 0,005000

**Respuesta a (dos cifras decimales):**

$$0,005000 \approx 0,00$$

> [!tip] Por qué se queda en 0,00
> Mismo caso de empate exacto en el tercer decimal, pero acá el dígito que se conserva ya es par (0), entonces no se redondea hacia arriba.

**Respuesta b (cuatro dígitos significativos):**

$$0,005000 \approx 0,005000$$

---

## Ejercicio 5

**Pregunta:** Repita el ejercicio 4 aplicando truncamiento.

### i) 555,666

$$\text{a) } 555,666 \to 555,66 \qquad \text{b) } 555,666 \to 555,6$$

### ii) 2222,333

$$\text{a) } 2222,333 \to 2222,33 \qquad \text{b) } 2222,333 \to 2222 \times 10^{0}$$

### iii) 333,00

$$\text{a) } 333,00 \to 333,00 \qquad \text{b) } 333,00 \to 333,0$$

### iv) 9,9950

$$\text{a) } 9,9950 \to 9,99 \qquad \text{b) } 9,9950 \to 9,995$$

### v) 0,005000

$$\text{a) } 0,005000 \to 0,00 \qquad \text{b) } 0,005000 \to 0,005000$$

> [!note] Diferencia clave con el Ejercicio 4
> En truncamiento no importa el valor del dígito descartado: siempre se corta directo, sin ajustar el último dígito conservado. Por eso en i) e iv) los resultados difieren del redondeo.

---

## Ejercicio 6

**Pregunta:** Calcule el error absoluto y el error relativo en las aproximaciones de $x$ por $x^*$.

### $x = \pi$, $x^* = \dfrac{22}{7}$

$$E_a(\pi) = \left| \pi - \frac{22}{7} \right| = 0,735 \times 10^{-5}$$

$$E_r(\pi) = \frac{E_a(\pi)}{\pi} = 0,234 \times 10^{-5}$$

### $x = \sqrt{2}$, $x^* = 1,414$

$$E_a(\sqrt{2}) = \left| \sqrt{2} - 1,414 \right| = 0,214 \times 10^{-3}$$

$$E_r(\sqrt{2}) = \frac{E_a(\sqrt{2})}{\sqrt{2}} = 0,151 \times 10^{-3}$$

### $x = e^{10}$, $x^* = 22000$

$$E_a(e^{10}) = \left| e^{10} - 22000 \right| = 0,265 \times 10^{2}$$

$$E_r(e^{10}) = \frac{E_a(e^{10})}{e^{10}} = 0,120 \times 10^{-2}$$

### $x = 8!$, $x^* = 39900$

$$E_a(8!) = \left| 8! - 39900 \right| = 0,420 \times 10^{3}$$

$$E_r(8!) = \frac{E_a(8!)}{8!} = 0,104 \times 10^{-1}$$

---

## Ejercicio 7

**Pregunta:** Calcular los errores absoluto y relativo cuando se aproxima el número $e$ por $p^* = 2,718$. ¿Cuántos dígitos exactos tiene la aproximación?

**Respuesta a (error absoluto):**

$$E_a(e) = |e - 2,718| = 0,282 \times 10^{-3}$$

**Respuesta b (error relativo):**

$$E_r(e) = \frac{E_a(e)}{e} = 0,104 \times 10^{-3}$$

**Dígitos exactos:**

$$E_r(e) < 0,5 \times 10^{-k+1} \;\Rightarrow\; k = 4$$

---

## Ejercicio 8

**Pregunta:** ¿Cuántos dígitos deben tomarse en el cálculo de $\sqrt{20}$, de manera que el error no supere 0,1 por ciento?

El error relativo pedido, en forma decimal, es:

$$E_r < 1 \times 10^{-3}$$

Aplicando la cota del error relativo de redondeo:

$$0,5 \times 10^{-k+1} \leq 1 \times 10^{-3} \;\Rightarrow\; k \geq 4$$

$$k = 4$$

(cuatro dígitos exactos)

---

## Ejercicio 9

**Pregunta:** Aplique la aritmética de redondeo a tres dígitos significativos para efectuar los siguientes cálculos. Calcule el error absoluto y relativo con el valor exacto determinado por lo menos a cinco dígitos significativos.

### a) $133 + 0,921$

**Valor real:**

$$133 + 0,921 = 133,921$$

**Resultado en fl (redondeo a 3 dígitos):**

$$fl(133,921) = 0,134 \times 10^{3}$$

**Error absoluto y relativo:**

$$E_a = 0,79 \times 10^{-1} \qquad E_r = 0,593 \times 10^{-3}$$

### b) $(121 - 0,327) - 119$

**Valor real:**

$$(121 - 0,327) - 119 = 1,673$$

**Resultado en fl:**

$$fl(1,673) = 0,167 \times 10^{1}$$

**Error absoluto y relativo:**

$$E_a = 0,3 \times 10^{-2} \qquad E_r = 0,179 \times 10^{-2}$$

### c) $\dfrac{\frac{13}{14} - \frac{6}{7}}{2 \cdot e - 5,4}$

**Valor real:**

$$\frac{\frac{13}{14} - \frac{6}{7}}{2 \cdot e - 5,4} = 1,953540$$

**Resultado en fl:**

$$fl(1,953540) = 0,18 \times 10^{1}$$

**Error absoluto y relativo:**

$$E_a = 0,154 \qquad E_r = 0,788 \times 10^{-1}$$

### d) $\left(\dfrac{2}{9}\right) \cdot \left(\dfrac{9}{7}\right)$

**Valor real:**

$$\left(\frac{2}{9}\right) \cdot \left(\frac{9}{7}\right) = 0,28571$$

**Resultado en fl:**

$$fl(0,28571) = 0,286$$

**Error absoluto y relativo:**

$$E_a = 0,29 \times 10^{-3} \qquad E_r = 0,102 \times 10^{-2}$$

---

## Ejercicio 10

**Pregunta:** Repita el ejercicio 9 utilizando la aritmética de corte (truncamiento) a tres dígitos.

### a) $133 + 0,921$

$$fl(133,921) = 0,133 \times 10^{3}$$

$$E_a = 0,921 \qquad E_r = 0,688 \times 10^{-2}$$

### b) $(121 - 0,327) - 119$

$$fl(1,673) = 0,167 \times 10^{1}$$

$$E_a = 0,3 \times 10^{-2} \qquad E_r = 0,179 \times 10^{-2}$$

### c) $\dfrac{\frac{13}{14} - \frac{6}{7}}{2 \cdot e - 5,4}$

$$fl(1,953540) = 0,355 \times 10^{1}$$

$$E_a = 0,154 \qquad E_r = 0,817$$

### d) $\left(\dfrac{2}{9}\right) \cdot \left(\dfrac{9}{7}\right)$

$$fl(0,28571) = 0,284$$

$$E_a = 0,171 \times 10^{-2} \qquad E_r = 0,599 \times 10^{-2}$$

> [!warning] Comparación con Ejercicio 9
> Notar en c) que la aritmética de corte da un error mucho mayor ($E_r = 0,817$) que la de redondeo ($E_r = 0,788 \times 10^{-1}$), porque en ese cálculo intervienen restas de números cercanos entre sí, y el truncamiento amplifica ese efecto (cancelación catastrófica) más que el redondeo.
---

## Documentos
- [[P1 - Teoria de errores.pdf]]
