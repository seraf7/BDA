-- @Autor:      Humberto Serafín Castillo López
-- @Fecha:      07/03/2021
-- @Decripcion: Script que crea un nuevo usuario en la base de datos y crea una
--              nueva tabla donde se inserta la información de liberación
--              de la versión de Oracle instalada

--Creación de un nuevo usuario que usa el tablespace users
CREATE USER serafin0104 IDENTIFIED BY serafin QUOTA UNLIMITED ON users;

--Se dan permisos para crear tablas y sesion al usuario
GRANT CREATE SESSION, CREATE TABLE TO serafin0104

--Creación de una tabla para el usuario serafin0104
CREATE TABLE serafin0104.t01_db_version(
  producto VARCHAR2(100),
  version VARCHAR2(50),
  version_full VARCHAR2(50)
);

--Inserciónde datos de versión de Oracle en la tabla t01_db_version
INSERT INTO serafin0104.t01_db_version(
  producto, version, version_full
)
  SELECT product, version, version_full
  FROM product_component_version;
