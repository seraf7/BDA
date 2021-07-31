-- @Autor:        Humberto Serafín Castillo López
-- @Fecha:        24/07/2021
-- @Descripción:  Script para analizar y administrar el almacenamientos de los
--                data files asociados al tablespace store_tbs_multiple

--Ejecutar como SYS
--Consulta de los data files de store_tbs_multiple
SELECT file_name, file_id,
  bytes / (1024 * 1024) AS size_mb
FROM dba_data_files
WHERE tablespace_name = 'STORE_TBS_MULTIPLE';

--Consulta del espacio libre en store_tbs_multiple
SELECT tablespace_name, SUM(bytes) / (1024 * 1024) AS free_space_mb,
  SUM(blocks) AS free_blocks
FROM dba_free_space
WHERE tablespace_name = 'STORE_TBS_MULTIPLE'
GROUP BY tablespace_name;

--Creación de usuario con store_tbs_multiple como tablespace default
CREATE USER serafin_tbs_multiple IDENTIFIED BY serafin
QUOTA UNLIMITED ON store_tbs_multiple
DEFAULT TABLESPACE store_tbs_multiple;

--Creación de una tabla de cadenas
CREATE TABLE serafin_tbs_multiple.serafin_tbs_multiple(
  str VARCHAR2(1024)
) SEGMENT CREATION IMMEDIATE;

--Consulta del espacio y extensiones usadas por el segmento creado
SELECT D.file_name, D.file_id, COUNT(*) AS total_extents,
  SUM(E.bytes) / (1024 * 1024) AS total_mb,
  SUM(E.blocks) AS total_blocks
FROM dba_extents E
JOIN dba_data_files D ON E.file_id = D.file_id
WHERE E.segment_name = 'SERAFIN_TBS_MULTIPLE'
GROUP BY D.file_name, D.file_id;

--Programa PL/SQL para insertar 512K en la tabla
DECLARE
  v_rows NUMBER;
BEGIN
  v_rows := 512;
  --Ciclo con 512 iteraciones
  FOR v_index IN 1 .. v_rows LOOP
    --Inserta una cadena aleatoria de 1k
    INSERT INTO serafin_tbs_multiple.serafin_tbs_multiple(str)
    VALUES (dbms_random.string('P', 1024));
  END LOOP;
END;
/
--Se confirman cambios
COMMIT;


--Programa PL/SQL para insertar 2.5M en la tabla
DECLARE
  v_rows NUMBER;
BEGIN
  v_rows := 2560;
  --Ciclo con 512 iteraciones
  FOR v_index IN 1 .. v_rows LOOP
    --Inserta una cadena aleatoria de 1k
    INSERT INTO serafin_tbs_multiple.serafin_tbs_multiple(str)
    VALUES (dbms_random.string('P', 1024));
  END LOOP;
END;
/
--Se confirman cambios
COMMIT;
