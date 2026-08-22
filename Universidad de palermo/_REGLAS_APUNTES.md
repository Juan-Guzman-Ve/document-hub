---
tags:
  - referencia
  - universidad-de-palermo
tipo: referencia
descripcion: Reglas a seguir para crear un nuevo apunte en cualquier materia de la Cursada Actual a partir de un documento fuente (PDF/slides), cubriendo estructura de carpetas, naming, frontmatter, indices y estilo de contenido.
---

# Reglas para agregar un nuevo apunte

Estas reglas aplican a cualquier materia dentro de `Cursada Actual`. El objetivo es que un apunte nuevo, creado a partir de un documento fuente (PDF de clase, slides, etc.), sea indistinguible en formato de los apuntes ya existentes.

> [!note] Alcance
> `Aprobadas/` y `Pendiente/` no cumplen este estandar (estructura y naming heredados de versiones anteriores del vault). Quedan fuera de alcance hasta que se haga un refactor dedicado — no aplicar estas reglas ahi de forma automatica.

## 1. Estructura estandar de una materia

```
<Materia>/
├── _INDICE.md
├── 0 - Informacion General.md        (opcional: cronograma, fechas de parciales)
├── 0 - Referencia ....md              (opcional: referencias de sintaxis, herramientas, etc.)
├── Documentos/                        (PDFs/slides fuente, sin subcarpetas por defecto)
├── Modulos/
│   ├── M1 - Nombre Descriptivo.md            (si el modulo tiene UN solo apunte)
│   └── M2 - Nombre Descriptivo/              (si el modulo tiene DOS o mas apuntes)
│       ├── M2 - Teoria.md
│       └── M2 - Ejercicios.md
└── Actividades/                       (opcional: entregas/ensayos evaluables, no son "teoria de modulo")
```

Reglas de esta estructura:

- **Carpeta de modulo:** si un modulo tiene un solo apunte, el archivo va directo en `Modulos/MX - Nombre Descriptivo.md`. En cuanto un modulo pasa a tener un segundo apunte (teoria + ejercicios, teoria + resumen, etc.), se crea la subcarpeta `Modulos/MX - Nombre Descriptivo/` y todos los apuntes de ese modulo se mueven ahi dentro.
- **`Documentos/`:** ahi van los PDFs/slides fuente tal como se descargan de la catedra. **Nunca se borran** despues de convertir su contenido en un apunte — se conservan siempre como respaldo del material original, aunque el apunte ya cubra todo su contenido.
- **`Actividades/`:** solo para entregas evaluables tipo ensayo/actividad puntual (no son teoria de un modulo especifico).

## 2. Convenciones de naming

- **Carpetas de modulo:** `MX - Nombre Descriptivo` (numero + guion + nombre corto, capitalizado, sin llamarlo simplemente "Modulo X").
- **Archivos de apunte:** `MX - Titulo Especifico.md` (ej. `M1 - Teoria de errores.md`, `M2 - Actividad.md`).
- **Archivos de nivel de materia (no ligados a un modulo puntual):** prefijo `0 - Nombre.md` (cronograma, referencias de herramientas).
- **Indices:** `_INDICE.md`, uno por carpeta de materia (y el `_INDICE.md` raiz de `Cursada Actual`).
- **Sin caracteres especiales** en nombres de archivo/carpeta: sin tildes, sin guiones em, sin `:` `/` `?`. Los acentos SI se usan libremente dentro del contenido del archivo.
- Los documentos fuente en `Documentos/` mantienen el prefijo del modulo al que pertenecen (`M1 - ...pdf`) o del practico (`P1 - ...pdf` para guias de ejercicios).

## 3. Frontmatter obligatorio

Todo apunte de modulo/actividad lleva este frontmatter (completar todos los campos, no dejar placeholders):

```yaml
---
tags:
  - materia/nombre-kebab
  - modulo/mx
  - tipo/[teoria|ejercicios|actividad|resumen|debate|guia|referencia]
materia: Nombre de la Materia
modulo: MX - Nombre Descriptivo
tipo: teoria
fecha_clase: YYYY-MM-DD   # opcional, solo si se conoce la fecha de la clase
descripcion: Una a tres lineas describiendo el contenido, pensada para que un LLM entienda de que trata sin abrir el archivo.
conceptos_clave:
  - concepto1
  - concepto2
relacionados:
  - "[[Otro Apunte Relacionado]]"
---
```

