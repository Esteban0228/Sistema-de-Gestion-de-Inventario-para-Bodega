Especificación de Requerimientos – Fase 2

Ficha 138 · ADSO – SENA · Fecha de entrega: 31 de agosto

Proyecto: Sistema de Gestión de Inventario para Bodega (cadena de sucursales)
Integrantes: Julián Camilo Losada, Cristian Camilo Bastidas Navarro, Daniel Esteban Espinosa Claros


1. Introducción

1.1 Propósito

Este documento especifica los requerimientos del **Sistema de Gestión de Inventario para Bodega**, una aplicación pensada para una empresa que opera **varias sucursales** y necesita centralizar el control de su inventario, sus ventas y su personal.

El problema que resuelve es la falta de control organizado y actualizado del negocio cuando el inventario se lleva de forma manual o descentralizada por sucursal: no hay visibilidad en tiempo real de las existencias, no se detectan a tiempo los productos que requieren reposición, y no es posible comparar el desempeño entre sucursales.

Está dirigido a tres tipos de usuario dentro de la empresa: el **administrador** (control global del negocio), el **encargado de bodega** (gestión operativa del inventario en su sucursal) y el **vendedor** (registro de ventas en el punto de atención).

1.2 Ámbito del producto

El sistema se denomina **SGIB (Sistema de Gestión de Inventario para Bodega). Permite:

- Registrar usuarios con roles diferenciados y controlar el acceso según el rol.
- Administrar múltiples sucursales, cada una con su propio inventario.
- Gestionar categorías, proveedores y productos.
- Registrar entradas y salidas de inventario (incluyendo ventas, daños/pérdidas, devoluciones a proveedor y ajustes).
- Consultar existencias en tiempo real y recibir alertas de stock mínimo por producto.
- Generar reportes de inventario y reportes comparativos entre sucursales.

Fuera del alcance de esta versión: facturación electrónica ante entidades tributarias, integración con pasarelas de pago, y gestión de nómina del personal (más allá del control de acceso por rol). *(Ajustar esta lista si el grupo definió un alcance distinto en Fase 1).*

Plataformas de acceso: el sistema se ofrece como aplicación web y aplicación móvil, ambas consumiendo los mismos servicios del backend para mantener la información sincronizada entre sucursales.

Este documento desarrolla las 13 historias de usuario (HU-01 a HU-13) definidas en la Fase 1, ampliadas por solicitud del instructor de una sola bodega a una cadena de sucursales con roles y ventas.

1.3 Definiciones, acrónimos y abreviaturas

| Término / Acrónimo | Definición |
| --- | --- |
| RF | Requerimiento funcional |
| RNF | Requerimiento no funcional |
| RN | Regla de negocio |
| RC | Restricción |
| CA | Criterio de aceptación |
| HU | Historia de usuario (Fase 1) |
| SKU | Código único que identifica un producto en el inventario |
| Stock mínimo | Cantidad umbral de un producto por debajo de la cual el sistema genera una alerta de reabastecimiento |
| Sucursal | Punto físico de la empresa con inventario, usuarios y ventas propios |
| Encargado de bodega | Usuario responsable de la gestión operativa del inventario de una sucursal |

1.4 Referencias

- Historias de Usuario – Sistema de Gestión de Inventario para Bodega (Fase 1), versión con criterios de aceptación y priorización MoSCoW.
- Ficha 138 – Análisis y Desarrollo de Software, SENA.
- Rúbrica Fase 2 – Requerimientos.

---

2. Descripción general

2.1 Perspectiva del producto

El SGIB es un sistema independiente que centraliza la información de todas las sucursales de la empresa. Cada sucursal mantiene su propio inventario y sus propias categorías (gestionadas por su encargado de bodega), mientras que el catálogo de productos y proveedores, así como el módulo de usuarios y reportes, tienen alcance global (administrador) o restringido a la sucursal asignada (vendedor, encargado de bodega). El sistema es accesible tanto desde una aplicación web como desde una aplicación móvil.

2.2 Funciones del producto

De forma general, el sistema permite: autenticar usuarios según su rol; administrar sucursales, categorías, proveedores y productos; registrar movimientos de inventario (entradas, salidas y ventas); consultar existencias y recibir alertas de stock mínimo; y generar reportes de inventario y comparativos entre sucursales.

2.3 Características de los usuarios

