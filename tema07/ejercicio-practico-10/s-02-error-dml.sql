-- @Autor:        Humberto Serafín Castillo López
-- @Fecha:        07/08/2021
-- @Descripción:  Sentencias para provocar error por falta de espacio en el
--                tablespace UNDO

-- Operaciones de borrado para replicar error de sentencias DML
DELETE FROM serafin0602.scl_cadena_2
WHERE id BETWEEN 1 AND 5000;

DELETE FROM serafin0602.scl_cadena_2
WHERE id BETWEEN 5001 AND 10000;

DELETE FROM serafin0602.scl_cadena_2
WHERE id BETWEEN 10001 AND 15000;

DELETE FROM serafin0602.scl_cadena_2
WHERE id BETWEEN 15001 AND 20000;

DELETE FROM serafin0602.scl_cadena_2
WHERE id BETWEEN 20001 AND 25000;

-- Se regeneran los datos
ROLLBACK;
