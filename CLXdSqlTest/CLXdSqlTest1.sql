-- 1.	查询没有考试成绩的学生姓名和课程名  (1)
SELECT s.sname,
    c.cname
FROM grade g
    INNER JOIN student s ON g.sno = s.sno
    INNER JOIN course c ON g.cno = c.cno
WHERE g.grade IS NULL;
-- 2.	查询和汪远在同一个系学习的学生姓名，宿舍号和电话  (1)
SELECT s.sname,
    s.dormno,
    r.tele
FROM student s
    INNER JOIN rome r ON s.dormno = r.dormno
WHERE s.dno = (
        SELECT dno
        FROM student
        WHERE sname = '汪远'
    )
WHERE s.sname <> '汪远';
-- 3.	查询选修了1号课程的所有姓张的同学的姓名和1号课程的成绩(1)
SELECT s.sname,
    g.score
FROM grade g
    INNER JOIN student s ON g.sno = s.sno
WHERE g.cno = 1
    AND s.sname LIKE '张%';
-- 4.	查询数学系所有学生的住宿情况，生成如下结果：(1)
-- 姓名        宿舍号      宿舍电话
-- XXX          XXX         XXX
SELECT s.sname,
    s.dormno,
    r.tele
FROM student s,
    rome r
WHERE s.dormno = r.dormno
    AND s.dno = (
        SELECT dno
        FROM department
        WHERE dname = '数学系'
    );
-- 5.	查询数据库原理这门课成绩不低于80分的学生姓名和成绩  (1)
SELECT s.sname,
    g.score
FROM student s,
    grade g
WHERE s.sno = g.sno
    AND g.cno = (
        SELECT cno
        FROM course
        WHERE cname = '数据库原理'
    )
    AND g.score >= 80;
-- 6.	查询与‘原野’同岁的学生姓名（不包括原野本人）(1)
SELECT sname
FROM student
WHERE sno IN (
        SELECT sno
        FROM student
        WHERE sage IN (
                SELECT sage
                FROM student
                WHERE sname = '原野'
            )
            AND sname <> '原野'
    );
-- 7.	查询每门课中成绩最低的学生学号、课程号、成绩，并按课程号排序。(1)
SELECT g1.sno,
    g1.cno,
    g1.score
FROM grade g1
WHERE g1.sno IN (
        SELECT g2.sno
        FROM grade g2
        WHERE g2.score = (
                SELECT MIN(g3.score)
                FROM grade g3
                WHERE g3.cno = g1.cno
            )
    )
ORDER BY g1.cno;
-- 8.	查询‘王凯’老师带的课程名和学生人数(1)
SELECT c.cname,
    COUNT(g.sno)
FROM course c,
    grade g
WHERE c.cno = g.cno
    AND g.cno = (
        SELECT cno
        FROM course
        WHERE teacher = '王凯'
    )
GROUP BY c.cname;
-- 9.	查询给‘计算机系’学生讲课的老师(1)
SELECT teacher
FROM course
WHERE cno IN(
        SELECT DISTINCT cno
        FROM grade
        WHERE sno IN(
                SELECT sno
                FROM student
                WHERE dno = (
                        SELECT dno
                        FROM department
                        WHERE dname = '计算机系'
                    )
            )
    );
-- 10.	查询宿舍电话是8302202的学生学号和姓名 (1)
SELECT sno,
    sname
FROM student
WHERE dormno IN(
        SELECT dormno
        FROM rome
        WHERE tele = '8302202'
    );
-- 11.	查询选修了没有先行课的课程的学生学号和姓名 (1)
SELECT sno,
    sname
FROM student
WHERE sno IN (
        SELECT sno
        FROM grade
        WHERE cno IN(
                SELECT cno
                FROM course
                WHERE cpno IS NULL
            )
    );
-- 12.	查询选修了学分是4分的课程的学生学号、姓名、性别和年龄，结果按性别升序、年龄降序排序 (1)
SELECT sno,
    sname,
    sex,
    sage