| Actor (Fase 1) | Responsabilidad en el sistema |
| --- | --- |
| Administrador | Gestionar usuarios, roles y sucursales; tiene visibilidad global del negocio; genera reportes comparativos entre sucursales |
| Encargado de bodega | Gestiona categorías, proveedores, productos, entradas y salidas de inventario de su sucursal; consulta existencias, atiende alertas de stock mínimo y genera reportes de inventario |
| Vendedor | Registra las ventas de productos en su sucursal, descontando existencias |

---

3. Requisitos

3.1 Requerimientos funcionales (RF)

Resumen de RF

| ID | Nombre | Actores | HU relacionada | Prioridad (MoSCoW) |
| --- | --- | --- | --- | --- |
| RF-001 | Registrar usuario y asignar rol | Administrador | HU-01 | Alta |
| RF-002 | Iniciar sesión | Todos los roles | HU-02 | Alta |
| RF-003 | Registrar sucursal | Administrador | HU-03 | Alta |
| RF-004 | Registrar categoría | Encargado de bodega | HU-04 | Media |
| RF-005 | Registrar proveedor | Encargado de bodega | HU-05 | Media |
| RF-006 | Registrar producto | Encargado de bodega | HU-06 | Crítica |
| RF-007 | Registrar entrada de inventario | Encargado de bodega | HU-07 | Crítica |
| RF-008 | Registrar salida de inventario | Encargado de bodega | HU-08 | Crítica |
| RF-009 | Registrar venta | Vendedor | HU-09 | Alta |
| RF-010 | Consultar existencias | Encargado de bodega, Administrador | HU-10 | Alta |
| RF-011 | Generar alerta de stock mínimo | Encargado de bodega (Sistema) | HU-11 | Media |
| RF-012 | Generar reporte de inventario | Encargado de bodega | HU-12 | Media |
| RF-013 | Generar reporte por sucursal | Administrador | HU-13 | Media |

MVP propuesto en Fase 1: RF-002, RF-006, RF-007, RF-008 y RF-010. RF-001 y RF-003 son configuración previa indispensable antes de poder operar el MVP.

Fichas detalladas por requerimiento

RF-001 – Registrar usuario y asignar rol
Actores: Administrador.
Precondiciones: El administrador ha iniciado sesión con permisos de gestión de usuarios.

Flujo Normal
1. El administrador selecciona "Registrar usuario" en el módulo de Usuarios.
2. El sistema muestra el formulario (nombre completo, documento, correo, usuario, contraseña, rol, sucursal asignada).
3. El administrador diligencia los datos y selecciona el rol (Administrador, Vendedor, Encargado de bodega).
4. El administrador presiona "Guardar".
5. El sistema valida que el usuario y el correo no existan previamente.
6. El sistema cifra la contraseña y almacena el nuevo usuario con su rol y sucursal.
7. El sistema muestra un mensaje de confirmación y el usuario aparece en el listado de usuarios activos.

Flujos Alternativos
- A1 (Paso 3): El administrador edita el rol de un usuario existente.
  1. Selecciona un usuario del listado y elige "Editar rol".
  2. El sistema muestra el rol actual y permite seleccionar uno nuevo.
  3. Continúa en el Paso 4 del Flujo Normal.

Flujos Anormales
- E1 (Paso 5 – Usuario o correo duplicado):
  1. El sistema detecta que el usuario o correo ya existen.
  2. Muestra "El usuario o correo ya está registrado".
  3. Regresa al Paso 3.
- E2 (Paso 3 – Campos incompletos):
  1. El sistema detecta campos obligatorios vacíos.
  2. Muestra "Debe completar todos los campos obligatorios".
  3. Regresa al Paso 3.

Postcondiciones: El usuario queda registrado en estado "Activo" con el rol y sucursal asignados, habilitado para iniciar sesión según sus permisos.

RF-002 – Iniciar sesión
Actores: Administrador, Vendedor, Encargado de bodega.
Precondiciones: El usuario debe estar previamente registrado y activo.

*Flujo Normal*
1. El usuario ingresa a la pantalla de inicio de sesión.
2. El sistema solicita usuario y contraseña.
3. El usuario ingresa sus credenciales y presiona "Ingresar".
4. El sistema valida las credenciales contra la base de datos.
5. El sistema identifica el rol y la(s) sucursal(es) asociadas.
6. El sistema redirige al menú principal mostrando solo las opciones habilitadas para su rol.

