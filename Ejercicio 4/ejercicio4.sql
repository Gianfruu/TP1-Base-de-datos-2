
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


-- Crear índice en nombre de departamento
CREATE INDEX idx_nombre_departamento ON departamentos(nombre);

-- Consulta CON índice y sin explain
SELECT * 
FROM empleados 
JOIN departamentos ON empleados.id_departamento = departamentos.id
WHERE departamentos.nombre = 'Soporte';

-- Consulta CON Indice y con explain
EXPLAIN SELECT * 
FROM empleados 
JOIN departamentos ON empleados.id_departamento = departamentos.id
WHERE departamentos.nombre = 'Ventas';

-- Sacar indice 
DROP INDEX idx_nombre_departamento ON departamentos;
ALTER TABLE departamentos DROP INDEX nombre;


-- Consulta SIN índice y sin explain
SELECT * 
FROM empleados 
JOIN departamentos ON empleados.id_departamento = departamentos.id
WHERE departamentos.nombre = 'Ventas';

-- Consulta  SIN INDICE y con explain
EXPLAIN SELECT * 
FROM empleados 
JOIN departamentos ON empleados.id_departamento = departamentos.id
WHERE departamentos.nombre = 'Ventas';

-- Agregar el indice unico nuevamente
ALTER TABLE departamentos ADD UNIQUE (nombre);