-- @Autor:        Humberto Serafín Castillo López
-- @Fecha:        20/03/2021
-- @Descripción:  Script encargado de realizar la creación de la base de datos
--                y cambio de contraseñas de usuario

--Inicio de sesión con usuario sys, usa archivo de passwords
PROMPT Conectando como usuario sys
CONNECT sys/hola1234* AS sysdba

--Se Verifica el estado de la base de datos
DECLARE
  v_count NUMBER;
  v_username VARCHAR2(16) := 'sclbda2';
BEGIN
  SELECT COUNT(*) INTO v_count FROM v$instance WHERE status = 'STARTED';
  IF v_count < 1 THEN
    --Inicia la instancia en modo mount
    EXECUTE IMMEDIATE 'ALTER DATABASE NOMOUNT';
  END IF;
END;
/

--Termina el script si ocurre un error y deshace cambios realizados
whenever sqlerror exit rollback;
PROMPT Iniciando creación de la base de datos

--Creación de la base de datos
CREATE DATABASE sclbda2
  --creación del usuario sys
  USER sys IDENTIFIED BY system2
  --Creación del usuario system
  USER system IDENTIFIED BY system2
  --Creacion de los grupos de archivos Redo Log
  LOGFILE GROUP 1 (
    '/u01/app/oracle/oradata/SCLBDA2/redo01a.log',
    '/u02/app/oracle/oradata/SCLBDA2/redo01b.log',
    '/u03/app/oracle/oradata/SCLBDA2/redo01C.log') SIZE 50M BLOCKSIZE 512,
  GROUP 2 (
    '/u01/app/oracle/oradata/SCLBDA2/redo02a.log',
    '/u02/app/oracle/oradata/SCLBDA2/redo02b.log',
    '/u03/app/oracle/oradata/SCLBDA2/redo02c.log') SIZE 50M BLOCKSIZE 512,
  GROUP 3 (
    '/u01/app/oracle/oradata/SCLBDA2/redo03a.log',
    '/u02/app/oracle/oradata/SCLBDA2/redo03b.log',
    '/u03/app/oracle/oradata/SCLBDA2/redo03c.log'
  ) SIZE 50M BLOCKSIZE 512
  MAXLOGHISTORY 1
  MAXLOGFILES 16
  MAXLOGMEMBERS 3
  MAXDATAFILES 1024
  --Elección del conjunto de caracteres
  CHARACTER SET AL32UTF8
  NATIONAL CHARACTER SET AL16UTF16
  --Creación de los tablespaces
  EXTENT MANAGEMENT LOCAL
  --tablespace para system
  DATAFILE '/u01/app/oracle/oradata/SCLBDA2/system01.dbf'
    SIZE 700M REUSE AUTOEXTEND ON NEXT 10240K  MAXSIZE UNLIMITED
  --tablespace auxiliar
  SYSAUX DATAFILE '/u01/app/oracle/oradata/SCLBDA2/sysaux01.dbf'
    SIZE 550M REUSE AUTOEXTEND ON NEXT 10240K MAXSIZE UNLIMITED
  --tablespace default, para todos los usuarios
  DEFAULT TABLESPACE users
    DATAFILE '/u01/app/oracle/oradata/SCLBDA2/users01.dbf'
    SIZE 500M REUSE AUTOEXTEND ON MAXSIZE UNLIMITED
  --tablespace temporal
  DEFAULT TEMPORARY TABLESPACE tempts1
    TEMPFILE '/u01/app/oracle/oradata/SCLBDA2/temp01.dbf'
    SIZE 20M REUSE AUTOEXTEND ON NEXT 640K MAXSIZE UNLIMITED
  --tablespace para datos undo
  UNDO TABLESPACE undotbs1
    DATAFILE '/u01/app/oracle/oradata/SCLBDA2/undotbs01.dbf'
    SIZE 200M REUSE AUTOEXTEND ON NEXT 5120K MAXSIZE UNLIMITED;

--Cambio de contraseñas de usuarios
ALTER USER sys IDENTIFIED BY system2;
ALTER USER system IDENTIFIED BY system2;

--Para regresar a la configuracion original
--whenever sqlerror continue none;
