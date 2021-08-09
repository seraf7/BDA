-- @Autor:        Humberto Serafín Castillo López
-- @Fecha:        04/08/2021
-- @Descripción:  Creación de los tablespace usados por la empresa automotriz
--                y creación del usuario que los usará

--Instrucción para detener la ejecución del script al detectar algún error
--sin aplicar cambios en la BD
whenever sqlerror exit rollback;

--Conexión como usuario sys
PROMPT Conectando como usuario sys...
CONNECT sys/system2 as sysdba

--Verifica si existe el usuario scl_autos_bda
DECLARE
  v_count NUMBER;
  v_username VARCHAR2(20) := 'SCL_AUTOS_BDA';
BEGIN
  SELECT COUNT(*) INTO v_count FROM all_users WHERE username=v_username;
  IF v_count > 0 THEN
    --Borra al usuario existente
    EXECUTE IMMEDIATE 'drop user ' || v_username || ' cascade';
  END IF;
END;
/

--Creación de los tablespaces requeridos
PROMPT Creando tablespace autos_tbs...
CREATE TABLESPACE autos_tbs
DATAFILE '/u01/app/oracle/oradata/SCLBDA2/autos01.dbf'
  SIZE 50m
  AUTOEXTEND ON NEXT 10m MAXSIZE 100m;

PROMPT Creando tablespace clientes_tbs...
CREATE TABLESPACE clientes_tbs
DATAFILE '/u01/app/oracle/oradata/SCLBDA2/clientes01.dbf'
  SIZE 30m
  AUTOEXTEND ON NEXT 10m MAXSIZE 100m;

PROMPT Creando tablespace indexes_tbs...
CREATE TABLESPACE indexes_tbs
DATAFILE '/u01/app/oracle/oradata/SCLBDA2/indexes01.dbf'
  SIZE 2m
  AUTOEXTEND ON NEXT 10m MAXSIZE 100m;

-- Creación de usuario con cuota ilimitada
PROMPT Creando usuario scl_autos_bda...
CREATE USER scl_autos_bda IDENTIFIED BY serafin
DEFAULT TABLESPACE autos_tbs;

--Asignación de cuotas de almacenamiento
PROMPT Asignando cuotas a scl_autos_bda...
ALTER USER scl_autos_bda QUOTA UNLIMITED ON autos_tbs;
ALTER USER scl_autos_bda QUOTA UNLIMITED ON clientes_tbs;
ALTER USER scl_autos_bda QUOTA UNLIMITED ON indexes_tbs;

--Asignación de privilegios
PROMPT Asignando privilegios a scl_autos_bda...
GRANT CREATE SESSION, CREATE TABLE, CREATE PROCEDURE,
  CREATE SEQUENCE
TO scl_autos_bda;

--Para regresar a la configuración original
whenever sqlerror continue none;
