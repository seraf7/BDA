-- @Autor:         Humberto Serafín Castillo López
-- @Fecha:         05/08/2021
-- @Descripción:   Activación de la funcionalidad block change tracking

-- Conexión como usuario sys
CONNECT sys/system2 AS sysdba

-- Activación de block change tracking
ALTER DATABASE ENABLE BLOCK CHANGE TRACKING USING FILE
  '/unam-bda/backups/block-tracking/change_tracking.dbf';
