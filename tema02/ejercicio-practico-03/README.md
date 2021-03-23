# Ejercicio 03: Creación de una base de datos con la instrucción create database

## Objetivo
Crear una base de datos a partir de la instrucción create database así como la creación de su diccionario de datos posterior proceso de configuración realizado en ejercicios anteriores.

## Descripción
* `s-01-crea-spfile-ordinario.sql`: creación de un SPFILE
* `s-02-crea-directorios-root.sh`: creación de directorios para la BD
* `s-03-crea-bd-ordinario.sql`: creación de la base de datos
* `s-04-crea-diccionario-datos-ordinario.sql`: ejecución de scripts para crear el diccionario de datos

### Instrucciones de ejecución
Como usuario del sistema operativo y ubicado en el directorio de los archivos ejecutar:
```
export ORACLE_SID=sclbda2
sqlplus /nolog
start s-05-validador-main.sql
```
