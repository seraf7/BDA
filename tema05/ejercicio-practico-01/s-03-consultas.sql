-- @Autor:        Humberto Serafín Castillo López
-- @Fecha:        20/07/2021
-- @Descripción:  Consultas informativas de los procesos implicados en el
--                modo compartido de la BD

--Conexión como sys en modo compartido
PROMPT Conectando como sys en modo compartido...
CONNECT sys/system2@sclbda2_shared AS sysdba

--Tabla de configuración de los dispatchers
CREATE TABLE serafin0501.t02_dispatcher_config AS
  SELECT 1 AS id, dispatchers, connections, sessions, service
  FROM v$dispatcher_config;

--Tabla de información de los dispatchers
CREATE TABLE serafin0501.t03_dispatcher AS
  SELECT 1 AS ID, name, network, status, messages,
  ROUND(bytes / (1024 * 1024) , 2) AS messages_mb,
  created AS circuits_created,
  ROUND(idle / (1000 * 60), 2) AS idle_min
  FROM v$dispatcher;

--Tabla informativa de los shared servers
CREATE TABLE serafin0501.t04_shared_server AS
  SELECT 1 AS id, name, status, messages,
  ROUND(bytes / (1024 * 1024), 2) AS messages_mb, requests,
  ROUND(idle / (1000 * 60), 2) AS idle_min,
  ROUND(busy / (1000 * 60), 2) AS busy_min
  FROM v$shared_server;

--Tabla informativa de las colas de mensajes de shared_servers y dispatchers
CREATE TABLE serafin0501.t05_queue AS
  SELECT 1 AS id, queued,
  ROUND(wait / (1000 * 60), 2) AS wait, totalq
  FROM v$queue;

--Tabla informativa de los virtual circuit
CREATE TABLE serafin0501.t06_virtual_circuit AS
  SELECT 1 AS id, C.circuit, D.name, C.server, C.status, C.queue
  FROM v$circuit C
  JOIN v$dispatcher D ON D.paddr = C.dispatcher;
