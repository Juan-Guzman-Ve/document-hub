# document-hub

Repositorio personal de notas (Obsidian) de Juan Guzman. Carpetas principales: `Personal/`, `Resources/`, `Universidad de palermo/`.

## Universidad de palermo

Vault de materias universitarias. Antes de crear, mover o reestructurar un apunte, leer `Universidad de palermo/_REGLAS_APUNTES.md` — ahi esta el estandar completo (estructura de carpetas, naming, frontmatter obligatorio, uso de LaTeX/Mermaid/callouts, actualizacion de indices).

Reglas que aplican en cualquier sesion, sin excepcion:

- **Nunca borrar** los PDFs/documentos fuente de ninguna carpeta `Documentos/`, ni siquiera despues de convertirlos en un apunte. Quedan como respaldo permanente.
- `Universidad de palermo/Aprobadas/` y `Universidad de palermo/Pendiente/` tienen estructura heredada que **no sigue** el estandar de `Cursada Actual/`. No aplicar ahi las reglas de naming/frontmatter de forma automatica — esta pendiente un refactor dedicado.
- Al agregar o editar un apunte en `Cursada Actual/`, actualizar el `_INDICE.md` de la materia y, si corresponde (tipo `teoria` o contenido nuevo relevante), el `_INDICE.md` raiz de `Cursada Actual/`.
- Enlazar `relacionados` en ambos sentidos cuando dos apuntes comparten tema (no solo en el archivo nuevo).

## Estilo de trabajo general

- Este repo se edita principalmente vía Claude Code corriendo en Windows con Git Bash — usar rutas y comandos compatibles.
- Antes de cualquier operacion destructiva (borrar, sobreescribir, mover archivos existentes) confirmar con el usuario, salvo que ya este cubierto por una regla explicita de este archivo.
- Preferir ediciones puntuales (Edit) sobre reescrituras completas de un apunte ya existente, para no perder contenido que el usuario haya agregado a mano entre sesiones.
