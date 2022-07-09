-- Fensteranfragen 
-- Beide sind nicht gleich
-- 1.
select s.name, count(*) over (partition by s.matrnr) as anz_vl_pro_stud, h.vorlnr
from hoeren h, studenten s
where h.matrnr = s.matrnr
order by s.name asc

-- 2.
select s.name, count(*) as anz_vl_pro_stud, h.vorlnr
from hoeren h, studenten s
where h.matrnr = s.matrnr
group by s.name , h.vorlnr
order by s.name asc

-- 3. ist fast gleich wie 1. , aber eliminiert Duplikate durh group by
select s.name, count(*) as anz_vl_pro_stud
from hoeren h, studenten s
where h.matrnr=s.matrnr
group by s.name
order by s.name asc;

-------------------------------------------
-- mehrere Partitionen
-- 1.
select s.name, count(h.matrnr) as anz_vl_pro_stud, count(h.vorlnr) as anz_stud_pro_vl, h.vorlnr
from hoeren h, studenten s
where h.matrnr = s.matrnr
group by s.name, h.vorlnr
order by s.name asc

-- 2. im vergleich zu 1.
select s.name, count(*) over (partition by h.matrnr) as anz_vl_pro_stud , 
count(*) over (partition by h.vorlnr) as anz_stud_pro_vl , h.vorlnr
from hoeren h, studenten s
where h.matrnr = s.matrnr
order by s.name asc

-----------------------------------------------
--- rank()
select s.name, count(*) over (partition by s.matrnr) as anz_vl_pro_stud,
rank() over (partition by s.name order by h.vorlnr) as vl_rank, h.vorlnr
from hoeren h, studenten s
where h.matrnr=s.matrnr
order by s.name asc;
-- kann man auch ohne rank() schreiben 
-- z.b
select ID, (1+(select count(*) 
			   from student_grades B
			   where B.GPA > A.GPA)) as student_rank
from student_grades A
order by student_rank;

--------------------------- keine partionierung
select h.matrnr, count(h.matrnr) over (order by h.matrnr)
from hoeren h;

------
select year, avg(num_credits)
over (order by year rows 3 preceding) as avg_total_credits
from tot_credits;

--------
select year, avg(num_credits) over (order by year rows between 3 preceding and 2 following) as avg_total_credits
from tot_credits;

----
select zeit, array agg(temperatur) over (order by zeit rows between 1
preceding and 1 following) as info from wetter order by zeit

----
select year, avg(num_credits) over (order by year range between year-4 and year) as avg_total_credits
from tot_credits;

---
select dept_name, year, avg(num_credits) over (partition by dept_name order by year range between year-4 and year) 
as avg_total_credits
from tot_credits_dept;