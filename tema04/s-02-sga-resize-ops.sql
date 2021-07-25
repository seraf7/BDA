-- @Autor:        Humberto Serafín Castillo López
-- @Fecha:        06/07/2021
-- @Descripción:  Script para provocar y obtener información de las operaciones
--                de reasignación de memoria

-- Se reinicia la instancia
PROMPT Deteniendo la instancia...
SHUTDOWN IMMEDIATE

PROMPT Levantando la instancia...
STARTUP

PROMPT Creando tabla de operaciones de reasignación de memoria...
--Tabla con información de las operaciones de reasignación de la memoria
CREATE TABLE serafin0401.t07_sga_resize_ops AS
  SELECT component, oper_type, parameter,
    initial_size / (1024 * 1024) AS initial_size_mb,
    target_size / (1024 * 1024) AS target_size_mb,
    final_size / (1024 * 1024) AS final_size_mb,
    (final_size - initial_size) / (1024 * 1024) AS increment_mb,
    status, start_time, end_time
  FROM v$sga_resize_ops
  WHERE target_size <> 0
  ORDER BY component, end_time;

PROMPT Creando tabla de datos aleatorios...
--Tabla para contenido random
CREATE TABLE serafin0401.t08_random_data(
  random_string VARCHAR2(1024)
);

PROMPT Realizando carga de cadenas aleatorias...
--Bloque para cargar de registros aleatorios en la tabla
DECLARE
  v_rows NUMBER;
BEGIN
  v_rows := 1000 * 900;
  --Ciclo con 300 000 iteraciones
  FOR v_index in 1 .. v_rows LOOP
    --Inserción de una cadena aleatoria en la tabla
    INSERT INTO serafin0401.t08_random_data(random_string)
    VALUES(dbms_random.string('P', 1024));
  END LOOP;
END;
/

--confirma cambios
COMMIT;

PROMPT Realizando consulta para provocar carga datos en el BD Buffer Caché...
--Inicio de conteo de tiempo
SET TIMING ON
SELECT COUNT(*) FROM SERAFIN0401.t08_random_data;
--Detiene conteo de tiempo
SET TIMING OFF

PROMPT Creando tabla con operaciones de reasignación de memoria actualizadas...
CREATE TABLE serafin0401.t09_sga_resize_ops AS
  SELECT component, oper_type, parameter,
    initial_size / (1024 * 1024) AS initial_size_mb,
    target_size / (1024 * 1024) AS target_size_mb,
    final_size / (1024 * 1024) AS final_size_mb,
    (final_size - initial_size) / (1024 * 1024) AS increment_mb,
    status, start_time, end_time
  FROM v$sga_resize_ops
  WHERE target_size <> 0
  ORDER BY component, end_time;
