---- Thema: Rekursion🤪
/* Welche Vorlesungen müssen besucht werden, um die Vorlesung
'Formale Sprachen und Berechenbarkeit' verstehen zu können? */
--
select v.vorgaenger, vl.titel
from voraussetzen v, vorlesungen vl
where v.nachfolger = vl.vorlnr and vl.titel = 'Formale Sprachen und Berechenbarkeit'

/* Welche Vorlesungen müssen besucht werden, um die Vorlesung
'Verteilte und nebenläufige Programmierung' verstehen zu können? */
select v.vorgaenger, vl.titel
from voraussetzen v, vorlesungen vl
where v.nachfolger = vl.vorlnr and vl.titel = 'Verteilte und nebenläufige Programmierung'

-- nur direkten Vorgänger berechnen
select v1.vorgaenger
from voraussetzen v1, voraussetzen v2, vorlesungen vl
where v1.nachfolger = v2.vorgaenger and v2.nachfolger = vl.vorlnr and vl.titel ='Formale Sprachen und Berechenbarkeit'

select v1.vorgaenger
from voraussetzen v1, voraussetzen v2, vorlesungen vl
where v1.nachfolger = v2.vorgaenger and v2.nachfolger = vl.vorlnr and vl.titel ='Verteilte und nebenläufige Programmierung'

---- --- --name und vorlnr alle direkten Vorgänger berechnen
-- 1. mit 😎view 😎
create view VorlnrDirektVorgaenger as (
select v1.vorgaenger
from voraussetzen v1, voraussetzen v2, vorlesungen vl
where v1.nachfolger = v2.vorgaenger and v2.nachfolger = vl.vorlnr and vl.titel ='Verteilte und nebenläufige Programmierung')

select v.titel, v.vorlnr
from vorlesungen v, VorlnrDirektVorgaenger dv
where v.vorlnr = dv.vorgaenger

-- 2. mit Temporäre Tabelle also 👍with statement✌️ 
with VorlnrDirektVorgaenger as (
select v1.vorgaenger
from voraussetzen v1, voraussetzen v2, vorlesungen vl
where v1.nachfolger = v2.vorgaenger and v2.nachfolger = vl.vorlnr and vl.titel ='Verteilte und nebenläufige Programmierung')

select v.titel, v.vorlnr
from vorlesungen v, VorlnrDirektVorgaenger dv
where v.vorlnr = dv.vorgaenger ;

------------- "with recursive" statement

---- die summe von 1 bis 999 rekursiv berechnen
with recursive mytab(my_column) as ( 
		values(1)
	 union all
		select my_column+1
		from mytab
		where my_column < 100
)
select sum(my_column)
from mytab;

---
with recursive mytab(my_column) as ( 
		values(1) )
select *
from mytab
	 union all
		select my_column+5
		from mytab
		where my_column < 50
)
select sum(my_column)
from mytab;

select *
from voraussetzen

-- Alle Voraussetzung für alle Vorlesungen
with recursive TransitivVol (vorgaenger, nachfolger) as (
	select vorgaenger, nachfolger
	from voraussetzen 
union all
	select distinct t.vorgaenger, v.nachfolger
	from TransitivVol t, voraussetzen v
	where t.nachfolger = v.vorgaenger
)
select *
from TransitivVol
order by (vorgaenger, nachfolger) asc;

------------ Alle direkte vorgaenger der Vorlesung 'Formale Sprachen und Berechenbarkeit'
with recursive TransitivVol (vorgaenger, nachfolger) as (
	select vorgaenger, nachfolger
	from voraussetzen 
union all
	select distinct t.vorgaenger, v.nachfolger
	from TransitivVol t, voraussetzen v
	where t.nachfolger = v.vorgaenger
)
select vl2.titel
from TransitivVol t, vorlesungen vl1, vorlesungen vl2
where t.nachfolger = vl1.vorlnr and t.vorgaenger = vl2.vorlnr and vl1.titel = 'Formale Sprachen und Berechenbarkeit'
order by (vorgaenger, nachfolger) asc;

-- 
