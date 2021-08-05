-- @Autor:        Humberto Serafín Castillo López
-- @Fecha:        04/08/2021
-- @Descripción:  Consultas para conocer el estado de los Online Redo Logs

-- Comando de SO para buscar los Online Redo Logs
-- sudo find /u0* -name redo*.log | grep SCLBDA2

--Consulta para obtener información de los grupos de Redo Logs
SELECT group#, sequence#, ROUND(bytes / (1024 * 1024), 2) AS size_mb,
  blocksize, members, status, first_change#, first_time, next_change#
FROM v$log;

--Consulta de información de los miembros de grupos de Redo Log
SELECT group#, status, type, member
FROM v$logfile;

--Creación de nuevos grupos de Redo, con tamaño 50m y bloque de 512k
ALTER DATABASE
  ADD LOGFILE
  GROUP 4 ('/u01/app/oracle/oradata/SCLBDA2/redo01_A.log',
    '/u01/app/oracle/oradata/SCLBDA2/redo01_B.log')
  SIZE 50m;

ALTER DATABASE
  ADD LOGFILE
  GROUP 5 ('/u01/app/oracle/oradata/SCLBDA2/redo02_A.log',
    '/u01/app/oracle/oradata/SCLBDA2/redo02_B.log')
  SIZE 50m;

ALTER DATABASE
  ADD LOGFILE
  GROUP 6 ('/u01/app/oracle/oradata/SCLBDA2/redo03_A.log',
    '/u01/app/oracle/oradata/SCLBDA2/redo03_B.log')
  SIZE 50m;

--Se agrega un nuevo miembro a cada grupo de Redo
ALTER DATABASE
  ADD LOGFILE MEMBER '/u01/app/oracle/oradata/SCLBDA2/redo01_C.log'
  TO GROUP 4;

ALTER DATABASE
  ADD LOGFILE MEMBER '/u01/app/oracle/oradata/SCLBDA2/redo02_C.log'
  TO GROUP 5;

ALTER DATABASE
  ADD LOGFILE MEMBER '/u01/app/oracle/oradata/SCLBDA2/redo03_C.log'
  TO GROUP 6;

--Se realiza log switch forzado para usar nuevos grupos
ALTER SYSTEM SWITCH LOGFILE;

--Se realiza un checkpoint manual para que los grupos de Redo activos
--pasen a estatus inactivo
ALTER SYSTEM CHECKPOINT;

--Se borran los grupos de Redo antiguos
ALTER DATABASE DROP LOGFILE GROUP 1;
ALTER DATABASE DROP LOGFILE GROUP 2;
ALTER DATABASE DROP LOGFILE GROUP 3;
