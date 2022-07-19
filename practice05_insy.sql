--Studenten mit mindestens einer Vorlesung von prof. Gotzhein

select s.matrnr, s.name
from studenten s
where exists (
			select h.* 
	        from hoeren h 
			where h.matrnr = s.matrnr and exists (
			        select * 
					from vorlesungen v
					where v.vorlnr = h.vorlnr and exists (
					         select * 
							 from professoren p 
							 where p.persnr = v.gelesen_von and p.name = 'Gotzhein')))
---- ------- -----

select p.persnr, p.name, sum(sws) as arbeitslast
from professoren p, vorlesungen v
where p.persnr = v.gelesen_von
group by p.persnr, p.name

select p.persnr, p.name, sum(sws) as arbeitslast
from professoren p left outer join vorlesungen v on p.persnr = v.gelesen_von
group by p.persnr, p.name


-- eine konstante Tabelle erstellen, beide codes sind nicht gleich
-- 1. 
values((1, 'eins'), (2, 'zwei'), (3, 'drei'))

--  2.
select 1 as column1, 'eins' as column2
union all
select 2, 'zwei'
union all
select 3, 'drei' ;

select * from (values(1, 'eins')) s

-- Studenten, deren semester zwischen 1 und 4 anliegt
select s.matrnr, s.name, s.semester
from studenten s
where s.semester between 1 and 4 

-- student mit höchstem semester
select *
from studenten
order by semester desc
limit 1

-- studenten, die bei 1-te semester sind
select matrnr, name
from studenten 
where semester = 1

-- studenten, die bei gleichem semester sind
/*TODO*/

-- alle semester geben ohne Duplikate und sortieren
select distinct semester
from studenten
order by semester 

-- Studenten mit mindestens einer Vorlesung von prof. Gotzhein
select s.matrnr, s.name as stud_name, p.name as dozent, v.titel as vorl_titel
from studenten s, hoeren h, vorlesungen v, professoren p
where p.persnr = v.gelesen_von and h.matrnr = s.matrnr and h.vorlnr = v.vorlnr and p.name = 'Gotzhein'
							
-- ---------------------------------------
--Studenten mit höchstens einer Vorlesung von prof. Gotzhein

select s.matrnr, s.name
from studenten s
where not exists (
			select * 
	        from hoeren h 
			where h.matrnr = s.matrnr and exists (
			        select * 
					from vorlesungen v
					where v.vorlnr = h.vorlnr and exists (
					         select * 
							 from professoren p 
							 where p.persnr = v.gelesen_von and p.name = 'Gotzhein'
							  )))

-- -------------------
select * 
from professoren p , vorlesungen v
where p.persnr = v.gelesen_von and p.name = 'Gotzhein'
--- ----------- ---- ----
select * 
from vorlesungen v, hoeren h
where v.vorlnr = h.vorlnr

--- ------------------
select * 
from hoeren h , studenten s
where h.matrnr = s.matrnr
----------------   ------------

select s.matrnr, s.name
from studenten s, hoeren h
where s.matrnr = h.matrnr and h.vorlnr = 1364
------------

select s.matrnr, s.name
from studenten s, hoeren h, vorlesungen v, professoren p
where s.matrnr = h.matrnr and p.persnr = v.gelesen_von  and p.name = 'Gotzhein'
