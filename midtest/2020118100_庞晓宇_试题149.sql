-- 156  
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
        WHERE cname = '数据库原理'
    );
-- 157
SELECT *
FROM grade
WHERE sno IN (
        SELECT sno
        FROM student
        WHERE dno = (
                SELECT dno
                FROM department
                WHERE dname = '计算机系'
            )
        INTERSECT
        SELECT sno
        FROM grade
        WHERE cno = (
                SELECT cno
                FROM course
                WHERE cname = '高等数学'
            )
    );
-- 158
-- SELECT sname
-- FROM student
-- WHERE sno NOT IN(
--         SELECT sno
--         FROM grade
--         WHERE cno = 3
--     );
SELECT sname
FROM student s
WHERE NOT EXISTS (
        SELECT *
        FROM grade g
        WHERE g.sno = s.sno
            AND g.cno = '03'
    );
-- 159
SELECT sno,
    sname
FROM student
WHERE sno IN(
        SELECT DISTINCT gradeX.sno
        FROM grade gradeX
        WHERE NOT EXISTS(
                SELECT *
                FROM grade gradeY
                WHERE gradeY.sno =(
                        SELECT sno
                        FROM student
                        WHERE sname = '张扬'
                    )
                    AND NOT EXISTS(
                        SELECT *
                        FROM grade gradeZ
                        WHERE gradeZ.sno = gradeX.sno
                            AND gradeZ.cno = gradeY.cno
                    )
            )
    );
-- 160
SELECT s.sno,
    d.dormno
FROM student s,
    (
        SELECT dormno,
            COUNT(*) "cnt"
        FROM student
        WHERE dormno IS NOT NULL
        GROUP BY dormno
        HAVING COUNT(*) < 5
    ) d
WHERE s.dormno IS NULL;