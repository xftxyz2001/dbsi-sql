if exists(select name from sysobjects
           where name='department' and type='U')
  drop table department
go
create table department
(dno char(4) not NULL unique,
 dname char(20)  not NUll,
 head char(20))

insert into department
values('1','计算机系','王凯锋');
insert into department
values('2','数学系','李永军');
insert into department
values('3','物理系','康健');
insert into department
values('4','中文系','秦峰');
select * from department;

if exists(select name from sysobjects
           where name='course' and type='U')
  drop table course
go
create table course
(cno char(2) not NULL unique,
 cname char (20) not NULL ,
 cpno char (2),
 credit int,
 teacher char(8));
insert into course
values('01','数据库原理','05',4,'王凯');
insert into course
values('02','高等数学',NULL ,6,'张风');
insert into course
values('03','信息系统','01',2,'李明');
insert into course
values('04','操作系统','06',4,'许强');
insert into course
values('05','数据结构','07',4,'路飞');
insert into course
values('06','算法设计',NULL,2,'黄海');
insert into course
values('07','c语言','06',3,'高达');
select * from course;

if exists(select name from sysobjects
           where name='student' and type='U')
  drop table student
go
create table student
(sno char (6) not NULL unique,
 sname char (8) not NULL ,
 sex char (2),
 sage int,
 dno char(4)  ,
 dormno char (5)
)
insert into student
values ('990101','原野','男',21,'1','2101');
insert into student
values ('990102','张原','男',21,'1','2101');
insert into student
values ('990103','李军','男',20,'1','2101');
insert into student
values ('990104','汪远','男',20,'1','2101');
insert into student
values ('990105',' 齐%欣','男',20,'1','2101');
insert into student
values ('990201','王大明','男',19,'2','2202');
insert into student
values ('990202','徐东','男',19,'2','2202');
insert into student
values ('990301','张扬','女',21,'1','2303');
insert into student
values ('990302','于洋','女',20,'3','2303');
insert into student
values ('990303','姚志旬','男',19,'4','2404');
insert into student
values ('990401','高明镜','男',19,'4',null);
insert into student
values ('990402',' 明天','男',21,'4','2404');
insert into student
values('960101','刘明华','女',24,'4','2303')
insert into student
values('960102','张大华','男',23,'3','2404')
insert into student
values('990501','刘欣嘉','女',22,'4',null)


select *from student

if exists(select name from sysobjects
           where name='dorm' and type='U')
  drop table dorm
go
create table dorm
(dormno char(5) not NULL unique,
 tele char(7));
insert into dorm
values ('2101','8302101');
insert into dorm
values ('2202','8302202');
insert into dorm
values ('2303','8302303');
insert into dorm
values ('2404','8302404');
insert into dorm
values ('2505','8302505');
insert into dorm
values ('2606','8302606');

select *from dorm;

if exists(select name from sysobjects
           where name='grade' and type='U')
  drop table grade
go
create table grade
(sno char(6),
 cno char(2),
 score int
 constraint pk_grade primary key (sno,cno) );

insert into grade
values ('990101','01',85);
insert into grade
values ('990101','03',65);
insert into grade
values ('990101','04',83);
insert into grade
values ('990101','07',72);
insert into grade
values ('990102','02',80);
insert into grade
values ('990102','04',81);
insert into grade
values ('990102','01',NULL);
insert into grade
values ('990103','07',74);
insert into grade
values ('990103','06',74);
insert into grade
values ('990103','01',74);
insert into grade
values ('990103','02',70);
insert into grade
values ('990103','04',70);
insert into grade
values ('990104','01',55);
insert into grade
values ('990104','06',0);
insert into grade
values ('990104','02',42);
insert into grade
values ('990105','03',85);
insert into grade
values ('990105','06',NULL);
insert into grade
values ('990301','01',46);
insert into grade
values ('990301','02',70);
insert into grade
values ('990302','01',85);
insert into grade
values ('990401','01',0);
insert into grade
values ('960101','01',85);
insert into grade
values ('960101','03',79);
insert into grade
values ('960102','01',85);


select *from grade;
