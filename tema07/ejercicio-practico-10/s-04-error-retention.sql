-- @Autor:        Humberto Serafín Castillo López
-- @Fecha:        07/08/2021
-- @Descripción:

-- Se da preferencia a consultas largas para usar datos undo en el tablespace
-- Ejecutar como sys
ALTER TABLESPACE undotbs2 RETENTION GUARANTEE;

-- Terminal 1
--Se inicia la sesión del Usuario
CONNECT serafin0602/serafin

-- Creación de una transacción con lecturas repetibles
SET TRANSACTION ISOLATION LEVEL SERIALIZABLE NAME 'T1-RC';

-- Consultas que se deben repetir despues de cada COMMIT en terminal 2
SELECT COUNT(*) FROM scl_cadena_2;

SELECT COUNT(*)
FROM scl_cadena_2
WHERE cadena LIKE 'A%'
OR cadena LIKE 'Z%'
OR cadena LIKE 'M%';

-- Terminal 2, usando sesión del Usuario serafin0602
-- 1
DELETE FROM scl_cadena_2
WHERE id BETWEEN 50001 AND 55000;
COMMIT;
-- 2
DELETE FROM scl_cadena_2
WHERE id BETWEEN 55001 AND 60000;
COMMIT;
-- 3
DELETE FROM scl_cadena_2
WHERE id BETWEEN 60001 AND 65000;
COMMIT;
-- 4
DELETE FROM scl_cadena_2
WHERE id BETWEEN 65001 AND 70000;
COMMIT;
-- 5
DELETE FROM scl_cadena_2
WHERE id BETWEEN 70001 AND 75000;
COMMIT;
-- 6
DELETE FROM scl_cadena_2
WHERE id BETWEEN 75001 AND 80000;
COMMIT;
-- 7
DELETE FROM scl_cadena_2
WHERE id BETWEEN 80001 AND 85000;
COMMIT;
-- 8 Aquí suceció error por no poder extender el tablespace
DELETE FROM scl_cadena_2
WHERE id BETWEEN 85001 AND 90000;
COMMIT;
-- 9
DELETE FROM scl_cadena_2
WHERE id BETWEEN 90001 AND 95000;
COMMIT;
-- 10
DELETE FROM scl_cadena_2
WHERE id BETWEEN 95001 AND 100000;
COMMIT;
