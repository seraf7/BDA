-- @Autor:        Humberto Serafín Castillo López
-- @Fecha:        07/07/2021
-- @Descripción:

-- A) Infromación de los tablespace existentes
SELECT tablespace_name, block_size, initial_extent, next_extent, min_extlen,
  status, contents, logging
FROM dba_tablespaces;

-- B) Información de configuraciones de los tablespace
SELECT tablespace_name, extent_management, segment_space_management,
  bigfile, encrypted
FROM dba_tablespaces;

-- C) Información de quotas sobre los tablespace
SELECT U.username, U.default_tablespace, U.temporary_tablespace,
  Q.bytes / (1024 * 1024) AS quota_mb,
  -- Valida como mostrar la quota asignada
  CASE
    WHEN Q.max_bytes = -1 THEN 'UNLIMITED'
    ELSE TO_CHAR(Q.max_bytes / (1024 * 1024))
  END AS allocated_mb,
  Q.blocks
FROM dba_users U
JOIN dba_ts_quotas Q ON U.username = Q.username
WHERE U.username LIKE 'SERAFIN%'
ORDER BY U.username;
