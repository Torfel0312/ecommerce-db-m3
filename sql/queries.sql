-- ==================================================
-- Módulo 3 - E-commerce
-- Script: queries.sql (25 Consultas + Transacción)
-- ==================================================

-- --------------------------------------------------
-- A. CONSULTAS BÁSICAS Y FILTROS (1-5)
-- --------------------------------------------------

-- 1. Listar todos los clientes registrados
SELECT * FROM users;

-- 2. Listar todos los productos con su precio y stock actual
SELECT name, price, stock FROM products;

-- 3. Filtrar productos de la categoría 'Electrónica' (asumiendo ID 1)
-- Requisito: Búsqueda por categoría
SELECT * FROM products WHERE category_id = 1;

-- 4. Búsqueda de productos por nombre (que contengan "Pro")
-- Requisito: Búsqueda de productos por nombre
SELECT * FROM products WHERE name LIKE '%Pro%';

-- 5. Listar órdenes que todavía están en estado 'pending'
SELECT * FROM orders WHERE status = 'pending';


-- --------------------------------------------------
-- B. CONSULTAS CON JOIN (6-10)
-- --------------------------------------------------

-- 6. Listar productos mostrando el nombre de su categoría (en lugar del ID)
SELECT p.name AS producto, p.price, c.name AS categoria
FROM products p
JOIN categories c ON p.category_id = c.id;

-- 7. Mostrar quién hizo cada orden (Unir Órdenes con Usuarios)
SELECT o.id AS order_id, o.date, u.name AS cliente, o.total_amount
FROM orders o
JOIN users u ON o.user_id = u.id;

-- 8. Ver el detalle de productos de una orden específica (ej. Orden #1)
SELECT oi.order_id, p.name, oi.quantity, oi.unit_price
FROM order_items oi
JOIN products p ON oi.product_id = p.id
WHERE oi.order_id = 1;

-- 9. Listar pagos realizados incluyendo el nombre del cliente asociado a la orden
SELECT py.id, py.amount, py.method, u.name AS cliente
FROM payments py
JOIN orders o ON py.order_id = o.id
JOIN users u ON o.user_id = u.id;

-- 10. Listar productos y sus categorías, incluso si no tienen categoría asignada (LEFT JOIN)
SELECT p.name, c.name AS categoria
FROM products p
LEFT JOIN categories c ON p.category_id = c.id;


-- --------------------------------------------------
-- C. AGREGACIONES Y KPIs (11-18)
-- --------------------------------------------------

-- 11. Calcular el total de ventas históricas (Suma de todas las órdenes pagadas o enviadas)
SELECT SUM(total_amount) AS total_ventas
FROM orders
WHERE status IN ('paid', 'shipped');

-- 12. Contar cuántas órdenes hay por cada estado (KPI de operación)
SELECT status, COUNT(*) AS cantidad_ordenes
FROM orders
GROUP BY status;

-- 13. Obtener el precio promedio de los productos en el inventario
SELECT AVG(price) AS precio_promedio FROM products;

-- 14. Ticket Promedio: Valor promedio de venta por orden
-- Requisito: Ticket promedio
SELECT AVG(total_amount) AS ticket_promedio FROM orders WHERE status != 'cancelled';

-- 15. Total de stock acumulado por categoría
SELECT c.name, SUM(p.stock) AS total_stock
FROM products p
JOIN categories c ON p.category_id = c.id
GROUP BY c.name;

-- 16. Ventas totales por mes
-- Requisito: Ventas por mes
SELECT 
    DATE_FORMAT(date, '%Y-%m') AS mes, 
    SUM(total_amount) AS total_vendido,
    COUNT(*) AS num_ordenes
FROM orders
GROUP BY DATE_FORMAT(date, '%Y-%m')
ORDER BY mes;

-- 17. Ventas totales por Categoría (Requiere unir OrderItems -> Products -> Categories)
-- Requisito: Ventas por categoría
SELECT c.name AS categoria, SUM(oi.quantity * oi.unit_price) AS total_generado
FROM order_items oi
JOIN products p ON oi.product_id = p.id
JOIN categories c ON p.category_id = c.id
GROUP BY c.name
ORDER BY total_generado DESC;

-- 18. Top 3 productos más vendidos (por cantidad)
-- Requisito: Top N productos
SELECT p.name, SUM(oi.quantity) AS total_vendido
FROM order_items oi
JOIN products p ON oi.product_id = p.id
GROUP BY p.name
ORDER BY total_vendido DESC
LIMIT 3;


-- --------------------------------------------------
-- D. SUBCONSULTAS Y LÓGICA DE NEGOCIO (19-25)
-- --------------------------------------------------

-- 19. Productos con Stock Bajo (ej. menos de 10 unidades)
-- Requisito: Stock bajo
SELECT name, stock FROM products WHERE stock < 10;

-- 20. Productos que NUNCA se han vendido
-- Requisito: Productos sin ventas
SELECT name FROM products 
WHERE id NOT IN (SELECT DISTINCT product_id FROM order_items);

-- 21. Clientes Frecuentes (que han hecho más de 1 orden)
-- Requisito: Clientes frecuentes
SELECT u.name, COUNT(o.id) AS compras
FROM users u
JOIN orders o ON u.id = o.user_id
GROUP BY u.name
HAVING compras > 1;

-- 22. Orden más cara registrada
SELECT * FROM orders 
WHERE total_amount = (SELECT MAX(total_amount) FROM orders);

-- 23. Usuarios que se registraron pero AÚN NO compran nada
SELECT name FROM users 
WHERE id NOT IN (SELECT DISTINCT user_id FROM orders);

-- 24. Ingresos por método de pago
SELECT method, SUM(amount) AS total
FROM payments
GROUP BY method;

-- 25. Productos caros (precio mayor al promedio de todos los productos)
SELECT name, price 
FROM products 
WHERE price > (SELECT AVG(price) FROM products);


-- ==================================================
-- TRANSACCIÓN DE PRUEBA
-- Escenario: El usuario 2 (Maria) compra 1 'Lámpara LED' (ID 6).
-- ==================================================

START TRANSACTION;

-- 1. Crear la cabecera de la orden
INSERT INTO orders (user_id, total_amount, status) 
VALUES (2, 25.00, 'pending');

-- 2. Obtener el ID de la orden recién creada (Variable de sesión)
SET @order_id = LAST_INSERT_ID();

-- 3. Insertar los ítems de la orden
-- Nota: La lámpara (ID 6) cuesta 25.00
INSERT INTO order_items (order_id, product_id, quantity, unit_price)
VALUES (@order_id, 6, 1, 25.00);

-- 4. Actualizar/Descontar stock del producto
UPDATE products 
SET stock = stock - 1 
WHERE id = 6;

-- 5. Confirmar transacción
COMMIT;

