# @Autor:         Humberto Serafín Castillo López
# @Fecha:         05/08/2021
# @Descripción:   Creación del directorio usado para Block Change Tracking

echo "Creando carpeta..."
# Se crea nueva carpeta
mkdir -p /unam-bda/backups/block-tracking

echo "Cambiando dueño..."
# Se cambia el dueño de la carpeta
chown oracle:oinstall /unam-bda/backups/block-tracking

echo "Cambiando permisos..."
# Se cambian los permisos
chmod 750 /unam-bda/backups/block-tracking
