select p.PersNr,p.Name from  Professoren p where p.rang='C2';

select distinct(vl.sws) from Vorlesungen vl;

select s.name from studenten s join hoeren h using(matrnr) join vorlesungen vl using(vorlnr) where vl.titel ='Informationssysteme';

select vorl.titel, count(matrnr) as anzahl from hoeren h join vorlesungen vorl using(vorlnr) group by vorl.titel;

select  matrnr, avg(note) as avgnote from studenten join pruefen using(matrnr) where note<=4.0 group by matrnr order by avgnote asc limit 10;

select p.name, v.titel from professoren p join vorlesungen v on(v.gelesen_von=p.persnr) where v.titel like '%systeme';