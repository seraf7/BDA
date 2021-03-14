-- @Autor:      Humberto Serafín Castillo López
-- @Fecha:      07/03/2021
-- @Decripcion: Script que crea un nuevo usuario en la base de datos y crea una
--              nueva tabla donde se inserta la información de released
--              de la versión de Oracle instalada

--Instrucción para detener ejecución del script al detectar el primer error
--sin que se apliquen cambios sobre la BD
whenever sqlerror exit rollback;

--Conexion como sysdba
PROMPT Conectando como usuario sys
CONNECT sys/system1 as sysdba

--Verifica si el usrio serafin0104 existe en la BD
DECLARE
  v_count NUMBER;
  v_username VARCHAR2(20) := 'SERAFIN0104';
BEGIN
  SELECT COUNT(*) INTO v_count FROM all_users WHERE username=v_username;
  IF v_count > 0 THEN
    --Borra el usuario existente
    EXECUTE IMMEDIATE 'drop user ' || v_username || ' cascade';
  END IF;
END;
/

--Creación de un nuevo usuario que usa el tablespace users
PROMPT Creando al usuario serafin0104
CREATE USER serafin0104 IDENTIFIED BY serafin QUOTA UNLIMITED ON users;

--Se dan permisos para crear tablas y sesion al usuario
GRANT CREATE SESSION, CREATE TABLE TO serafin0104;

--Creación de una tabla para el usuario serafin0104
--se usan los datos de la consulta para crear y agregar datos a la tabla
CREATE TABLE serafin0104.t01_db_version AS
  SELECT product, version, version_full
  FROM product_component_version;

--Consulta a la tabla t01_db_version
SELECT * FROM serafin0104.t01_db_version;

--Para regresar a la configuracion original
whenever sqlerror continue none;
