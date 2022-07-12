/*gibt name alle professoren wenn es existiert eine vorlesung wo gelesen_von ungleich persnr ist
d.h professoren, die keine vorlesungen anbieten*/
select p.name
from professoren p
where not exists (
                 select *
                 from vorlesungen v
				 where v.gelesen_von = p.persnr)
				

				 
/*( select * from vorlesungen  where titel like 'L%') ist eine Anfrage 
d.h Tabelle die wirklich nciht existiert und wir nennen das vorl	*/			 
select *
from professoren p, ( select * from vorlesungen  where titel like 'L%') vorl
where p.persnr = vorl.gelesen_von			

-- beide Anfragen sind nicht gleich 
--1.hier sind alle professoren drin, auch die, die keine vorlesungen anbieten
select p.persnr, p.name, ( select sum(sws) from vorlesungen where gelesen_von = p.persnr) as arbeitslast
from professoren p
order by arbeitslast asc

--2. hier fehlen professoren, die keine vorlesungen anbieten
select p.persnr, p.name, sum(v.sws) as arbeitslast
from professoren p, vorlesungen v
where p.persnr = v.gelesen_von
group by p.persnr, p.name

select * 
from professoren

insert into professoren values (100, 'Mueller', 'W3', 34, 102);
insert into professoren values (200, 'Goethz', 'C5', 34, 103);
insert into professoren values (300, 'Kaiser', 'C3', 34, 104);
insert into professoren values (400, 'Kaiser', 'C1', 34, 105);

select * 
from vorlesungen

insert into vorlesungen values(1200, 'FSE', 12, null);
insert into vorlesungen values(1300, 'Elektronik 1', 12, null);
insert into vorlesungen values(1400, 'SPPM', 12, null);
insert into vorlesungen values(1500, 'Glet 1', null, 400);

-- Für welche Vorlesung(en) gibt es kein professoren
select v.vorlnr, v.titel
from vorlesungen v
where not exists ( select * from professoren p where p.persnr = v.gelesen_von)

select * 
from professoren

-- gibt nur die sws von professoren, die vorlesungen anbieten
select p.name, p.persnr, sum(sws) as arbeitslast
from professoren p, vorlesungen v
where p.persnr = v.gelesen_von
group by p.name, p.persnr

-- für jede professoren seine sws
select p.name, p.persnr, (select sum(sws) from vorlesungen )
from professoren p