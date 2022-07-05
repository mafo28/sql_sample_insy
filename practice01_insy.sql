select * 
from studenten 

select *
from hoeren

select *
from professoren

select * 
from vorlesungen

-- welcher Studenten welcher vorlesung hört
select *
from hoeren natural join studenten

-- 
select *
from studenten natural join vorlesungen
/* da studenten und vorlesungen kein gemeinsamer Attribut haben 
ist das Ergebnis gleich */
select *
from studenten , vorlesungen

select *
from hoeren natural join studenten natural join vorlesungen
where sws < 4

-- wir können kein natural join nutzen, weil gelesen_von das persnr nicht entspricht
-- mit natural join gbt keine Duplikaten 
select *
from hoeren natural join studenten natural join vorlesungen
join professoren on gelesen_von = persnr

-- es gibt zwei attribute name, name von studenten und name von profesoren, 
-- welcher name ist es?
select name
from hoeren natural join studenten natural join vorlesungen
join professoren on gelesen_von = persnr

-- name von professoren
select p.name
from hoeren natural join studenten natural join vorlesungen
join professoren p on gelesen_von = persnr

-- name von studenten
select s.name
from hoeren natural join studenten s natural join vorlesungen
join professoren  on gelesen_von = persnr

--name von professoren und name von studenten
select p.name, s.name
from hoeren natural join studenten s natural join vorlesungen
join professoren p on gelesen_von = persnr

-- Duplikaten vermeiden
select distinct p.name, s.name
from hoeren natural join studenten s natural join vorlesungen
join professoren p on gelesen_von = persnr

select s.matrnr, v.vorlnr, p.persnr, p.name
from hoeren h natural join studenten s natural join vorlesungen v
join professoren p on v.gelesen_von = p.persnr 

select * 
from studenten natural join hoeren

-- anzahl von vorlesungen pro student
select matrnr, count(vorlnr) as anzahl_vorl
from studenten  natural join  hoeren 
group by matrnr

-- anzahl von Studenten pro vorlesung
select vorlnr, count(matrnr) as anzahl_stud
from studenten  natural join  hoeren 
group by vorlnr

-- wie viele sws die einzelne studierende hoeren
select name, matrnr , semester, count(vorlnr) as anzahl_vl, sum(sws) as anzahl_sws
from studenten natural join hoeren natural join vorlesungen 
group by matrnr

-- wie viele sws die einzelne studierende hoeren
-- andere schreibweise
select matrnr , name , semester, count(vorlnr) as anzahl_vl, sum(sws) as anzahl_sws
from studenten natural join hoeren natural join vorlesungen 
group by matrnr, name, semester

-- nur die Ergenisse haben, wo die summe der sws kleiner ist als 50
select matrnr, name , semester, count(vorlnr) as anzahl_vl, sum(sws) as anzahl_sws
from studenten natural join hoeren natural join vorlesungen 
group by matrnr, name, semester
having sum(sws) <= 50

-- studenten die mindestens 4 vorlesungen hören
select matrnr, name , semester, count(vorlnr) as anzahl_vl
from studenten natural join hoeren natural join vorlesungen 
group by matrnr, name, semester
having count(vorlnr) >= 4

-- studenten die höchstens 50 sws haben
select matrnr, name , semester, sum(sws) as anzahl_sws
from studenten natural join hoeren natural join vorlesungen 
group by matrnr, name, semester
having sum(sws) <= 50

-- studenten die höchstens 50 sws haben und nur genau 3 vorlesungen haben
select matrnr, name , semester, count(vorlnr) as anzahl_vl, sum(sws) as anzahl_sws
from studenten natural join hoeren natural join vorlesungen 
group by matrnr, name, semester
having sum(sws) <= 50 and count(vorlnr) = 3


-- nur die Ergenisse haben, wo die summe der sws kleiner ist als 50 
-- und matrnr sortieren (default sortierung)
-- order by auf dem Attribut
select matrnr, name , semester, count(vorlnr) as anzahl_vl, sum(sws) as anzahl_sws
from studenten natural join hoeren natural join vorlesungen 
group by matrnr, name, semester
having sum(sws) <= 50
order by matrnr

-- nur die Ergenisse haben, wo die summe der sws kleiner ist als 50 
-- und matrnr aufsteigen sortieren 
-- order by OHNE limit -> auf dem Attribut
select matrnr, name , semester, count(vorlnr) as anzahl_vl, sum(sws) as anzahl_sws
from studenten natural join hoeren natural join vorlesungen 
group by matrnr, name, semester
having sum(sws) <= 50
order by matrnr asc

-- nur die Ergenisse haben, wo die summe der sws kleiner ist als 50 
-- und matrnr absteigen sortieren 
-- order by OHNE limit -> auf dem Attribut
select matrnr, name , semester, count(vorlnr) as anzahl_vl, sum(sws) as anzahl_sws
from studenten natural join hoeren natural join vorlesungen 
group by matrnr, name, semester
having sum(sws) <= 50
order by matrnr desc

-- 10 ersten studenten
-- nur die Ergenisse haben, wo die summe der sws kleiner ist als 50 
-- order by ... asc/desc MIT limit -> auf Tabelle/ Relation
select matrnr, name , semester, count(vorlnr) as anzahl_vl, sum(sws) as anzahl_sws
from studenten natural join hoeren natural join vorlesungen 
group by matrnr, name, semester
having sum(sws) <= 50
order by Studenten asc
limit 10

--
select v.titel, p.name as dozent_name
from vorlesungen v,  professoren p  
where v.gelesen_von = p.persnr
--oder
select v.titel as vorl_titel, p.name as dozent_name
from vorlesungen v join professoren p on v.gelesen_von = p.persnr

-- titel der vorlesung, name des dozents und die Anzahl von studenten
select v.titel as vorl_titel, p.name as dozent_name, matrnr, count(matrnr) as anz_stud
from vorlesungen v join professoren p on v.gelesen_von = p.persnr,
studenten natural join hoeren 
group by matrnr, v.titel, p.name

-- virtuelle Tabelle/Relation erzeugen
/* vorteil: im view speichert wir nur informationen, dass die anderen sehen können
        Also private Dinge werden versteckt*/
create view professorenVorlesungen as (
select v.titel as vorl_titel, p.name as dozent_name
from vorlesungen v join professoren p on v.gelesen_von = p.persnr)

-- 
select *
from professorenVorlesungen

-- titel der vorlesung, name des dozents und die Anzahl von studenten
    -- 1. erstelle eine virtuale Tabelle  mit Anzahl der Studenten pro Vorlnr
create view studentenVorlesungen as (
select vorlnr, count(matrnr) as anzahl_studenten
from hoeren
group by vorlnr)

select *
from studentenVorlesungen

     -- 2. erstelle une virtuale Tabelle mit dozent_name und vorl_titel
create view professorenVorlesungen as (
select v.titel as vorl_titel, p.name as dozent_name, v.vorlnr
from vorlesungen v join professoren p on v.gelesen_von = p.persnr)

select *
from professorenVorlesungen

    -- 3. virtualen Tabellen studentenVorlesungen und professorenVorlesung verbinden
select *
from studentenVorlesungen natural join  professorenVorlesungen