Flujos Alternativos
- A1 (Paso 3): El usuario solicita recuperar su contraseña.
  1. Presiona "Olvidé mi contraseña".
  2. El sistema envía un enlace de restablecimiento al correo registrado.
  3. Regresa al Paso 1 tras restablecer la contraseña.

Flujos Anormales
- E1 (Paso 4 – Credenciales incorrectas):
  1. El sistema no encuentra coincidencia de usuario/contraseña.
  2. Muestra "Usuario o contraseña incorrectos".
  3. Regresa al Paso 3.
- E2 (Paso 4 – Usuario inactivo):
  1. El sistema detecta que el usuario está inactivo.
  2. Muestra "Su cuenta se encuentra inactiva, contacte al administrador".
  3. El flujo finaliza sin acceso.
- E3 (Paso 4 – Intentos fallidos consecutivos):
  1. El sistema detecta que el usuario ha superado el número máximo de intentos fallidos consecutivos definido (ver RN-009).
  2. El sistema bloquea temporalmente la cuenta y muestra "Cuenta bloqueada temporalmente, intente más tarde".
  3. El flujo finaliza sin acceso hasta que expire el bloqueo o el administrador la reactive.

Postcondiciones: Se crea una sesión activa asociada al rol del usuario y se registra la fecha/hora del ingreso.


RF-003 – Registrar sucursal
Actores: Administrador.
Precondiciones: El administrador ha iniciado sesión.

Flujo Normal
1. Accede al módulo "Sucursales".
2. Selecciona "Nueva sucursal".
3. El sistema muestra el formulario (nombre, dirección, ciudad, teléfono, encargado).
4. El administrador diligencia los datos y presiona "Guardar".
5. El sistema valida que el nombre no esté duplicado.
6. El sistema crea la sucursal y su inventario independiente asociado.
7. Confirma la creación; la sucursal aparece en el listado.

Flujos Alternativos
- A1 (Paso 3): El administrador edita una sucursal existente.
  1. Selecciona la sucursal y elige "Editar".
  2. Modifica los datos necesarios.
  3. Continúa en el Paso 4.
- A2: El administrador inactiva una sucursal que ya tiene inventario o usuarios asociados (en vez de eliminarla, ver E2).
  1. Selecciona la sucursal y elige "Inactivar".
  2. El sistema cambia su estado a "Inactiva"; deja de estar disponible para nuevos movimientos, pero conserva su historial.

Flujos Anormales
- E1 (Paso 5 – Nombre duplicado):
  1. El sistema detecta un nombre de sucursal ya existente.
  2. Muestra "Ya existe una sucursal con ese nombre".
  3. Regresa al Paso 3.
- E2 (Intento de eliminar sucursal con datos asociados):
  1. El administrador intenta eliminar una sucursal que tiene inventario o usuarios asociados.
  2. El sistema muestra "No se puede eliminar: la sucursal tiene inventario o usuarios asociados" y sugiere inactivarla (ver A2).
  3. El flujo finaliza sin eliminar.

Postcondiciones: La sucursal queda registrada y disponible para asociar usuarios, inventario y ventas.

RF-004 – Registrar categoría
Actores: Encargado de bodega.
Precondiciones: El encargado ha iniciado sesión.

Flujo Normal
1. Accede al módulo "Categorías" de su sucursal.
2. Selecciona "Nueva categoría".
3. Ingresa nombre y descripción.
4. Presiona "Guardar".
5. El sistema valida que el nombre no esté duplicado **dentro de esa sucursal** (el mismo nombre sí puede existir en otra sucursal, gestionado de forma independiente por su propio encargado).
6. El sistema almacena la categoría.
7. Confirma el registro; la categoría queda disponible para asociar productos.

Flujos Alternativos
- A1 (Paso 3): El encargado edita una categoría existente.
  1. Selecciona la categoría y elige "Editar".
  2. Modifica el nombre/descripción.
  3. Continúa en el Paso 4.
- A2: El encargado inactiva una categoría que tiene productos asociados (en vez de eliminarla, ver E2).
  1. Selecciona la categoría y elige "Inactivar".
  2. El sistema cambia su estado a "Inactiva"; deja de estar disponible para nuevos productos, pero los ya clasificados conservan la referencia.

