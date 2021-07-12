-- @Autor:        Humberto Serafín Castillo López
-- @Fecha:        06/07/2021
-- @Descripción:  Script de distintas consultas de los parámetros de memoria
--                de la SGA

PROMPT Creando tabla con información de los componentes de la SGA...
--Tabla de componentes de la SGA
CREATE TABLE serafin0401.t01_sga_components(
  memory_target_param NUMBER(10, 2),
  fixed_size NUMBER(10, 2),
  variable_size NUMBER(10, 2),
  database_buffers NUMBER(10, 2),
  redo_buffers NUMBER(10, 2),
  total_sga NUMBER(10, 2)
);

PROMPT Insertando datos de los componentes...
--Inserción de datos de la SGA
INSERT INTO serafin0401.t01_sga_components(memory_target_param,
fixed_size, variable_size, database_buffers, redo_buffers, total_sga)
VALUES (
  --Obtiene valor de memory_target
  (SELECT value / (1024 * 1024) FROM v$parameter WHERE name='memory_target'),
  --Obtiene valor de componentes de la SGA
  (SELECT value / (1024 * 1024) FROM v$sga WHERE name='Fixed Size'),
  (SELECT value / (1024 * 1024) FROM v$sga WHERE name='Variable Size'),
  (SELECT value / (1024 * 1024) FROM v$sga WHERE name='Database Buffers'),
  (SELECT value / (1024 * 1024) FROM v$sga WHERE name='Redo Buffers'),
  --Obtiene tamaño total de la SGA
  (SELECT SUM(value) / (1024 * 1024) FROM v$sga)
);

PROMPT Creando tabla de componentes dinámimicos de la SGA...
--Tabla de información de los componentes de la SGA
CREATE TABLE serafin0401.t02_sga_dynamic_components(
  component_name VARCHAR2(64),
  current_size_mb NUMBER(10, 2),
  operation_count NUMBER(10, 0),
  last_operation_type VARCHAR2(13),
  last_operation_time DATE
);

PROMPT Insertando datos de componentes dinámimicos...
--Inserción de datos informativos de la SGA
INSERT INTO serafin0401.t02_sga_dynamic_components(component_name,
current_size_mb, operation_count, last_operation_type, last_operation_time)
  SELECT component, current_size / (1024 * 1024), oper_count,
  last_oper_type, last_oper_time
  FROM v$sga_dynamic_components;

PROMPT Creando tabla de componentes más grandes de la SGA...
-- Tabla para el componente con mas memoria en la SGA
CREATE TABLE serafin0401.t03_sga_max_dynamic_component(
  component_name VARCHAR2(64),
  current_size_mb NUMBER(10, 2)
);

PROMPT Insertando componente de mayor tamaño...
-- Inserción del componente de mayor tamaño
INSERT INTO serafin0401.t03_sga_max_dynamic_component(component_name,
  current_size_mb)
  SELECT component, current_size / (1024 * 1024)
  FROM v$sga_dynamic_components
  WHERE current_size =
    (SELECT MAX(current_size) FROM v$sga_dynamic_components);

PROMPT Creando tabla de componentes de menor tamaño...
--Tabla para el componente con menos memoria de la SGA
CREATE TABLE serafin0401.t04_sga_min_dynamic_component(
  component_name VARCHAR2(64),
  current_size_mb NUMBER(10, 2)
);

PROMPT Insertando componente más pequeño de la SGA...
--Inserción del componente con menor tamaño
INSERT INTO serafin0401.t04_sga_min_dynamic_component(component_name,
  current_size_mb)
  SELECT component, current_size / (1024 * 1024)
  FROM v$sga_dynamic_components
  WHERE current_size = (
    SELECT MIN(current_size)
    FROM v$sga_dynamic_components
    WHERE current_size > 0
  );

PROMPT Creando tabla información de tamaños de la SGA...
--Tabla con información de memoria actual y máxima de la SGA
CREATE TABLE serafin0401.t05_sga_memory_info(
  name VARCHAR2(64),
  current_size_mb NUMBER(10,2)
);

PROMPT Insertando información de tamaños de la SGA...
--Inserción de memoria máxima y disponible d la SGA
INSERT INTO serafin0401.t05_sga_memory_info(name, current_size_mb)
  SELECT name, bytes / (1024 * 1024)
  FROM v$sgainfo
  WHERE name = 'Maximum SGA Size'
  OR name = 'Free SGA Memory Available';

PROMPT Creando tabla de componentes configurables...
--Tabla de los componentes de la SGA que pueden ajustar su tamaño
CREATE TABLE serafin0401.t06_sga_resizeable_components(
  name VARCHAR2(64)
);

PROMPT Insertando componentes configurables...
-- Recuperación de componentes con memoria ajustable
INSERT INTO serafin0401.t06_sga_resizeable_components(name)
  SELECT name
  FROM v$sgainfo
  WHERE resizeable = 'Yes';

--Se confirman cambios
COMMIT;
