-- @Autor:          Humberto Serafín Castillo López
-- @Fecha:          05/08/2021
-- @Descripción:    Script para habilitar la carpeta de la FRA

-- Creación del directorio
-- sudo mkdir /unam-bda/fast-reco-area
-- sudo chown oracle:oinstall /unam-bda/fast-reco-area
-- sudo chmod 750 /unam-bda/fast-reco-area

-- Crea respaldo del spfile
CREATE PFILE FROM SPFILE;

-- Se establece tamaño de la FRA
ALTER SYSTEM SET db_recovery_file_dest_size=3G SCOPE=both;

-- Se establece la ruta de la FRA
ALTER SYSTEM SET db_recovery_file_dest='/unam-bda/fast-reco-area' SCOPE=both;

-- Se establece la política de retención de la FRA
ALTER SYSTEM SET db_flashback_retention_target=1440 SCOPE=both;

-- Para usar la FRA
-- Se indica que una copia de los Archived se guarde en la FRA
ALTER SYSTEM SET log_archive_dest_3='LOCATION=USE_DB_RECOVERY_FILE_DEST'
SCOPE=both;
