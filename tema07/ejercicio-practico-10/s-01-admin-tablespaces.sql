-- @Autor:        Humberto Serafín Castillo López
-- @Fecha:        07/08/2021
-- @Descripción:  Operaciones de administración e información del
--                tablespace UNDO

--Mostrar el tablespace UNDO que se usa actualmente
SHOW PARAMETER undo_tablespace

--Creación de un nuevo tablespace UNDO
CREATE UNDO TABLESPACE undotbs2
DATAFILE '/u01/app/oracle/oradata/SCLBDA2/undotbs_2.dbf' SIZE 30m
EXTENT MANAGEMENT LOCAL AUTOALLOCATE;

--Usar el nuevo tablespace de manera temporal a nivel instancia
ALTER SYSTEM SET undo_tablespace='undotbs2' SCOPE=memory;

--Consulta de estadísticas de datos UNDO, muestra primeros 20 registros
SELECT begin_time, end_time, undotsn, undoblks, txncount, maxqueryid,
  maxquerylen, activeblks, unexpiredblks, expiredblks, tuned_undoretention
FROM v$undostat
ORDER BY begin_time DESC
FETCH FIRST 20 ROWS ONLY;

--Periodos de muestra y nombres de cada tablespace UNDO
SELECT U.begin_time, U.end_time, U.undotsn, T.name
FROM v$undostat U
JOIN v$tablespace T ON U.undotsn = T.ts#;

--Consulta del espacio libre del tablespace UNDO
SELECT d.tablespace_name, D.blocks AS total_blocks, F.blocks AS free_blocks,
  ROUND(F.blocks / D.blocks * 100, 2) AS free_percent
FROM dba_free_space F
JOIN dba_data_files D ON f.tablespace_name = D.tablespace_name
WHERE D.tablespace_name = 'UNDOTBS2';

--Creación de tabla para cadenas aleatorias, no genera datos de REDO
CREATE TABLE serafin0602.scl_cadena_2 (
  id NUMBER CONSTRAINT scl_cadena_2_pk PRIMARY KEY,
  cadena VARCHAR2(1024)
) NOLOGGING;

--Creación de una nueva secuencia
CREATE SEQUENCE serafin0602.sec_scl_cadena_2
START WITH 1
INCREMENT BY 1
NOCYCLE;

--Programa PL/SQL para insertar registros en tabla de cadenas
DECLARE
  v_rows NUMBER;
BEGIN
  v_rows := 50000;
  --Ciclo de 50000 iteraciones
  FOR v_index IN 1 .. v_rows LOOP
    --Se insertan cadenas aleatorias de 1K
    INSERT INTO serafin0602.scl_cadena_2(id, cadena)
    VALUES (serafin0602.sec_scl_cadena_2.nextval,
      dbms_random.string('X', 1024));
  END LOOP;
END;
/
--Se confirman cambios
COMMIT;
