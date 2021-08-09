-- @Autor:        Humberto Serafín Castillo López
-- @Fecha:        05/08/2021
-- @Descripción:  Consultas del diccionario de datos referentes a los
--                respaldos realizados

-- Se filtran los registro del backup autos_full_inicial
SELECT session_key, bs_key, set_count, handle, tag
FROM v$backup_piece_details
WHERE bs_key BETWEEN 13 AND 16;

SELECT session_key, bs_key, status, start_time, completion_time,
  elapsed_seconds, deleted, size_bytes_display
FROM v$backup_piece_details
WHERE bs_key BETWEEN 13 AND 16;

-- Informe de los backup piece encontrados
-- BS_KEY: 13
-- Ubicación: /unam-bda/backups/backup_0d0617ub_1_1.bkp
-- Tamaño: 38.67 MB
-- Contenido: Archived Redo Logs

-- BS_KEY: 14
-- Ubicación: /unam-bda/backups/backup_0e0617uf_1_1.bkp
-- Tamaño: 2 .0 GB
-- Contenido: data files

-- BS_KEY: 15
-- Ubicación: /unam-bda/backups/backup_0f06182a_1_1.bkp
-- Tamaño: 16.50 KB
-- Contenido: Archived Redo Logs

-- BS_KEY: 16
-- Ubicación: /unam-bda/backups/ctl_filec-805870510-20210808-03.bkp
-- Tamaño: 17.95 MB
-- Contenido: SPFILE y controlfile
