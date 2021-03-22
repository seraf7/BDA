-- @Autor:        Humberto Serafín Castillo López
-- @Fecha:        20/03/2021
-- @Descripción:  Ejecución de scripts que crean las tablas y vistas del
--                diccionario de datos

--Conexión como usuario sys
PROMPT Conectando como usuario sys
CONNECT sys/system2 AS sysdba

--Ejecución de script que crea vistas del diccionario de datos y otros objetos
--@ indica la ejecución de un archivo de instrucciones
--? hace referencia a ORACLE_HOME
PROMPT Ejecución catalog.sql
@?/rdbms/admin/catalog.sql

--Ejecución de script de configuración de objetos para programación PL/SQL
PROMPT Ejecución de catproc.sql
@?/rdbms/admin/catproc.sql

--Script de recompilación de módulos inválidos
PROMPT Ejecución de utlrp.sql
@?/rdbms/admin/utlrp.sql

--Conexión como usuario system
PROMPT Conectando como usuario system
CONNECT system/system2

--Script de configuración de SQL *PLUS
PROMPT Ejecución de pupbld
@?/sqlplus/admin/pupbld.sql
