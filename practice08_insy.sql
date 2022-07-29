/*Prozentsatz der studenten pro vorlesung
1. viele studneten gibt es pro vorlesung
2. viele studenten gibt es in der DB */

with AnzStudentenJeVL as (
	    select vorlnr, count (*) as anz_stud_pro_vl
		from hoeren
		group by vorlnr
) , 
GesamtAnzStudenten as ( 
		select count(*) as ges_anz_stud
		from studenten
)		
select a.vorlnr,  a.anz_stud_pro_vl, g.ges_anz_stud, a.anz_stud_pro_vl/cast(g.ges_anz_stud as float) as anteil_stud
from AnzStudentenJeVL a, GesamtAnzStudenten g;

---------
/*Welche Studenten (Name) haben eine Prüfung einmal nicht bestanden, dann aber mit einer Note
bestanden, die besser ist, als ihre gesamte Durchschnittsnote?*/

with GepruefteteStudenten as (
	select s.name, s.matrnr, p.vorlnr, p.note
	from studenten s, pruefen p
	where s.matrnr = p.matrnr
), 
BestandendePruefungJeStud as (
	select s.name, s.matrnr, pr.note, pr.vorlnr
	from studenten s, pruefen pr
	where s.matrnr = pr.matrnr and pr.note < 5 
),
AvgNote as (
select matrnr, avg(note) as durchschnittsnote
from pruefen 
where note < 5
group by matrnr)

select distinct b.name
from  BestandendePruefungJeStud b, GepruefteteStudenten g, AvgNote a, studenten s , vorlesungen v
where b.matrnr = g.matrnr and b.matrnr = a.matrnr  and g.note = 5 and g.vorlnr = b.vorlnr and g.vorlnr =v.vorlnr
and b.note < a.durchschnittsnote

----------- view
create view pruefenSicht as
select MatrNr, VorlNr, PersNr
from pruefen;

select *
from pruefenSicht
---
create view pruefenSicht2 (M,V,P) as
select MatrNr, VorlNr, PersNr
from pruefen;

select *
from pruefenSicht2
--
create view pruefenSicht3 (M,V) as
select MatrNr, VorlNr, PersNr
from pruefen;

select *
from pruefenSicht3

-- Views

create table Angestellte(PersNr integer not null,Name varchar (30) not null);

create table ProfDaten(PersNr integer not null,Rang character (2),Raum integer);

create table AssistentenDaten(PersNr integer not null,Fachgebiet varchar (30),Boss integer);

create view Prof as
select *
from Angestellte a join ProfDaten d on a.PersNr=d.PersNr;

create view Assistenten as
select *
from Angestellte a join AssistentenDaten d on a.PersNr=d.PersNr;

create table Prof(PersNr integer not null,Name varchar (30) not null,Rang character (2), Raum integer);
create table Assistenten(PersNr integer not null,Name varchar (30) not null,Fachgebiet varchar (30), Boss integer);
create table Andere_Angestellte(PersNr integer not null,Name varchar (30) not null);

create view Angestellte as
(select PersNr, Name
from Prof)
union
(select PersNr, Name
from Assistenten)
union
(select *
from Andere_Angestellte);

-- Update im view

-- 1. nicht veränderbare Sicht
create view WieHartAlsPruefer as 
	select persnr, avg(note) as duchschnittsnote
	from pruefen
	group by persnr
	
select *
from WieHartAlsPruefer

update WieHartAlsPruefer
	set duchschnittsnote = 1.0
	where persnr = (select persnr 
					from professoren 
					where name = 'Schweitzer' );
					
-- 2. nicht veränderbare Sicht
drop view VorlesungenSicht

create view VorlesungenSicht as
select persnr, Titel, SWS, Name
from Vorlesungen, Professoren
where gelesen_von = persnr 

select *
from VorlesungenSicht

insert into VorlesungenSicht
values (700, 'Nihilismus', '2', 'Nobody');

-- ------

create view studis as
 select *
 from studenten 
 
select matrnr, name
from studenten
where matrnr = 42
 
insert into studis values (42, 'merveille', 11)

-- Blatt6 A2 , d)
create table akademische_jahresfeier (name varchar(50), vermerk varchar(100))

create view bestanden as (
	select n.name
	from studenten s, pruefen pr
	where s.matrnr = pr.matrnr and pr.note <= 4)
	
create view absolventen as 
	with AnzVl as (
	select count(*) as anz_vl
	from vorlesungen),
	AnzBestandendeProStud as (
	select p.matrnr, p.vorlnr, count(p.vorlnr) as anz_best_pruefung
	from studenten s, pruefen p
	where s.matrnr = p.matrnr and p.note <= 4
	group by p.matrnr, p.vorlnr)
select  distinct s.name
from studenten s, AnzVl av, AnzBestandendeProStud b
where s.matrnr = b.matrnr and av.anz_vl = b.anz_best_pruefung


select* from akademische_jahresfeier
union all
select name, 'Dozent' from professoren
union all
select name 'Absolvent' from absolventen
select name, 'Student' from st

---
select distinct p.matrnr
from pruefen p, voraussetzen v
where p.vorlnr = v.nachfolger and v.vorgaenger not in (select pr.vorlnr
								                       from pruefen pr
													   where pr.matrnr = p.matrnr and pr.note<5)



---

create view DirekteVoraussetzung as (
	
with recursive DirekteVoraussetzen(vorgaenger, nachfolger) 
as (
	select vorgaenger, nachfolger
	from voraussetzen
union all
select distinct dv.vorgaenger, v.nachfolger
from DirekteVoraussetzen dv, voraussetzen v
where dv.nachfolger = v.vorgaenger 
select *
from DirekteVoraussetzen)
	
)
select s.name, s.matrnr
from studenten s, pruefen p, DirekteVoraussetzung d
where s.matrnr = p.matrnr and ( select *
							  from DirekteVoraussetzung v1
							  where v1.vorganger = p.vorlnr)
							  
---------------
SELECT DISTINCT s.name
FROM pruefen p, voraussetzen v, vorlesungen pv, vorlesungen vv,
studenten s
WHERE p.vorlnr = v.nachfolger AND v.nachfolger = pv.vorlnr AND vv.
vorlnr = v.vorgaenger AND s.matrnr = p.matrnr
AND not exists (SELECT * FROM pruefen p2 WHERE p2.matrnr = p.matrnr
AND p2.vorlnr = v.vorgaenger AND p2.note != 5.0)
-------------
select max()