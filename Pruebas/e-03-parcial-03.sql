-- @Autor:        Humberto Serafín Castillo López
-- @Fecha:        12/08/2021
-- @Descripción:  Respuestas para el examen parcial 3, ejercicio 03

-- B)
-- 1. Detener la instancia
SHUTDOWN
-- 2. Copiar los Redo Log files a su nueva ubicación
mv /u05/data/logs/log05.log /u08/data/logs/log05.log

-- 3. Iniciar la instancia en modo mount
STARTUP MOUNT

-- 4. Realizar la reubicación de los archivos a nivel instancia:
ALTER DATABASE
RENAME FILE
  '/u05/data/logs/log05.log'
TO
  ' /u08/data/logs/log05.log';

-- 5. Abrir la base de datos
ALTER DATABASE OPEN;

-- C)
-- Se debe hacer que la base de datos de prioridad a las operaciones DML con la siguiente sentencia:

ALTER TABLESPACE <undo_tbs> RETENTION NOGUARANTEE;

-- D)
-- Se establece el número de procesos ARCn
ALTER SYSTEM SET log_archive_max_processes=n SCOPE=spfile;

-- Se especifican las ubicaciones y formato de nombrado
ALTER SYSTEM SET log_archive_dest_1='LOCATION=/log1' SCOPE=spfile;
ALTER SYSTEM SET log_archive_dest_2='LOCATION=/log2' SCOPE=spfile;
ALTER SYSTEM SET log_archive_format='log_%t_%s_%r.ac' SCOPE=spfile;

-- Se establece el mínimo de copias
ALTER SYSTEM SET log_archive_min_succeed_dest=2 SCOPE=spfile;

-- Se reinicia la instancia y se activa el modo archive
SHUTDOWN IMMEDIATE
STARTUP MOUNT
ALTER DATABASE archivelog;
ALTER DATABASE open;

-- Se comprueba el estado de la BD
ARCHIVE LOG LIST

-- E)
-- Se establece tamaño de la FRA
ALTER SYSTEM SET db_recovery_file_dest_size=200G SCOPE=both;

-- Se establece la ruta de la FRA
ALTER SYSTEM SET db_recovery_file_dest='/u99' SCOPE=both;

-- Se establece la política de retención de la FRA
ALTER SYSTEM SET db_flashback_retention_target=7200 SCOPE=both;

-- F)
ALTER SYSTEM SET log_archive_dest_5='LOCATION=USE_DB_RECOVERY_FILE_DEST'
SCOPE=both;

ALTER DATABASE ADD LOGFILE;
