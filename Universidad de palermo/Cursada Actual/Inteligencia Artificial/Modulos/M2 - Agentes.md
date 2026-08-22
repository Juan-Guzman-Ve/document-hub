---
tags:
  - materia/inteligencia-artificial
  - modulo/m2
  - tipo/teoria
materia: Inteligencia Artificial
modulo: M2 - Agentes Inteligentes
tipo: teoria
fuente: "Russell, S. J. (2009). Inteligencia artificial: un enfoque moderno (3ª ed.)"
descripcion: Agentes inteligentes — definicion (sensores + efectores), agentes naturales vs artificiales, racionalidad y sus 4 factores, 5 tipos de agentes (reactivo simple, basado en modelo, objetivos, utilidad, aprendizaje), y propiedades de los ambientes.
conceptos_clave:
  - agente
  - racionalidad
  - sensores
  - efectores
  - agente reactivo
  - funcion de utilidad
  - ambiente accesible
  - ambiente deterministico
relacionados:
  - "[[M1 - Intro a la IA]]"
---

# Módulo 2 - Agentes Inteligentes

## Definición de agente

Un **agente** es todo aquello que puede considerarse que percibe su ambiente mediante **sensores** y que responde o actúa en ese ambiente por medio de **efectores**.

```
entorno --percepts--> [sensores] AGENTE [efectores] --actions--> entorno
```

Un agente también puede definirse como un sistema hardware o software que es:
- **Autónomo**
- **Interactivo** con su entorno y con otros agentes
- **Reactivo** a su entorno
- **Pro-activo**, al tomar la iniciativa en un comportamiento dirigido hacia objetivos

Existen diferentes clases de agentes en función de su comportamiento en distintos entornos operativos, definidos por:
- Las tareas que el agente debe realizar
- Los recursos de que dispone para realizar tareas
- Las condiciones de contexto que pueden influenciar su funcionamiento
- Los criterios de evaluación que debe satisfacer

### Principios de adaptación de un agente

Un agente debe adaptar:
- Sus mecanismos y estrategias de percepción a los requerimientos dinámicos de información y recursos disponibles
- Su modo de control a restricciones dinámicas basadas en objetivos y a la incertidumbre del entorno
- Su elección entre varias tareas posibles de razonamiento a objetivos dinámicos locales y globales
- Sus métodos de razonamiento a la información disponible
- Su estrategia de meta-control a configuraciones dinámicas de demandas, oportunidades y recursos

---

## Agentes naturales vs. artificiales

### Agentes naturales
| Elemento | Descripción |
|---|---|
| Agente | Cuerpo biológico |
| Entorno | Naturaleza |
| Sensores | Ojos, oídos, lengua, piel, etc. |
| Efectores | Piernas, brazos, manos, etc. |
| Medida de rendimiento | Sobrevivir, reproducirse |

### Agentes artificiales

**Agentes hardware (robots)**
- Interactúan directamente con un entorno físico
- Disponen de un "cuerpo" físico
- Sensores: cámaras, telémetros infrarrojos, etc.
- Efectores: ruedas/piernas, manipuladores, etc.

**Agentes software (softbots)**
- Actúan en entornos virtuales (por ejemplo, Internet)
- Todo software: no necesitan manipular físicamente el entorno
- Sensores y efectores dependientes del entorno

---

## Racionalidad

**Agente racional**: el que percibe y actúa para cumplir con sus objetivos en base a sus creencias de lo que es correcto.

La racionalidad de un agente depende de cuatro factores:
1. **La medida del rendimiento** - define el grado de éxito del agente en el cumplimiento de sus objetivos
2. **La secuencia de percepciones** - todo lo que ha percibido el agente hasta ese momento
3. **El conocimiento del medio** - todo el conocimiento acumulado sobre el medio en que habita
4. **Las acciones que el agente puede ejecutar**

### Comportamiento racional
1. El que se realiza a partir de la secuencia de percepciones hasta el momento y el conocimiento a priori sobre el entorno
2. El que elige, entre las capacidades disponibles, la acción que maximiza la medida de rendimiento

> [!note] Conceptos clave a distinguir
> - **Autonomía**: cuanto más se rige el comportamiento del agente por su propia experiencia y cuanto menos depende de sus conocimientos a priori
> - **Aprendizaje**: cuando el agente no solo recopila información, sino que aprende de lo que percibe

---

## Clasificación de agentes inteligentes

Existen **5 categorías principales**, de menor a mayor complejidad:

