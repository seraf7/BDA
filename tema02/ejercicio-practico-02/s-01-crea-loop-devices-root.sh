# @Autor:        Humberto Serafín Castillo López
# @Fecha:        14/03/2021
# @Descripción:  Script encargado de realizar la creación de un loop device.
#                Se debe ejecutar por usuario root y posteriormente se debe
#                modificar el archivo /etc/fstab

#Verifica si existe el directorio unam-bd
if ! [ -d "/unam-bda" ]; then
  echo "Creando directorio unam-bda..."
  #Crea el directorio unam-bda
  mkdir /unam-bda
fi;

#Cambio al directorio unam-bda
cd /unam-bda

#Creación de archivos binarios de 1GB, representan los loop devices
dd if=/dev/zero of=disk2.img bs=100M count=10
dd if=/dev/zero of=disk3.img bs=100M count=10

#Se comprueba la creación de los archivos
du -sh disk*.img

#Se comprueba si fue exitoso
status=$?
if ! [ ${status} -eq 0 ]; then
  echo "Error al crear archivos disk*.img..."
  exit
fi;

#Se crean los loop devices al asociarlos a archivos disk
#-f localiza primer loop device disponible
#-P obliga al kernel a leer tabla de particiones, incluye nuevos loop devices
losetup -fP disk2.img
losetup -fP disk3.img

#Se confirma la creacion de los loop devices
losetup -a

#Se comprueba si fue exitoso
status=$?
if ! [ ${status} -eq 0 ]; then
  echo "Error al crear loop devices..."
  exit
fi;

#Formateo de los archivos a ext4
mkfs.ext4 disk2.img
mkfs.ext4 disk3.img

#Creacion de directorios para montar loop devices
mkdir /u02
mkdir /u03
