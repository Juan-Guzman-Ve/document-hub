# Speech — Defensa PPS (Juan Guzman)
---

### Slide 1 — Portada · ~15s

Buenos días. Soy Juan Guzman, estudiante de Ingeniería en Informática. 
Actualmente trabajo full time como Software Engineer en CraftLabs Holdings, prestando servicios para GSK

### Slide 2 — Contexto y rol · ~35s

Para ponerlos en contexto: Concretamente, sobre un conjunto de procesos automáticos —background services— que integran datos provenientes de sistemas externos, los normalizan y los almacenan. Mi trabajo se concentró en el backend de ese sistema, y es lo que voy a desarrollar hoy.

### Slide 3 — El punto de partida · ~50s

Cuando llegué, heredé un sistema de 41 background services que funcionaba, pero era frágil. Tenía cuatro problemas de raíz. Primero, no había control de concurrencia: los servicios se pisaban entre sí compitiendo por recursos críticos. Segundo, no estaban estandarizados: cada servicio estaba implementado a su manera. Tercero, la configuración estaba hardcodeada, con magic strings e IDs dispersos por todo el código. Y cuarto, no había integration tests, así que cada cambio era a ciegas, sin red de seguridad. Mi trabajo fue estabilizar ese sistema, hacerlo mantenible, y sobre esas fundaciones, gestionar nuevos servicios. Lo voy a contar como cinco mejoras.

### Slide 4 — Arquitectura general · ~45s

Antes, una foto general. A la izquierda están las APIs REST externas; la principal es Signals, que tiene un detalle clave: tiene rate limit. En el centro, los background services que desarrollé en .NET 8: son los que extraen, transforman y cargan los datos, usando NHibernate como ORM. A la derecha, la base Oracle, donde viven los datos, la configuración y los logs. Y arriba, orquestando todo, Hangfire, sobre una máquina virtual en Azure. Sobre este esquema voy a ir montando cada mejora.

### Slide 5 — Mejora 1: Orquestación y concurrencia · ~55s

La primera mejora fue la orquestación y el control de concurrencia. Como les decía, Signals tiene rate limit: no podía correr varios servicios en paralelo golpeando esa API, porque me bloqueaba. Y el sistema no tenía ningún mecanismo de control; los servicios competían por los recursos sin coordinación. La solución fue darle a Hangfire un storage propio en SQL Server. Eso me habilitó su distributed lock, que era justamente lo que necesitaba: ahora todos los servicios se registran en el contenedor de Hangfire y la concurrencia queda controlada. Además, sumé el dashboard de Hangfire, que me da gestión y visibilidad en tiempo real de qué se está ejecutando.

### Slide 6 — Mejora 2: Estandarización · ~55s

La segunda mejora fue la estandarización. Como cada servicio hacía las cosas a su manera, creé una clase base —BaseService— que centraliza la funcionalidad compartida: el manejo de errores y el logueo de transacciones por cada fase del procesamiento. Después, para el dominio específico de Signals, creé una segunda clase base, SignalsBaseService, que hereda de la primera y agrega los cimientos para operar directamente contra Signals. Así, cualquier servicio nuevo que creo arranca ya estandarizado, con todo eso resuelto de entrada.

### Slide 7 — Mejora 3: Configuración + observabilidad · ~60s

La tercera mejora atacó la configuración hardcodeada, y de paso me dio observabilidad. En lugar de magic strings e IDs en el código, creé un esquema en la base con una tabla de configuración: cada servicio tiene su id, su job id, su expresión cron y un flag enabled para habilitarlo o deshabilitarlo. En el arranque, la API lee esa tabla y registra automáticamente todos los servicios activos. Y esa misma tabla es la fuente que uso para vincular los transaction logs de cada corrida con cada servicio. ¿El resultado? Tengo health checks y puedo sacar benchmarks de duración de cada servicio. Pasé de configuración dispersa en el código a algo centralizado y observable.

### Slide 8 — Mejora 4: Extensibilidad con generics · ~55s

La cuarta mejora fue hacer el sistema extensible. Me di cuenta de que los servicios de Signals siempre hacen lo mismo: extraen datos, los mapean, verifican si la entidad ya existe en la base, y la insertan o la actualizan. Así que generalicé todas esas operaciones usando generics, una sola vez. ¿Qué se ganó? Antes, cuando GSK pedía extraer una entidad nueva de Signals —samples, experiments, lo que fuera—, armar ese servicio llevaba días. Ahora solo toco dos funciones: una para registrar el modelo de NHibernate de la nueva entidad, y otra para mapear sus campos. Lo que llevaba días, hoy son minutos.

### Slide 9 — Mejora 5: Red de seguridad (tests + CI) · ~55s

La quinta mejora fue darle al sistema una red de seguridad, con tests e integración continua. Armé un proyecto de tests con tres niveles. Los smoke tests verifican que la app arranca. Los unit tests cubren la lógica de dominio y de negocio. Pero los más importantes fueron los integration tests, porque la app no los tenía y eran los que más falta hacían: levantan la aplicación en memoria, corren el servicio, y verifican en los transaction logs que la ejecución terminó correctamente. Y todo esto lo conecté a un pipeline de GitHub Actions: ante cada Pull Request se corren los tests, con dorny para reportar los resultados, sobre un runner de Ubuntu por costos. La regla es simple: si algo falla, no se mergea a main.

### Slide 10 — Resultados · ~45s

¿Cuál fue el resultado de todo esto? Pasé de 41 a 31 servicios, porque en el camino detecté y eliminé operaciones redundantes entre servicios. Pero más allá del número, el sistema cambió de naturaleza: pasó de ser frágil a estar orquestado, con la concurrencia controlada; estandarizado; observable; extensible en minutos; y con una red de seguridad real en CI. De un sistema que daba miedo tocar, a uno confiable y mantenible.

### Slide 11 — Extra: MCP / Spec-Driven Development · ~45s

Por último, un trabajo extra del que estoy especialmente orgulloso. Para las tareas repetitivas, como justamente agregar una nueva extracción de Signals, construí una base de conocimiento y la expuse a través de un servidor MCP que desarrollé en C#. La idea es darle a los agentes de IA —en este caso, agentes de Copilot— un cerebro de conocimiento verificado: cuando encaran una tarea, en vez de improvisar, consultan esta base y reciben instrucciones, principios de software y buenas prácticas ya validadas. Lo construí para aplicar Spec-Driven Development en el equipo.

### Slide 12 — Cierre · ~15s

Y con eso cierro. Les agradezco mucho, y quedo a disposición para sus preguntas.

---

**Si vas justo de tiempo, podés recortar sin que se note:**

- En Slide 7, sacá la frase final ("Pasé de configuración dispersa…").
- En Slide 11 (MCP), podés acortarlo a dos oraciones: qué es y para qué lo hiciste.

**Si te sobra tiempo:** abrí el dashboard de Hangfire o mostrá la demo del MCP sobre la Slide 11.