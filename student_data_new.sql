IF EXISTS (
  SELECT NAME
  FROM sysobjects
  WHERE NAME = 'department'
    AND type = 'U'
) DROP TABLE department
go CREATE TABLE department (
    dno CHAR (4),
    dname CHAR (20),
    head CHAR (20),
    CONSTRAINT PK_dno PRIMARY KEY (dno)
  );
INSERT INTO department
VALUES ('1', '计算机系', '王凯锋');
INSERT INTO department
VALUES ('2', '数学系', '李永军');
INSERT INTO department
VALUES ('3', '物理系', '康健');
INSERT INTO department
VALUES ('4', '中文系', '秦峰');
SELECT *
FROM department;
IF EXISTS (
  SELECT NAME
  FROM sysobjects
  WHERE NAME = 'dorm'
    AND type = 'U'
) DROP TABLE dorm
go CREATE TABLE dorm (
    dormno CHAR (5),
    tele CHAR (7),
    CONSTRAINT PK_dormno PRIMARY KEY (dormno)
  );
INSERT INTO dorm
VALUES ('2101', '8302101');
INSERT INTO dorm
VALUES ('2202', '8302202');
INSERT INTO dorm
VALUES ('2303', '8302303');
INSERT INTO dorm
VALUES ('2404', '8302404');
INSERT INTO dorm
VALUES ('2505', '8302505');
SELECT *
FROM dorm;
IF EXISTS (
  SELECT NAME
  FROM sysobjects
  WHERE NAME = 'course'
    AND type = 'U'
) DROP TABLE course
go CREATE TABLE course (
    cno CHAR (2),
    cname CHAR (20),
    cpno CHAR (2),
    credit INT,
    teacher CHAR (8),
    CONSTRAINT PK_cno PRIMARY KEY (cno)
  );
INSERT INTO course
VALUES ('01', '数据库原理', '05', 4, '王凯');
INSERT INTO course
VALUES ('02', '高等数学', NULL, 6, '张风');
INSERT INTO course
VALUES ('03', '信息系统', '01', 2, '李明');
INSERT INTO course
VALUES ('04', '操作系统', '06', 4, '许强');
INSERT INTO course
VALUES ('05', '数据结构', '07', 4, '路飞');
INSERT INTO course
VALUES ('06', '算法设计', NULL, 2, '黄海');
INSERT INTO course
VALUES ('07', 'c语言', '06', 3, '高达');
SELECT *
FROM course;
IF EXISTS (
  SELECT NAME
  FROM sysobjects
  WHERE NAME = 'student'
    AND type = 'U'
) DROP TABLE student
go CREATE TABLE student (
    sno CHAR (6),
    sname CHAR (8),
    sex CHAR (2),
    sage INT,
    dno CHAR (4),
    dormno CHAR (5),
    CONSTRAINT PK_sno PRIMARY KEY (sno),
    CONSTRAINT FK_dno FOREIGN KEY (dno) REFERENCES department (dno),
    CONSTRAINT FK_dormno FOREIGN KEY (dormno) REFERENCES dorm (dormno)
  );
INSERT INTO student
VALUES ('990101', '原野', '男', 21, '1', '2101');
INSERT INTO student
VALUES ('990102', '张原', '男', 21, '1', '2101');
INSERT INTO student
VALUES ('990103', '李军', '男', 20, '1', '2101');
INSERT INTO student
VALUES ('990104', '汪远', '男', 20, '1', '2101');
INSERT INTO student
VALUES ('990105', '齐欣', '男', 20, '1', '2101');
INSERT INTO student
VALUES ('990201', '王大明', '男', 19, '2', '2202');
INSERT INTO student
VALUES ('990202', '徐东', '男', 19, '2', '2202');
INSERT INTO student
VALUES ('990301', '张扬', '女', 21, '1', '2303');
INSERT INTO student
VALUES ('990302', '于洋', '女', 20, '3', '2303');
INSERT INTO student
VALUES ('990303', '姚志旬', '男', 19, '4', '2404');
INSERT INTO student
VALUES ('990401', '高明镜', '男', 19, '4', NULL);
INSERT INTO student
VALUES ('990402', ' 明天', '男', 21, '4', '2404');
SELECT *
FROM student IF EXISTS (
    SELECT NAME
    FROM sysobjects
    WHERE NAME = 'grade'
      AND type = 'U'
  ) DROP TABLE grade
go CREATE TABLE grade (
    sno CHAR (6),
    cno CHAR (2),
    score INT,
    CONSTRAINT PK_grade PRIMARY KEY (sno, cno),
    CONSTRAINT FK_sno FOREIGN KEY (sno) REFERENCES student (sno),
    CONSTRAINT FK_cno FOREIGN KEY (cno) REFERENCES course (cno),
    CONSTRAINT CK_score CHECK (
      score >= 0
      AND score <= 100
    )
  );
INSERT INTO grade
VALUES ('990101', '01', 85);
INSERT INTO grade
VALUES ('990101', '03', 65);
INSERT INTO grade
VALUES ('990101', '04', 83);
INSERT INTO grade
VALUES ('990101', '07', 72);
INSERT INTO grade
VALUES ('990102', '02', 80);
INSERT INTO grade
VALUES ('990102', '04', 81);
INSERT INTO grade
VALUES ('990102', '01', NULL);
INSERT INTO grade
VALUES ('990103', '07', 74);
INSERT INTO grade
VALUES ('990103', '06', 74);
INSERT INTO grade
VALUES ('990103', '01', 74);
INSERT INTO grade
VALUES ('990103', '02', 70);
INSERT INTO grade
VALUES ('990103', '04', 70);
INSERT INTO grade
VALUES ('990104', '01', 55);
INSERT INTO grade
VALUES ('990104', '06', 0);
INSERT INTO grade
VALUES ('990104', '02', 42);
INSERT INTO grade
VALUES ('990105', '03', 85);
INSERT INTO grade
VALUES ('990105', '06', NULL);
INSERT INTO grade
VALUES ('990301', '01', 46);
INSERT INTO grade
VALUES ('990301', '02', 70);
INSERT INTO grade
VALUES ('990302', '01', 85);
INSERT INTO grade
VALUES ('990401', '01', 0);
SELECT *
FROM grade;