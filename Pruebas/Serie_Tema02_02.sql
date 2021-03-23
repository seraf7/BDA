SELECT * FROM puesto
WHERE SUBSTR(nombre, 0, 1) BETWEEN 'A' AND 'J';

SELECT * FROM puesto
WHERE SUBSTR(nombre, 0, 1) BETWEEN 'K' AND 'R';

SELECT * FROM puesto
WHERE SUBSTR(nombre, 0, 1) BETWEEN 'S' AND 'Z';

--Consulta de empleados analistas
SELECT emp1.nombre, ae2.rol, ae2.duracion
FROM emp1
INNER JOIN ae1
ON emp1.empleado_id = ae1.empleado_id
INNER JOIN pu1
ON pu1.puesto_id = emp1.puesto_id
WHERE pu1.nombre = 'analista';

--Empleados con más de 3 meses en sitio 1
SELECT emp1.nombre, ae1.rol, ae2.duracion
FROM emp1
JOIN ae1
ON emp1.empleado_id = ae1.puesto_id
WHERE ae1.duracion > 3;

--Empleados con más de 3 meses en sitio 2
SELECT emp2.nombre, ae2.rol, ae2.duracion
FROM emp2
JOIN ae2
ON emp2.empleado_id = ae2.puesto_id
WHERE ae2.duracion > 3;

--Empleados con más de 3 meses en sitio 3
SELECT emp3.nombre, ae3.rol, ae3.duracion
FROM emp3
JOIN ae3
ON emp3.empleado_id = ae3.puesto_id
WHERE ae3.duracion > 3;

--Fragmentación de usuario
SELECT * FROM usuario
WHERE fecha_registro <= TO_DATE('yyyy-mm-dd', 2010-12-2010)
AND email LIKE '%social.music.com';

SELECT * FROM usuario
WHERE fecha_registro <= TO_DATE('yyyy-mm-dd', 2010-12-2010)
AND email NOT LIKE '%social.music.com';

--Fragmentación de canción
SELECT * FROM cancion
WHERE duracion <= 180;

SELECT * FROM cancion
WHERE duracion > 180;

--Alternativa
--instr busca ocurrencias de una subcadena dentro de una cadena
--con > 0, indicamos que al menos hay una ocurrencia
SELECT * FROM usuario
WHERE fecha_registro <= TO_DATE('yyyy-mm-dd', 2010-12-2010)
AND email INSTR(email, 'social.music.com', 1, 1) > 0;
