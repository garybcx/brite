
drop table tableA
drop table tableB
create table tableA(id int, b int, c varchar(10) default 'test')
create table tableB(id int, d int, e varchar(10) default 'testing')


insert into tableA values(1,1,'test')
insert into tableA values(1,2,'test')
insert into tableA values(0,3,'test')
insert into tableB values(0,1,'testing')
insert into tableB values(1,2,'testing')
insert into tableB values(1,3,'testing')

select * from tableA
select * from tableB

--------------------------------------------------

select * from tableA aa
cross apply 
(select * from tableB bb ) C

select * from tableA aa
inner join tableB bb on 1=1
-------------------------------------------

select * from tableA;
select * from tableB;

--id's of rows that must be inserted 
with  insert_ids (id) as 
(select id from tableB 
except
select id from tableA)
select * from insert_ids ;

--id's of rows that must be updated in tableA from input tableB with unique key ‘id’
with unchanged_rows(id) as (
	select id from ( 
		select * from tableB 
		intersect 
		select * from tableA 
	) A
) 
select a.id from tableA a 
INNER JOIN tableB b ON a.id=b.id
where NOT EXISTS (select 1 from unchanged_rows u where a.id = u.id);
 




 

select * from tableA
select CHECKSUM(b.*) from tableB b

update tableB 
set hashrow=

SELECT hashbytes('md5', (SELECT * FOR xml raw)) from tableB

WITH CTE input_tab (
select *,(SELECT hashbytes('md5', (SELECT first_name, last_name FOR xml raw))) as hashrow
from tableA)
update b 
set c = 'updated'
from tableb a
where not exists ( select 1 from tableB b where a.id = b.id and CHECKSUM(a.*) <> CHECKSUM(b.*)
