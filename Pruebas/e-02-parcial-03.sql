-- @Autor:        Humberto Serafín Castillo López
-- @Fecha:        12/08/2021
-- @Descripción:  Respuestas para el examen parcial 3, ejercicio 02

-- A)
-- Para extensiones se puede indicar si serán de tamaño variable o de un
-- tamaño fijo, además de indicar si se administraran de forma local o vía
-- diccionario de datos
--
-- Para los segmentos se puede indicar si la administración del espacio será
-- manual o automática, la última es la recomendada

-- B) Tablesspaces del usuario
SHOW parameter undo_tablespace;
SELECT default_tablespace, temporary_tablespace
FROM dba_users
WHERE username = 'oper';

-- C)
ALTER USER oper_user DEFAULT TABLESPACE oper_tbs;

-- D)
ALTER TABLESPACE <nombre_tbs> OFFLINE;

-- E)
SELECT tablespace_name, file_name FROM dba_data_files;

-- F)
CREATE TABLESPACE oper_tbs
DATAFILE
  '/disk_a/oper_tbs_01.dbf' SIZE 2g,
  '/disk_b/oper_tbs_02.dbf' SIZE 1g
  AUTOEXTEND ON NEXT 50m MAXSIZE 3g
EXTENT MANAGEMENT LOCAL AUTOALLOCATE
SEGMENT SPACE MANAGEMENT AUTO;
