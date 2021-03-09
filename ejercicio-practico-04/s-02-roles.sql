-- @Autor:        Humberto Serafín Castillo López
-- @Fecha:        07/03/2021
-- @Descripción:  Script para realizar la creación de una tabla que almacenará
--                los roles existentes en la base de datos

--Creación de una tabla para el usuario serafin0104
CREATE TABLE serafin0104.t02_db_roles(
  role_id NUMBER,
  role VARCHAR2(128)
);

--Inserción de los roles existentes en la tabla t02_db_roles
INSERT INTO serafin0104.t02_db_roles(
  role_id, role
)
  SELECT role_id, role
  FROM dba_roles;

--Creación de tabla para guardar roles de DBA
CREATE TABLE serafin0104.t03_dba_privs(
  privilege VARCHAR2(128)
);

--Insersión de los privilegios de DBA en la tabla
INSERT INTO serafin0104.t03_dba_privs(
  privilege
)
  SELECT privilege
  FROM dba_sys_privs
  WHERE grantee = 'DBA';