### 1. Agentes reactivos simples
- Actúan solo sobre la base de la **percepción actual**, ignorando el historial de percepción
- Se basan en reglas de condición-acción: "si es condición, entonces acción"
- Solo tienen éxito cuando el entorno es **completamente observable**
- Pueden caer en **bucles infinitos** en entornos parcialmente observables

### 2. Agentes reactivos basados en modelo
- Pueden manejar entornos **parcialmente observables**
- Mantienen un **modelo del mundo**: una estructura interna que describe la parte del entorno que no se puede observar directamente
- Este modelo depende del historial de percepción y refleja aspectos no observados del estado actual
- También pueden usar modelos para predecir el comportamiento de otros agentes

### 3. Agentes basados en objetivos
- Amplían las capacidades de los agentes basados en modelo mediante información de **"objetivos"**
- La información del objetivo describe situaciones deseables
- Permiten elegir entre múltiples posibilidades, seleccionando la que alcanza el estado objetivo
- La **búsqueda** y la **planificación** son los subcampos de la IA dedicados a encontrar secuencias de acción que logren los objetivos del agente

### 4. Agentes basados en utilidad
- Los agentes basados en objetivos solo distinguen entre estados objetivo y estados no objetivo; los basados en utilidad van más allá
- Usan una **función de utilidad** que asigna a cada estado una medida de cuán deseable (o "feliz") es para el agente
- El agente racional basado en utilidad elige la acción que **maximiza la utilidad esperada** de los resultados, considerando probabilidades y utilidades de cada resultado posible
- Requieren modelar y hacer seguimiento del entorno: implican investigación en percepción, representación, razonamiento y aprendizaje

### 5. Agentes que aprenden
- El aprendizaje permite operar inicialmente en entornos desconocidos y volverse más competente de lo que el conocimiento inicial permitiría
- Componentes principales:
  - **Elemento de rendimiento**: es el agente "completo" tal como se consideraba antes; toma percepciones y decide acciones
  - **Elemento de aprendizaje**: responsable de realizar mejoras, usando la retroalimentación del "crítico"
  - **Crítico**: da retroalimentación sobre cómo le está yendo al agente respecto de un estándar de rendimiento
  - **Generador de problemas**: sugiere acciones que conduzcan a experiencias nuevas e informativas

> [!tip] Para recordar el orden de complejidad creciente
> Reactivo simple -> Reactivo basado en modelo -> Basado en objetivos -> Basado en utilidad -> Que aprende

---

## Ambientes

Un sistema de IA está compuesto por un **agente** y su **entorno o ambiente**. Los agentes actúan en su entorno, y el ambiente puede contener otros agentes.

### Propiedades de los ambientes

| Propiedad | Descripción |
|---|---|
| Accesible / Inaccesible | Accesible: los sensores dan toda la información necesaria sobre el estado completo del ambiente para elegir una acción. Libera al agente de mantener un inventario interno del mundo. |
| Determinístico / No-determinístico (estocástico) | Determinístico: el estado siguiente queda determinado plenamente por el estado presente y la acción del agente. El agente escapa de la incertidumbre. |
| Episódico / No-episódico | No-episódico: los episodios siguientes no dependen de las acciones ocurridas en episodios previos (similar a cadenas de Markov). El agente no necesita planificar a futuro. |
| Estático / Dinámico | Estático: el ambiente no cambia mientras el agente piensa. El tiempo de cómputo no tiene costo. |
| Discreto / Continuo | Discreto: número escaso de percepciones y acciones posibles. Continuo: el caso contrario. |
| Sin adversario / Con adversarios racionales | Sin adversario: no hay otros agentes racionales adversarios, por lo que el agente no debe preocuparse por su estrategia. Ambientes ingenieriles suelen ser sin adversario; los sociales y económicos (ej. la Bolsa) suelen tenerlos. |

> [!warning] Ambientes más difíciles para un agente
> Los ambientes **inaccesibles, no-determinísticos, no-episódicos, dinámicos y continuos** son los más difíciles de manejar para un agente inteligente.

---

## Conexión con Módulo 1

- El concepto de **sistema inteligente** visto en [[M1 - Introduccion a la IA]] (objetivo principal, sentidos, efectores) es la base directa sobre la que se construye la definición de **agente** en este módulo.
- La noción de **racionalidad** aquí desarrollada complementa las definiciones formales de IA (Minsky, Nilsson, Buchanan y Feigenbaum, Rich) revisadas en el Módulo 1.

---

## Bibliografía

Russell, S. J. (2009). *Inteligencia artificial: un enfoque moderno* (3ª ed.). México: Prentice Hall Hispanoamericana.
---

## Documentos
- [[M2 - Agentes Inteligentes.pdf]]
