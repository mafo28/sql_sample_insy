create materialized view studis_kamers as
select si.matrnr as studis, s2.matrnr as kamers from studenten s1, studenten s2, pruefen pl
where s1.matrnr&>s2.matrnr and s1.semester=s2.semester and pi.note=5.0 and p1.matrnr=s2.matrnr and
exists (select * from studenten, pruefen p2 where s1.matrnr=p2,matrnr and p2.note=5.0 and p2. persnr=p1

with recursive transKamerade (kamer1) as
(select studis from studis_kamers where kamers=94823
union
select distinct k.studis from transkamerade t, studis_kamers k where t.kamer1=k. kamers
select name from transKamerade tr, studenten s where s.matrnr=tr-kamer1 ;

with Teilnehmer as
(with recursive transKamerade kamerl) as
(select studis from studis kamers where kamers=94823
union
select distinct k.studis from transkamerade t, studis_kamers k where t.kamer1=k.kamers )
select name from transKamerade tr, studenten s where s.matrnr=tr.kamer1)
select count(*) as Teilnehmerzahl from Teilnehmer