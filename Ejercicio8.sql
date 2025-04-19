
-- Tabla principalauditoria_clientesauditoria_clientes
CREATE TABLE clientes (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(100),
    email VARCHAR(100)
);

-- Tabla de auditoría
CREATE TABLE auditoria_clientes (
    id INT AUTO_INCREMENT PRIMARY KEY,
    accion VARCHAR(10),
    cliente_id INT,
    datos_viejos JSON,
    datos_nuevos JSON,
    fecha DATETIME DEFAULT CURRENT_TIMESTAMP
);

-- TRIGGERS DE AUDITORÍA

-- Trigger para INSERT
DELIMITER $$
CREATE TRIGGER t_auditoria_clientes_insert
AFTER INSERT ON clientes
FOR EACH ROW
BEGIN
    INSERT INTO auditoria_clientes (
        accion,
        cliente_id,
        datos_viejos,
        datos_nuevos
    ) VALUES (
        'INSERT',
        NEW.id,
        NULL,
        JSON_OBJECT('nombre', NEW.nombre, 'email', NEW.email)
    );
END$$
DELIMITER ;

-- Trigger para UPDATE
DELIMITER $$
CREATE TRIGGER t_auditoria_clientes_update
AFTER UPDATE ON clientes
FOR EACH ROW
BEGIN
    INSERT INTO auditoria_clientes (
        accion,
        cliente_id,
        datos_viejos,
        datos_nuevos
    ) VALUES (
        'UPDATE',
        OLD.id,
        JSON_OBJECT('nombre', OLD.nombre, 'email', OLD.email),
        JSON_OBJECT('nombre', NEW.nombre, 'email', NEW.email)
    );
END$$
DELIMITER ;

-- Trigger para DELETE
DELIMITER $$
CREATE TRIGGER t_auditoria_clientes_delete
AFTER DELETE ON clientes
FOR EACH ROW
BEGIN
    INSERT INTO auditoria_clientes (
        accion,
        cliente_id,
        datos_viejos,
        datos_nuevos
    ) VALUES (
        'DELETE',
        OLD.id,
        JSON_OBJECT('nombre', OLD.nombre, 'email', OLD.email),
        NULL
    );
END$$
DELIMITER ;

-- Ejemplos de uso para probar el sistema
-- Insertar algunos clientes
INSERT INTO clientes (nombre, email) VALUES 
('Juan Pérez', 'juan@ejemplo.com'),
('María López', 'maria@ejemplo.com');

-- Actualizar un cliente
UPDATE clientes SET email = 'juan.perez@ejemplo.com' WHERE id = 1;
UPDATE clientes SET nombre = 'María Antonieta López' WHERE id = 2;
-- Eliminar un cliente
DELETE FROM clientes WHERE id = 2;

-- Consultar la tabla de auditoría para ver los resultados
SELECT * FROM auditoria_clientes;