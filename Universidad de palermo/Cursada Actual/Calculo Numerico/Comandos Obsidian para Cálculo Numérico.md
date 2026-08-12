Guia de referencia de sintaxis para tomar apuntes de la materia. Obsidian usa MathJax (LaTeX) para matemática y Markdown estándar para el resto.

## 1. Matemática en línea vs bloque

**En línea** (dentro de un párrafo): `$ ... $`

```
El error absoluto se define como $E_a = |x - \hat{x}|$
```

**En bloque** (fórmula centrada, propia línea): `$$ ... $$`

```
$$
x_{n+1} = x_n - \frac{f(x_n)}{f'(x_n)}
$$
```

Regla práctica: si la fórmula es corta y forma parte de una oración, en línea. Si es una fórmula que querés que resalte (definición de método, teorema), en bloque.

## 2. Símbolos y operadores básicos

|Símbolo|Comando|Uso típico|
|---|---|---|
|≈|`\approx`|aproximaciones|
|≠|`\neq`|desigualdad|
|≤ ≥|`\leq` `\geq`|cotas de error|
|±|`\pm`|error absoluto|
|∞|`\infty`|límites, normas|
|→|`\to` o `\rightarrow`|límites, convergencia|
|Δ|`\Delta`|incrementos, diferenciales|
|∂|`\partial`|derivadas parciales|
|∈|`\in`|pertenencia a un intervalo|
|∀|`\forall`|cuantificador|
|∃|`\exists`|cuantificador|

## 3. Fracciones, raíces, potencias

```
\frac{a}{b}              →  fracción
\sqrt{x}                  →  raíz cuadrada
\sqrt[n]{x}               →  raíz n-ésima
x^2, x^{n+1}               →  exponentes (usar llaves si es más de un carácter)
x_1, x_{n+1}                →  subíndices
```

Ejemplo típico de error relativo:

```
$$
E_r = \frac{|x - \hat{x}|}{|x|}
$$
```

## 4. Sumatorias, productorias, límites, integrales

```
\sum_{i=1}^{n} x_i        →  sumatoria
\prod_{i=1}^{n} x_i        →  productoria
\lim_{x \to a} f(x)         →  límite
\int_{a}^{b} f(x)\,dx        →  integral definida
```

Ejemplo (regla del trapecio):

```
$$
\int_{a}^{b} f(x)\,dx \approx \frac{h}{2}\left[f(x_0) + 2\sum_{i=1}^{n-1} f(x_i) + f(x_n)\right]
$$
```

## 5. Matrices y sistemas (clave para Jacobi / Gauss-Seidel)

```
$$
A = \begin{bmatrix}
a_{11} & a_{12} \\
a_{21} & a_{22}
\end{bmatrix}
$$
```

Variantes de delimitador:

- `\begin{bmatrix} ... \end{bmatrix}` → corchetes `[ ]`
- `\begin{pmatrix} ... \end{pmatrix}` → paréntesis `( )`
- `\begin{vmatrix} ... \end{vmatrix}` → barras `| |` (determinante)

Sistema de ecuaciones alineado (útil para mostrar iteraciones):

```
$$
\begin{cases}
2x + y = 5 \\
x - 3y = -1
\end{cases}
$$
```

## 6. Ecuaciones multilínea alineadas

Para mostrar el desarrollo paso a paso de un método (usa `\\` para salto de línea y `&` para alinear en el signo `=`):

```
$$
\begin{aligned}
f(x) &= x^3 - 2x - 5 \\
f'(x) &= 3x^2 - 2 \\
x_1 &= x_0 - \frac{f(x_0)}{f'(x_0)}
\end{aligned}
$$
```

## 7. Texto dentro de fórmulas

Si necesitás escribir una palabra dentro de un bloque matemático (por ejemplo "si converge"), usar `\text{}`:

```
$$
x_{n+1} = g(x_n) \quad \text{si } |g'(x)| < 1 \text{ converge}
$$
```

## 8. Estructura y organización del documento

- `#`, `##`, `###` → encabezados de nivel 1, 2, 3 (tema, subtema, punto específico)
- `---` → línea divisoria entre secciones
- `**negrita**`, `*cursiva*` → resaltar definiciones o términos clave
- `> texto` → cita/callout simple (para observaciones)
- `- [ ] tarea` → checkbox (para marcar ejercicios resueltos)
- `- item` o `1. item` → listas con o sin numeración

### Callouts (cajas destacadas, muy útiles para definiciones y advertencias)

```
> [!note] Definición
> El error de truncamiento aparece por aproximar un proceso infinito con uno finito.

> [!warning] Cuidado
> El método de Newton-Raphson puede no converger si $f'(x_0) \approx 0$.

> [!tip] Truco
> Verificar siempre el signo de $f(a) \cdot f(b)$ antes de aplicar Bisección.
```

Otros tipos de callout disponibles: `[!info]`, `[!example]`, `[!question]`, `[!success]`, `[!failure]`, `[!abstract]`.

## 9. Tablas (para comparar métodos)

```
| Método | Orden de convergencia | Requiere derivada |
|---|---|---|
| Bisección | Lineal | No |
| Newton-Raphson | Cuadrático | Sí |
| Punto Fijo | Lineal | No |
```

## 10. Código y pseudocódigo

Para pseudocódigo de algoritmos iterativos, usar bloque de código (no matemático, texto plano):

````
```
mientras |f(x)| > tolerancia:
    x = x - f(x)/f'(x)
```
````

## 11. Diagramas de flujo (Mermaid)

Para representar el algoritmo de un método:

````
```mermaid
flowchart TD
    A[Inicio: x0, tolerancia] --> B[Calcular f(x0), f'(x0)]
    B --> C[x1 = x0 - f(x0)/f'(x0)]
    C --> D{"|x1 - x0| < tolerancia?"}
    D -->|No| E[x0 = x1]
    E --> B
    D -->|Sí| F[Fin: raíz aproximada = x1]
```
````

## 12. Enlaces internos y tags

- `[[Nombre de otra nota]]` → enlaza notas entre sí (ej: conectar "Newton-Raphson" con "Convergencia de métodos")
- `[[Nota#Encabezado]]` → enlaza a una sección específica
- `#tag` → etiquetas para filtrar (ej: `#metodos-iterativos`, `#ecuaciones-no-lineales`, `#interpolacion`)

## 13. Resumen rápido: símbolos más usados en la materia

|Tema|Símbolos frecuentes|
|---|---|
|Errores|`\approx`, `\pm`, `E_a`, `E_r`, `\Delta`|
|Ecuaciones no lineales|`f(x)`, `f'(x)`, `x_{n+1}`, `\to`, `\leq`|
|Sistemas lineales|`\begin{bmatrix}`, `\begin{cases}`, matrices|
|Interpolación|`P_n(x)`, `\sum`, `\prod`, subíndices `x_i, y_i`|
|Mínimos cuadrados|`\sum_{i=1}^{n}`, potencias, exponenciales `e^x`|
|Integración numérica|`\int_{a}^{b}`, `\frac{h}{2}`, sumatorias|

---