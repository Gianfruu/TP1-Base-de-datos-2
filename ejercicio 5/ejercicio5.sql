
-- elimina las tablas si existen 
DROP TABLE IF EXISTS empleados;
DROP TABLE IF EXISTS departamentos;

-- crea la tabla departamentos 
CREATE TABLE departamentos (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(100) UNIQUE
);

-- agrega departamentos 
INSERT INTO departamentos (nombre) VALUES ('Ventas'), ('Soporte');

-- Tabla Empleados
CREATE TABLE empleados (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(100),
    salario DECIMAL(10,2),
    id_departamento INT,
    FOREIGN KEY (id_departamento) REFERENCES departamentos(id)
);
-- Aumenta el limite de recursión
SET SESSION cte_max_recursion_depth = 100000;

-- agrega 100.000 registros 
INSERT INTO empleados (nombre, salario, id_departamento)
WITH RECURSIVE numeros AS (
  SELECT 1 AS n
  UNION ALL
  SELECT n + 1 FROM numeros WHERE n < 100000
)
SELECT
    CONCAT('Empleado', n),
    ROUND(RAND() * 10000, 2),
    IF(n % 2 = 0, 
        (SELECT id FROM departamentos WHERE nombre = 'Ventas'), 
        (SELECT id FROM departamentos WHERE nombre = 'Soporte')
    )
FROM numeros;

-- agregar la nueva columna fecha_ingreso
ALTER TABLE empleados ADD fecha_ingreso DATE;

-- asigna fechas aleatorias mediante intervalo 
UPDATE empleados
SET fecha_ingreso = DATE_ADD('2010-01-01', INTERVAL FLOOR(RAND() * 4000) DAY);

-- creacion de indices individuales
CREATE INDEX idx_salario ON empleados(salario);
CREATE INDEX idx_fecha ON empleados(fecha_ingreso);

-- creacion del indice 
CREATE INDEX idx_salario_fecha ON empleados(salario, fecha_ingreso);

-- consulta sin explain
SELECT * 
FROM empleados
WHERE salario > 5000 AND fecha_ingreso > '2020-01-01';

-- consulta con explain
EXPLAIN SELECT * 
FROM empleados
WHERE salario > 5000 AND fecha_ingreso > '2020-01-01';

-- eliminar indices 
DROP INDEX idx_salario ON empleados;
DROP INDEX idx_fecha ON empleados;
DROP INDEX idx_salario_fecha ON empleados;




