-- @Autor:        Humberto Serafín Castillo López
-- @Fecha:        10/07/2021
-- @Descripción:

-- B) Información de data files
SELECT D.file_name, file_id, relative_fno, tablespace_name,
  bytes / (1024 * 1024) AS size_mb, status, autoextensible, increment_by,
  (bytes - user_bytes) / 1024 AS header_kb, online_status
FROM dba_data_files D;

-- Ejercicio 02
-- E)
SELECT D.file_id, d.file_name, COUNT(*) AS total_extensiones,
  SUM(e.bytes) / (1024 * 1024) AS total_mb,
  SUM(e.blocks) AS total_bloques,
  d.bytes / (1024 * 1024) AS data_file_size_mb
FROM dba_data_files D
JOIN dba_extents E ON D.file_id = E.file_id
GROUP BY D.file_id, d.file_name, d.bytes / (1024 * 1024);
