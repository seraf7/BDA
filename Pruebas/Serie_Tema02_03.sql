--Ejemplo recontrucción con transparencia de localizacion
SELECT c1.cliente_id, q1.nombre, q1.ap_pat, q1.ap_mat, c1.foto, c2.num_tarjeta,
  q1.num_seguridad
FROM c1
JOIN c2
ON c1.cliente_id = c2.cliente_id
JOIN (
  SELECT * FROM c3
  UNION ALL
  SELECT * FROM c4
  UNION ALL
  SELECT * FROM c5
) q1
ON c2.cliente_id = q1.cliente_id;


--Recontrucción de empleado
SELECT * FROM empleado_1@L1
UNION ALL
SELECT * FROM empleado_2@L1
UNION ALL
SELECT * FROM empleado_3@L1
UNION ALL
SELECT * FROM empleado_4@L2;

--Recontrucción de puesto
SELECT pu1.puesto_id, pu2.clave, pu2.descripcion, pu1.plantilla_contrato
FROM puesto_1@L1 pu1
JOIN (
  SELECT * FROM puesto_2@L1
  UNION ALL
  SELECT * FROM puesto_3@L2
) pu2
ON pu1.puesto_id = pu2.puesto_id;

--Consulta usando esquema global
SELECT em.nombre, pu.clave, pu.plantilla_contrato
FROM empleado em
JOIN puesto pu
ON em.puesto_id = pu.puesto_id;

--Consulta usando mapeo local
--Se Obtiene nombre del empleado, clave de puesto y plantilla
SELECT em_g.nombre, pu_g.clave, pu_g.plantilla_contrato
FROM (
  --Se reconstruye tabla empleado
  SELECT nombre, puesto_id FROM empleado_1
  UNION ALL
  SELECT nombre, puesto_id FROM empleado_2
  UNION ALL
  SELECT nombre, puesto_id FROM empleado_3
  UNION ALL
  SELECT nombre, puesto_id FROM empleado_4@L2
) em_g
JOIN (
  --Se reconstruye tabla puesto
  SELECT pu1.puesto_id, q1.clave, pu1.plantilla_contrato
  FROM puesto_1 pu1
  JOIN (
    SELECT puesto_id, clave FROM puesto_2
    UNION ALL
    SELECT puesto_id, clave FROM puesto_3@L2
  ) q1
  ON pu1.puesto_id = q1.puesto_id
) pu_g
ON em_g.puesto_id = pu_g.puesto_id;