FROM student
WHERE sno IN (
        SELECT sno
        FROM grade
        WHERE cno IN (
                SELECT cno
                FROM course
                WHERE credit = 4
            )
    )
ORDER BY sex ASC,
    age DESC;
-- 13.	查询数学系、物理系、中文系的学生情况（要求：用三种方法实现查询）(1)
SELECT *
FROM student
WHERE dno IN (
        SELECT dno
        FROM department
        WHERE dname IN ('数学系', '物理系', '中文系')
    );
SELECT s.*
FROM student s,
    department d
WHERE s.dno = d.dno
    AND d.dname IN ('数学系', '物理系', '中文系');
SELECT s.*
FROM student s
    INNER JOIN department d ON s.dno = d.dno
WHERE d.dname IN ('数学系', '物理系', '中文系');
-- 14.	查询所有课程的后继课程，生成如下结果：（要求：按照课程号排序）(1)
-- 课程号        后继课程号
-- XXX           XXX
SELECT cpno "课程号",
    cno "后继课程号"
FROM course
WHERE cpno IS NOT NULL
ORDER BY cpno;
-- 15.	查询每个宿舍中成绩最高的学生的宿舍号、学号和姓名 (1)
SELECT d.dormno,
    t.sno,
    sname
FROM (
        SELECT rome.dormno,
            MAX(score) maxs
        FROM rome
            LEFT JOIN (
                SELECT s.sno,
                    sname,
                    cno,
                    score,
                    dormno
                FROM student s,
                    grade g
                WHERE s.sno = g.sno
            ) t ON rome.dormno = t.dormno
        GROUP BY rome.dormno
    ) d
    LEFT JOIN (
        SELECT s.sno,
            sname,
            cno,
            score,
            dormno
        FROM student s,
            grade g
        WHERE s.sno = g.sno
    ) t ON d.dormno = t.dormno
    AND d.maxs = t.score;
-- 16.	查询计算机系所有1985年出生的学生（以2005年为标准）(1)
SELECT *
FROM student
WHERE 2005 - sage = 1985
    AND dno = (
        SELECT dno
        FROM department
        WHERE dname = '计算机系'
    );
-- 17.	查询1系选修了02号课程的最高分、最低分、平均分 (1)
SELECT MAX(score) "最高分",
    MIN(score) "最低分",
    AVG(score) "平均分"
FROM grade
WHERE cno = '02'
    AND sno IN(
        SELECT sno
        FROM student
        WHERE dno = '1'
    );
-- 18.	查询所有不及格同学的基本情况 (1)
SELECT *
FROM student
WHERE sno IN (
        SELECT sno
        FROM grade
        WHERE score < 60
    );
-- 19.	查询GRADE表中成绩在60到80分之间的所有成绩记录信息；(1)
SELECT *
FROM grade
WHERE score BETWEEN 60 AND 80;
-- 20.	查询中文系年龄在20岁以下的学生姓名。(1)
SELECT sname
FROM student
WHERE sage < 20
    AND dno IN (
        SELECT dno
        FROM department
        WHERE dname = '中文系'
    );
-- 21.	查询所有”01”系或性别为”女”的同学记录；(1)
SELECT *
FROM student
WHERE dno = '01'
    OR sex = '女';
-- 22.	查询王老师讲的每门课的学生平均成绩，输出课程号和平均成绩。(1)
SELECT cno,
    AVG(score)
FROM grade
WHERE cno IN (
        SELECT cno
        FROM course
        WHERE teacher LIKE '王%'
    )
GROUP BY cno;
-- 23.	查询所有男学生情况并按年龄升序排。(1)
SELECT *
FROM student
WHERE sex = '男'
ORDER BY sage ASC;
-- 24.	查询选修了课程’01’但没有选修课程’02’的学生学号(1)
SELECT sno
FROM grade
WHERE cno = '01'
    AND sno NOT IN (
        SELECT sno
        FROM grade
        WHERE cno = '02'
    );
-- 25.	查询‘物理系’学生的学号、姓名和宿舍情况，结果按宿舍号升序排列。(1)
SELECT sno,
    sname,
    r.*
