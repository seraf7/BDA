-- @Autor:        Humberto Serafín Castillo López
-- @Fecha:        08/03/2021
-- @Descripción:  Script para realizar la creación de una tabla que almacenará
--                los schemas de usuarios y resliza la consulta de los
--                usuarios con privilegios administrativos

--Instrucción para detener ejecución del script al detectar el primer error
--sin que se apliquen cambios sobre la BD
whenever sqlerror exit rollback;

--Conexión con el usuario serafin0104 sin privilegios
CONNECT serafin0104/serafin

PROMPT Creando tabla t04_my_schema
CREATE TABLE t04_my_schema(
  username VARCHAR2(128),
  schema_name VARCHAR2(128)
);

--Se otorgan permisos para insertar en t04_my_schema
PROMPT Otorgando privilegios para insertar
GRANT INSERT ON t04_my_schema TO sys;
GRANT INSERT ON t04_my_schema TO public;
GRANT INSERT ON t04_my_schema TO sysbackup;

--Inserción de registro con serafin0104
PROMPT Insertando con serafin0104 como sysdba
CONNECT serafin0104/serafin AS sysdba
INSERT INTO serafin0104.t04_my_schema VALUES (
  --Se obtienen los datos del usuario actual
  sys_context('USERENV', 'CURRENT_USER'),
  sys_context('USERENV', 'CURRENT_SCHEMA')
);
COMMIT;

--Iserción de registro con serafin0105
PROMPT Insertando con serafin0105 como sysoper
CONNECT serafin0105/serafin AS sysoper
INSERT INTO serafin0104.t04_my_schema VALUES (
  --Se obtienen los datos del usuario actual
  sys_context('USERENV', 'CURRENT_USER'),
  sys_context('USERENV', 'CURRENT_SCHEMA')
);
COMMIT;

--Inserción de registro con serafin0106
PROMPT Insertando con serafin0106 como sysbackup
CONNECT serafin0106/serafin AS sysbackup
INSERT INTO serafin0104.t04_my_schema VALUES (
  --Se obtienen los datos del usuario actual
  sys_context('USERENV', 'CURRENT_USER'),
  sys_context('USERENV', 'CURRENT_USER')
);
COMMIT;

--Consulta de los usuarios con privilegios de administración
SELECT username, sysdba, sysoper, sysbackup, last_login
FROM v$pwfile_users;

--Conexión del usuario sys
CONNECT sys/Hola1234# as sysdba
--Cambio de la contraseña del usuario
ALTER USER sys IDENTIFIED BY system1;

--Para regresar a la configuracion original
whenever sqlerror continue none;
