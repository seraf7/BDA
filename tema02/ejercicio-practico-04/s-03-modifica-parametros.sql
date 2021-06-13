-- @Autor:        Humberto Serafín Castillo López
-- @Fecha:        18/04/2021
-- @Descripción:  Script para automatizar la modificación de los parámetros
--                configurados en la BD y posterior almacenamiento en tablas
--                y archivo PFILE

--Instrucción para detener ejecución del script al detectar algún error
--sin aplicar cambios en la BD
whenever sqlerror exit rollback;

--Conexión como sysdba
PROMPT Conectando como usuario sys...
CONNECT sys/system2 AS sysdba

--Comprobación de la existencia de tablas anteriores
DECLARE
  v_count NUMBER;
  v_username VARCHAR2(20) := 'SERAFIN0204';
  v_session VARCHAR2(30) := 'T03_UPDATE_PARAM_SESSION';
  v_instance VARCHAR2(30) := 'T04_UPDATE_PARAM_INSTANCE';
  v_spfile VARCHAR2(30) := 'T05_UPDATE_PARAM_SPFILE';
BEGIN
  --Busca tabla de parámetros de sesión
  SELECT COUNT(*) INTO v_count FROM all_tables WHERE table_name=v_session;
  IF v_count > 0 THEN
    --Elimina tabla indicada
    EXECUTE IMMEDIATE 'drop table ' || v_username || '.' || v_session;
  END IF;

  --Busca tabla de parámetros de instancia
  SELECT COUNT(*) INTO v_count FROM all_tables WHERE table_name=v_instance;
  IF v_count > 0 THEN
    EXECUTE IMMEDIATE 'drop table ' || v_username || '.' || v_instance;
  END IF;

  --Busca tabla de parámetros de SPFILE
  SELECT COUNT(*) INTO v_count FROM all_tables WHERE table_name=v_spfile;
  IF v_count > 0 THEN
    EXECUTE IMMEDIATE 'drop table ' || v_username || '.' || v_spfile;
  END IF;
END;
/

--Cambio del formato de fecha a nivel sesión
PROMPT Cambiando formato de fecha...
ALTER SESSION SET nls_date_format="dd/mm/yyyy hh24:mi:ss";

--Establece 2 procesos iniciales de DB Writer
PROMPT Estableciendo db_writer_processes...
ALTER SYSTEM SET db_writer_processes=2 SCOPE=spfile;

--Establece buffer de 10 MB
PROMPT Estableciendo valor de log_buffer...
ALTER SYSTEM SET log_buffer=10M SCOPE=spfile;

--Establce máximo de data files abiertos simultaneamente
PROMPT Estableciendo valor de db_files...
ALTER SYSTEM SET db_files=250 SCOPE=spfile;

--Establece cantidad máxima de bloqueos en instrucciones DML
PROMPT Estableciendo valor de dml_locks
ALTER SYSTEM SET dml_locks=2500 SCOPE=spfile;

--Establce cantidad de segmentos de rollback
PROMPT Estableciendo valor de transactions...
ALTER SYSTEM SET transactions=600 SCOPE=spfile;

--Establece en 2MB la memoria usada para hash joins para sesión actual
--y reinicios posteriores
PROMPT Estableciendo valor de hash_area_size ...
ALTER SESSION SET hash_area_size = 2097152;
ALTER SYSTEM SET hash_area_size=2097152 SCOPE=spfile;

--Establce en 1MB la memoria usada para ordenamientos a nivel sesión
PROMPT Estableciendo valor de sort_area_size...
ALTER SESSION SET sort_area_size=1048576;

--Habilita datos de debug para sentencias SQL a nivel instancia
PROMPT Estableciendo valor de sql_trace...
ALTER SYSTEM SET sql_trace=TRUE SCOPE=memory;

--Optimización de recursos para recuperar los primeros 100 registros,
--aplicado inmediatamente y permanentemente
PROMPT Estableciendo valor de optimizer_mode...
ALTER SYSTEM SET optimizer_mode=FIRST_ROWS_100 SCOPE=both;

--Uso de validación DEFERRED en cursores a nivel sesión
PROMPT Estableciendo valor de cursor_invalidation...
ALTER SESSION SET cursor_invalidation=DEFERRED;

--Comprobación de cambios de parámetros aplicados en la BD
PROMPT Creando tablas de parámetros modificados...
--Creación de tabla con parámetros modificados a nivel sesión
CREATE TABLE serafin0204.t03_update_param_session AS
  SELECT name, value
  FROM v$parameter
  WHERE name IN(
    'cursor_invalidation', 'optimizer_mode', 'sql_trace', 'sort_area_size',
    'hash_area_size', 'nls_date_format', 'db_writer_processes', 'db_files',
    'dml_locks', 'log_buffer', 'transactions'
  )
  AND value IS NOT NULL;

--Creación de tabla con parámetros modificados a nivel instancia
CREATE TABLE serafin0204.t04_update_param_instance AS
  SELECT name, value
  FROM v$system_parameter
  WHERE name IN (
    'cursor_invalidation', 'optimizer_mode', 'sql_trace', 'sort_area_size',
    'hash_area_size', 'nls_date_format', 'db_writer_processes', 'db_files',
    'dml_locks', 'log_buffer', 'transactions'
  )
  AND value IS NOT NULL;

--Creación de tabla con parámetros modificados a nivel SPFILE
CREATE TABLE serafin0204.t05_update_param_spfile AS
  SELECT name, value
  FROM v$spparameter
  WHERE name IN (
    'cursor_invalidation', 'optimizer_mode', 'sql_trace', 'sort_area_size',
    'hash_area_size', 'nls_date_format', 'db_writer_processes', 'db_files',
    'dml_locks', 'log_buffer', 'transactions'
  )
  AND value IS NOT NULL;

--Creación de un PFILE en directorio t0204 con los cambios realizados
PROMPT Creando nuevo PFILE...
create pfile='/unam-bda/ejercicios-practicos/t0204/e-03-spparameter-pfile.txt'
from spfile;

--Para regresar a la configuración original
whenever sqlerror continue none;
