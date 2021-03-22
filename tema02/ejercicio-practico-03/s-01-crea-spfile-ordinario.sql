-- @Autor:        Humberto Serafín Castillo López
-- @Fecha:        20/03/2021
-- @Descripción:  Script para realizar la creación de un SPIFILE (archivo
--                binario)a partir de un archivo PFILE (archivo de texto).
--                Se debe haber inicializado ORACLE_SID con sclbda2

--Autenticación como usuario sys
CONNECT sys/hola1234* as sysdba

--Inicio de instancia en modo nomount, no existe la base de datos
--que se iniciará
STARTUP nomount

--Creación del archivo binario
CREATE SPFILE FROM PFILE;

--Verifica que se ha creado el SPIFILE
--! permite ejecuatar comandos del sistema operativo
!ls $ORACLE_HOME/dbs/spfilesclbda2.ora
