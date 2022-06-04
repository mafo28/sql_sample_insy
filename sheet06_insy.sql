
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


--Aufgabe 2
------2a
select gebauede, count(*) as anzahl         
  from pruefen pr, professoren p 
 where pr.PersNr = p.PersNr
 group by gebauede order by anzahl desc limit 1; 


----2b
select stud.name
  from studenten stud natural join pruefen pr       
 where
 

---2c: Welche Studenten (Name) haben eine Prüfung einmal nicht bestanden, dann aber mit einer Note
--bestanden, die besser ist, als ihre gesamte Durchschnittsnote?
select st.name
  from studenten st natural join pruefen pr1
 where exists (select vorgaenger 
               from vorraussetzung v
               where not exists ( select vorlNr 
                                  from studenten natural join pruefen pr2
                                  where pr2.matrNr = s.matrNr and pr2.vorlNr = v.vorgaenger
                                )
               )
group by matrNr; 