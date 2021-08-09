-- @Autor:        Humberto Serafín Castillo López
-- @Fecha:        05/08/2021
-- @Descripción:  Consultas para comprobar los objetos creados para el caso
--                de estudio de la empresa automotriz

-- Se requiere que previamente se hayan creado los tablespace del caso de
-- estudio y los objetos correspondientes. Los scripts están
-- en scripts-ejemplo-autos:
-- s-01-tablespaces-usuario.sql
-- s-02-autos-ddl.sql

-- Consulta de las tabla y tablespace al que corresponden
SELECT owner, table_name, tablespace_name
FROM dba_tables
WHERE owner = 'SCL_AUTOS_BDA'
ORDER BY tablespace_name;

-- Consulta de los indices creados y tablespace al que corresponden
SELECT owner, index_name, tablespace_name, index_type, table_name, uniqueness
FROM dba_indexes
WHERE owner = 'SCL_AUTOS_BDA';

-- Se requier que previamente se haya realizado la carga de datos Los scripts
-- están en scripts-ejemplo-autos:
-- s-03-carga-inicial.sql

-- Consulta de los segmentos que han sido creados
SELECT segment_name, extents
FROM dba_segments
WHERE owner = 'SCL_AUTOS_BDA'
ORDER BY extents DESC;
