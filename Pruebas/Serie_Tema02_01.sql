--Creacion de la tabla profesor para pruebas
CREATE TABLE serafin0104.profesor(
  profesor_id NUMERIC(5,0),
  nombre VARCHAR(40),
  es_investigador NUMERIC(1,0),
  es_admin NUMERIC(1,0),
  es_directivo NUMERIC(1,0)
);

INSERT INTO serafin0104.profesor
VALUES (12, 'Jorge', 0, 0, 0);

INSERT INTO serafin0104.profesor
VALUES (32, 'Pedro', 1, 0, 0);

INSERT INTO serafin0104.profesor
VALUES (21, 'Ruben', 0, 1, 1);

INSERT INTO serafin0104.profesor
VALUES (90, 'Sandra', 1, 1, 1);

--Prueba decode
SELECT profesor_id, nombre
FROM serafin0104.profesor
WHERE (
  DECODE(es_investigador, 1, 1, 0)+
  DECODE(es_admin, 1, 1, 0)+
  DECODE(es_directivo, 1, 1, 0)) > 1;


--Creación de la tabla auto para pruebas
CREATE TABLE serafin0104.auto(
  auto_id NUMERIC(3,0),
  fecha_construccion DATE,
  lugar_construccion VARCHAR2(5),
  clave_agencia VARCHAR2(4)
);

--Insercion de registros en auto
INSERT INTO serafin0104.auto
VALUES (1, '07-February-2010', 'PL-A', 'AKCS');

INSERT INTO serafin0104.auto
VALUES (3, '07-February-2011', 'PL-A', 'BKCS');

INSERT INTO serafin0104.auto
VALUES (4, '07-March-2010', 'PL-A', 'JKCS');

INSERT INTO serafin0104.auto
VALUES (9, '27-January-2015', 'PL-A', 'TKCS');

INSERT INTO serafin0104.auto
VALUES (11, '15-October-2019', 'PL-A', 'ZKCS');

INSERT INTO serafin0104.auto
VALUES (19, '21-November-2010', 'PL-B', 'UKCS');

INSERT INTO serafin0104.auto
VALUES (23, '31-March-2019', 'PL-B', 'RKCS');

--Consultar todos los datos de la tabla
SELECT * FROM serafin0104.auto;

--Consulta autos viejitos
SELECT * FROM serafin0104.auto
WHERE fecha_construccion < TO_DATE('01/03/2010', 'dd/mm/yyyy');

--Autos nuevos de las agencias A-H
SELECT * FROM serafin0104.auto
WHERE fecha_construccion >= TO_DATE('01/03/2010', 'dd/mm/yyyy') AND
  SUBSTR(clave_agencia, 0, 1) BETWEEN 'A' AND 'H';

--Autos nuevos de las agencias I-R
SELECT * FROM serafin0104.auto
WHERE fecha_construccion >= TO_DATE('01/03/2010', 'dd/mm/yyyy') AND
  SUBSTR(clave_agencia, 0, 1) BETWEEN 'I' AND 'R';

--Autos nuevos de las agencias S-Z, planta A
SELECT * FROM serafin0104.auto
WHERE fecha_construccion >= TO_DATE('01/03/2010', 'dd/mm/yyyy') AND
  SUBSTR(clave_agencia, 0, 1) >= 'S' AND
  SUBSTR(clave_agencia, 0, 1) <= 'Z' AND
  lugar_construccion = 'PL-A';

--Alternativa
SELECT * FROM serafin0104.auto
WHERE fecha_construccion >= TO_DATE('01/03/2010', 'dd/mm/yyyy') AND
  SUBSTR(clave_agencia, 0, 1) BETWEEN 'S' AND 'Z' AND
  lugar_construccion = 'PL-A';

--Autos nuevos de las agencias S-Z, planta B
SELECT * FROM serafin0104.auto
WHERE fecha_construccion >= TO_DATE('01/03/2010', 'dd/mm/yyyy') AND
  SUBSTR(clave_agencia, 0, 1) >= 'S' AND
  SUBSTR(clave_agencia, 0, 1) <= 'Z' AND
  lugar_construccion = 'PL-B';

--Alternativa
SELECT * FROM serafin0104.auto
WHERE fecha_construccion >= TO_DATE('01/03/2010', 'dd/mm/yyyy') AND
  SUBSTR(clave_agencia, 0, 1) BETWEEN 'S' AND 'Z' AND
  lugar_construccion = 'PL-B';
