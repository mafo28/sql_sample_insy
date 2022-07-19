/* Mengeoperationen: Unionmenge (union), Durchschnittmenge (intersect), Differenzmenge (except)*/

select *
from testtab

insert into testtab values (4, 2, 3, null, null)

create table test (e integer, f integer, g integer, h integer, vorname varchar(30) )
insert into test values (2 ,3 ,4 ,null, null);
insert into test values (1,2,3,null, null);
insert into test values (7,2,3,null, null);
insert into test values (1,2,8,null, null);
insert into test values (4,5,6,null, null);
insert into test values (1,2,8,null, null);
insert into test values (1, 2, 3, 4, null);
insert into test values (1, 2, 3, null, 5);
insert into test values (1, 2, 3, null, 5);

select *
from test

-- Durchscnhittmenge zwischen testtab und test OHNE Duplikaten
(select * from testtab)
intersect
(select * from test); 

-- Durchscnhittmenge zwischen testtab und test MIT Duplikaten
(select * from testtab)
intersect all
(select * from test); 

-- Differenzmenge zwischen testtab und test OHNE Duplikaten
(select * from testtab)
except
(select * from test); 

-- Differenzmenge zwischen testtab und test MIT Duplikaten
(select * from testtab)
except all
(select  * from test); 

-- Unionmenge zwischen testtab und test OHNE Duplikaten
(select * from testtab)
union
(select  * from test); 

-- alle elemente die mehmals im testtab vorkommen
(select * from testtab)
except all
(select  distinct * from testtab);

-- unkorrelierte Unteranfrage
-- Alle professoren, die eine Vorlesungen anbieten
select name 
from professoren
where persnr in ( select gelesen_von from vorlesungen)

-- korrelierte Unteranfrage
-- Alle professoren, die eine Vorlesungen anbieten
select name 
from professoren p
where exists  ( select * from vorlesungen v where v.gelesen_von = p.persnr)

--- any: wir kennen den Vergleichswert NICHT
select name, semester
from studenten
where semester > any ( select semester from studenten)

--- hier kennen wir den Vergleichswert
select name, semester
from studenten 
where semester > 1

-- studierende, die bei höchstem semester sind
select name , semester
from studenten
where semester >= all ( select semester from studenten) 
--
select name , semester
from studenten
where semester > all ( select semester from studenten)

-- 
select s.*
from studenten s
where not exists ( select * from vorlesungen v where  v.sws = 4 and not exists (
                         select * from hoeren h where s.matrnr = h.matrnr and h.vorlnr = v.vorlnr) ); 