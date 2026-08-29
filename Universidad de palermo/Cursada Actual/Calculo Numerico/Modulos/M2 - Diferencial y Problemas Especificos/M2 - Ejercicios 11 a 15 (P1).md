---
tags:
  - materia/calculo-numerico
  - modulo/m2
  - tipo/ejercicios
materia: Calculo Numerico
modulo: M2 - Diferencial y Problemas Especificos
tipo: ejercicios
descripcion: Practico N1 resuelto (ejercicios 11-15) — propagacion de errores mediante diferencial en volumen de esfera y cubo, area de circulo con dos variables, y propagacion en operaciones combinadas (suma, producto, cociente, potencia) con cotas de error dadas.
conceptos_clave:
  - diferencial
  - error absoluto
  - error relativo
  - propagacion de errores
  - derivada parcial
relacionados:
  - "[[M1 - Teoria de errores]]"
  - "[[M1 - Ejercicios]]"
  - "[[M2 - Aplicacion del Diferencial al Calculo de Errores]]"
---

> [!note] Sobre esta resolucion
> El documento original solo trae las respuestas finales ("Rta:"), no las resoluciones paso a paso. Fueron reconstruidas aplicando el metodo del diferencial, y en la mayoria el resultado coincide exacto con el del apunte. En dos casos (11 y parcialmente 14) hay una pequena discrepancia con el error relativo que figura en la respuesta oficial — se marca explicitamente para no memorizar un numero mal.

---

## Ejercicio 11

**Enunciado:** Plantee el ejemplo 12 utilizando diferenciales. Considere $x = 4,71 \pm 0,01$.

**Resolución:**

Dado que el valor $x=4,71$ coincide con el usado en el Ejemplo 13 ($f(x)=x^3-6,1x^2+3,2x+1,5$), se aplica el diferencial a esa función:

$$f'(x) = 3x^2 - 12,2x + 3,2$$

Evaluando en $x=4,71$:

$$f'(4,71) = 3(4,71)^2 - 12,2(4,71) + 3,2 = 66,5523 - 57,462 + 3,2 = 12,2903$$

Error absoluto (diferencial):

$$E_a = |f'(4,71)| \cdot \Delta x = 12,2903 \times 0,01 = 0,123$$

Error relativo:

$$E_r = \frac{E_a}{|f(4,71)|} = \frac{0,123}{14,263899} \approx 0,0086$$

**Rta oficial:** $E_a = 0,123$ (coincide) — $E_r = 0,0068$ (el apunte da este valor; mi cálculo directo da $\approx 0,0086$; la diferencia probablemente viene de qué valor de $f(4,71)$ usaron como referencia. Te dejo ambos para que lo cheques con la cátedra si te genera dudas).

---

## Ejercicio 12

**Enunciado:** Halle el error relativo cometido al hallar el volumen de una esfera de 10 m de radio, si esta medida viene afectada por un error absoluto de 0,2 m. Exprésolo con dos dígitos significativos.

**Resolución:**

$$V = \frac{4}{3}\pi r^3 \qquad \frac{dV}{dr} = 4\pi r^2$$

Error absoluto:

$$E_a = 4\pi r^2 \cdot \Delta r = 4\pi (10)^2 (0,2) = 251,33 \ m^3$$

Volumen exacto:

$$V(10) = \frac{4}{3}\pi (10)^3 = 4188,79 \ m^3$$

Error relativo:

$$E_r = \frac{E_a}{V} = \frac{4\pi r^2 \Delta r}{\frac{4}{3}\pi r^3} = \frac{3\Delta r}{r} = \frac{3(0,2)}{10} = 0,06$$

**Rta oficial:** $E_r = 0,061$ (mi cálculo analítico da exactamente $0,06$; la diferencia es de redondeo mínimo, prácticamente el mismo resultado).

---

## Ejercicio 13

**Enunciado:** Halle los errores absoluto y relativo, cometidos al hallar el volumen de un cubo de 5 m de arista, si esta medida viene afectada por un error absoluto de 0,1 m.

**Resolución:**

$$V = a^3 \qquad \frac{dV}{da} = 3a^2$$

$$E_a = 3a^2 \cdot \Delta a = 3(5)^2(0,1) = 3(25)(0,1) = 7,5 \ m^3$$

$$V(5) = 5^3 = 125 \ m^3$$

$$E_r = \frac{E_a}{V} = \frac{7,5}{125} = 0,06$$

**Rta:** $E_a = 7,5\ m^3 \qquad E_r = 0,06$ — coincide exacto con el apunte.

