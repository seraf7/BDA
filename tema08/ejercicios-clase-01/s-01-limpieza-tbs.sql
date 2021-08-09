-- @Autor:        Humberto Serafín Castillo López
-- @Fecha:        05/08/2021
-- @Descripción:  Preparación del ambiente de la base de datos para realizar
--                respaldos

-- Eliminar tablespaces no usados
DROP TABLESPACE store_tbs1 INCLUDING CONTENTS AND DATAFILES;
DROP TABLESPACE store_tbs_multiple INCLUDING CONTENTS AND DATAFILES;
DROP TABLESPACE store_tbs_custom INCLUDING CONTENTS AND DATAFILES;
DROP TABLESPACE undotbs2 INCLUDING CONTENTS AND DATAFILES;

-- Consulta de los archive redo logs que se han realizado por cada destino
SELECT dest_id, count(*) AS total_archived
FROM v$archived_log
GROUP BY dest_id;

-- Consulta el total de archive redo logs que existen en cada destino
-- Al contar sobre la columna name, se descartan los nulos pues dichos
-- pues dichos archivos ya no existen físicamente
SELECT dest_id, count(name) AS total_archived
FROM v$archived_log
GROUP BY dest_id;
