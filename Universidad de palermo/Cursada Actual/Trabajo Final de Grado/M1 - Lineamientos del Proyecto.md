---
tags:
  - materia/trabajo-final-grado
  - modulo/m1
  - tipo/guia
materia: Trabajo Final de Grado
modulo: M1 - Introduccion al TFG
tipo: guia
descripcion: Lineamientos del TFG — 4 etapas del proyecto (Idea, Referencias, Esqueleto, Intro/Conclusion/Abstract), formato LaTeX, criterios bibliograficos (10-15 iniciales, 20+ finales), diferencias entre paper/ensayo/informe/tesina, y uso estrategico de IA como asistente en cada etapa.
conceptos_clave:
  - paper cientifico
  - LaTeX
  - BibTeX
  - bibliografia
  - uso de IA en investigacion
  - metodologia de investigacion
relacionados: []
---

# Módulo 1 - Investigación y Uso de IA

## Presentación del curso

El objetivo de la materia es investigar. Para aprobar la cursada es necesario entregar un **paper científico aprobado por el profesor**, a lo largo de 17 semanas con 4 entregas obligatorias. El avance a la siguiente entrega requiere la aprobación de la anterior (puede requerir más de una versión).

> [!important]
> A partir de la aprobación de la idea, todas las entregas se redactan en LaTeX (genera el PDF a entregar). Cada versión debe nombrarse con el formato: `tema_apellido_nombre_vN.pdf`

- Contacto más rápido con el profesor: mensajería instantánea (Pronto)
- Devoluciones pueden requerir encuentro sincrónico
- Comunicaciones formales: Blackboard

### Las 4 etapas del proyecto

```
Idea → Referencias Bibliográficas → Esqueleto → Introducción, Conclusión y Abstract
```

#### Etapa 1: Idea
- Se presenta y discute en un foro específico hasta obtener aprobación del profesor
- Una vez aprobada, se crea el primer borrador en LaTeX con sección "Idea" (un párrafo inicial)
- Se prepara además un cronograma con riesgos y recursos

> [!note] Consejos para encontrar una idea
> - No se desarrolla una app o prototipo; enfocar el esfuerzo en la parte original, no en la implementación
> - La idea debe ser original en el sentido de "nueva", no "revolucionaria"
> - La idea es el punto de partida, no la conclusión: puede cambiar durante la investigación
> - Elegir un tema que realmente guste (se trabaja 17 semanas sobre él)
> - Verificar en Google Scholar / Google si el problema ya fue resuelto

#### Etapa 2: Referencias bibliográficas
- Encontrar entre **10 y 15 referencias**, crear sección "Investigación bibliográfica" con breve descripción de cada una
- Al finalizar el proyecto se requieren **mínimo 20 referencias**
- El comando `\bibliography{mibibliografia}` carga el archivo `.bib`
- BibTeX se obtiene desde Google Scholar (ícono de comillas → "Bibtex")
- Formatos comunes: `@Misc`, `@book`, `@article`, `@online`
- Wikipedia no es fuente fiable, pero sirve como punto de partida (revisar sus referencias)
- Solo se aceptan referencias efectivamente citadas en el texto

#### Etapa 3: Esqueleto
- Las secciones "Idea" e "Investigación bibliográfica" desaparecen; su contenido pasa temporalmente a "Introducción"
- Aprobado el esqueleto, se completan las secciones **excepto** abstract, introducción y conclusión
- Se describe la problemática, las herramientas teóricas del valor agregado, y se prepara la prueba de concepto

#### Etapa 4: Introducción, conclusión y resumen
| Sección | Función | Extensión | Referencias |
|---|---|---|---|
| Resumen (Abstract) | Define si el tema interesa al lector | 2 párrafos (motivación + idea) | No se citan |
| Introducción | Detalla motivación, antecedentes e idea | Mínimo media página | Casi todas las del paper (mín. 20) |
| Resultados | Análisis de los resultados obtenidos | - | - |
| Conclusión | Informa si los resultados fueron positivos/negativos, obstáculos y trabajo futuro | Sin extensión definida | - |

### Condiciones generales
- El tema debe corresponder a las áreas preacordadas con el docente y **no puede modificarse** una vez aprobado
- El trabajo debe tener valor agregado y solidez, siguiendo el formato preestablecido por la cátedra
- Defensa oral: 15 minutos de exposición + 5 minutos para la prueba de concepto, sin interrupciones

---

## Diferencias entre paper, ensayo, informe y tesina

