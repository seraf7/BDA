-- @Autor:        Humberto Serafín Castillo López
-- @Fecha:        06/07/2021
-- @Descripción:  Script usado para la creación del usuario que será usado
--                a lo largo del ejercicio

--Instrucción para detener la ejecución del script al detectar algún error
--sin aplicar cambios en la BD
whenever sqlerror exit rollback;

--Conexión como usuario sys
PROMPT Conectando como usuario sys...
CONNECT sys/system2 as sysdba

--Verifica si existe el usuario serafin0401
DECLARE
  v_count NUMBER;
  v_username VARCHAR2(20) := 'SERAFIN0401';
BEGIN
  SELECT COUNT(*) INTO v_count FROM all_users WHERE username=v_username;
  IF v_count > 0 THEN
    --Borra al usuario existente
    EXECUTE IMMEDIATE 'drop user ' || v_username || ' cascade';
  END IF;
END;
/

-- Creación de usuario con cuota ilimitada
PROMPT Creando usuario serafin0401...
CREATE USER serafin0401 IDENTIFIED BY serafin QUOTA UNLIMITED ON users;

--Asignación de privilegios a serafin0401
PROMPT Asignando privilegios a serafin0401...
GRANT CREATE SESSION, CREATE TABLE
TO serafin0401;

--Para regresar a la configuración original
whenever sqlerror continue none;
