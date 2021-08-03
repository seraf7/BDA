-- @Autor:        Humberto Serafín Castillo López
-- @Fecha:        01/08/2021
-- @Descripción:  Script para simular la pérdida de un data file y el
--                reestablecimiento de salud de la BD

--Como usuario oracle, se borra el data file
!rm /u01/app/oracle/oradata/SCLBDA2/store_tbs01.dbf

--Se intenta poner el otro data file en modo offline
--La instrucción falla debido a que la BD se encuentra en modo NOARCHIVELOG
ALTER DATABASE DATAFILE
  '/u01/app/oracle/oradata/SCLBDA2/store_tbs02.dbf'
OFFLINE;

--Se coloca todo el tablespace afectado en modo offline
ALTER TABLESPACE store_tbs1 OFFLINE;

--Se detiene la instancia
--La operación se realiza correctamente debido a que el tablespace afectado
--se encuentra marcado offline y no se realiza sincronización
SHUTDOWN IMMEDIATE

--Se inicia la instancia
--La instancia se levanta correctamente a pesar del data file dañado ya que el
--tablespace se encuentra offline, los datos serán inaccesibles
STARTUP

--Recuperación del daño
--Se debe borrar el tablespace junto a sus datafiles
DROP TABLESPACE store_tbs1 INCLUDING CONTENTS AND DATAFILES;

--Se recrea el tablespace con nuevos data files de características similares
CREATE TABLESPACE store_tbs1
DATAFILE
  '/u01/app/oracle/oradata/SCLBDA2/store_tbs01.dbf' SIZE 20M,
  '/u01/app/oracle/oradata/SCLBDA2/store_tbs02.dbf' SIZE 5M
EXTENT MANAGEMENT LOCAL AUTOALLOCATE
SEGMENT SPACE MANAGEMENT AUTO;
