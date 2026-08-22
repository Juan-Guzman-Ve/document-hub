---
tags:
  - materia/inteligencia-artificial
  - modulo/m1
  - tipo/teoria
materia: Inteligencia Artificial
modulo: M1 - Introduccion a la IA
tipo: teoria
descripcion: Origenes historicos de la IA (1943-2020s), definiciones formales (Minsky, Nilsson, Buchanan, Rich), sistemas inteligentes y su ciclo interno, Test de Turing y sus requisitos, representacion formal de problemas mediante espacio de estados, operadores y tipos de busqueda.
conceptos_clave:
  - neurona formal McCulloch-Pitts
  - Test de Turing
  - sistema inteligente
  - espacio de estados
  - operadores
  - Sistemas Expertos
  - Conferencia Dartmouth
relacionados:
  - "[[M2 - Agentes]]"
---

> [!info] Resumen Este módulo cubre los orígenes históricos de la IA, sus definiciones formales, el concepto de "sistema inteligente", el Test de Turing y la representación formal de problemas (espacio de estados, operadores, soluciones).

---

## 1. Orígenes históricos

- **1943** — McCulloch & Pitts definen la **neurona formal**: un dispositivo binario con varias entradas y salidas. Se considera el punto de partida conceptual de la IA.
- **1950** — Alan Turing publica _"Computing Machinery and Intelligence"_ en la revista _Mind_, donde plantea el **Test de Turing** como criterio para evaluar si una máquina se comporta de forma inteligente.
- **1956** — **Conferencia de Dartmouth** (Hanover, EE.UU.), organizada por John McCarthy en el MIT. Participan McCarthy, Marvin Minsky, Nathaniel Rochester y Claude E. Shannon. Se establece la IA como campo independiente dentro de la informática.
- **Años 60** — Pocos avances: la tecnología requería mucha inversión y estaba concentrada en grandes centros de investigación.
- **Años 70-80** — Auge de los **Sistemas Expertos**, con lenguajes como **PROLOG** y **LISP**.
- **Actualidad** — Avances en:
    - Visión por computadora
    - Control robótico autónomo (ej. robots de Sony que caminan e imitan el movimiento humano)
    - Lógica difusa (ej. tracking automático de video)
    - La IA sigue, en general, **limitada a dominios tecnológicos específicos**.

> [!note] Idea central La IA busca crear una máquina secuencial programada capaz de repetir indefinidamente un conjunto de instrucciones generadas por un humano.

---

## 2. Definiciones de Inteligencia Artificial

**RAE — Inteligencia:** potencia intelectual; facultad de conocer, entender o comprender.

|Autor|Definición (idea clave)|
|---|---|
|**Marvin Minsky**|Ciencia de construir máquinas que hacen tareas que, hechas por humanos, requerirían inteligencia.|
|**N. Nilsson**|Se enfoca en los procesos comunes que combinan percepción y conocimiento, estudiables científicamente.|
|**Buchanan & Feigenbaum**|Rama de la informática centrada en procesos simbólicos, razonamiento no algorítmico y representación simbólica del conocimiento.|
|**Elaine Rich**|Estudio de cómo lograr que las computadoras hagan cosas que, por ahora, los humanos hacen mejor.|

> [!tip] Concepto clave Un **sistema inteligente** actúa apropiadamente en entornos con incertidumbre: una acción es "adecuada" cuando aumenta la probabilidad de éxito, entendiendo el éxito como el logro de subobjetivos que sostienen el objetivo final del sistema.

---

## 3. Sistemas inteligentes

### 3.1 Conceptos base

- **Inteligencia**: capacidad de alcanzar objetivos. Un sistema es más inteligente cuanto más rápido y fácil los logra. Incluye la capacidad de **aprender**.
- **Sistema**: parte del universo con extensión limitada en espacio y tiempo, donde hay más correlación interna que con el exterior.
- **Sistema inteligente**: tiene un objetivo propio, sentidos y efectores. Elige acciones según su experiencia y puede generalizar lo aprendido.
    - Ejemplos: personas, animales superiores, robots, empresas, naciones.
- **Sistema inteligente artificial**: programa de computación que implementa las funciones anteriores.

### 3.2 Funcionamiento interno (ciclo del sistema inteligente)