| Tipo | Características | Estructura típica |
|---|---|---|
| **Paper** | Redacción científica clara y sintética, para publicación de investigación técnica; incluye citas y referencias | Abstract, Introducción, Marco teórico, Desarrollo, Conclusión |
| **Ensayo** | Interpretación o reflexión subjetiva; estructura flexible, se apoya en la organización lógica de ideas | Sin estructura fija |
| **Informe** | Describe cualidades de un hecho y eventos relacionados; puede ser expositivo, analítico o persuasivo | Portada, Índice, Introducción, Cuerpo, Conclusiones, Bibliografía |
| **Tesina** | Investigación de una problemática concreta ligada a la experiencia profesional; requiere coherencia teórica y metodológica; tiene componente de originalidad pero no busca ser tan original como una tesis doctoral | No muy extensa |

### Pasos para un proyecto de investigación exitoso
1. Elección de un tema
2. Revisión de antecedentes
3. Selección, análisis y definición del problema
4. Marco teórico o conceptual
5. Formulación de preguntas y definición de la investigación
6. Metodología y técnicas de investigación

### Criterios para una buena idea
- Debe resultar atractiva (motiva al investigador)
- No necesita ser nueva, pero sí novedosa para el contexto/cultura donde se aplique
- Debe servir para resolver problemas o elaborar teorías

### Líneas temáticas sugeridas
IoT, Business Intelligence, Inteligencia Artificial, Arquitectura de software, Blockchain & Criptografía.

> [!note] Ejemplos de buenas ideas (premiadas)
> - Recetas médicas digitales con blockchain y smart contracts
> - Monitoreo de lactantes para prevención de muerte súbita
> - Remera inteligente para prevención de ahogamiento (Premio Santander)

> [!warning] Ejemplos de malas ideas
> - Software clasificador de perfilación criminal: idea confusa (¿asiste al detective o predice criminales?), con problemas éticos y jurídicos graves
> - App de trabajos temporales: sin innovación tecnológica real (clon de Uber/Airbnb/Tinder sin algoritmo de matching diferenciador)

---

## Uso estratégico de la IA en el TFG

> [!important]
> La IA debe usarse como **asistente, no como sustituto** del esfuerzo cognitivo del estudiante. El valor agregado se demuestra en la curación, el análisis crítico, la síntesis y la aplicación práctica.

### Manifestación del valor agregado del estudiante
1. **Formulación y refinamiento de prompts**: la calidad del resultado depende de la precisión y contextualización de la instrucción
2. **Validación y curación de contenido**: verificar sistemáticamente datos y referencias (riesgo de alucinaciones o sesgos)
3. **Análisis, interpretación y discusión crítica**: transformar los datos de la IA con perspectiva y juicio propio (epicentro del valor agregado)
4. **Reflexión metacognitiva y ética**: declarar explícitamente qué herramienta se usó, para qué y cómo se integró el resultado

### Usos de IA por etapa del TFG

| Etapa | Posibles usos | Herramientas comunes | Riesgos |
|---|---|---|---|
| Elección del tema | Generar ideas, revisar tendencias | ChatGPT, Perplexity | Temas poco originales |
| Búsqueda bibliográfica | Resumir artículos, localizar fuentes | Elicit, Semantic Scholar AI | Fuentes no verificadas |
| Redacción y estilo | Revisión ortográfica, reescritura | Grammarly, DeepL Write | Pérdida de voz personal |
| Análisis de datos | Procesamiento y estadística | Python con IA, ChatGPT Code Interpreter | Interpretación errónea |
| Presentación final | Diseño de diapositivas | Canva AI, PowerPoint Designer | Falta de originalidad |

### Ventajas y riesgos

```
Ventajas: eficiencia, aprendizaje guiado, accesibilidad, mejora de calidad textual, estimulación de creatividad
Riesgos: plagio/autoría, dependencia tecnológica, falta de transparencia, alucinaciones, desigualdad de acceso
```

### Recomendaciones para el estudiante
1. Utilizar la IA como guía, no como autor
2. Contrastar siempre la información generada
3. Ser transparente sobre su uso en el trabajo
4. Conservar versiones intermedias de los textos como prueba de autoría
5. Consultar al tutor o la normativa del centro antes de usar herramientas avanzadas
---

## Documentos
- [[M1 - Diferencias entre diferentes recursos de investigacion.pdf]]
- [[M1 - Presentacion.pdf]]
- [[M1 - Uso de la IA para investigaciones.pdf]]
