# Ejercicio 1: Reglas de Integridad

- **Dado un modelo de base de datos de una universidad, identificar violaciones posibles a la integridad referencial si se elimina un estudiante con cursos inscriptos. ¿Qué mecanismos usarías para evitarlo?**


    La integridad referencial es un concepto del diseño de bases de datos, cuya esencia es que la base de datos debe exhibir precisión y coherencia en los datos y que los mismos deben estar sincronizados entre las diferentes tablas que la conformen. 

    Los mecanismos que se emplean para alcanzar la integridad referencial se integran en un conjunto denominado como Normalización, cuyo contenido se conoce como Formas Normales. Las Formas Normales consisten en una serie de prácticas o acciones, idealmente ejecutadas durante la etapa del diseño de la base de datos. Se considera que la simple aplicación de las tres primeras formas, soluciona la amplia mayoría de los potenciales problemas de integridad.

    Para el caso planteado, el diseño debería tener separados los estudiantes de los cursos en tablas diferentes, que se relacionarían entre sí a partir de una tercera tabla, que contenga los alumnos y sus cursos.

# Mecanismos

- Las claves de la tercer tabla, que la unen a las tabla de estudiantes y a la tabla de cursos, son del tipo Clave Foranea, creadas para asegurar la integridad referencial. 

    Para prevenir posibles violaciones a esta integridad, se puede definir estas relaciones con restricción de borrado y/o de actualización. Por ejemplo, en MySQL se definirían las relaciones como ON DELETE / ON UPDATE RESTRICT.