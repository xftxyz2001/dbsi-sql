/*
MySQL Backup
Database: stu
Backup Time: 2022-05-24 16:08:27
*/

SET FOREIGN_KEY_CHECKS=0;
DROP TABLE IF EXISTS `stu`.`course`;
DROP TABLE IF EXISTS `stu`.`department`;
DROP TABLE IF EXISTS `stu`.`dorm`;
DROP TABLE IF EXISTS `stu`.`grade`;
DROP TABLE IF EXISTS `stu`.`student`;
DROP VIEW IF EXISTS `stu`.`view_1`;
DROP PROCEDURE IF EXISTS `stu`.`transaction_insert_check_delete_rollback`;
CREATE TABLE `course` (
  `cno` char(2) DEFAULT NULL,
  `cname` char(20) DEFAULT NULL,
  `cpno` char(2) DEFAULT NULL,
  `credit` int DEFAULT NULL,
  `teacher` char(8) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
CREATE TABLE `department` (
  `dno` char(4) DEFAULT NULL,
  `dname` char(20) DEFAULT NULL,
  `head` char(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
CREATE TABLE `dorm` (
  `dormno` char(5) DEFAULT NULL,
  `tele` char(7) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
CREATE TABLE `grade` (
  `sno` char(6) DEFAULT NULL,
  `cno` char(2) DEFAULT NULL,
  `score` decimal(4,1) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
CREATE TABLE `student` (
  `sno` char(6) DEFAULT NULL,
  `sname` char(8) DEFAULT NULL,
  `sex` char(2) DEFAULT NULL,
  `sage` int DEFAULT NULL,
  `dno` char(4) DEFAULT NULL,
  `dormno` char(5) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `view_1` AS select `student`.`sno` AS `sno`,`student`.`sname` AS `sname`,`student`.`sex` AS `sex`,(2022 - `student`.`sage`) AS `BIRTHDAY`,`student`.`dno` AS `dno`,`student`.`dormno` AS `dormno` from `student` where (`student`.`sex` = '男');
CREATE DEFINER=`root`@`localhost` PROCEDURE `transaction_insert_check_delete_rollback`()
BEGIN START TRANSACTION;
-- 开始事务
-- 在 Stu数据库的student表中插入一条记录(990901，何为，男，20，NULL，2505)
INSERT INTO student
VALUES (990901, '何为', '男', 20, NULL, 2505);
-- 检索插入是否成功
SELECT *
FROM student
WHERE sno = 990901;
-- 设置一个保存点
SAVEPOINT sp1;
-- 删除刚才插入的数据
DELETE FROM student
WHERE sno = 990901;
-- 检索删除是否成功
SELECT *
FROM student
WHERE sno = 990901;
-- 回滚事务
ROLLBACK TO sp1;
-- 检索插入的数据
SELECT *
FROM student
WHERE sno = 990901;
END;
BEGIN;
LOCK TABLES `stu`.`course` WRITE;
DELETE FROM `stu`.`course`;
INSERT INTO `stu`.`course` (`cno`,`cname`,`cpno`,`credit`,`teacher`) VALUES ('01', '数据库原理', '05', 4, '王凯'),('02', '高等数学', NULL, 6, '张风'),('03', '信息系统', '01', 2, '李明'),('04', '操作系统', '06', 4, '许强'),('05', '数据结构', '07', 4, '路飞'),('06', '算法设计', NULL, 2, '黄海'),('07', 'C语言', '06', 3, '高达');
UNLOCK TABLES;
COMMIT;
BEGIN;
LOCK TABLES `stu`.`department` WRITE;
DELETE FROM `stu`.`department`;
INSERT INTO `stu`.`department` (`dno`,`dname`,`head`) VALUES ('1', '计算机系', '王凯峰'),('2', '数学系', '李永军'),('3', '物理系', '唐建'),('4', '中文系', '秦峰');
UNLOCK TABLES;
COMMIT;
BEGIN;
LOCK TABLES `stu`.`dorm` WRITE;
DELETE FROM `stu`.`dorm`;
INSERT INTO `stu`.`dorm` (`dormno`,`tele`) VALUES ('2101', '8302101'),('2202', '8302202'),('2303', '8302303'),('2404', '8302404'),('2505', '8302505');
UNLOCK TABLES;
COMMIT;
BEGIN;
LOCK TABLES `stu`.`grade` WRITE;
DELETE FROM `stu`.`grade`;
INSERT INTO `stu`.`grade` (`sno`,`cno`,`score`) VALUES ('990101', '01', 80.0),('990101', '03', 65.0),('990101', '04', 83.0),('990101', '07', 72.0),('990102', '02', 80.0),('990102', '04', 81.0),('990102', '01', NULL),('990103', '07', 74.0),('990103', '06', 74.0),('990103', '01', 74.0),('990103', '02', 70.0),('990103', '04', 70.0),('990104', '01', 55.0),('990104', '02', 42.0),('990104', '01', 0.0),('990105', '03', 85.0),('990105', '06', NULL),('980301', '01', 46.0),('980301', '02', 70.0),('990302', '01', 85.0),('990401', '01', 0.0);
UNLOCK TABLES;
COMMIT;
BEGIN;
LOCK TABLES `stu`.`student` WRITE;
DELETE FROM `stu`.`student`;
INSERT INTO `stu`.`student` (`sno`,`sname`,`sex`,`sage`,`dno`,`dormno`) VALUES ('990101', '原野', '男', 21, '1', '2101'),('990102', '张原', '男', 21, '1', '2101'),('990103', '李军', '男', 20, '1', '2101'),('990104', '汪远', '男', 20, '1', '2101'),('990105', '齐欣', '男', 20, '1', '2101'),('990201', '王大鸣', '男', 19, '2', '2202'),('982002', '徐东', '男', 19, '2', '2202'),('980301', '张扬', '女', 21, '1', '2303'),('990302', '于洋', '女', 20, '3', '2303'),('990303', '姚志旬', '男', 19, '4', '2404'),('990401', '高明镜', '男', 19, '4', NULL),('990402', '明天', '男', 21, '4', '2404');
UNLOCK TABLES;
COMMIT;
CREATE DEFINER = `root`@`localhost` TRIGGER `check_time` BEFORE UPDATE ON `grade` FOR EACH ROW BEGIN IF (
        DAYOFWEEK(NOW()) <> 1
        AND DAYOFWEEK(NOW()) <> 2
        AND DAYOFWEEK(NOW()) <> 3
        AND DAYOFWEEK(NOW()) <> 4
        AND DAYOFWEEK(NOW()) <> 5
    )
    AND (
        HOUR(NOW()) < 9
        OR HOUR(NOW()) > 15
    ) THEN SIGNAL SQLSTATE '45000'
SET MESSAGE_TEXT = '当前时间不允许修改!';
END IF;
END;;
CREATE DEFINER = `root`@`localhost` TRIGGER `check_age` BEFORE INSERT ON `student` FOR EACH ROW BEGIN IF NEW.sage < 18
    OR NEW.sage > 28 THEN SIGNAL SQLSTATE '45000'
SET MESSAGE_TEXT = '数据有误，请检查!';
END IF;
END;;
