# @Autor:       Humberto Serafín Castillo López
# @Fecha:       08/03/2021
# @Descripción: Script que simula la perdida del archivo de passwords y
#               posteriormente realiza su creación. Requiere ser ejecutado
#               como usuario oracle

#Verificar si existe el directorio backups
if ! [ -d "/home/${USER}/backups" ]; then
  #Se crea el directorio especificado
  mkdir -p "/home/${USER}/backups"
  echo "Directorio de respaldos creado..."
fi;

#Respaldo del archivo de passwords actual
cp $ORACLE_HOME/dbs/orapwsclbda1 /home/${USER}/backups

#Verifica que el respaldo ha sido creado
if ! [ -f "/home/${USER}/backups/orapwsclbda1" ]; then
  echo "No se pudo realizar el respaldo..."
  exit;
fi;

#Se elimina el archivo de passwords
rm $ORACLE_HOME/dbs/orapwsclbda1

echo "Se creará el nuevo archivo de passwords..."
#Creación del archivo de passwords permitiendo su sobreescritura
#la nueva contraseña se ingresa durante ejecución
orapwd FILE=$ORACLE_HOME/dbs/orapwsclbda1 \
FORCE=y \
FORMAT=12.2 \
SYS=password \
SYSBACKUP=password
