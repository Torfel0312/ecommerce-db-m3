-- ==================================================
-- Módulo 3 - E-commerce
-- Script DML: Datos de Semilla (Seed)
-- ==================================================

-- 1. Insertar Usuarios
INSERT INTO users (name, email, password, address) VALUES
('Juan Pérez', 'juan.perez@example.com', 'pass123', 'Av. Siempre Viva 123, Santiago'),
('Maria Gonzalez', 'maria.gonzalez@example.com', 'pass456', 'Calle Falsa 456, Valparaíso'),
('Carlos Lopez', 'carlos.lopez@example.com', 'pass789', 'Pasaje Los Alerces 789, Concepción'),
('Ana Torres', 'ana.torres@example.com', 'pass321', 'Ruta 5 Sur, Temuco'),
('Pedro Ruiz', 'pedro.ruiz@example.com', 'pass654', 'Alameda 100, Santiago');

-- 2. Insertar Categorías
INSERT INTO categories (name) VALUES
('Electrónica'),
('Ropa'),
('Hogar'),
('Deportes'),
('Libros');

-- 3. Insertar Productos
-- Nota: Asumimos los IDs 1 a 5 para las categorías insertadas arriba
INSERT INTO products (name, description, price, stock, category_id) VALUES
('Smartphone X', 'Teléfono inteligente gama alta', 800.00, 50, 1),
('Laptop Pro', 'Portátil para desarrolladores', 1200.00, 30, 1),
('Camiseta Básica', 'Camiseta de algodón 100%', 20.00, 100, 2),
('Jeans Clásicos', 'Pantalón de mezclilla', 40.00, 80, 2),
('Sofá 3 Cuerpos', 'Sofá cómodo para sala de estar', 300.00, 10, 3),
('Lámpara LED', 'Lámpara de escritorio con luz ajustable', 25.00, 50, 3),
('Balón de Fútbol', 'Balón profesional tamaño 5', 30.00, 100, 4),
('Pesas 5kg', 'Set de pesas para ejercicio', 50.00, 5, 4), -- Stock bajo
('El Señor de los Anillos', 'Edición completa tapa dura', 60.00, 20, 5),
('Aprende SQL', 'Guía completa de bases de datos', 35.00, 0, 5); -- Sin stock

-- 4. Insertar Órdenes
-- Insertamos órdenes con fechas pasadas para tener historial
INSERT INTO orders (user_id, date, total_amount, status) VALUES
(1, '2025-10-01 10:00:00', 1240.00, 'shipped'), -- Juan compra Laptop + Jeans
(2, '2025-10-05 14:30:00', 40.00, 'shipped'),   -- Maria compra Jeans
(1, '2025-11-10 09:15:00', 800.00, 'shipped'),   -- Juan compra Smartphone
(3, '2025-11-20 18:00:00', 300.00, 'pending'),   -- Carlos compra Sofá
(4, '2025-12-01 11:00:00', 60.00, 'paid'),       -- Ana compra Libro
(1, '2025-12-05 16:45:00', 50.00, 'paid');       -- Juan compra Pesas (Cliente frecuente)

-- 5. Insertar Detalles de Orden (Order Items)
-- Deben coincidir con los totales de arriba
INSERT INTO order_items (order_id, product_id, quantity, unit_price) VALUES
-- Orden 1 (Total 1240)
(1, 2, 1, 1200.00), -- Laptop
(1, 4, 1, 40.00),   -- Jeans
-- Orden 2 (Total 40)
(2, 4, 1, 40.00),   -- Jeans
-- Orden 3 (Total 800)
(3, 1, 1, 800.00),  -- Smartphone
-- Orden 4 (Total 300)
(4, 5, 1, 300.00),  -- Sofá
-- Orden 5 (Total 60)
(5, 9, 1, 60.00),   -- Libro
-- Orden 6 (Total 50)
(6, 8, 1, 50.00);   -- Pesas

-- 6. Insertar Pagos
INSERT INTO payments (order_id, amount, payment_date, method) VALUES
(1, 1240.00, '2025-10-01 10:05:00', 'credit_card'),
(2, 40.00, '2025-10-05 14:35:00', 'paypal'),
(3, 800.00, '2025-11-10 09:20:00', 'transfer'),
(5, 60.00, '2025-12-01 11:05:00', 'credit_card'),
(6, 50.00, '2025-12-05 16:50:00', 'credit_card');
-- La orden 4 de Carlos está 'pending', simulamos que no ha pagado aún.