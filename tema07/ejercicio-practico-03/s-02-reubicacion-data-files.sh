# @Autor:         Humberto Serafín Castillo López
# @Fecha:         02/08/2021
# @Descripción:   Script con instrucciones para reubicar los data files a
#                 nivel sistema operativo

# Se crea una copia del archivo de control
# originalmente el archivo pertenece a oracle:oinstall
sudo cp /u01/app/oracle/oradata/SCLBDA2/control01.ctl \
/unam-bda/ejercicios-practicos/t0703

# Se mueven y renombran los data files, las acciones deben realizarse
# como usuario oracle
mv /u01/app/oracle/oradata/SCLBDA2/store_tbs_multiple_01.dbf \
/u03/app/oracle/oradata/SCLBDA2/store_tbs_multiple_013.dbf

mv /u02/app/oracle/oradata/SCLBDA2/store_tbs_multiple_02.dbf \
/u02/app/oracle/oradata/SCLBDA2/store_tbs_multiple_023.dbf

mv /u03/app/oracle/oradata/SCLBDA2/store_tbs_multiple_03.dbf \
/u01/app/oracle/oradata/SCLBDA2/store_tbs_multiple_031.dbf
