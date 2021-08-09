# @Autor:         Humberto Serafín Castillo López
# @Fecha:         05/08/2021
# @Descripción:   Creación de los directorios destino para los respaldos

# Se crea carpeta de backups
mkdir -p /unam-bda/backups

# Se cambia el dueño
chown oracle:oinstall /unam-bda/backups

# Se cambian permisos
chmod 750 /unam-bda/backups
