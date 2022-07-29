with AnzahlStudentenJeVL as (
    select vorlnr, count(*) as AnzProf
	
    from hoeren 
    group by vorlnr (
	     select ))
		 
----------------------------------		 
select gebaeude, count (pr.vorlnr) as anz_pruefung
from professoren p , pruefen pr
where p.persnr = pr.persnr
group by gebaeude 
order by anz_pruefung desc
limit 1

select s.*, pr.vorlnr, pr.note
from studenten s, pruefen pr 
where s.matrnr = pr.matrnr and pr.note < 5.0
order by s.matrnr 


select s. matrnr, s.name, pr.vorlnr 
from studenten s, pruefen pr 
where s.matrnr = pr.matrnr
order by s.matrnr, pr.vorlnr 

---------------------- Florent 

create or replace view durchschnittsnote_stud as
	select s.name, s.matrnr, avg(pr.note)
	from studenten s, pruefen pr
	where s.matrnr = pr.matrnr and pr.note <= 4
	group by s.name, s.matrnr 
	
select *
from durchschnittsnote_stud

select distinct s.name, s.matrnr, p.vorlnr, p.note, pr.note, d.avg
from studenten s, pruefen p , durchschnittsnote_stud d, pruefen pr
where p.matrnr = d.matrnr and p.matrnr = s.matrnr and p.note > 4 and pr.matrnr = s.matrnr 
and p.vorlnr = pr.vorlnr and pr.note < d.avg
order by s.name


select distinct s.name , s.matrnr, p.vorlnr, p.note, pr.note, d.avg
from studenten s natural join pruefen p, durchschnittsnote_stud d natural join pruefen pr
where p.note > 4 and p.vorlnr = pr.vorlnr and pr.note < d.avg and pr.matrnr = p.matrnr
order by s.name
				
-------------- Korrektur 

WITH nichtbestanden AS (SELECT distinct *
FROM pruefen p
WHERE p.note = 5.0), bestanden AS (
	   SELECT *
       FROM pruefen p
	   WHERE p.note != 5.0), avgnote AS (
			SELECT matrnr , avg(note) note
		    FROM pruefen p
            WHERE p.note != 5.0
			GROUP BY matrnr)
			
SELECT DISTINCT s.name
FROM nichtbestanden n, bestanden b, avgnote a, studenten s, vorlesungen v
WHERE n.matrnr = b.matrnr and b.matrnr = a.matrnr and n.matrnr = s.matrnr
AND n.vorlnr = b.vorlnr and v.vorlnr = n.vorlnr
AND b.note < a.note

----------- ----------


------------------ Merveille
select s.*
from studenten s
where exists (
        select s.matrnr, s.name
 		from pruefen pr
        where pr.note < 5
		group by s.matrnr, s.name
		having  pr.note <  avg(pr.note) and exists (
				select *
				from pruefen p
				where s.matrnr = p.matrnr and p.note = 5) )

-------------------
 create table logik_and (a boolean , b boolean )
 
 drop table logik_and
 
 insert into logik_and values (true, true);
 insert into logik_and values (true, false);
 insert into logik_and values (false, true);
 insert into logik_and values (false, false);
 insert into logik_and values (null, null);
 insert into logik_and values (null, true);
 insert into logik_and values (null, false);
 insert into logik_and values (false, null);
 insert into logik_and values (true, null);
 
 select *, a and b as response
 from logik_and
 ---------------------
 
create table mytable_1 (val1 integer primary key, val2 integer, val3 integer)
create table mytabl1_default ( val1 integer primary key, val2 integer, val3 integer)
 
insert into mytable_1 values (1,2,3)
insert into mytable_1 values (4,5,6)
insert into mytable1_default values (1,2,3)
insert into mytable1_default values (4,5,6)
 
create table mytable_2 (val1 primary key integer, val2 integer, val3 integer)
create table mytabl2_default ( val1 primary key integer, val2 integer, val3 integer)

insert into mytable_2 values (7,8,9)
insert into mytable_2 values (10,11,12)
insert into mytabl2_default values (7,8,9)
insert into mytabl2_default values (10,11,12)
  
create table mytable_3 (val1 primary key integer, val2 integer, val3 integer)
create table mytabl3_default (val1 primary key integer, val2 integer, val3 integer)

insert into mytable_3 values (13,14,15)
insert into mytable_3 values (16,17,18)
insert into mytable3_default values (13,14,15)
insert into mytable3_default values (13,16, 15)

create table stud(mtr integer primary key, name varchar(30))

create view Anz as (
   select s.name, s.mtr
   from stud s)
   
insert into Anz(mtr) values(1)

create view Anz2 as (
   select s.name
   from stud s) 
 
select *
from stud
 