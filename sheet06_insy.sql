
--1a
drop table if exists Assistenten; 

--1b
alter table professoren
add column gebauede integer, 
add column raumnummer integer
CHECK (gebauede >= 0 AND raumnummer >= 0); 

/** import
 * psql-d insy2022 < /Desktop/buero.sql
**/

--1c
alter table pruefen add column sws integer; 

--1d
update pruefen pr
   set sws = vl.sws
   from vorlesungen vl
 where pr.vorlNr = vl.vorlNr

 -- oder

 update pruefen
    set sws=vorlesungen.sws
  where pruefen.vorlNr = vorlesungen.vorlNr