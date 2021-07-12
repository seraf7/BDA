-- @Autor:        Humberto Serafín Castillo López
-- @Fecha:        07/07/2021
-- @Descripción:  Verificación del uso de almacenamiento de un tablespace

-- A) Creación de usuario
CREATE TABLE serafin06_store.test(ID NUMBER)
SEGMENT CREATION DEFERRED;

-- B) Programa PL/SQL para usar todo el espacio del tablespace
--Activa salida de consola
SET SERVEROUTPUT ON
--Programa
DECLARE
  v_extensiones NUMBER;
  v_total_espacio NUMBER;
BEGIN
  -- Ciclo infinito
  LOOP
    --Bloque anidado
    BEGIN
      --Reserva una nueva extensión
      EXECUTE IMMEDIATE 'alter table serafin06_store.test allocate extent';
      --Incrementa el contador de extensiones
      --v_extensiones := v_extensiones + 1;
    EXCEPTION
      --Manejo de cualquier excepción
      WHEN OTHERS THEN
        --Detecta que ya no se pueden crear extensiones
        IF sqlcode = -1653 THEN
          dbms_output.put_line('Ya no se pueden crear más extensiones');
          --Termina el ciclo infinito
          EXIT;
        END IF;
    END;
  END LOOP;
  --Consulta de información requerida
  SELECT SUM(bytes) / (1024 * 1024), COUNT(*)
  INTO v_total_espacio, v_extensiones
  FROM dba_extents
  WHERE segment_name = 'TEST'
  AND owner = 'SERAFIN06_STORE';
  dbms_output.put_line('Total de extensiones: ' || v_extensiones);
  dbms_output.put_line('Total de espacio: ' || v_total_espacio || 'M');
END;
/

-- C) Expandir el tablespace con un data file
ALTER TABLESPACE store_tbs1
ADD DATAFILE '/u01/app/oracle/oradata/SCLBDA2/store_tbs02.dbf' SIZE 5m;

-- D) Información de los tablespace existentes, numero de segmentos que tiene
-- se usa COUNT(col) para descartar los valores nulos del LEFT JOIN
SELECT T.tablespace_name, COUNT(s.tablespace_name) AS num_segmentos
FROM dba_tablespaces T
LEFT JOIN dba_segments S ON T.tablespace_name = S.tablespace_name
GROUP BY t.tablespace_name
ORDER BY num_segmentos DESC;
