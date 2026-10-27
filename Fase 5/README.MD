# Fase 5 — Mockup / Prototipo Navegable

## Información del Proyecto
- *Proyecto:* Sistema de Gestión de Inventario para Bodega
- *Fase:* 5 — Diseño de interfaces y flujo de navegación interactivo
- *Objetivo:* Diseñar las interfaces principales, flujos de navegación y validar la experiencia de usuario (UX/UI) antes de la codificación y persistencia en base de datos.

---

## 🔗 Enlace al Prototipo Navegable
El prototipo funcional se encuentra desplegado y listo para su validación interactiva en el siguiente enlace:

👉 **[Ver Prototipo Navegable en Vivo] https://share.gemini.google/3lx39sSvK3hG**

(Nota: Si descargan el repositorio de forma local, pueden abrir directamente el archivo index.html en cualquier navegador web).

---

## 📋 Cumplimiento de Requerimientos Evaluados

| # | Requerimiento | Implementación en el Prototipo |
|---|---|---|
| 1 | *Estructura de navegación* | Arquitectura SPA fluida con barra lateral (sidebar) fija, colapsable y migas de pan dinámicas. |
| 2 | *Pantalla de inicio* | Landing Page institucional con estado de andenes, capacidad operativa en tiempo real y botón de inicio de turno. |
| 3 | *Login / Registro* | Pantalla de acceso por roles (Administrador y Operativo) + pestaña de solicitud de registro para nuevos empleados. |
| 4 | *Dashboard* | Métricas en vivo (unidades totales, valorización COP, stock crítico) y accesos directos operacionales. |
| 5 | *Formularios* | Máscaras automáticas para moneda COP ($ 1.250.000), SKU en mayúsculas asistido y validación de stock disponible. |
| 6 | *Listados* | Tablas estructuradas para Inventario y Kardex transaccional con insignias semánticas de estado de existencias. |
| 7 | *Consultas* | Buscador predictivo en vivo y filtros avanzados por rangos de fecha (Hoy, 7 días, Mes, Personalizado). |
| 8 | *Detalle de registros* | Ventana modal con ficha técnica, ubicación en estantería (pasillo, estante, nivel) e historial exclusivo de movimientos del SKU. |
| 9 | *Mensajes de error y confirmación* | Validación inline contextual por campo (bordes rojos y mensajes de ayuda), alertas flotantes Toast y diálogo modal de confirmación. |
| 10 | *Prototipo navegable* | Reactividad total y simulación en memoria que sincroniza entradas, salidas, dashboard y Kardex sin recargar. |