--Creación del usuario SERAFIN0105 sin cuota de almacenamiento
PROMPT Creando al usuario serafin0105
CREATE USER serafin0105 IDENTIFIED BY serafin;
--Asignación de privilegio de inicio de sesión
GRANT CREATE SESSION TO serafin0105
--Asignación de rol
GRANT sysoper TO serafin0105;

--Conexion nueva
CONNECT serafin0104/serafin;
--Asignar privilegios
GRANT INSERT ON auto TO serafin0105;
--Insercion
INSERT INTO serafin0104.auto
VALUES (1, '07-February-2010', 'PL-A', 'AKCS');