---

## Ejercicio 14

**Enunciado:** Al hallar el área de un círculo de radio $r=12,62,m$ se han aproximado $\pi$ por $3,14$ y $r$ por $12,6$. ¿Cuál es el error relativo cometido?

**Resolución:**

$$A = \pi r^2$$

Se trata de una función de dos variables ($\pi$ y $r$), por lo que:

$$dA = \frac{\partial A}{\partial \pi}\Delta\pi + \frac{\partial A}{\partial r}\Delta r = r^2 \cdot \Delta\pi + 2\pi r \cdot \Delta r$$

Con $\Delta\pi = |3,14159\ldots - 3,14| \approx 0,0016$ y $\Delta r = |12,62-12,6| = 0,02$:

$$E_a = (12,62)^2 (0,0016) + 2\pi(12,62)(0,02)$$ $$E_a = (159,2644)(0,0016) + (79,285)(0,02) = 0,2548 + 1,5857 = 1,84 \ m^2$$

Área exacta:

$$A_{exacto} = \pi (12,62)^2 = 500,34 \ m^2$$

Error relativo:

$$E_r = \frac{E_a}{A_{exacto}} = \frac{1,84}{500,34} \approx 0,0037$$

**Rta oficial:** $E_a = 1,9\ m^2 \qquad E_r = 0,0038$ (mis valores, $1,84$ y $0,0037$, redondean prácticamente a lo mismo; la mínima diferencia viene de cuántos decimales de $\pi$ se usan para $\Delta\pi$).

---

## Ejercicio 15

**Enunciado:** Sea $a = 100 \pm 1$; $b = 2000 \pm 40$; $c = 2500 \pm 50$. Hallar una cota del error absoluto y relativo propagado al hacer las siguientes operaciones:

**Resolución (todas coinciden exactas con el apunte):**

### a) $x = a - b + c$

$$\frac{\partial x}{\partial a}=1,\quad \frac{\partial x}{\partial b}=-1,\quad \frac{\partial x}{\partial c}=1$$ $$E_a(x) = |1|\Delta a + |-1|\Delta b + |1|\Delta c = 1 + 40 + 50 = 91$$ $$x = 100 - 2000 + 2500 = 600 \qquad E_r(x) = \frac{91}{600} = 0,15$$

### b) $y = b \cdot c$

$$\frac{\partial y}{\partial b}=c,\quad \frac{\partial y}{\partial c}=b$$ $$E_a(y) = c\cdot\Delta b + b\cdot\Delta c = 2500(40) + 2000(50) = 100000+100000=200000$$ $$y = 2000\times2500 = 5.000.000 \qquad E_r(y) = \frac{200000}{5000000} = 0,04$$

### c) $z = \dfrac{c}{b}$

$$\frac{\partial z}{\partial c}=\frac{1}{b},\quad \frac{\partial z}{\partial b}=-\frac{c}{b^2}$$ $$E_a(z) = \frac{1}{b}\Delta c + \frac{c}{b^2}\Delta b = \frac{50}{2000} + \frac{2500}{4.000.000}(40) = 0,025+0,025=0,05$$ $$z = \frac{2500}{2000}=1,25 \qquad E_r(z) = \frac{0,05}{1,25}=0,04$$

### d) $w = \dfrac{a \cdot c}{b}$

$$\frac{\partial w}{\partial a}=\frac{c}{b},\quad \frac{\partial w}{\partial c}=\frac{a}{b},\quad \frac{\partial w}{\partial b}=-\frac{a\cdot c}{b^2}$$ $$E_a(w) = \frac{c}{b}\Delta a + \frac{a}{b}\Delta c + \frac{a\cdot c}{b^2}\Delta b = 1,25(1)+0,05(50)+0,0625(40)$$ $$E_a(w) = 1,25+2,5+2,5 = 6,25$$ $$w = \frac{100\times2500}{2000}=125 \qquad E_r(w) = \frac{6,25}{125}=0,05$$

### e) $t = b^3$

$$\frac{dt}{db}=3b^2 = 3(2000)^2 = 12.000.000$$ $$E_a(t) = 12.000.000 \times 40 = 480.000.000 = 0,48\times10^9$$ $$t = 2000^3 = 8\times10^9 \qquad E_r(t) = \frac{0,48\times10^9}{8\times10^9}=0,06$$

---

¿Querés que arme ahora el archivo `.md` con todo esto (enunciados + resoluciones) para pegarlo en Obsidian?