# Ejercicio 04: Privilegios de Administración, roles y mecanismos de autenticación

## Objetivo
Comprender y poner en práctica los conceptos referentes a los privilegios de administración así como los diferentes mecanismos de autenticación que pueden emplearse en una base de datos.

## Descripción
Scripts para obtener información de la base de datos y realizar tareas de administración
* `s-01-version-bd.sql`: versión de la base de datos
* `s-02-roles.sql`: visualización de roles
* `s-03-archivo-passwords.sh`: creación de archivo de passwords
* `s-04-privs-admin.sql`: usuarios de administración
* `s-05-schemas.sql` esquemas de los privilegios de administración

### Instrucciones de ejecución
En una terminal se accede al directorio donde se ecuentran los archivos y se inicia el proceso de validación como se indica:
```
su -l oracle
export ORACLE_SID=sclbda1
sqlplus /nolog
start s-06-validador-oracle-main.sql
```