Flujos Anormales
- E1 (Paso 5 – Categoría duplicada):
  1. El sistema detecta que ya existe una categoría con ese nombre en la misma sucursal.
  2. Muestra "La categoría ya existe en esta sucursal".
  3. Regresa al Paso 3.
- E2 (Intento de eliminar categoría con productos asociados):
  1. El encargado intenta eliminar una categoría que tiene productos asociados.
  2. El sistema muestra "No se puede eliminar: existen productos asociados a esta categoría" y sugiere inactivarla (ver A2).
  3. El flujo finaliza sin eliminar.

Postcondiciones: La categoría queda disponible para clasificar productos del inventario de esa sucursal.

---

RF-005 – Registrar proveedor
Actores: Encargado de bodega.
Precondiciones: El encargado ha iniciado sesión.

Flujo Normal
1. Accede al módulo "Proveedores".
2. Selecciona "Nuevo proveedor".
3. Ingresa NIT/documento, razón social, teléfono, correo y dirección.
4. Presiona "Guardar".
5. El sistema valida que el NIT no esté duplicado.
6. El sistema almacena el proveedor.
7. Confirma el registro; el proveedor queda disponible para asociarlo a entradas de inventario.

Flujos Alternativos
- A1 (Paso 3): El encargado edita un proveedor existente.
  1. Selecciona el proveedor y elige "Editar".
  2. Modifica los datos.
  3. Continúa en el Paso 4.

Flujos Anormales
- E1 (Paso 5 – NIT duplicado):
  1. El sistema detecta un NIT ya registrado.
  2. Muestra "Este proveedor ya se encuentra registrado".
  3. Regresa al Paso 3.
- E2 (Paso 3 – Datos de contacto incompletos):
  1. El sistema detecta que faltan el teléfono o el correo de contacto.
  2. Muestra "Debe completar los datos de contacto del proveedor".
  3. Regresa al Paso 3.

Postcondiciones: El proveedor queda registrado y disponible para asociarlo a productos y a futuras entradas de inventario.

---

RF-006 – Registrar producto
Actores: Encargado de bodega.
Precondiciones: Debe existir al menos una categoría (de la sucursal) y un proveedor registrados; el encargado ha iniciado sesión.

Flujo Normal
1. Accede al módulo "Productos".
2. Selecciona "Nuevo producto".
3. Ingresa nombre, descripción, categoría, proveedor, precio de compra, precio de venta y su propio stock mínimo.
4. Presiona "Guardar".
5. El sistema valida que la categoría y el proveedor seleccionados existan, y que el stock mínimo esté definido y sea mayor a cero.
6. El sistema almacena el producto con existencia inicial en 0 para cada sucursal.
7. Confirma el registro.

Flujos Alternativos
- **A1 (Paso 3):** El encargado edita un producto existente (precio, stock mínimo, categoría, proveedor).
  1. Selecciona el producto y elige "Editar".
  2. Modifica los campos necesarios.
  3. Continúa en el Paso 4.

Flujos Anormales
- E1 (Paso 5 – Categoría o proveedor inexistentes):
  1. El sistema detecta que la categoría o el proveedor seleccionados no existen o están inactivos.
  2. Muestra "Debe seleccionar una categoría y un proveedor válidos".
  3. Regresa al Paso 3.
- E2 (Paso 5 – Stock mínimo inválido o no definido):
  1. El sistema detecta que el stock mínimo está vacío, en cero o es negativo.
  2. Muestra "Debe definir un stock mínimo mayor a cero".
  3. Regresa al Paso 3.

Postcondiciones: El producto queda disponible en el catálogo, con su categoría y proveedor asociados, para registrar entradas, salidas y ventas.


RF-007 – Registrar entrada de inventario
Actores: Encargado de bodega.
Precondiciones: El producto y el proveedor deben estar previamente registrados.

Flujo Normal
1. Accede al módulo "Entradas de inventario".
2. Selecciona "Nueva entrada".
3. Selecciona proveedor, sucursal, producto y cantidad ingresada.
4. Presiona "Guardar".
5. El sistema valida que la cantidad sea mayor a cero.
6. El sistema incrementa la existencia del producto en la sucursal seleccionada.
7. Registra el movimiento con fecha, usuario y proveedor, y confirma la operación.

