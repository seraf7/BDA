# @Autor:         Humberto Serafín Castillo López
# @Fecha:         15/04/2021
# @Descripción:   Script para la creación del directorio base, usado para
#                 almacenar los archivos generados en el ejercicio. Se debe
#                 ejecutar como root

echo "Creando directorios..."
#Creación de directorios
mkdir -p /unam-bda/ejercicios-practicos/t0204

echo "Cambiando dueño de los directorios..."
#Cambio de dueño y grupo de pertenencia
cd /unam-bda
chown -R serafin:oinstall ejercicios-practicos

echo "Cambiando permisos de los directorios..."
#Dueño y grupo: todos los permisos
#Otros: solo lectura
chmod -R 774 ejercicios-practicos
