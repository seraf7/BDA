-- @Autor:        Humberto Serafín Castillo López
-- @Fecha:        20/07/2021
-- @Descripción:  Script para probar los distintos tipos de conexión a la BD
--                y registro de la información de sesión

--Conexión en modo dedicado
PROMPT Conectando como sys en modo dedicado...
CONNECT sys/system2 as sysdba

--Tabla para registrar la sesión iniciada
CREATE TABLE serafin0501.t01_session_data AS
  SELECT 1 AS id, sid, logon_time, username, status, server, osuser,
    process, port
  FROM v$session
  WHERE username = 'SYS'
  AND osuser <> 'oracle';

COMMIT;

set serveroutput on

CREATE OR REPLACE TRIGGER trg_captura_sesion
  AFTER INSERT ON serafin0501.t01_session_data
  FOR EACH ROW
  DECLARE
    v_sid NUMBER;
    v_logon DATE;
    v_username VARCHAR2(128);
    v_status VARCHAR2(8);
    v_server VARCHAR2(9);
    v_osuser VARCHAR2(128);
    v_process VARCHAR2(24);
    v_port NUMBER;
  BEGIN
    --Obtiene datos de la sesión
    SELECT sid, logon_time, username, status, server, osuser, process, port
    INTO v_sid, v_logon, v_username, v_status, v_server, v_osuser,
      v_process, v_port
    FROM v$session
    WHERE osuser <> 'oracle';

    -- :new.sid = v_sid;
    -- :new.logon_time = v_logon;
    -- :new.username = v_username;
    -- :new.status = v_status;
    -- :new.server = v_server;
    -- :new.osuser = v_osuser;
    -- :new.process = v_process;
    -- :new.port = v_port;

    --Actualiza el registro
    UPDATE serafin0501.t01_session_data
    SET sid = v_sid, logon_time = v_logon, username = v_username,
      status = v_status, server = v_server, osuser = v_osuser,
      process = v_process, port = v_port
    WHERE id = :new.id;
  END;
/

--Conexión en modo compartido
PROMPT Conectando como sys en modo compartido...
CONNECT sys/system2@sclbda2 AS sysdba

--Registro de la sesión iniciada
INSERT INTO serafin0501.t01_session_data(id) VALUES (2);

-- INSERT INTO serafin0501.t01_session_data(id, sid, logon_time, username, status,
--   server, osuser, process, port)
--   SELECT 2, sid, logon_time, username, status, server, osuser, process, port
--   FROM v$session
--   WHERE username = 'SYS'
--   AND osuser <> 'oracle';
COMMIT;

--Conexión en modo dedicado
PROMPT Conectando como serafin0501 en modo dedicado...
CONNECT serafin0501/serafin@sclbda2_dedicated

--Registro de la sesión iniciada
INSERT INTO serafin0501.t01_session_data(id) VALUES (3);

-- INSERT INTO serafin0501.t01_session_data(id, sid, logon_time, username, status,
--   server, osuser, process, port)
--   SELECT 3, sid, logon_time, username, status, server, osuser, process, port
--   FROM v$session
--   WHERE username = 'SERAFIN0501'
--   AND server = 'DEDICATED';

COMMIT;

--Conexión en modo compartido
PROMPT Conectando como serafin0501 en modo compartido...
CONNECT serafin0501/serafin@sclbda2_shared

--Registro de la sesión iniciada
INSERT INTO serafin0501.t01_session_data(id) VALUES (4);

-- INSERT INTO serafin0501.t01_session_data(id, sid, logon_time, username, status,
--   server, osuser, process, port)
--   SELECT 4, sid, logon_time, username, status, server, osuser, process, port
--   FROM v$session
--   WHERE username = 'SERAFIN0501'
--   AND server <> 'DEDICATED';

COMMIT;
