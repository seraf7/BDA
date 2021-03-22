# @Autor:         Humberto Serafín Castillo López
# @Fecha:         20/03/2021
# @Descripción:   Script para realizar la creación de los directorios que
#                 requiere una base de datos. Ejecutado como usuario root

#Creación de directorio para data files
cd /u01/app/oracle/oradata
mkdir SCLBDA2

#Asigna como dueño a usuario oracle
chown oracle:oinstall SCLBDA2
#Cambio de permisos
#Dueño, todos los permisos
#Grupo, lectura y ejecución
chmod 750 SCLBDA2

#Creación de directorio para archivos de control en /u02
cd /u02
mkdir -p app/oracle/oradata/SCLBDA2

#Creación de directorio para archivos de control en /u03
cd /u03
mkdir -p app/oracle/oradata/SCLBDA2

#Cambio de dueño y permisos de archivos dentro de /u02
cd /u02
#-R, aplica el comando sobre toda la estructura de directorios
#*, indica que se toma cualquier archivo
chown -R oracle:oinstall *
chmod -R 750 *

#Cambio de dueño y permisos de archivos dentro de /u03
cd /u03
chown -R oracle:oinstall *
chmod -R 750 *
