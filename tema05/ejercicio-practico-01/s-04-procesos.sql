-- @Autor:        Humberto Serafín Castillo López
-- @Fecha:        20/07/2021
-- @Descripción:  Script para obtener información de las sesiones creadas por
--                usuarios y procesos de la instancia

--Conexión como sys en modo compartido
PROMPT Conectando como sys...
CONNECT sys/system2 AS sysdba

--Tabla informativa de la sesión del usuario sys
CREATE TABLE serafin0501.t07_session_info_context AS
  SELECT
    SYS_CONTEXT ('USERENV', 'HOST') AS host,
    SYS_CONTEXT ('USERENV', 'OS_USER') AS os_user,
    SYS_CONTEXT ('USERENV', 'SESSION_USERID') AS user_id,
    SYS_CONTEXT ('USERENV', 'SID') AS session_id
  FROM DUAL;

--Tabla de información complementaria de la sesión
CREATE TABLE serafin0501.t08_session_info_view AS
  SELECT sid AS session_id, paddr AS process_address, username AS bd_username,
    status AS session_status, port AS client_port,
    process AS os_client_process_id, program AS client_program
  FROM v$session
  JOIN serafin0501.t07_session_info_context T ON t.session_id = v$session.sid;

--Tabla informativa de los procesos de la sesión actual
CREATE TABLE serafin0501.t09_process_info AS
  SELECT P.sosid, P.pname, P.background, P.tracefile
  FROM v$process P
  JOIN serafin0501.t07_session_info_context S ON S.os_user = P.username;

--Tabla informativa de los procesos de background
CREATE TABLE serafin0501.t10_background_process AS
  SELECT addr, sosid, pname, username AS os_username, background
  FROM v$process
  WHERE background = 1;

--Tabla informativa de los procesos de foreground
CREATE TABLE serafin0501.t11_foreground_process AS
  SELECT P.addr, P.sosid, P.pname, P.username AS os_username,
    S.username AS bd_username, P.background
  FROM v$process P
  FULL JOIN v$session S ON P.addr = S.paddr
  WHERE background IS NULL;

--Consulta de proceso del SO del cliente para la sesión
--os_client_process_id en t08_session_info_view
!echo "Proceso del lado del cliente..."
!ps -ef | grep 65051

--Consulta del proceso del SO del servidor para la sesión
--sosid en t09_process_info
!echo "Proceso del lado del servidor..."
!ps -ef | grep 65053
