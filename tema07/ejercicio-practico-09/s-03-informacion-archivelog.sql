-- @Autor:        Humberto Serafín Castillo López
-- @Fecha:        04/08/2021
-- @Descripción:

--Información del modo de la base de datos
SELECT name, log_mode
FROM v$database;

--Información de las rutas configuradas para los archivelogs
SELECT dest_id, dest_name, status, binding, destination
FROM v$archive_dest
WHERE status = 'VALID';

--Información de los grupos de Redo
SELECT * FROM v$log;

-- ¿Cuál es el número de grupo en el que actualmente se está escribiendo?
-- status CURRENT --> 6

-- ¿Qué número de secuencia tiene cada grupo?
-- 4 --> 215
-- 5 --> 216
-- 6 --> 217

-- ¿Qué valor tiene el número de secuencia menor?
-- sequence# --> 215

-- ¿Qué significado y relación tienen las columnas first_change# y next_change#?
-- fisrt_change#, indica cual fue el SCN menor que se almacenado en el Redo Log
-- next_change#, indica cuál fue el último SCN que se grabó, si tiene el
-- estatus CURRENT, se coloca el valor maximo que puede ser almacenado

-- Historial de los log switch realizados
SELECT H.*
FROM v$log_history H
JOIN v$log L ON H.sequence# = L.sequence#
ORDER BY H.first_time;

-- Información de los Redo Log que se han archivado
SELECT * FROM v$archived_log;

--Proceso para provocar el archivado de archivos
--Creación de una tabla de cadenas de 1K
CREATE TABLE serafin0602.scl_cadena(
  cadena VARCHAR2(1024)
);

--Procedimiento para insertar 20 MB de datos en la tabla y provocar log switch
DECLARE
  v_rows NUMBER;
BEGIN
  v_rows := 20480;
  --Ciclo para insertar datos
  FOR v_index IN 1 .. v_rows LOOP
    --Se insertan cadenas alfanumericas en mayusculas de forma aleatoria
    INSERT INTO serafin0602.scl_cadena(cadena)
    VALUES (dbms_random.string('X', 1024));
  END LOOP;
END;
/
--Cofirma cambios
COMMIT;
--Para lograr que se archiven los tres grupos de Redo, el proceso
--se ejecutó 5 veces

--Consulta de los Redo Log archivados
SELECT recid, name AS ruta, dest_id, sequence#, first_time,
  status, completion_time
FROM v$archived_log;

--Consulta de la cantidad de registros
--Se insertaron 102 400
SELECT COUNT(*) AS total_registros
FROM serafin0602.scl_cadena;

--Comando para encontrar Redo Logs archivados
-- sudo find /unam-bda -name arch_sclbda*.arc

--Contar log switch realizados en la sesión actual
SELECT COUNT(*) as total_log_switch
FROM v$log_history
WHERE sequence# >= 215;

--Contar log switch del día actual
SELECT COUNT(*) AS log_switch_hoy
FROM v$log_history
WHERE TO_CHAR(first_time, 'DD-MM-YYYY') = TO_CHAR(sysdate, 'DD-MM-YYYY');
