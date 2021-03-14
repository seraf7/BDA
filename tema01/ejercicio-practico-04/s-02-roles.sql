-- @Autor:        Humberto Serafín Castillo López
-- @Fecha:        07/03/2021
-- @Descripción:  Script para realizar la creación de una tabla que almacenará
--                los roles existentes en la base de datos y tabla para
--                almacenar privilegios del rol DBA

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

--Creación de la tabla t03_dba_privs a  partir de la consulta de los
--privilegios que posee el rol DBA
CREATE TABLE serafin0104.t03_dba_privs AS
  SELECT privilege
  FROM dba_sys_privs
  WHERE grantee = 'DBA';
