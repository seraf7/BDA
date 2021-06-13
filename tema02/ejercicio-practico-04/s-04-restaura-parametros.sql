-- @Autor:        Humberto Serafín Castillo López
-- @Fecha:        18/04/2021
-- @Descripción:  Script que realiza la restauración de parámetros de la BD
--                a partir de un PFILE

--Se realiza conexión como sysdba
PROMPT Conectando como usuario sys...
CONNECT sys/system2 AS sysdba

--Detiene la instancia
PROMPT Deteniendo la instancia...
SHUTDOWN IMMEDIATE

--Crear SPFILE de un PFILE específico
PROMPT Creando nuevo spfile...
create spfile
from pfile='/unam-bda/ejercicios-practicos/t0204/e-02-spparameter-pfile.txt';

--Vuelve a iniciar la instancia
PROMPT Reiniciando la instancia...
STARTUP
