-- Optimierung 
-- Brute force 
select distinct v.titel
from hoeren h, studenten s, vorlesungen v
where s.matrnr = h.matrnr and h.vorlnr=v.vorlnr and (s.semester = 2 or s.semester=4)

--
select distinct v.titel
from (vorlesungen v join hoeren h on v.vorlnr=h.vorlnr ) join studenten s on s.matrnr = h.matrnr
and (s.semester=2 or s.semester=4) 

--
create view v1 as 
select p.persnr, p.vorlnr,s.name, s.semester, p.note
from studenten s, pruefen p
where s.matrnr = p.matrnr and s.semester >= 4 and p.note < 2.0


create view v2 as
select p.persnr, p.vorlnr,s.name, s.semester, p.note
from studenten s, pruefen p
where s.matrnr = p.matrnr and s.semester <= 6 and p.note < 2.0

(select *from v1)
intersect 
(select * from v2  )

----
(select p.persnr, p.vorlnr,s.name, s.semester, p.note
from studenten s, pruefen p
where s.matrnr = p.matrnr and s.semester >= 4 and p.note < 2.0)
intersect all 
(select p.persnr, p.vorlnr,s.name, s.semester, p.note
from studenten s, pruefen p
where s.matrnr = p.matrnr and s.semester <= 6 and p.note < 2.0)

--- optimierte Anfrage 
select *
from studenten s join pruefen p on s.matrnr = p.matrnr and (s.semester between 4 and 6) and p.note<2.0