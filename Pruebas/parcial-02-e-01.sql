-- @Autor:        Humberto Serafín Castillo López
-- @Fecha:        15/07/2021
-- @Descripción:  Respuestas para el examen parcial 2, ejercicio 01

--A)
SELECT component, current_size / (1024 * 1024) AS current_size_mb
FROM v$sga_dynamic_components;

--B) Total de RAM 768 MB
ALTER SYSTEM SET memory_target=0 SCOPE=both;
ALTER SYSTEM SET sga_target=0 SCOPE=both;
ALTER SYSTEM SET streams_pool_size=0 SCOPE=both;

ALTER SYSTEM SET pga_aggregate_target=77m SCOPE=memory;

ALTER SYSTEM SET shared_pool_size=300m SCOPE=both;
ALTER SYSTEM SET large_pool_size=81m SCOPE=both;
ALTER SYSTEM SET java_pool_size=10m SCOPE=both;
ALTER SYSTEM SET db_cache_size=300m SCOPE=both;

--C)
ALTER SYSTEM SET dispatchers='(PROTOCOL=tcp)(DISPATCHERS=2)'
SCOPE=memory;
ALTER SYSTEM SET shared_servers=2 SCOPE=memory;

ALTER SYSTEM register;

--D)
SELECT sosid, pname, tracefile, pga_used_mem / (1024 * 1024) AS memory_used_mb
FROM v$process
WHERE background = 1;