1. **Objetivo temporal** derivado del objetivo principal.
2. **Percepción del entorno** mediante sentidos limitados (ej. luz, sonido) — no perciben el objeto en sí, solo señales de él.
3. **Almacenamiento** de impresiones sensoriales como **conceptos elementales**.
4. **Creación de nuevos conceptos** y relaciones (totales, parciales, abstractas, concretas).
5. **Control de la información entrante** antes de procesar.
6. **Definición de la situación actual** en base a los conceptos recibidos.
7. **Búsqueda de reglas de actuación** aplicables en la memoria → elección de la mejor → ejecución de la acción.
8. **Almacenamiento continuo** de la relación situación-acción como nueva regla de actuación.
9. **"Descanso" del sistema** (inactividad externa): revisión y generalización de reglas → creación de abstracciones.
10. **Comparación** entre reglas recientes y antiguas para generar reglas más generales aplicables a varias situaciones similares.
11. **Olvido**: cuando la memoria se llena, se descartan los conceptos y reglas menos usados.

> [!important] Distinción clave Hay una diferencia entre:
> 
> - el **objeto/hecho** real del entorno,
> - el **concepto** interno que el sistema usa para procesarlo,
> - y la **palabra** que usa para comunicarlo.

---

## 4. Test de Turing

### Procedimiento

1. Participan **dos personas + una computadora**: un interrogador y dos "identificados" (persona + máquina).
2. Cada participante está en un **cuarto separado**.
3. La comunicación es **escrita**, sin contacto visual.
4. Si tras varias preguntas el interrogador **no puede distinguir** quién es la máquina y quién la persona, se dice que la computadora **"piensa"** como un humano en esa tarea.

### Capacidades que debería tener la computadora

- Procesar lenguaje natural
- Representar el conocimiento
- Razonar automáticamente
- Autoaprendizaje (machine learning)

### Tareas para caracterizar sistemas inteligentes

- a) Reconocerlos y diferenciarlos de sistemas convencionales
- b) Clarificar el rol de la inteligencia en ellos
- c) Identificar problemas donde la IA es la única o mejor solución

---

## 5. Representación formal de problemas

### 5.1 Elementos que definen un problema

1. **Punto de partida** — características iniciales del problema.
2. **Objetivo** — qué se quiere lograr.
3. **Acciones disponibles** — herramientas para manipular el problema.
4. **Restricciones** — condiciones que debe cumplir la solución.
5. **Elementos relevantes del dominio** — conocimiento específico útil para resolverlo eficientemente.

### 5.2 Tipos de aproximación

|Aproximación|Descripción|
|---|---|
|**Espacio de estados**|La más general. El problema se descompone en pasos que conectan el estado inicial con el estado solución.|
|**Reducción a subproblemas**|Descomposición recursiva del problema global en problemas más simples.|
|**Satisfacción de restricciones**|El problema se modela como variables que deben cumplir ciertas restricciones.|
|**Juegos**|El problema se plantea como competencia entre dos o más agentes.|

> [!note] El **espacio de estados** de un juego es un **grafo**: los nodos son configuraciones alcanzables (estados válidos) y los arcos son las transiciones (movidas posibles). Es teóricamente construible desde el estado inicial, pero en la práctica suele ser demasiado grande para explicitarlo completo.

### 5.3 Representación de estados

- Un **estado** describe una situación posible del problema.
- Se basa en **abstracción de propiedades** relevantes (información suficiente y necesaria, ni de más ni de menos).
- La forma de representar los estados **influye directamente** en la cantidad de estados posibles y en la eficiencia de la búsqueda de soluciones.

### 5.4 Operadores

- Conjunto **finito de acciones básicas** que transforman un estado en otro.
- Se definen por:
    - **Precondición** (cuándo son aplicables)
    - **Postcondición** (estado resultante)
- Criterio de selección: depende de la representación elegida; se prefieren representaciones con **menor cantidad de operadores**.

### 5.5 Estado inicial y estados finales

- **Estado inicial**: describe la situación de partida.
- **Estados finales**: describen el objetivo. Puede ser un conjunto de estados o, a veces, uno solo.

### 5.6 Solución de un problema

- Secuencia de **acciones** (u **operadores**) que, aplicada desde el estado inicial, lleva a un estado final.

### 5.7 Tipos de problemas de búsqueda

- Determinar si existe solución (y hallar un estado final)
- Buscar **una** solución
- Buscar cualquier solución **lo más rápido posible**
- Buscar **todas** las soluciones
- Buscar la solución **más corta**
- Buscar la solución **menos costosa**

---

## Ideas para conectar con otras notas

- `[[Búsqueda en espacio de estados]]`
- `[[Sistemas Expertos]]`
- `[[Algoritmos de búsqueda - BFS DFS A*]]`
- `[[Historia de la IA - línea de tiempo]]`

---

## Bibliografía

- Russell, S. J. (2009). _Inteligencia artificial: un enfoque moderno_ (3ª ed.). México: Prentice Hall Hispanoamericana.

---

_Nota generada a partir del material del Módulo 1 (Universidad de Palermo) — organizada y resumida para estudio personal._
---

## Documentos
- [[M1 - Introduccion a la IA.pdf]]