FROM student s
    LEFT JOIN rome r ON s.dormno = r.dormno
WHERE s.dno = (
        SELECT dno
        FROM department
        WHERE dname = '物理系'
    );
-- 26.	查询‘中文’系学生的详细记录情况，结果按性别升序、年龄降序排列。(1)
SELECT *
FROM student
WHERE dno = (
        SELECT dno
        FROM department
        WHERE dname = '中文系'
    )
ORDER BY sex ASC,
    sage DESC;
-- 27.	查询‘2’系的姓名和其出生年月(以2005年为标准)，并用“BIRTHDAY”改变结果标题。(1)
SELECT sname,
    2005 - sage "BIRTHDAY"
FROM student
WHERE dno = '2';
-- 28.	查询所有被选修的课程情况。(1)
SELECT *
FROM course
WHERE cno IN (
        SELECT DISTINCT cno
        FROM grade
    );
-- 29.	查询年龄在21-25之间（包括21和25）的学生姓名，宿舍号，电话。(1)
SELECT sname,
    dno,
    tele
FROM student,
    rome
WHERE student.dormno = rome.dormno
    AND sage BETWEEN 21 AND 25 -- 30.	查询‘计算机’系、‘中文’系和‘物理’系的学生姓名，宿舍号。(1)
SELECT sname,
    r.dormno
FROM student s
    JOIN rome r ON s.dormno = r.dormno
WHERE dno IN (
        SELECT dno
        FROM department
        WHERE dname IN ('计算机系', '中文系', '物理系')
    );
-- 31.	查询所有姓‘张’的学生情况。(1)
SELECT *
FROM student
WHERE sname LIKE '张%';
-- 32.	查询COURSE表中有先修课程的课程名和教师情况  (1)
SELECT cname,
    teacher
FROM course
WHERE cpno IS NOT NULL;
-- 33.	查询‘计算机’系的所有男学生的信息  (1)
SELECT *
FROM student
WHERE dno = (
        SELECT dno
        FROM department
        WHERE dname = '计算机系'
    )
    AND sex = '男';
-- 34.	查询所有‘2’系的学生人数。 (1)
SELECT COUNT(*)
FROM student
WHERE dno = '2';
-- 35.	查询所有已选修课程的学生的学号、姓名、选修的课程名和授课教师信息。(1)
SELECT s.sno,
    s.sname,
    c.cname,
    c.teacher
FROM grade g
    INNER JOIN student s ON g.sno = s.sno
    INNER JOIN course c ON g.cno = c.cno;
-- 36.	查询是系主任‘李永军’的学生的姓名和宿舍电话。 (1)
SELECT sname,
    tele
FROM student
    INNER JOIN rome ON student.dormno = rome.dormno
WHERE dno = (
        SELECT dno
        FROM department
        WHERE head = '李永军'
    );
-- 37.	查询其他系比‘中文系’所有学生年龄大的学生姓名和年龄。(1)
SELECT sname,
    sage
FROM student
WHERE sage > (
        SELECT MAX(sage)
        FROM student
        WHERE dno = (
                SELECT dno
                FROM department
                WHERE dname = '中文系'
            )
    )
    AND dno <> (
        SELECT dno
        FROM department
        WHERE dname = '中文系'
    );
-- 38.	查询选修课程库没有不及格分数的学生。(1)
SELECT *
FROM student
WHERE sno IN (
        SELECT sno
        FROM grade
        WHERE cno = (
                SELECT cno
                FROM course
                WHERE cname = '数据库原理'
            )
            AND score >= 60
    );
-- 39.	查询‘3’系的学生与年龄大于19岁的学生的差集。(1)
SELECT *
FROM student
WHERE dno = '3'
EXCEPT
SELECT *
FROM student
WHERE sage > 19;
-- 40.	查询选修“数据库原理”的学生与选修“C语言”的学生的交集。(1)
SELECT *
FROM student
WHERE sno IN(
        SELECT sno
        FROM grade
        WHERE cno = (
                SELECT cno
                FROM course
                WHERE cname = '数据库原理'
            )
    )
