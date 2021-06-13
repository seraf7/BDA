-- @Autor:        Humberto Serafín Castillo López
-- @Fecha:        16/04/2021
-- @Descripción:  Sccript para obtener parámetros contenidos en la vista
--                v$system_parameter e insertarlos en una nueva tabla

--Conexión como sysdba
PROMPT Conectando como sysdba...
CONNECT sys/system2 as sysdba

--Creación de tabla con parámetros del sistema
PROMPT Creando tabla t02_other_parameters...
CREATE TABLE serafin0204.t02_other_parameters AS
  SELECT num, name, value, default_value,
  isses_modifiable AS is_session_modifiable,
  issys_modifiable AS is_system_modifiable
  FROM v$system_parameter;
