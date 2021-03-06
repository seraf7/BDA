-- @Autor:        Humberto Serafín Castillo López
-- @Fecha:        13/08/2021
-- @Descripción:  Conjunto de pruebas para la creación y relación de objetos
--                usando esquemas distintos

-- Para usuario de clientes
CREATE USER administrador_clientes IDENTIFIED BY administrador_clientes;
-- Se agrega cuota en tablespaces
ALTER USER administrador_clientes QUOTA UNLIMITED ON users;
ALTER USER administrador_clientes QUOTA UNLIMITED ON clientes_tbs;
ALTER USER administrador_clientes QUOTA UNLIMITED ON indexes_tbs;
-- Privilegios
GRANT CREATE SESSION, CREATE TABLE, CREATE VIEW, CREATE PROCEDURE,
  CREATE SEQUENCE, CREATE TRIGGER, CREATE INDEX TO administrador_clientes;

-- Para usuario de gimnasios
CREATE USER administrador_gimnasios IDENTIFIED BY administrador_gimnasios
DEFAULT TABLESPACE autos_tbs
QUOTA UNLIMITED ON autos_tbs;
-- Privilegios
GRANT CREATE SESSION, CREATE TABLE, CREATE VIEW, CREATE PROCEDURE,
  CREATE SEQUENCE, CREATE TRIGGER, CREATE INDEX TO administrador_gimnasios;


-- Privilegios de selección
GRANT SELECT ON administrador_gimnasios TO administrador_clientes;
GRANT SELECT ON administrador_clientes TO administrador_gimnasios;

-- Tabla de usuario administrador_clientes
CREATE TABLE prueba(
  id_prueba NUMBER NOT NULL,
  archivo BLOB NOT NULL,
  CONSTRAINT prueba_pk PRIMARY KEY (id_prueba)
  USING INDEX (
    CREATE UNIQUE INDEX prueba_pk ON administrador_clientes.prueba(id_prueba)
    TABLESPACE indexes_tbs
  )
) LOB (archivo) STORE AS BASICFILE (TABLESPACE clientes_tbs)
TABLESPACE clientes_tbs;

INSERT INTO prueba(id_prueba, archivo)
VALUES (1, empty_blob());

-- Privilegios para referencias de esquema
GRANT REFERENCES ON administrador_clientes.prueba TO administrador_gimnasios;

-- Tabla de administrador_gimnasios
CREATE TABLE cliente(
  id_cliente NUMBER NOT NULL,
  id_prueba NUMBER NOT NULL,
  CONSTRAINT cliente_pk PRIMARY KEY (id_cliente),
  CONSTRAINT cliente_prueba_fk FOREIGN KEY (id_prueba)
  REFERENCES administrador_clientes.prueba(id_prueba)
);

INSERT INTO cliente(id_cliente, id_prueba)
VALUES (1, 1);

INSERT INTO cliente(id_cliente, id_prueba)
VALUES (1, 2);
