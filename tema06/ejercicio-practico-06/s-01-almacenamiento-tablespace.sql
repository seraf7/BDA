-- @Autor:        Humberto Serafín Castillo López
-- @Fecha:        27/07/2021
-- @Descripción:  Script con instrucción para la administración de espacio
--                de un tablespace

--Creación de tabla de pruebas
CREATE TABLE store_user.test(
  id NUMBER
) SEGMENT CREATION DEFERRED;

--Programa PL/SQL anónimo para agotar espacio del tablespace
DECLARE
  v_extensiones NUMBER;
  v_espacio_total NUMBER;
BEGIN
  --Ciclo infinito
  LOOP
    --Bloque anónimo anidado para provocar error
    BEGIN
      --Se reserva una nueva extensión con SQL dinámico
      EXECUTE IMMEDIATE 'alter table store_user.test allocate extent';
    EXCEPTION
      --Manejo de cualquier excepción
      WHEN OTHERS THEN
        --Detecta que ya no se pueden crear extensiones
        IF sqlcode = -1653 THEN
          --Termina el ciclo infinito
          dbms_output.put_line('Ya no se pueden reservar extensiones');
          EXIT;
        END IF;
    END;
  END LOOP;
  --Se consulta la información de las extensiones
  SELECT SUM(bytes) / (1024 * 1024), COUNT(*)
  INTO v_espacio_total, v_extensiones
  FROM dba_extents
  WHERE segment_name = 'TEST'
  AND owner = 'STORE_USER';
  dbms_output.put_line('Total de extensiones: ' || v_extensiones);
  dbms_output.put_line('Total de espacio:     ' || v_espacio_total || 'M');
END;
/

--Aumentar tamaño del tablespace con un nuevo data file
ALTER TABLESPACE store_tbs1
ADD DATAFILE '/u01/app/oracle/oradata/SCLBDA2/store_tbs02.dbf' SIZE 5M;

--Obtener el número de segmentos creados en cada tablespace, incluye vacios
SELECT T.tablespace_name, COUNT(S.tablespace_name) AS total_segmentos
FROM dba_tablespaces T
LEFT JOIN dba_segments S ON T.tablespace_name = S.tablespace_name
GROUP BY T.tablespace_name
ORDER BY total_segmentos DESC;
