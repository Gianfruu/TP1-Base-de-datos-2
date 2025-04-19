CREATE DATABASE tienda;
USE tienda;

CREATE TABLE productos (
    id_producto INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(100)
);

CREATE TABLE ventas (
    id_venta INT AUTO_INCREMENT PRIMARY KEY,
    id_producto INT,
    fecha_venta DATETIME,
    cantidad INT,
    FOREIGN KEY (id_producto) REFERENCES productos(id_producto)
);




-- Asegúrate de usar la base de datos correcta
USE tienda;

DELIMITER //

CREATE PROCEDURE generar_ventas()
BEGIN
    DECLARE i INT DEFAULT 0;
    DECLARE block_size INT DEFAULT 10000; -- Tamaño del bloque
    WHILE i < 100000 DO
        INSERT INTO ventas (id_producto, fecha_venta, cantidad)
        SELECT
            FLOOR(1 + (RAND() * 100)), -- producto 1 a 100
            DATE_SUB(NOW(), INTERVAL FLOOR(RAND() * 365) DAY), -- fecha aleatoria
            FLOOR(1 + (RAND() * 10)) -- cantidad
        FROM (SELECT 1 FROM DUAL LIMIT block_size) AS temp;
        SET i = i + block_size;
    END WHILE;
END //

DELIMITER ;

-- Finalmente, llamamos a la procedura para que inserte los datos
CALL generar_ventas();




CREATE VIEW resumen_ventas_mensuales AS
SELECT 
    id_producto,
    DATE_FORMAT(fecha_venta, '%Y-%m') AS mes,
    SUM(cantidad) AS total_vendido
FROM ventas
GROUP BY id_producto, mes;



SELECT 
    id_producto,
    SUM(total_vendido) AS total_vendido
FROM resumen_ventas_mensuales
GROUP BY id_producto
ORDER BY total_vendido DESC
LIMIT 5;
