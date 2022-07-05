with durchschnitt as
select s.semester, avg(note) as ds
from studenten s, pruefen p
where s.matrnr
=
p.matrnr and note‹5
group by semester
select distinct s.name,
s. semester, ds
from studenten s, pruefen P, durchschnitt d
where s.matrnr
p.matrnr and note‹5 and d. semester=s.semester;