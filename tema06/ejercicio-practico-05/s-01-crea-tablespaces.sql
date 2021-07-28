-- @Autor:        Humberto Serafín Castillo López
-- @Fecha:        26/07/2021
-- @Descripción:  Creación de tablespaces con distintas configuraciones

--Conexión como sys
CONNECT sys/system2 AS sysdba

--Creación de un tablespace de tamaño fijo, manejo de extensiones local y
--tamaño automático, administración de segmentos automática
CREATE TABLESPACE store_tbs1
DATAFILE '/u01/app/oracle/oradata/SCLBDA2/store_tbs01.dbf' SIZE 20M
EXTENT MANAGEMENT LOCAL AUTOALLOCATE
SEGMENT SPACE MANAGEMENT AUTO;

--Tablespace con múltiples data files de tamaño fijo
CREATE TABLESPACE store_tbs_multiple
DATAFILE
  '/u01/app/oracle/oradata/SCLBDA2/store_tbs_multiple_01.dbf' SIZE 10M,
  '/u02/app/oracle/oradata/SCLBDA2/store_tbs_multiple_02.dbf' SIZE 10M,
  '/u03/app/oracle/oradata/SCLBDA2/store_tbs_multiple_03.dbf' SIZE 10M
EXTENT MANAGEMENT LOCAL AUTOALLOCATE
SEGMENT SPACE MANAGEMENT AUTO;

--Tablespace personalizado, un data file que se va a sobreescribir si
-- existe, sin generar datos de REDO, crecimiento dinámico, con extensiones de
-- tamaño fijo y administración automática de los segmentos
CREATE TABLESPACE store_tbs_custom
DATAFILE '/u01/app/oracle/oradata/SCLBDA2/store_tbs_custom_01.dbf'
  SIZE 10M
  REUSE
  AUTOEXTEND ON NEXT 1M MAXSIZE 30M
NOLOGGING
BLOCKSIZE 8K
OFFLINE
EXTENT MANAGEMENT LOCAL UNIFORM SIZE 64K
SEGMENT SPACE MANAGEMENT AUTO;

--Usuario con tablespace por default específico y cuota ilimitada
CREATE USER store_user IDENTIFIED BY store_user
QUOTA UNLIMITED ON store_tbs1
DEFAULT TABLESPACE store_tbs1;
