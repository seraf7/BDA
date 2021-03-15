-- @Autor:        Humberto Serafín Castillo López
-- @Fecha:        14/03/2021
-- @Descripción:  Script encargado de crear un nuevo usuario y posteriormente
--                crear una tabla para almacenar datos de la instancia de BD

--Instrucción para detener ejecución del script al detectar el primer error
--sin que se apliquen cambios sobre la BD
whenever sqlerror exit rollback;

--Conexion como sysdba
PROMPT Conectando como usuario sys
CONNECT sys/system1 as sysdba

--Verifica si el usrio serafin0201 existe en la BD
DECLARE
  v_count NUMBER;
  v_username VARCHAR2(20) := 'SERAFIN0201';
BEGIN
  SELECT COUNT(*) INTO v_count FROM all_users WHERE username=v_username;
  IF v_count > 0 THEN
    --Borra el usuario existente
    EXECUTE IMMEDIATE 'drop user ' || v_username || ' cascade';
  END IF;
END;
/

--Creación de un nuevo usuario que usa el tablespace users
PROMPT Creando al usuario serafin0201
CREATE USER serafin0201 IDENTIFIED BY serafin QUOTA UNLIMITED ON users;

--Creación de la tabla database_info
PROMPT Creando la tabla database_info
CREATE TABLE serafin0201.database_info(
  instance_name VARCHAR2(16),
  db_domain VARCHAR2(20),
  db_charset VARCHAR2(15),
  sys_timestamp VARCHAR2(40),
  timezone_offset VARCHAR2(10),
  db_block_size_bytes NUMBER(5, 0),
  os_block_size_bytes NUMBER(5, 0),
  redo_block_size_bytes NUMBER(5, 0),
  total_components NUMBER(5, 0),
  total_components_mb NUMBER(10, 2),
  max_component_name VARCHAR2(30),
  max_component_desc VARCHAR2(64),
  max_component_mb NUMBER(10, 0)
);

--Inserción de registro con información de la BD
INSERT INTO serafin0201.database_info(instance_name, db_domain, db_charset,
  sys_timestamp, timezone_offset, db_block_size_bytes, os_block_size_bytes,
  redo_block_size_bytes, total_components, total_components_mb,
  max_component_name, max_component_desc, max_component_mb)
VALUES (
  --Obtiene nombre de la instancia
  (SELECT instance_name FROM v$instance),
  --Obtiene el dominio de la instancia
  (SELECT value FROM v$parameter WHERE name='db_domain'),
  --Obtiene el conjunto de caracteres
  (SELECT value FROM nls_database_parameters
  WHERE parameter='NLS_CHARACTERSET'),
  --Obtiene la fecha y zona horaria del sistema
  (SELECT systimestamp FROM dual),
  --Obtiene el offset de la zona horaria
  (SELECT tz_offset((SELECT sessiontimezone FROM dual)) FROM dual),
  --Obtiene el tamaño de bloque de la BD
  (SELECT value FROM v$parameter WHERE name='db_block_size'),
  --tamaño de bloque del SO
  --sudo tune2fs -l /dev/sda8 | grep "Block size"
  ('4096'),
  --Tamaño de bloque de archivos Redo Log
  (SELECT blocksize FROM v$log WHERE status='CURRENT'),
  --Obtiene el número de componentes instalados
  (SELECT COUNT(occupant_name) FROM v$sysaux_occupants),
  --Calculo del espacio total usado por los componentes en MB
  (SELECT ROUND(SUM(space_usage_kbytes)/1024, 2) FROM v$sysaux_occupants),
  --Obtiene nombre del componente de mayor tamaño
  (SELECT v.occupant_name FROM v$sysaux_occupants v,
    (SELECT MAX(space_usage_kbytes) AS maximo FROM v$sysaux_occupants) r
  WHERE v.space_usage_kbytes=r.maximo),
  --Obtiene descripción del componente de mayor tamaño
  (SELECT v.occupant_desc FROM v$sysaux_occupants v,
    (SELECT MAX(space_usage_kbytes) AS maximo FROM v$sysaux_occupants) r
  WHERE v.space_usage_kbytes=r.maximo),
  --Obtiene espacion en MB del componente de mayor tamaño
  (SELECT ROUND(MAX(space_usage_kbytes)/1024, 2) FROM v$sysaux_occupants)
);

--Muestra contenido de database_info
PROMPT Mostrando datos parte 1
--Se ajusta el tamaño de linea a la ventana
SET LINESIZE window
--Ajuste del ancho de columa
COLUMN db_domain FORMAT a10
SELECT instance_name, db_domain, db_charset, sys_timestamp, timezone_offset
FROM serafin0201.database_info;

PROMPT Mostrando datos parte 2
SELECT db_block_size_bytes, os_block_size_bytes, redo_block_size_bytes,
  total_components, total_components_mb
FROM serafin0201.database_info;

PROMPT Mostrando datos parte 3
COLUMN max_component_desc FORMAT a40
SELECT max_component_name, max_component_desc, max_component_mb
FROM serafin0201.database_info;

--Para regresar a la configuracion original
whenever sqlerror continue none;