INTERSECT
SELECT *
FROM student
WHERE sno IN(
        SELECT sno
        FROM grade
        WHERE cno = (
                SELECT cno
                FROM course
                WHERE cname = 'C语言'
            )
    );
-- 41.	从学生选课关系SC中，删除李军（学生关系中可能有重名）的所有选课(1)
DELETE FROM grade
WHERE sno = (
        SELECT sno
        FROM student
        WHERE sname = '李军'
    );
-- 42.	对STUDENT表以学号SNO，创建聚簇索引。  (1)
CREATE CLUSTERED INDEX STUDENT_SNO_INDEX ON STUDENT(SNO);
-- 43.	对STUDENT表以学号DORMNO，创建唯一索引。  (1)
CREATE UNIQUE INDEX STUDENT_DORMNO_INDEX ON student(dormno);
-- 44.	将计算机系学生选修课程中，成绩为空的学生成绩置零 (1)
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
    AND score IS NULL;
-- 45.	对所有“计算机系”的学生的选修课程的成绩提高10%。 (1)
UPDATE grade
SET score = score * 1.1
WHERE sno IN (
        SELECT sno
        FROM student
        WHERE dno = (
                SELECT dno
                FROM department
                WHERE dname = '计算机系'
            )
    )
    AND score IS NOT NULL;
-- 46.	将COURSE课程信息表中有先修课的课程的学分增加2分。(1)
UPDATE course
SET credit = credit + 2
WHERE cpno IS NOT NULL;
-- 47.	将student中学号为”990303”的学生的系号改为“3”； (1)
UPDATE student
SET dno = 3
WHERE sno = '990303';
-- 48.	插入一条学生记录（960101，张华，女，21，4，2303）。 (1)
INSERT INTO student
VALUES(960101, '张华', '女', 21, 4, 2303);
-- 49.	创建计算机系所有不及格学生的视图  (1)
CREATE VIEW view_computer_low_grade AS
SELECT *
FROM student
WHERE dno = (
        SELECT dno
        FROM department
        WHERE dname = '计算机系'
    )
    AND sno IN (
        SELECT sno
        FROM grade
        WHERE score < 60
    );
-- 50.	创建“计算机”系的所有男生的视图VIEW_1（要求反映出学生的出生年份）。(1)
CREATE VIEW VIEW_1 AS
SELECT sno,
    sname,
    sex,
    sage,
    2022 - sage "birthyear",
    dno,
    dormno
FROM student
WHERE sex = '男';
-- 51.	修改视图VIEW_1中的学生“明天”的年龄为23，宿舍号为“2202”。(1)
UPDATE VIEW_1
SET sage = 23,
    dormno = 2202
WHERE sname = '明天';
-- 52.	把用户U2修改学生学号的权限收回。 （以上操作，需要检查是否授权成功。）(1)
REVOKE
UPDATE(sno) ON student
FROM U2;
-- 53.	对表STUDENT的INSERT权限授予U1用户，并允许他再将此权限授予其他用户。 （以上操作，需要检查是否授权成功。）(1)
GRANT INSERT ON STUDENT TO U1 WITH
GRANT OPTION;
-- 54.	???创建一个“TEST”用户，默认数据库为STUDENT_DATA(应用实例中数据环境)，且享有一切数据库操作权限。（以上操作，需要检查是否授权成功。）(1)
CREATE USER TEST WITH DBA;
-- 55.	将“TEST”用户修改学生姓名的权限收回。（以上操作，需要检查是否授权成功。）(1)
REVOKE
UPDATE(sname) ON student
FROM TEST;
-- 56.	收回“TEST”用户对STUDENT表的所有权限。（以上操作，需要检查是否授权成功。）  (1)
REVOKE ALL ON STUDENT
FROM TEST;
-- 57.	将对GRADE表的查询权限授给“TEST”用户。（以上操作，需要检查是否授权成功。）(1)
GRANT SELECT ON GRADE TO TEST;