-- @Autor:        Humberto Serafín Castillo López
-- @Fecha:        13/06/2021
-- @Descripción:  Script para realizar las actividades correspondientes al
--                ejercicio en clase 01. Detención e inicio de la instancia

SET LINESIZE WINDOW
COLUMN instance_name FORMAT a20
COLUMN startup_time FORMAT a20
COLUMN status FORMAT a15
COLUMN database_status FORMAT a20

--A) Información del estado de la BD en nomount
SELECT instance_name,
  TO_CHAR(startup_time, 'DD-MON-YYYY HH24:MM:SS') AS startup_time, status,
  database_status
FROM v$instance;

--B) Montar la BD
ALTER DATABASE mount;

--C) Repetir consulta del inciso A)
-- El status de la instancia cambia de STARTED a MOUNTED, mientras que el
-- estado de la BD se mantiene en ACTIVE

--D) Cambio de status a open y valor del parametro undo_tablespace
ALTER DATABASE open;
SHOW PARAMETER undo_tablespace
-- se muestra el valor undotbs1

--E) Cerrar la BD y revisión del status de la instancia
ALTER DATABASE close;
-- El status de la BD cambia de open a mounted, por lo que sería similar a
-- ejecutar startup mount

--F) Detener instancia y abrirla en solo lectura. Posteriormente detener la
-- instancia en modo abort
SHUTDOWN immediate
STARTUP mount
ALTER DATABASE open read only;
SHUTDOWN abort
