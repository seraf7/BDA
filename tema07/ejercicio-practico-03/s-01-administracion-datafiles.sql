-- @Autor:        Humberto Serafín Castillo López
-- @Fecha:        01/08/2021
-- @Descripción:  Pasos iniciales para comprobar estado de la BD e inicio
--                de archivos de respaldo

--Poner un data file en modo offline
--La instrucción devuelve un error debido a que la BD no se encuentra en
-- modo ARCHIVELOG, medio de protección para evitar pérdida de datos
ALTER DATABASE DATAFILE
  '/u01/app/oracle/oradata/SCLBDA2/store_tbs_multiple_01.dbf'
OFFLINE;

--Poner el tablespace en modo offline
ALTER TABLESPACE store_tbs_multiple OFFLINE;

--Conteo de registros de la tabla TEST
--La instrucción falla debido a que el tablespace está en modo offline
SELECT COUNT(*) AS total_registros
FROM SERAFIN_TBS_MULTIPLE.serafin_tbs_multiple;

--Consulta del estado de datafiles del tablespace
SELECT file_name, file_id, online_status
FROM dba_data_files
WHERE tablespace_name = 'STORE_TBS_MULTIPLE';

--Se crea una copia del archivo de parámetros
CREATE PFILE = '/unam-bda/ejercicios-practicos/t0703/pfile-backup.txt'
FROM SPFILE;
