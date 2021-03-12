-- @Autor:        Humberto Serafín Castillo López
-- @Fecha:        07/03/2021
-- @Descripción:  Script para realizar la creación de una tabla que almacenará
--                los roles existentes en la base de datos

--Instrucción para detener ejecución del script al detectar el primer error
--sin que se apliquen cambios sobre la BD
whenever sqlerror exit rollback;

--Conexion como usuario sys
CONNECT sys/Hola1234# AS sysdba

--Verifica si el usrio SERAFIN0105 existe en la BD
DECLARE
  v_count NUMBER;
  v_username VARCHAR2(20) := 'serafin105';
BEGIN
  SELECT COUNT(*) INTO v_count FROM all_users WHERE username=v_username;
  IF v_count > 0 THEN
    --Borra el usuario existente
    EXECUTE IMMEDIATE 'drop user' || v_username || 'cascade';
  END IF;
END;
/

--Verifica si el usrio serafin0106 existe en la BD
DECLARE
  v_count NUMBER;
  v_username VARCHAR2(20) := 'serafin0106';
BEGIN
  SELECT COUNT(*) INTO v_count FROM all_users WHERE username=v_username;
  IF v_count > 0 THEN
    --Borra el usuario existente
    EXECUTE IMMEDIATE 'drop user' || v_username || 'cascade';
  END IF;
END;
/

--Creación del usuario SERAFIN0105 sin cuota de almacenamiento
PROMPT Creando al usuario serafin0105
CREATE USER SERAFIN0105 IDENTIFIED BY serafin;
--Asignación de privilegio de inicio de sesión
GRANT CREATE SESSION TO serafin0105

--Creación del usuario SERAFIN0106 sin cuota de almacenamiento
PROMPT Creando al usuario serafin0106
CREATE USER SERAFIN0105 IDENTIFIED BY serafin;
--Asignación de privilegio de inicio de sesión
GRANT CREATE SESSION TO serafin0106

--Asinación de roles de administración
PROMPT Asignando roles de administración
GRANT sysdba TO serafin0104
GRANT sysoper TO serafin105
GRANT sysbackup TO SERAFIN0106

--Para regresar a la configuracion original
whenever sqlerror continue none
