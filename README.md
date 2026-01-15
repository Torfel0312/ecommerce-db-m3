# E-commerce Database - Módulo 3

Este repositorio contiene el proyecto final del Módulo 3. Se trata del modelado y construcción de una base de datos relacional para una plataforma de E-commerce, incluyendo Diagrama ER, scripts SQL de creación (DDL), poblado de datos (DML) y consultas de negocio.

## 🔗 Repositorio
**Link al repositorio público:** [https://github.com/Torfel0312/ecommerce-db-m3](https://github.com/Torfel0312/ecommerce-db-m3)

## 📋 Estructura del Proyecto
El proyecto está organizado de la siguiente manera:

* `/docs`: Contiene la documentación y el diagrama ER.
* `/sql`: Contiene los scripts SQL necesarios.
    * `schema.sql`: Estructura de tablas y restricciones (DDL).
    * `seed.sql`: Datos de prueba iniciales (DML).
    * `queries.sql`: 25 Consultas de negocio y transacción de prueba.

## 🖼️ Diagrama Entidad-Relación (ER)
El modelo de datos respeta las cardinalidades y relaciones requeridas (Usuarios, Productos, Órdenes, Ítems, etc.).

![Diagrama ER](./docs/er.png)

---

## ⚙️ Instrucciones de Ejecución

Sigue estos pasos para levantar el proyecto en tu entorno local (MySQL):

1.  **Clonar el repositorio:**
    ```bash
    git clone [https://github.com/Torfel0312/ecommerce-db-m3.git](https://github.com/Torfel0312/ecommerce-db-m3.git)
    cd ecommerce-db-m3
    ```

2.  **Crear la Base de Datos:**
    Ingresa a tu cliente MySQL (Workbench, DBeaver o Terminal) y ejecuta:
    ```sql
    CREATE DATABASE ecommerce_db;
    USE ecommerce_db;
    ```

3.  **Ejecutar Scripts (en orden estricto):**
    * **Paso 1:** Ejecuta el contenido de `sql/schema.sql` para crear las tablas y relaciones.
    * **Paso 2:** Ejecuta el contenido de `sql/seed.sql` para insertar los datos de prueba.
    * **Paso 3:** Ejecuta las consultas de `sql/queries.sql` para verificar los KPIs.

---

## 📊 Resultados del Análisis (Evidencias)

A continuación se presentan las evidencias de ejecución de las consultas clave solicitadas en el alcance (KPIs).

### 1. Ventas Totales por Mes
*Consulta que agrupa el monto total vendido y la cantidad de órdenes por mes.*

| Mes     | Total Vendido | Num Ordenes |
| :--- | :--- | :--- |
| 2025-10 | 1280.00       | 2           |
| 2025-11 | 1100.00       | 2           |
| 2025-12 | 110.00        | 2           |

### 2. Top 3 Productos Más Vendidos
*Identificación de los productos con mayor rotación (cantidad).*

> **Resultado:**
> 1. Jeans Clásicos (2 unidades)
> 2. Laptop Pro (1 unidad)
> 3. Smartphone X (1 unidad)

### 3. Clientes Frecuentes
*Usuarios que han realizado más de 1 orden en la plataforma.*

```text
+------------+---------+
| name       | compras |
+------------+---------+
| Juan Pérez | 3       |
+------------+---------+