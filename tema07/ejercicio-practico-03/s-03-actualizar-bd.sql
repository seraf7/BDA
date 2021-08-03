-- @Autor:        Humberto Serafín Castillo López
-- @Fecha:        01/08/2021
-- @Descripción:  Actualización de ubicaciones de data files y activación
--                del tablespace

--Actualización de ubicaciones de data files
ALTER TABLESPACE store_tbs_multiple
  RENAME DATAFILE
    '/u01/app/oracle/oradata/SCLBDA2/store_tbs_multiple_01.dbf',
    '/u02/app/oracle/oradata/SCLBDA2/store_tbs_multiple_02.dbf',
    '/u03/app/oracle/oradata/SCLBDA2/store_tbs_multiple_03.dbf'
  TO
    '/u03/app/oracle/oradata/SCLBDA2/store_tbs_multiple_013.dbf',
    '/u02/app/oracle/oradata/SCLBDA2/store_tbs_multiple_023.dbf',
    '/u01/app/oracle/oradata/SCLBDA2/store_tbs_multiple_031.dbf';

--Se pone en modo online el tablespace
ALTER TABLESPACE store_tbs_multiple ONLINE;

--Conteo de registros de la tabla TEST
--La instrucción falla debido a que el tablespace está en modo online
SELECT COUNT(*) AS total_registros
FROM SERAFIN_TBS_MULTIPLE.serafin_tbs_multiple;

--Reubicación de los data files a su ubicación original, manteniendo
--su estatus online
ALTER DATABASE MOVE DATAFILE
  '/u03/app/oracle/oradata/SCLBDA2/store_tbs_multiple_013.dbf'
TO 
  '/u01/app/oracle/oradata/SCLBDA2/store_tbs_multiple_01.dbf';

ALTER DATABASE MOVE DATAFILE
  '/u02/app/oracle/oradata/SCLBDA2/store_tbs_multiple_023.dbf'
TO
  '/u02/app/oracle/oradata/SCLBDA2/store_tbs_multiple_02.dbf';

ALTER DATABASE MOVE DATAFILE
  '/u01/app/oracle/oradata/SCLBDA2/store_tbs_multiple_031.dbf'
TO
  '/u03/app/oracle/oradata/SCLBDA2/store_tbs_multiple_03.dbf';
