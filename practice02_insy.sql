select p.name, h.vorlnr, count(*) as anzahlstudenten
from professoren p, hoeren h, vorlesungen v
where p.persnr = v.gelesen_von and v.vorlnr = h.vorlnr
group by p.name, h.vorlnr


select s.name, s.matrnr, count(*) as anzahlvorlesungen,  sum(v.sws) as sumsws
from studenten s, hoeren h, vorlesungen v
where s.matrnr = h.matrnr and v.vorlnr = h.vorlnr
group by s.name, s.matrnr 
having  sum(v.sws) <= 100
order by sumsws desc, s.name

select distinct p.name, v.titel
from professoren p, vorlesungen v
where p.persnr = v.gelesen_von

select  p.name, v.titel, count(h.matrnr) as anz_stud
from professoren p, vorlesungen v, hoeren h
where p.persnr = v.gelesen_von and h.vorlnr = v.vorlnr
group by p.name, v.titel 
order by anz_stud asc
limit 1

select  p.name, v.titel, count(h.matrnr) as anz_stud
from professoren p, vorlesungen v, hoeren h
where p.persnr = v.gelesen_von and h.vorlnr = v.vorlnr
group by p.name, v.titel 
having count(h.matrnr) < 1000
order by anz_stud desc
limit 1

select  p.name, v.titel, count(h.matrnr) as anz_stud
from professoren p, vorlesungen v, hoeren h
where p.persnr = v.gelesen_von and h.vorlnr = v.vorlnr
group by p.name, v.titel 
having count(h.matrnr) < 1000


select  p.name, v.titel, count(h.matrnr) as anz_stud
from professoren p, vorlesungen v, hoeren h
where p.persnr = v.gelesen_von and h.vorlnr = v.vorlnr
group by p.name, v.titel 
order by anz_stud asc
limit 1

select vorlnr, count(matrnr)
from hoeren 
group by vorlnr
order by count

select p.name, h.vorlnr, count(matrnr) as anz_stud
from hoeren h, professoren p, vorlesungen v
where p.persnr = v.gelesen_von and h.vorlnr = v.vorlnr
group by h.vorlnr, p.name
order by anz_stud

create view professorenUndVorlesungen as
	select p.name, v.titel
	from professoren p, vorlesungen v
	where p.persnr = v.gelesen_von
	order by p.name
	
select*
from professorenUndVorlesungen

drop table assistenten

select p.gebaeude, count(*) as anzahlPruefungen
from professoren p, pruefen f
where p.persnr = f.persnr
group by p.gebaeude
order by count(*) desc
limit 1


create view bestandendePruefungen as
	select s.name, p.vorlnr, p.note
	from studenten s, pruefen p
	where s.matrnr = s