Flujos Alternativos
- **A1 (Paso 3):** El encargado registra la entrada de varios productos en un mismo comprobante.
  1. Agrega múltiples líneas de producto/cantidad antes de guardar.
  2. Continúa en el Paso 4, procesando cada línea.

Flujos Anormales
- **E1 (Paso 5 – Cantidad inválida):**
  1. El sistema detecta una cantidad igual o menor a cero.
  2. Muestra "La cantidad debe ser mayor a cero".
  3. Regresa al Paso 3.

Postcondiciones: Las existencias del producto en la sucursal quedan actualizadas y el movimiento queda registrado en el histórico.


RF-008 – Registrar salida de inventario
Actores: Encargado de bodega.
Precondiciones: El producto debe tener existencias registradas en la sucursal.

Flujo Normal
1. Accede al módulo "Salidas de inventario".
2. Selecciona "Nueva salida".
3. Selecciona sucursal, producto, cantidad y tipo de salida (daño/pérdida, devolución a proveedor, ajuste de inventario).
4. Presiona "Guardar".
5. El sistema valida que la cantidad no supere la existencia disponible.
6. El sistema descuenta la cantidad de la existencia del producto en la sucursal.
7. Registra el movimiento con fecha, usuario y tipo de salida, y confirma la operación.

Flujos Alternativos
- **A1 (Paso 3 – Salida por venta):** La salida se genera automáticamente desde RF-009 (Registrar venta), sin intervención manual del encargado; continúa en el Paso 6.
- **A2 (Paso 3 – Devolución a proveedor):** El encargado asocia la salida a un proveedor y a la entrada original.
  1. Selecciona el proveedor y la entrada relacionada.
  2. Continúa en el Paso 4.

Flujos Anormales
- **E1 (Paso 5 – Existencia insuficiente):**
  1. El sistema detecta que la cantidad solicitada supera la existencia disponible.
  2. Muestra "Existencia insuficiente para esta salida".
  3. Regresa al Paso 3.

Postcondiciones: Las existencias quedan actualizadas y el movimiento, clasificado por tipo de salida, queda registrado en el histórico.


RF-009 – Registrar venta
Actores: Vendedor.
Precondiciones: El vendedor ha iniciado sesión y existen productos con existencia disponible en su sucursal.

Flujo Normal
1. Accede al módulo "Ventas".
2. Selecciona "Nueva venta".
3. Busca y agrega los productos con su cantidad al detalle de la venta.
4. El sistema calcula subtotal, impuestos (si aplica) y total.
5. El vendedor confirma la venta y selecciona el medio de pago.
6. El sistema valida la existencia disponible de cada producto en la sucursal.
7. El sistema descuenta la existencia (genera una salida tipo "venta", ver RF-008 A1), registra la venta asociada a la sucursal y al vendedor, y genera el comprobante.

Flujos Alternativos
- **A1 (Paso 3):** El vendedor elimina un producto agregado antes de confirmar.
  1. Selecciona el ítem y presiona "Quitar".
  2. El sistema recalcula el total y continúa en el Paso 3.

Flujos Anormales
- E1 (Paso 6 – Existencia insuficiente):
  1. El sistema detecta que la cantidad solicitada de un producto supera la existencia disponible.
  2. Muestra "Existencia insuficiente para completar la venta".
  3. Regresa al Paso 3 para ajustar la cantidad o retirar el producto.

Postcondiciones: La venta queda registrada, la existencia del producto se actualiza y el comprobante queda disponible para consulta y reportes.


RF-010 – Consultar existencias
Actores: Encargado de bodega, Administrador.
Precondiciones: El usuario ha iniciado sesión con permisos para el módulo de inventario.

Flujo Normal
1. Accede al módulo "Inventario".
2. Selecciona "Consultar existencias".
3. Filtra por sucursal, categoría o producto (opcional).
4. El sistema consulta la base de datos y muestra el listado con cantidades disponibles por producto y sucursal.
5. El usuario puede exportar o visualizar el detalle de un producto.

Flujos Alternativos
- A1 (Paso 3): El usuario no aplica ningún filtro.
  1. El sistema muestra la existencia de todos los productos de todas las sucursales a las que tiene acceso.
  2. Continúa en el Paso 4.

Flujos Anormales
- E1 (Paso 4 – Sin resultados):
  1. El sistema no encuentra productos que coincidan con el filtro aplicado.
  2. Muestra "No se encontraron productos con los criterios seleccionados".
  3. Regresa al Paso 3.

