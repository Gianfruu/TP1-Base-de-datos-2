DROP DATABASE IF EXISTS tecnologia;
CREATE DATABASE tecnologia;
USE tecnologia;

DROP TABLE IF EXISTS alumnos;
DROP TABLE IF EXISTS materias;
DROP TABLE IF EXISTS matriculas;


CREATE TABLE alumnos (
    id_alumno INT PRIMARY KEY AUTO_INCREMENT UNIQUE,
    nombre VARCHAR(50),
    apellido VARCHAR(50)
);

CREATE TABLE materias (
    id_materia INT PRIMARY KEY AUTO_INCREMENT UNIQUE,
    materia VARCHAR(50)
);

CREATE TABLE matriculas (
    alumno_id INT NOT NULL,
    materia_id INT NOT NULL,
    PRIMARY KEY(alumno_id,materia_id),
	FOREIGN KEY(alumno_id) REFERENCES alumnos(id_alumno)
	ON UPDATE CASCADE ON DELETE RESTRICT,
	FOREIGN KEY(materia_id) REFERENCES materias(id_materia)
	ON UPDATE CASCADE ON DELETE RESTRICT    
);

INSERT INTO alumnos(nombre, apellido) VALUES
('Juan','Simón'),
('Hugo', 'Alves'),
('Abelardo', 'Carabelli'),
('Rubén', 'Rossi'),
('Jorge', 'Piaggio'),
('Marcelo', 'Bachino'),
('Daniel', 'Sperandio');

INSERT INTO materias(materia) VALUES
('Física'),
('Matemática'),
('Química'),
('Sistemas'),
('Planeamiento');

insert into matriculas values (1,3);
insert into matriculas values (1,3);