- `tipo` es el enum cerrado: `teoria`, `ejercicios`, `actividad`, `resumen`, `debate`, `guia`, `referencia`, `indice`. No inventar valores nuevos sin motivo — si ninguno encaja, preguntame.
- `relacionados` usa wikilinks `[[Nombre del archivo]]` (sin ruta de carpeta, Obsidian resuelve por nombre unico) a otros apuntes de la misma materia que compartan tema o sean prerrequisito/continuacion.
- `conceptos_clave` es una lista corta (4-8 items) de terminos tecnicos centrales del apunte, en minuscula.
- Los archivos `_INDICE.md` usan un frontmatter reducido: `tags: [indice, materia/...]`, `tipo: indice`, `materia:` (excepto el indice raiz, que no lleva `materia:`), y `descripcion:`.

## 4. Proceso paso a paso: de documento fuente a apunte

1. **Ubicar/copiar el documento fuente** en `<Materia>/Documentos/` con naming `MX - Nombre.pdf` (o `PX -` si es un practico de ejercicios).
2. **Determinar el modulo** (`MX`) y si ya existe subcarpeta `Modulos/MX - .../`. Si el modulo va a tener un segundo apunte y todavia es un archivo suelto, primero migrarlo a subcarpeta (ver seccion 1).
3. **Leer el documento completo** antes de escribir — no resumir a partir de un titulo o indice parcial.
4. **Redactar el apunte** siguiendo la seccion 5 (estilo de contenido) y completar el frontmatter de la seccion 3.
5. **Enlazar el apunte nuevo** desde `relacionados` de otros apuntes existentes que compartan tema (edicion bidireccional cuando tenga sentido).
6. **Actualizar `<Materia>/_INDICE.md`**: agregar una linea bajo el modulo correspondiente con wikilink + descripcion corta.
7. **Actualizar el `_INDICE.md` raiz** de `Cursada Actual` si el apunte es de tipo `teoria` (tabla de "Accesos rapidos por tipo de contenido") o si introduce una seccion nueva relevante.
8. **No borrar** el PDF fuente de `Documentos/` bajo ninguna circunstancia — queda como respaldo permanente.

## 5. Reglas de contenido y estilo

- **Fidelidad a la fuente:** el apunte sintetiza y organiza el documento, pero no debe inventar datos, formulas o ejemplos que no esten en la fuente. Si un ejercicio o dato queda incompleto en el original, decirlo explicitamente (ej. "*no consta en el archivo*") en vez de completarlo por inventiva.
- **Formulas matematicas:** siempre en LaTeX con `$...$` (inline) o `$$...$$` (bloque), nunca como texto plano o pseudo-notacion.
- **Diagramas de flujo/proceso/decision:** usar bloques ` ```mermaid ` (`graph TD` o `graph LR`) para relaciones causales, arboles de decision o procesos — es un patron recurrente en los apuntes existentes, no solo decorativo.
- **Ejercicios resueltos:** usar el callout `> [!example] Ejercitacion (...)` para agrupar ejercicios de la practica relacionados con la seccion teorica.
- **Notas/observaciones sobre limitaciones del material:** usar `> [!note]` cuando algo queda pendiente o fuera de alcance del modulo.
- **Encabezados:** `#` para el titulo del modulo, `##` para secciones tematicas, `###` para subsecciones/ejemplos. No saltar niveles.
- **Idioma y formato numerico:** contenido en espanol, coma decimal (`0,167`) igual que el material de catedra.
- **Tablas:** usar tablas Markdown para comparar variantes de un mismo calculo (ej. redondeo vs. truncamiento), como ya se hace en los apuntes de Calculo Numerico.

## 6. Checklist rapido antes de dar el apunte por terminado

- [ ] Carpeta correcta (`Modulos/MX - Nombre.md` o subcarpeta si hay 2+ apuntes en el modulo)
- [ ] Nombre de archivo sigue `MX - Titulo.md`, sin tildes/caracteres especiales
- [ ] Frontmatter completo: tags, materia, modulo, tipo, descripcion, conceptos_clave, relacionados
- [ ] Formulas en LaTeX, diagramas en Mermaid donde corresponda
- [ ] `_INDICE.md` de la materia actualizado
- [ ] `_INDICE.md` raiz actualizado si aplica (tipo `teoria` o seccion nueva)
- [ ] Enlaces `relacionados` agregados en ambos sentidos donde tenga sentido
