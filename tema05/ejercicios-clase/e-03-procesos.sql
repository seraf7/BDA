-- A) Información sobre la sesión actual de la BD
SELECT sid, username, osuser, machine, program, status
FROM v$session
WHERE username = 'SYS';

-- B)
SELECT s.sql_id, sql.sql_text
FROM v$session s
JOIN v$sql sql ON s.sql_id = sql.sql_id;

-- C)
SELECT sh.user_id, sh.sample_time, sql.sql_text
FROM v$sql sql
JOIN v$active_session_history sh ON sql.sql_id = sh.sql_id;
