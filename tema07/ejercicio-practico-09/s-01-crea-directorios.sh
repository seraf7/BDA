# @Autor:         Humberto Serafín Castillo López
# @Fecha:         04/08/2021
# @Descripción:   Script encargado de crear la estructura de directorios para
#                 acticar el modo archivelog

#Creación de directorios
echo "Creando directorios..."
mkdir -p /unam-bda/archivelogs/SCLBDA2/disk_a
mkdir -p /unam-bda/archivelogs/SCLBDA2/disk_b

#Cambio de dueño de los directorios
echo "Cambiando dueño de los directorios..."
chown oracle:oinstall /unam-bda/archivelogs/SCLBDA2/disk_a
chown oracle:oinstall /unam-bda/archivelogs/SCLBDA2/disk_b

#Cambio de los permisos
echo "Cambiando permisos..."
chmod 750 /unam-bda/archivelogs/SCLBDA2/disk_a
chmod 750 /unam-bda/archivelogs/SCLBDA2/disk_b
