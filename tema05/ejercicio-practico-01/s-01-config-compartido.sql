-- @Autor:        Humberto Serafín Castillo López
-- @Fecha:        20/07/2021
-- @Descripción:  Script para realizar la configuración del modo compartido

--Conexión como sysdba
PROMPT Conectando como usuario sys...
CONNECT sys/system2 AS sysdba

--Configuración de 2 dispatchers con protocolo TCP
PROMPT Configurando dispatchers con TCP...
ALTER SYSTEM SET dispatchers = '(PROTOCOL=tcp)(DISPATCHERS=2)'
SCOPE=memory;

--Configuración de 4 shared servers
PROMPT Configurando shared servers...
ALTER SYSTEM SET shared_servers = 4 SCOPE=memory;

--Comprobación de parámetros configurados
PROMPT Dispatchers configurados...
SHOW PARAMETER dispatchers;

PROMPT Shared servers configurados...
SHOW PARAMETER shared_servers;

--Actualización del listener
PROMPT Actualizando listener...
ALTER SYSTEM register;

--Muestra información de los servicios del listener
PROMPT Mostrando servicios registrados en el listener...
!lsnrctl services
