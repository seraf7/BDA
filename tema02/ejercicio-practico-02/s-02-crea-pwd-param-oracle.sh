# @Autor:        Humberto Serafín Castillo López
# @Fecha:        17/03/2021
# @Descripción:  Script encargado de realizar la creación de el archivo de
#                passwords y archivo de parámetros PFILE para la BD sclbda2

#Se crea variable de entorno
echo "Creando variable de entorno ORACLE_SID..."
export ORACLE_SID=sclbda2

if [ -f $ORACLE_HOME/dbs/orapwsclbda2 ]; then
  echo "Ya existe un archivo de passwords..."
else
  echo "Creando el archivo de passwords..."
  #Creacion del archivo de passwords
  orapwd FILE=$ORACLE_HOME/dbs/orapwsclbda2 \
  FORMAT=12.2 \
  SYS=password
fi;

echo "Creando archivo de parámetros..."
echo "
#Archivo de parametros para la segunda base de datos de BDA
db_name=sclbda2
control_files=(/u01/app/oracle/oradata/SCLBDA2/control01.ctl,
              /u02/app/oracle/oradata/SCLBDA2/control02.ctl,
              /u03/app/oracle/oradata/SCLBDA2/control03.ctl)
memory_target=768M
" > $ORACLE_HOME/dbs/initsclbda2.ora

#Se comprueba si fue exitoso
status=$?
if ! [ ${status} -eq 0 ]; then
  echo "Ocurrió un error al crear archivo de parámetros..."
  exit
fi;

echo "Proceso completado..."
