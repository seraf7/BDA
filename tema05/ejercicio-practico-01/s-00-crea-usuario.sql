-- @Autor:        Humberto Serafín Castillo López
-- @Fecha:        20/07/2021
-- @Descripción:  Script ecargado de la creación de un nuevo usuario y
--                asignación de privilegios

--Conexión como sysdba
PROMPT Conectando como usuario sys...
CONNECT sys/system2 AS sysdba

--Instrucción para detener la ejecución del script al detectar algún error
--sin aplicar cambios en la BD
whenever sqlerror exit rollback;

--Verifica si existe el usuario serafin0401
DECLARE
  v_count NUMBER;
  v_username VARCHAR2(20) := 'SERAFIN0501';
BEGIN
  SELECT COUNT(*) INTO v_count FROM all_users WHERE username=v_username;
  IF v_count > 0 THEN
    --Borra al usuario existente
    EXECUTE IMMEDIATE 'drop user ' || v_username || ' cascade';
  END IF;
END;
/

--Creación de usuario serafin0501
PROMPT Creando usuario serafin0501...
CREATE USER serafin0501 IDENTIFIED BY serafin QUOTA UNLIMITED ON users;

--Asignación de privilegios
PROMPT Asignando privilegios a serafin0501...
GRANT CREATE SESSION, CREATE TABLE
TO serafin0501;

GRANT SELECT ON serafin0401.t08_random_data TO serafin0501;

--Para regresar a la configuración original
whenever sqlerror continue none;
