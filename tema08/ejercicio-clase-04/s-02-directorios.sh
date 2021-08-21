# @Autor:         Humberto Serafín Castillo López
# @Fecha:         05/08/2021
# @Descripción:   Provocar una perdida de datafile. Requiere que la instancia
#                 esté detenida

# Crear directorio
mkdir /home/oracle/backups/temp-backups

#Mover el data file
mv /u01/app/oracle/oradata/SCLBDA2/sysaux01.dbf \
/home/oracle/backups/temp-backups
