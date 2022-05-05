-- 58.	查询每个宿舍住宿的人数（要求列出宿舍号、宿舍人数）   (2)
SELECT dormno,
    COUNT(*)
FROM student
WHERE dormno IS NOT NULL
GROUP BY dormno;
-- 59.	查询每个系主任所在系的学生人数（要求列出系主任名称、所在系名和系中学生人数）  (2)
SELECT d.head,
    d.dname,
    COUNT(*)
FROM department d
    INNER JOIN student s ON s.dno = d.dno
GROUP BY s.dno,
    d.head,
    d.dname;
-- 60.	查询计算机系总成绩最高的人，生成如下结果：  (2)
-- 姓名        总成绩
-- XXX          XXX
-- SELECT sname "姓名",
--     SUM(score) "总成绩"
-- FROM grade g
--     INNER JOIN student s ON g.sno = s.sno
-- GROUP BY s.sname
-- ORDER BY SUM(score) DESC
-- LIMIT 1;
SELECT TOP 1 sname "姓名",
    SUM(score) "总成绩"
FROM grade g
    INNER JOIN student s ON g.sno = s.sno
GROUP BY s.sname
ORDER BY SUM(score) DESC;
-- 61.	求所有系的学生平均成绩，并把结果存入新表Dep_avg_s（DNO, AVG_S）中，
-- 再从这个表中查询出所有结果（要求：如果某个系没有平均成绩，就将平均成绩置为空值）(2)
-- CREATE TABLE Dep_avg_s AS(
--     SELECT s.dno "DNO",
--         AVG(g.score) "AVG_S"
--     FROM grade g,
--         student s
--     WHERE g.sno = s.sno
--     GROUP BY s.dno
-- );
-- DROP TABLE Dep_avg_s;
SELECT t.* INTO Dep_avg_s
FROM (
        SELECT s.dno "DNO",
            AVG(g.score) "AVG_S"
        FROM grade g,
            student s
        WHERE g.sno = s.sno
        GROUP BY s.dno
    ) t;
SELECT *
FROM Dep_avg_s;
-- 62.	查询其他系中比计算机系某一学生年龄小的学生姓名和年龄  (2)
SELECT sname,
    sage
FROM student
WHERE sage < ANY (
        SELECT sage
        FROM student
        WHERE dno = (
                SELECT dno
                FROM department
                WHERE dname = '计算机系'
            )
    )
    AND dno <> (
        SELECT dno
        FROM department
        WHERE dname = '计算机系'
    );
-- 63.	查询选修课程中，有课程没有成绩、
-- ???但是其他课程的成绩均在80分以上的同学的姓名、课程号、成绩  (2)
SELECT s.sname,
    g.cno,
    g.score
FROM student s
    INNER JOIN grade g ON s.sno = g.sno
WHERE g.sno IN (
        SELECT sno
        FROM grade
        WHERE score IS NULL
    );
-- 64.	查询选修课程总学分最高的学生姓名和总学分 (2)
SELECT sname,
    sc
FROM student,
    (
        SELECT TOP 1 g.sno,
            SUM(credit) sc
        FROM grade g
            INNER JOIN course c ON g.cno = c.cno
        GROUP BY g.sno
        ORDER BY SUM(credit) DESC
    ) t
WHERE t.sno = student.sno;
-- 65.	查询显示所有学生选修课程的学分的累计情况，并按照总学分的高低顺序排序。 (2)
SELECT g.sno,
    SUM(credit) "总学分"
FROM grade g
    INNER JOIN course c ON g.cno = c.cno
GROUP BY g.sno
ORDER BY SUM(credit) DESC;
-- 66.	查询所有未选修 ‘03’ 号课程的学生姓名(用存在量词)。(2)
SELECT sname
FROM student
WHERE sno NOT IN (
        SELECT sno
        FROM grade
        WHERE cno = '03'
    );
-- 67.	查询选修了课程名为’高等数学’的学生学号和姓名（用嵌套/用连接）。 (2)
SELECT sno,
    sname
FROM student
WHERE sno IN (
        SELECT sno
        FROM grade
        WHERE cno IN (
                SELECT cno
                FROM course
                WHERE cname = '高等数学'
            )
    );
-- 68.	创建数据表Grade1，将“99”级学生选修“高等数学”的的学生插入到Grade1表中。(2)
SELECT t.* INTO Grade1
FROM (
        SELECT *
        FROM student s
            INNER JOIN grade g ON s.sno = g.sno
        WHERE s.sno LIKE '99%'
            AND g.cno = (
                SELECT cno
                FROM course
                WHERE cname = '高等数学'
            )
    ) t;
-- 69.	查询姓名中有“明”字的学生情况 (2)
SELECT *
FROM student
WHERE sname LIKE '%明%';
-- 70.	查询姓名是三个字的学生情况  (2)
SELECT *
FROM student
WHERE sname LIKE '___';
-- 71.	查询选修了3门以上课程的学生学号、姓名。  (2)
SELECT sno,
    sname
FROM student
WHERE sno IN(
        SELECT sc.sno
        FROM grade
        GROUP BY grade.sno
        HAVING count (*) > 3
    );
-- 72.	查询所有男学生及其宿舍住宿情况。 (2)
SELECT s.*,
    r.*
FROM student s
    INNER JOIN rome r ON s.dormno = r.dormno
WHERE s.sex = '男';
-- 73.	查询所有课程的间接先修课情况。 (2)
SELECT c1.cno,
    c2.cpno
FROM course c1
    INNER JOIN course c2 ON c1.cpno = c2.cno
    INNER JOIN course c3 ON c2.cpno = c3.cno;
-- 74.	查询所有学生及其选修课程情况。(2)
SELECT *
FROM student
    LEFT JOIN grade g ON student.sno = g.sno
    INNER JOIN course c ON g.cno = c.cno;
-- 75.	将“计算机”学生的“信息系统”的分数置0分处理。 (2)
UPDATE grade
SET score = 0
WHERE sno IN (
        SELECT sno
        FROM student
        WHERE dno = (
                SELECT dno
                FROM department
                WHERE dname = '计算机系'
            )
    )
    AND cno = (
        SELECT cno
        FROM course
        WHERE cname = '信息系统'
    );
-- 76.	在视图VIEW_1中找出名字中有“明”字的学生的学号、姓名、宿舍号。(2)
SELECT sno,
    sname,
    dormno
FROM VIEW_1
WHERE sname LIKE '%明%';
-- 77.	创建每门课的选修人数的视图，生成如下结果的视图：(2)
-- 课程名        选修人数
-- XXX          XXX
CREATE VIEW Course_stu_num AS
SELECT c.cname "课程名",
    COUNT(*) "选修人数"
FROM course c
    INNER JOIN grade g ON c.cno = g.cno
GROUP BY c.cno,
    c.cname;
-- 78.	删除“数学系”的相关信息。 (2)
UPDATE student
SET dno = NULL
WHERE dno = (
        SELECT dno
        FROM department
        WHERE dname = '数学系'
    );
DELETE FROM department
WHERE dname = '数学系';
-- 79.	删除“2202”宿舍的相关信息。（宿舍撤消，住宿的学生重新待分配）(2)
UPDATE student
SET dormno = NULL
WHERE dormno = '2202';
DELETE FROM rome
WHERE dormno = '2202';