Postcondiciones: El usuario visualiza el estado actualizado de las existencias sin modificar los datos.


RF-011 – Generar alerta de stock mínimo
Actores: Encargado de bodega (receptor); Sistema (generador automático).
Precondiciones: Cada producto debe tener definido su stock mínimo (RF-006).

Flujo Normal
1. El sistema verifica, tras cada movimiento de inventario (entrada, salida o venta), si la existencia de un producto es igual o menor a su stock mínimo.
2. El sistema genera una alerta asociada al producto y a la sucursal.
3. El sistema notifica al encargado de bodega de la sucursal correspondiente.
4. El encargado visualiza el listado de productos en alerta.

Flujos Alternativos
- A1 (Paso 4): El encargado marca la alerta como "gestionada" tras iniciar el reabastecimiento.
  1. Selecciona la alerta y elige "Marcar como gestionada".
  2. El sistema actualiza el estado de la alerta.

Flujos Anormales
- E1 (Paso 1 – Producto sin stock mínimo definido):
  1. El sistema detecta que el producto no tiene un stock mínimo configurado.
  2. Omite la validación para ese producto y registra la incidencia para revisión del encargado.

Postcondiciones: Los productos en nivel crítico quedan visibles en un listado de alertas activas hasta que se reabastezcan.


RF-012 – Generar reporte de inventario
Actores: Encargado de bodega.
Precondiciones: Deben existir movimientos y/o productos registrados en el sistema.

Flujo Normal
1. Accede al módulo "Reportes".
2. Selecciona "Reporte de inventario".
3. Define rango de fechas, sucursal y/o categoría a consultar.
4. Presiona "Generar".
5. El sistema procesa la información y muestra el reporte (existencias, entradas, salidas, valorización).
6. El usuario exporta el reporte (PDF/Excel) si lo requiere.

Flujos Alternativos
- A1 (Paso 6): El usuario decide solo visualizar el reporte en pantalla sin exportarlo.

Flujos Anormales
- E1 (Paso 5 – Sin información en el rango seleccionado):
  1. El sistema no encuentra movimientos en el rango de fechas indicado.
  2. Muestra "No hay información disponible para los criterios seleccionados".
  3. Regresa al Paso 3.

Postcondiciones: El reporte queda disponible para consulta o descarga, sin alterar los datos del inventario.


RF-013 – Generar reporte por sucursal
Actores: Administrador.
Precondiciones: Deben existir al menos dos sucursales con movimientos registrados.

Flujo Normal
1. Accede al módulo "Reportes".
2. Selecciona "Reporte por sucursal".
3. Selecciona las sucursales a comparar y el rango de fechas.
4. Presiona "Generar".
5. El sistema consolida la información de inventario y ventas por sucursal.
6. Muestra el comparativo (ventas totales, existencias, productos más vendidos) por sucursal.
7. El administrador exporta el reporte si lo requiere.

Flujos Alternativos
- A1 (Paso 3): El administrador selecciona todas las sucursales sin filtrar.
  1. El sistema incluye todas las sucursales activas en el comparativo.
  2. Continúa en el Paso 4.

Flujos Anormales
- E1 (Paso 5 – Sucursal sin movimientos):
  1. El sistema detecta que una sucursal seleccionada no tiene movimientos en el rango indicado.
  2. Muestra dicha sucursal con valores en cero y la nota "Sin movimientos registrados".
  3. Continúa en el Paso 6.

Postcondiciones: El administrador obtiene un comparativo actualizado del desempeño entre sucursales.


3.2 Requerimientos no funcionales (RNF)

