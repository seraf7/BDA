# Ejercicio 04: Administración de parámetros

## Objetivo
Comprender y poner en práctica los conceptos asociados con la configuración de los parámetros de una base de datos, en particular, los 3 niveles de aplicación: nivel sesión, nivel instancia y nivel SPFILE, así como las diferentes opciones que existen para obtener y reconstruir tanto PFILEs como SPFILEs.

## Descripción
* `s-00-crea-directorios.sh`: archivo bash usado para la preparación inicial de directorios

* Los archivos con la estructura `s-0*.sql`, son usados para la realización de las actividades solicitadas en la práctica

### Instrucciones de ejecución
La validación se realiza en dos partes. En la primera parte, se validan los cambios de parámetros con los siguientes comandos
```
sqlplus /nolog
start s-05-validador-main-cambios.sql
```
En la segunda parte, se valida la correcta reastauración de la instancia, para ello se debe ejecutar el script `s-04-restaura-parametros.sql` y posteriormente
```
sqlplus /nolog
start s-06-validador-main-restaura.sql
```
