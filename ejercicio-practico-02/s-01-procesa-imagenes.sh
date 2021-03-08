# @Autor      Humberto Serafín Castillo López
# @Fecha      24/02/2021
# @Decripcion Script encargado de realizar la descarga y empaquetado
#             de imágenesen un archivo zip. El usuario indica la lista de
#             imágenes, número a descargar y ruta del archivo destino

#Parámetros
archivoImagenes="${1}"
numImagenes="${2}"
archivoZip="${3}"

#Función para desplegar información de ayuda
function ayuda(){
  #Se obtiene el parámetro código de error
  status="${1}"
  #Obtiene el texto de información
  cat s-02-ayuda.sh
  #Termina la ejecución con el código asignado
  exit "${status}"
}

#Validación de los parámetros de entrada
#-z valida si la variable está vacía
if [ -z "${archivoImagenes}" ]; then
  echo "ERROR: el nombre del archivo de imágenes es obligatorio"
  #Se invoca funcion de ayuda y se indica código de error 100
  ayuda 100
else
  #-f valida si el archivo indicado existe
  if ! [ -f "${archivoImagenes}" ]; then
    echo "ERROR: El archivo ${archivoImagenes} no existe"
    ayuda 101
  fi;
fi;

#Validación del número de imágenes
#=~ [0-9]+ verifica que la variable se conforme por números
#-gt verifica que el valor sea mayor
#-le verifica que le valor sea menor o igual
if ! [[ "${numImagenes}" =~ [0-9]+ && "${numImagenes}" -gt 0  &&
  "${numImagenes}" -le 90 ]]; then
    echo "ERROR: fuera del rango aceptado"
    ayuda 102
fi;

#Validación del archivo zip destino
#-n verifica que el tamaño de la cadena es mayor a 0
if [ -n "${archivoZip}" ]; then
  #Se extrae la ruta del archivo zip, separa directorio del archivo
  dirSalida=$(dirname "${archivoZip}")
  #Se extrae el nombre del archivo zip
  nombreZip=$(basename "${archivoZip}")
  #Verifica si el directorio no existe
  #-d comprueba si el archivo existe y es un directorio
  if ! [ -d "${dirSalida}" ]; then
    echo "ERROR: el directorio indicado no existe"
    ayuda 103
  fi;
else
  #Usa la variable de entorno USER para tomar el usuario del sistema
  dirSalida="/tmp/${USER}/imagenes"
  #Creación del directorio
  #-p crea la ruta de directorios indicada
  mkdir -p "${dirSalida}"
  #Definicion del nombre del zip
  #Se extraen los elementos de la fecha para formar el nombre
  nombreZip="imagenes-$(date +'%Y-%m-%d-%H-%M-%S').zip"
fi;

echo "Parámetros correctos, obteniendo imágenes..."

#Limpia el directorio en caso de no estar vacío
#-rf vuelve recursiva la operación, pasa por todos los directorios
rm -rf "${dirSalida}"/"${nombreZip}"

#Lectura linea a linea del archivo con la lista de imágenes a descargar
count=1
while read -r linea
do
  #Obtiene imagen de la URL indicada
  #-q indica que no se mostraran mensajes durante ejecución
  #-P para especificar el directorio de descarga
  wget -q -P "${dirSalida}" "${linea}"

  #Valida el código de salida de wget
  status=$?
  #-eq verifica que los valores sean iguales
  if ! [ ${status} -eq 0 ]; then
    echo "ERROR: no se pudo descargar el archivo de ${linea}"
    ayuda 104
  fi;

  #Valida si el contador ha llegado al numero de imágenes solicitado
  #-ge verifica si el valor es mayor o igual
  if [ ${count} -ge ${numImagenes} ]; then
    #Rompe el ciclo
    break;
  fi;

  #Incrementa el contador
  count=$((count+1))
done < "${archivoImagenes}"

#Generación del archivo zip
#Creación de una variable de entorno nueva
export IMG_ZIP_FILE="${dirSalida}"/"${nombreZip}"
#-j indica que no se creará un directorio al descomprimir
zip -j ${IMG_ZIP_FILE} "${dirSalida}"/*.jpg

#Eliminación de imagenes descargadas
rm -rf "${dirSalida}"/*.jpg

#Cambio de permisos del archivo zip
#6: lectura y escritura
#0: ningún permiso
chmod 600 "${IMG_ZIP_FILE}"

#Generacion de lista de archivos inscluidos en el zip
#-Z evita la descompresión del archivo al leerlo
#-1 obtiene lista de los nombres de archivos
#> redirecciona la salida a un archivo de texto
unzip -Z1 "${IMG_ZIP_FILE}" > "${dirSalida}"/s-00-lista-archivos.txt
