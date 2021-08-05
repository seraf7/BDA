-- @Autor:        Humberto Serafín Castillo López
-- @Fecha:        04/08/2021
-- @Descripción:  Configuración de parametros para activar el modo
--                archivelog de la BD

--Conexión como usuario sys
PROMPT Conectando como sys...
CONNECT sys/system2 AS sysdba

--Instrucción para detener la ejecución del script al detectar algún error
--sin aplicar cambios en la BD
whenever sqlerror exit rollback;

--Respaldo del SPFILE
PROMPT Respaldando el SPFILE...
!mkdir -p /unam-bda/ejercicios-practicos/t0709
CREATE PFILE='/unam-bda/ejercicios-practicos/t0709/pfile-backup1.txt'
FROM SPFILE;

PROMPT Configurando parámetros de forma permanente...
--Creación de 5 procesos ARCn
ALTER SYSTEM SET log_archive_max_processes=5 SCOPE=both;

--Configuración de 2 copias en cada archivado
--la copia de disk_a es obligarotia
ALTER SYSTEM
SET log_archive_dest_1='LOCATION=/unam-bda/archivelogs/SCLBDA2/disk_a MANDATORY'
SCOPE=both;

ALTER SYSTEM
SET log_archive_dest_2='LOCATION=/unam-bda/archivelogs/SCLBDA2/disk_b'
SCOPE=both;

--Configuración del formato de nombrado
ALTER SYSTEM SET log_archive_format='arch_sclbda2_%t_%s_%r.arc'
SCOPE=spfile;

--Se establece que al menos una copia debe realizarse correctamente
ALTER SYSTEM SET log_archive_min_succeed_dest=1 SCOPE=both;

PROMPT Reiniciando instancia...
--Se detiene la instancia
SHUTDOWN IMMEDIATE
--Se inicia la instancia en modo mount
STARTUP MOUNT
--Se activa el modo archivelog
ALTER DATABASE archivelog;
--Se abre la instancia
ALTER DATABASE open;

--Se comprueba que se ha activado el modo archivelog
PROMPT Comprobando el modo de la base de datos
ARCHIVE LOG LIST

--Se realiza un nuevo respaldo del SPFILE
CREATE PFILE='/unam-bda/ejercicios-practicos/t0709/pfile-backup2.txt'
FROM SPFILE;
