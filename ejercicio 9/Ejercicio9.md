# Como hacer un backup completo?

- pasar los archivos al backup (puede ser de forma especifica o general):

~~~
// backup de una base de datos especifica:
mysqldump -u TU_USUARIO -p NOMBRE_BASE_DE_DATOS > backup_completo.sql

// backup de todas las base de datos:
mysqldump -u TU_USUARIO -p --all-databases > backup_full.sql
~~~

- restaurar los datos almacenados en el backup:

~~~
// restauramos una base de datos especifica
mysql -u TU_USUARIO -p NOMBRE_BASE_DE_DATOS < backup_completo.sql

//restauramos todas las bases de datos
mysql -u root -p < backup_todas_bases.sql
~~~

- todo esto tambien se puede lograr de manera automatica usando crontab, que es un sistema operativo de linux

## Simulacion de perdida de datos

~~~
// Creamos la base de datos del local de trabajo
CREATE DATABASE Negocio;

// Creamos la tabla
CREATE TABLE Clientes (
    clienteid INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(100),
    edad INT
);

// Insertamos los datos
INSERT INTO Clientes (nombre, edad) VALUES
('Pedro Perez', 24),
('Martina Martinez', 32);

// Hacemos el backup
mysqldump -u root -p Negocio > backup.sql

// Simulamos la perdida de estos datos
DROP DATABASE Negocio;

// Restauramos la base de datos perdida
mysql -u root -p Negocio < backup_simulacion.sql
~~~
