-- 作业七:数据库完整性
-- 1、检查Stu数据库是否添加了所有的主码、外码
SELECT 索引名称 = a.name,
    表名 = c.name,
    索引字段名 = d.name,
    索引字段位置 = d.colid
FROM sysindexes a
    JOIN sysindexkeys b ON a.id = b.id
    AND a.indid = b.indid
    JOIN sysobjects c ON b.id = c.id
    JOIN syscolumns d ON b.id = d.id
    AND b.colid = d.colid
WHERE a.indid NOT IN (0, 255)
    AND c.xtype = 'U'
    AND c.status > 0 --查所有用户表  
    --AND   c.name='message' --查指定表  
ORDER BY c.name,
    a.name,
    d.name;
-- EXEC sp_MSforeachtable 'ALTER TABLE ? WITH CHECK CHECK CONSTRAINT ALL';
EXEC sp_helpconstraint student;
EXEC sp_helpconstraint grade;
EXEC sp_helpconstraint course;
EXEC sp_helpconstraint department;
EXEC sp_helpconstraint dorm;
-- 2、给student表添加check约束:学生性别只能取‘男’或‘女’或 NULL;学生年龄在15-60之间（包含15和60)。
ALTER TABLE student
ADD CONSTRAINT CK_student_sex CHECK(sex IN('男', '女', NULL));
ALTER TABLE student
ADD CONSTRAINT CK_student_sage CHECK(
        sage BETWEEN 15 AND 60
    );
-- 3、给score表添加check 约束:成绩在0到100之间。
ALTER TABLE grade
ADD CONSTRAINT CK_grade_score CHECK(
        score BETWEEN 0 AND 100
    );
-- 4、验证
-- 1）向student表插入('990101','原平,男',21,'1','2101')
INSERT INTO student
VALUES('990101', '原平', '男', 21, '1', '2101');
-- 2）向student表插入(NULL,'原平,男',21,'1',2101')
INSERT INTO student
VALUES(NULL, '原平', '男', 21, '1', '2101');
-- 3）向student表插入('990901','原平,男',121,1',2101')
INSERT INTO student
VALUES('990901', '原平', '男', 121, 1, '2101');
-- 4）向student表插入('990901','原平';'M',21,'1',2101')
INSERT INTO student
VALUES('990901', '原平', 'M', 21, '1', '2101');
-- 5）向student表插入('990901','原平,男',21,'1',2601')
INSERT INTO student
VALUES('990901', '原平', '男', 21, '1', '2601');
-- 6）向student表插入('990101','原平,男',21,'1',2101')
INSERT INTO student
VALUES('990101', '原平', '男', 21, '1', '2101');
-- 7）向score表插入('990101','08',85)
INSERT INTO grade
VALUES('990101', '08', 85);
-- 8）删除计算机系
DELETE FROM department
WHERE dname = '计算机系';
-- 9)）删除原野
DELETE FROM student
WHERE sname = '原野';
-- 10）将'计算机系'的系号改为8
UPDATE department
SET dno = '8'
WHERE dname = '计算机系';
INSERT INTO department
VALUES('8', '计算机系', '???');