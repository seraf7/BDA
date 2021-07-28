-- @Autor:        Humberto Serafín Castillo López
-- @Fecha:        24/07/2021
-- @Descripción:  Script de consultas para obtener información de los distintos
--                tablespace de la BD

--Se requiere estar en sesión como sysdba

--Obtiene información de los tablespace en la BD
SELECT tablespace_name, block_size, initial_extent, next_extent, min_extlen,
  status, contents, logging
FROM dba_tablespaces;

--Información adicional de los tablespace de la BD
SELECT tablespace_name, extent_management, segment_space_management,
  bigfile, encrypted
FROM dba_tablespaces;

--Información de los tablespace del usuario serafin0602
SELECT U.username, U.default_tablespace, U.temporary_tablespace,
  CASE
    WHEN Q.max_bytes = -1 THEN 'UNLIMITED'
    ELSE TO_CHAR(ROUND(Q.max_bytes / (1024 * 1024) , 2))
  END AS quota_mb,
  ROUND(Q.bytes / (1024 * 1024), 2) AS allocated_mb, Q.blocks
FROM dba_users U
JOIN dba_ts_quotas Q ON U.username = Q.username
WHERE U.username = 'SERAFIN0602';
