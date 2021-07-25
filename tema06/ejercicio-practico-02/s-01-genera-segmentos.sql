-- @Autor:        Humberto Serafín Castillo López
-- @Fecha:        24/07/2021
-- @Descripción:  Script para crear y comprobar la generación de segmentos

--Conexión con serafin0602
CONNECT serafin0602/serafin

--Creación de la tabla empleado, sus segmentos se crean en la primer inserción
CREATE TABLE empleado(
  id NUMBER NOT NULL,
  nombre_completo VARCHAR2(40) NOT NULL,
  num_cuenta VARCHAR2(9) NOT NULL,
  expediente CLOB NOT NULL,
  CONSTRAINT empleado_pk PRIMARY KEY (id),
  CONSTRAINT empleado_num_cuenta_uk UNIQUE (num_cuenta)
) SEGMENT CREATION DEFERRED;

--Consulta de segmentos asociados a empleado
SELECT segment_name, segment_type, tablespace_name, bytes, blocks, extents,
  min_extents, max_extents
FROM user_segments
WHERE segment_name LIKE '%EMPLEADO%';

--Inserción de nuevo registro
INSERT INTO empleado(id, nombre_completo, num_cuenta, expediente)
VALUES (1, 'Francisco Garcés', '340819921', dbms_random.string('P', 500));
COMMIT;

--Consulta de los LOB de empleado
SELECT table_name, column_name, segment_name, tablespace_name, index_name
FROM user_lobs
WHERE table_name = 'EMPLEADO';

--Consulta de los segmentos de empleado, icnluyendo segmentos de dato CLOB
SELECT segment_name, segment_type, tablespace_name, bytes, blocks, extents,
  min_extents, max_extents
FROM user_segments
WHERE segment_name LIKE '%EMPLEADO%'
UNION ALL
SELECT US.segment_name, US.segment_type, US.tablespace_name, US.bytes,
  US.blocks, US.extents, US.min_extents, US.max_extents
FROM user_segments US
JOIN user_lobs UL ON US.segment_name IN (UL.segment_name, UL.index_name)
WHERE UL.table_name = 'EMPLEADO';
