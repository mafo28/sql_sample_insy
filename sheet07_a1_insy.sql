---- Aufgabe 2: 
---a)

select distinct name, semester, avg(note)over (partition by s.semester) as durchschnittsnote from studenten s, pruefen p where s.matrNr = p.matrNr and note<5.0 ;

---b)
select name , sum(anzahl) over (order by anzahl desc rows unbounded preceding)
 from (select distinct name, count(note) over (partition by professoren.name order by note ) as anzahl
    from professoren left join pruefen on professoren.persNr = pruefen.persNr and pruefen.note = 1.0
    order by anzahl desc ) as summ; 