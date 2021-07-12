-- @Autor:        Humberto Serafín Castillo López
-- @Fecha:        07/07/2021
-- @Descripción:  Ejercicios del tema 06 parte 02. Enfoque a la creación y
--                configuración de tablespace

-- A) Creación de un tablespace
CREATE TABLESPACE store_tbs1
DATAFILE '/u01/app/oracle/oradata/SCLBDA2/store_tbs01.dbf' SIZE 20m
EXTENT MANAGEMENT LOCAL AUTOALLOCATE
SEGMENT SPACE MANAGEMENT AUTO;

-- B) Tablespace con múltiples data files
CREATE TABLESPACE store_tbs_multiple
DATAFILE
  '/u01/app/oracle/oradata/SCLBDA2/store_tbs_multiple_01.dbf' SIZE 10m,
  '/u02/app/oracle/oradata/SCLBDA2/store_tbs_multiple_02.dbf' SIZE 10m,
  '/u03/app/oracle/oradata/SCLBDA2/store_tbs_multiple_03.dbf' SIZE 10m
EXTENT MANAGEMENT LOCAL AUTOALLOCATE
SEGMENT SPACE MANAGEMENT AUTO;

-- C) Tablespace personalizado
CREATE TABLESPACE store_tbs_custom
DATAFILE '/u01/app/oracle/oradata/SCLBDA2/store_tbs_custom_01.dbf'
  SIZE 10m
  REUSE
  AUTOEXTEND ON NEXT 1m MAXSIZE 30m
NOLOGGING
BLOCKSIZE 8k
OFFLINE
EXTENT MANAGEMENT LOCAL UNIFORM SIZE 64k
SEGMENT SPACE MANAGEMENT AUTO;

-- D) Usuario con tablespace por default
CREATE USER serafin06_store IDENTIFIED BY serafin
QUOTA UNLIMITED ON store_tbs1
DEFAULT TABLESPACE store_tbs1;