| ID | Categoría | Requerimiento (medible) |
| --- | --- | --- |
| RNF-001 | Rendimiento | El sistema debe responder a consultas de existencias e inicio de sesión en ≤ 3 segundos, con hasta 50 usuarios concurrentes. |
| RNF-002 | Seguridad | Solo el rol Administrador puede acceder al módulo de gestión de usuarios y sucursales; las contraseñas se almacenan cifradas (hash). |
| RNF-003 | Disponibilidad | El sistema debe estar disponible al menos el 95% del tiempo en horario laboral (lunes a sábado, 7:00 a.m. – 8:00 p.m.). |
| RNF-004 | Usabilidad | Un usuario sin capacitación previa debe poder registrar una venta en no más de 5 pasos/clics. |
| RNF-005 | Escalabilidad | El sistema debe permitir agregar nuevas sucursales sin afectar el rendimiento de las existentes, soportando al menos 10 sucursales. |
| RNF-006 | Integridad de datos | Toda venta o movimiento de inventario debe ejecutarse como transacción atómica (todo o nada) para evitar inconsistencias en las existencias. |
| RNF-007 | Compatibilidad | El sistema debe ser accesible mediante una aplicación web (navegadores Chrome, Edge o Firefox actualizados) y una aplicación móvil (Android como mínimo), ambas consumiendo los mismos servicios del backend. |
| RNF-008 | Consistencia | Un movimiento de inventario o venta registrado desde la app móvil debe reflejarse en la versión web (y viceversa) en un tiempo ≤ 5 segundos, sujeto a disponibilidad de red. |

3.3 Reglas de negocio

| ID | Regla de negocio |
| --- | --- |
| RN-001 | Un vendedor solo puede registrar ventas de productos con existencia disponible en su propia sucursal. |
| RN-002 | El stock mínimo es una propiedad individual de cada producto y puede definirse de forma diferente por sucursal. |
| RN-003 | Una venta no puede completarse si el total solicitado de algún producto supera la existencia disponible. |
| RN-004 | Solo el rol Administrador puede crear, editar o inactivar sucursales y usuarios. |
| RN-005 | Toda salida de inventario debe clasificarse obligatoriamente en uno de los tipos definidos: venta, daño/pérdida, devolución a proveedor o ajuste de inventario. |
| RN-006 | Una categoría o una sucursal no pueden eliminarse si tienen productos, inventario o usuarios asociados; en ese caso solo pueden inactivarse. |
| RN-007 | El precio de venta de un producto debe ser mayor que su precio de compra. |
| RN-008 | Un usuario solo puede ver y operar sobre el inventario y las ventas de la(s) sucursal(es) a las que está asignado, salvo el Administrador, que tiene visibilidad global. |
| RN-009 | Tras 5 intentos fallidos consecutivos de inicio de sesión, el sistema bloquea temporalmente la cuenta durante 15 minutos. |
| RN-010 | El nombre de una categoría debe ser único dentro de su sucursal, pero puede repetirse entre sucursales distintas. |
| RN-011 | Todo producto debe tener asociados una categoría y un proveedor válidos, además de un stock mínimo propio mayor a cero, desde el momento de su registro. |

3.4 Restricciones

| ID | Restricción (técnica/externa) |
| --- | --- |
| RC-001 | El sistema usará MySQL como motor de base de datos relacional (propuesta del grupo, sujeta a confirmación con el instructor), por su soporte transaccional, costo cero y compatibilidad con backends que sirvan tanto a la app web como a la app móvil. El lenguaje de backend queda pendiente de definir por el grupo. |
| RC-002 | El sistema debe estar operativo antes de la fecha límite establecida por el instructor para la sustentación del proyecto. |
| RC-003 | El proyecto se desarrolla con fines académicos (Ficha 138 – SENA); no se contemplan licencias de software comerciales de pago. |
| RC-004 | El sistema debe operar con acceso a red local o a internet para sincronizar la información del inventario y las ventas entre sucursales. |

3.5 Criterios de aceptación por requerimiento

RF-001 – Registrar usuario y asignar rol
- El sistema crea el usuario en estado "Activo" cuando todos los campos son válidos y el usuario/correo no existen previamente.
- El sistema rechaza el registro y muestra un mensaje de error si el usuario o correo ya existen.
- El sistema no permite guardar si falta algún campo obligatorio.

RF-002 – Iniciar sesión
- El sistema permite el acceso y redirige al menú correspondiente cuando las credenciales son correctas y el usuario está activo.
- El sistema rechaza el acceso y muestra un mensaje de error genérico (sin indicar cuál dato falló) cuando las credenciales son incorrectas.
- El sistema impide el acceso a un usuario inactivo, indicando el motivo.
- Tras 5 intentos fallidos consecutivos, el sistema bloquea temporalmente la cuenta (RN-009).

RF-003 – Registrar sucursal
- El sistema registra la sucursal cuando el nombre no está duplicado y los datos obligatorios están completos.
- El sistema rechaza la creación si el nombre de la sucursal ya existe.
- Cada sucursal creada cuenta con un inventario independiente desde su creación.
- El sistema impide eliminar una sucursal con inventario o usuarios asociados y ofrece inactivarla en su lugar.

