# @Autor:         Humberto Serafín Castillo López
# @Fecha:         04/08/2021
# @Descripción:   Realiza el borrado de los Redo Logs que ya no son usados

sudo rm /u01/app/oracle/oradata/SCLBDA2/redo03a.log \
/u01/app/oracle/oradata/SCLBDA2/redo02a.log \
/u01/app/oracle/oradata/SCLBDA2/redo01a.log \
/u02/app/oracle/oradata/SCLBDA2/redo02b.log \
/u02/app/oracle/oradata/SCLBDA2/redo03b.log \
/u02/app/oracle/oradata/SCLBDA2/redo01b.log \
/u03/app/oracle/oradata/SCLBDA2/redo03c.log \
/u03/app/oracle/oradata/SCLBDA2/redo02c.log \
/u03/app/oracle/oradata/SCLBDA2/redo01C.log

sudo find /u0* -name redo*.log | grep SCLBDA2
