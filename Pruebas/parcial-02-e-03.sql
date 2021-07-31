-- @Autor:        Humberto Serafín Castillo López
-- @Fecha:        15/07/2021
-- @Descripción:  Respuestas para el examen parcial 2, ejercicio 03

--B)
DROP TABLE <tabla>;
TRUNCATE TABLE <tabla>;

--C)
SELECT file_id, COUNT(blocks) AS free_blocks
FROM dba_free_space
GROUP BY file_id;

--D)
SELECT segment_name, COUNT(*) AS total_extensiones
FROM dba_extents
GROUP BY segment_name;

--E)
CREATE TABLE TA(
  id NUMBER
) SEGMENT CREATION IMMEDIATE;

--F)
interno     -->   table
interno_id  -->   index
foto_ix     -->   lobindex
foto        -->   lobsegment
foto_p_ix   -->   lobindex
foto_p      -->   lobsegment
num_seguro  -->   index
