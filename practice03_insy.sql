create table nullen (a integer, b integer)

insert into nullen values (3,4)
insert into nullen values (1,2)
insert into nullen values (1,4)

insert into nullen values (1,0)
insert into nullen values (0,1)

-- um die Werte auf null setzen gilt
-- 1.
insert into nullen values (null,1)

-- oder 2.
insert into nullen(b) values(5)

-- ein tupel einfügen, das komplet auf null, null besteht
-- 1.
insert into nullen values (null,null)
-- 2.
insert into nullen(a,b) values (null,null)

select *
from nullen 

-- zählt wie viele Einträge(Tupeln) wir in der Tabelle nullen haben , also (null,null) auch, Ans =7
select count(*)
from nullen 

-- summe der Werte von dem attribut a
select sum(a)
from nullen 

-- Zählt nur die integer, nullen werden nicht berücksichtigt , Ans = 5 nicht 7
select count(a)
from nullen 

--mit serial inkrementiert sich der Wert von persnr automatisch
create table personen(persnr serial, name varchar(100))

insert into personen(name) values('Alice')
insert into personen(name) values('bob')
insert into personen(name) values('claude')
insert into personen(name) values('daniel')

select *
from personen

--
create table testtab (a integer, b integer, c integer);
insert into testtab values (1,2,3);
insert into testtab values (4,2,3);
insert into testtab values (1,4,3);
insert into testtab values (2,2,3);
insert into testtab values (1,2,3);
insert into testtab values (1,2,8);
insert into testtab values (1,3,8);

select *
from testtab

-- alle werte von a summieren
select sum(a)
from testtab

-- groupieren nach a
select a
from testtab
group by a

--
select a
from testtab
group by a
order by a

-- groupieren nach Tupel (a,b)
select a ,b
from testtab
group by a, b

--groupieren nach Tupel (a,b), summe der werte c
select a ,b, sum(c)
from testtab
group by a, b

--groupiern nach a, Anzahl der Einträge b und summe der werte c
select a ,count(b), sum(c)
from testtab
group by a

--groupiern nach a, maximale Werte von b und summe der werte c
select a ,max(b), sum(c)
from testtab
group by a

create table person (name varchar(100), age integer, city varchar(30));
insert into person(age) values (13);
insert into person values('alice', 14, 'kaiserslautern');
					 
alter table person
add id serial

select *
from person

insert into person(name, age, city) values('bob', 16, 'Born')