RF-004 – Registrar categoría
- El sistema registra la categoría cuando el nombre no está duplicado dentro de la misma sucursal (nombres repetidos entre sucursales distintas sí son válidos).
- El sistema impide crear una categoría con nombre repetido en la misma sucursal.
- El sistema impide eliminar una categoría con productos asociados y ofrece inactivarla en su lugar.

RF-005 – Registrar proveedor
- El sistema registra el proveedor cuando el NIT/documento no está duplicado y los datos de contacto están completos.
- El sistema rechaza el registro si el NIT ya existe o si faltan los datos de contacto.

RF-006 – Registrar producto
- El sistema registra el producto cuando tiene categoría, proveedor y stock mínimo (mayor a cero) válidos.
- El sistema rechaza el registro si la categoría o el proveedor seleccionados no existen, o si el stock mínimo no está definido o es inválido.
- El producto queda disponible en el catálogo con existencia inicial en cero para cada sucursal.

RF-007 – Registrar entrada de inventario
- El sistema incrementa la existencia del producto en la sucursal cuando la cantidad ingresada es mayor a cero.
- El sistema rechaza la operación si la cantidad es igual o menor a cero.
- El movimiento queda registrado con fecha, usuario y proveedor asociado.

RF-008 – Registrar salida de inventario
- El sistema descuenta la existencia cuando la cantidad solicitada no supera la disponible y se selecciona un tipo de salida válido.
- El sistema rechaza la operación si la cantidad supera la existencia disponible.
- Toda salida queda clasificada en uno de los tipos definidos (venta, daño/pérdida, devolución, ajuste).

RF-009 – Registrar venta
- El sistema registra la venta y descuenta la existencia cuando todos los productos tienen existencia suficiente en la sucursal.
- El sistema impide confirmar la venta si algún producto no tiene existencia suficiente, indicando cuál.
- El sistema genera el comprobante de venta asociado a la sucursal y al vendedor.

RF-010 – Consultar existencias
- El sistema muestra las existencias actuales por producto y sucursal, con o sin filtros aplicados.
- El sistema informa cuando no hay resultados para los filtros seleccionados, sin generar un error del sistema.

RF-011 – Generar alerta de stock mínimo
- El sistema genera una alerta automática cuando la existencia de un producto es igual o menor a su stock mínimo.
- El encargado de bodega puede visualizar y marcar como gestionada cada alerta activa.

RF-012 – Generar reporte de inventario
- El sistema genera el reporte de inventario con la información correspondiente al rango y filtros seleccionados.
- El sistema informa cuando no hay información disponible para los criterios seleccionados.
- El reporte puede exportarse sin alterar los datos originales del inventario.

RF-013 – Generar reporte por sucursal
- El sistema genera el comparativo entre las sucursales seleccionadas con datos de ventas y existencias.
- El sistema muestra en cero, con la nota correspondiente, las sucursales sin movimientos en el rango indicado.

3.6 Matriz de trazabilidad HU ↔ Requerimientos

| HU (Fase 1) | RF que la desarrolla |
| --- | --- |
| HU-01 – Gestionar usuarios y roles | RF-001 |
| HU-02 – Iniciar sesión | RF-002 |
| HU-03 – Gestionar sucursales | RF-003 |
| HU-04 – Registrar categorías | RF-004 |
| HU-05 – Registrar proveedores | RF-005 |
| HU-06 – Registrar productos | RF-006 |
| HU-07 – Registrar entradas de inventario | RF-007 |
| HU-08 – Registrar salidas de inventario | RF-008 |
| HU-09 – Registrar ventas | RF-009 |
| HU-10 – Consultar existencias | RF-010 |
| HU-11 – Alertar productos con stock mínimo | RF-011 |
| HU-12 – Generar reportes de inventario | RF-012 |
| HU-13 – Generar reportes por sucursal | RF-013 |

Toda HU de Fase 1 traza a exactamente un RF, y todo RF traza a exactamente una HU (RF-008 referencia además a RF-009 como su alternativa de salida por venta).


4. Apéndices

- Glosario: ver sección 1.3.
- Diagramas de apoyo (casos de uso).

5. Índice
