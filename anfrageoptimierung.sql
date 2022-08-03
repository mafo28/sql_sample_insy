-- Anfrageoptimierung 

-- Diese kostet viel und ist nicht effizient
select distinct s.semester
from studenten s, hoeren h, vorlesungen v, professoren p
where p.name = 'Ebert' and v.gelesen_von = p.persnr and v.vorlnr = h.vorlnr and s.matrnr = h.matrnr 

-- eine effiziente Optimierung wäre Selektionen soweit wie möglich nach unten schieben, Kreuzprodukte durch Joins erstzen usw.
-- das entspricht eine Regelbasierte Optimiertanfrage
select distinct s.semester
from studenten s join hoeren h on s.matrnr = h.matrnr join vorlesungen v on h.vorlnr = v.vorlnr join 
professoren p on p.persnr = v.gelesen_von and p.name = 'Ebert'

-- Erklärung
-- TT1 : Transitiv tabelle 
select *
from professoren p 
where p.name = 'Ebert'

-- TT2
select * 
from TT1 w join vorlesungen v on w.persnr = v.gelesen_von

-- TT3 
select *
from TT2 x join hoeren h on x.vorlnr = h.vorlnr

-- TT4
select *
from TT3 y join studenten s on y.matrnr = s.matrnr

-- T_ges : Ergebnistabelle
select distinct z.semester
from TT4 z