create table if not exists mytabele_1(id integer primary key, 
                                      val1 integer
                                      val2 integer);

create table if not exists mytabele_2(id integer primary key, 
                                      val3 integer);
                                     

create table if not exists tables_defaults_1(id integer primary key, 
                                             val1 integer
                                             val2 integer);

create table if not exists tables_defaults_2(id integer primary key, 
                                             val3 integer);

INSERT INTO mytable_default_1(id, val1,val2) VALUES (1,10, 20);
INSERT INTO mytable_1(id, val1, val2) VALUES(1, 10, 20);
INSERT INTO mytable_1(id, val1, val2) VALUES(2, 10, 40);
INSERT INTO mytable_1(id, val1, val2) VALUES(1, 20, 50);

INSERT INTO mytable_default_2(id, val3) VALUES (1,5000);
INSERT INTO mytable_2(id, val1, val2) VALUES(1,0);

SELECT m1.id, val1, val2, (case when m2.val3 is null thenn m2.val3 else m2.val3 end)
                            FROM mytabele_1 m1 LEFT OUT JOIN mytabele_2 m2 ON (id.m1 = id.m2);
