-- @Autor:        Humberto Serafín Castillo López
-- @Fecha:        16/04/2021
-- @Descripción:  Script para realizar la creación de un PFILE de la BD 2
--                en un ruta específica y obtención de parámetros

--Instrucción para detener ejecución del script al detectar algún error
--sin aplicar cambios en la BD
whenever sqlerror exit rollback;

--Conexión como usuario sys
PROMPT Conectando como usuario sys...
CONNECT sys/system2 as sysdba

--Creación de PFILE en ruta específica
PROMPT Creando PFILE en directorio t0204...
create pfile='/unam-bda/ejercicios-practicos/t0204/e-02-spparameter-pfile.txt'
from spfile;

--Verifica si existe el usuario serafin0204
DECLARE
  v_count NUMBER;
  v_username VARCHAR2(20) := 'SERAFIN0204';
BEGIN
  SELECT COUNT(*) INTO v_count FROM all_users WHERE username=v_username;
  IF v_count > 0 THEN
    --Borra al usuario existente
    EXECUTE IMMEDIATE 'drop user ' || v_username || ' cascade';
  END IF;
END;
/

--Creación de nuevo usuario con cuota ilimitada
PROMPT Creando al usuario serafin0204...
CREATE USER serafin0204 IDENTIFIED BY serafin QUOTA UNLIMITED ON users;

--Asignación de privilegios a serafin0204
PROMPT Asignando privilegios a serafin0204
GRANT CREATE SESSION, CREATE TABLE, CREATE SEQUENCE, CREATE PROCEDURE
TO serafin0204;

--Creación de tabla con los parámetros no nulos de la BD
PROMPT Creando tabla de parámetros de la base de datos
CREATE TABLE serafin0204.t01_spparameters AS
  SELECT name, value FROM v$spparameter
  WHERE value IS NOT NULL;

--Para regresar a la configuración original
whenever sqlerror continue none;

/*
Sección de preguntas y respuestas
1. Observar que los parámetros mostrados en el archivo
e-02-spparameter-pfile.txt tienen 2 formatos: algunos inician con
<oracle_sid>.__ y otro grupo inicia con *.
¿Qué diferencia existe entre estos 2 grupos?

Respuesta:
Los parámetros que inician con <oracle_sid>.__ son aplicados únicamente a la
instancia con el SID especificado en el parámetro; mientras que los iniciados
con * son aplicados para todas las instancias  que hagan uso del mismo archivo
de parámetros

2. Comparar los 2 archivos e-01-spparameter-alert-log.txt y
e-02-spparameter-pfile.txt así como el contenido de la tabla t01_spparameters.
Confirmar que en los 3 casos, existen los mismos parámetros con los mismos
valores. De encontrar diferencias mencionarlas.

Respuesta:
La única diferencia se encontró en el parámetro memory_target, para ambos
archivos se tiene el valor de 768 MB; sin embargo la tabla reporta 805306368
que es un valor equivalente en kB
*/
