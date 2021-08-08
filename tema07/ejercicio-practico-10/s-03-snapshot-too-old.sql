-- @Autor:        Humberto Serafín Castillo López
-- @Fecha:        07/08/2021
-- @Descripción:  Replicación del error snapshot too old. Se requieren dos
--                sesiones diferentes del Usuario serafin0602

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


-- Terminal 2
--Se inicia la sesión del Usuario
CONNECT serafin0602/serafin

-- Sentencias DML para provocar error en terminal 1
-- 1
DELETE FROM serafin0602.scl_cadena_2
WHERE id BETWEEN 1 AND 5000;
COMMIT;
-- 2
DELETE FROM serafin0602.scl_cadena_2
WHERE id BETWEEN 5001 AND 10000;
COMMIT;
-- 3
DELETE FROM serafin0602.scl_cadena_2
WHERE id BETWEEN 10001 AND 15000;
COMMIT;
-- 4
DELETE FROM serafin0602.scl_cadena_2
WHERE id BETWEEN 15001 AND 20000;
COMMIT;
-- 5
DELETE FROM serafin0602.scl_cadena_2
WHERE id BETWEEN 20001 AND 25000;
COMMIT;
-- 6
DELETE FROM serafin0602.scl_cadena_2
WHERE id BETWEEN 25001 AND 30000;
COMMIT;
-- 7
DELETE FROM serafin0602.scl_cadena_2
WHERE id BETWEEN 30001 AND 35000;
COMMIT;
-- 8
DELETE FROM serafin0602.scl_cadena_2
WHERE id BETWEEN 35001 AND 40000;
COMMIT;
-- 9
DELETE FROM serafin0602.scl_cadena_2
WHERE id BETWEEN 40001 AND 45000;
COMMIT;
-- 10 Aquí ocurrió el error por segunda vez
DELETE FROM serafin0602.scl_cadena_2
WHERE id BETWEEN 45001 AND 50000;
COMMIT;
-- 11
DELETE FROM serafin0602.scl_cadena_2
WHERE id BETWEEN 50001 AND 55000;
COMMIT;
-- 12
DELETE FROM serafin0602.scl_cadena_2
WHERE id BETWEEN 55001 AND 60000;
COMMIT;
-- 13
DELETE FROM serafin0602.scl_cadena_2
WHERE id BETWEEN 60001 AND 65000;
COMMIT;
-- 14
DELETE FROM serafin0602.scl_cadena_2
WHERE id BETWEEN 65001 AND 70000;
COMMIT;
-- 15 Aquí ocurrió el error por primera vez
DELETE FROM serafin0602.scl_cadena_2
WHERE id BETWEEN 70001 AND 75000;
COMMIT;
