/*
 Navicat Premium Data Transfer

 Source Server         : XFdMysql
 Source Server Type    : MySQL
 Source Server Version : 80027
 Source Host           : localhost:3306
 Source Schema         : test

 Target Server Type    : MySQL
 Target Server Version : 80027
 File Encoding         : 65001

 Date: 15/03/2022 16:00:22
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for course
-- ----------------------------
DROP TABLE IF EXISTS `course`;
CREATE TABLE `course`  (
  `cno` char(2) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `cname` char(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `cpno` char(2) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `credit` int NULL DEFAULT NULL,
  `teacher` char(8) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  PRIMARY KEY (`cno`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of course
-- ----------------------------
INSERT INTO `course` VALUES ('01', '数据库原理', '05', 4, '王凯');
INSERT INTO `course` VALUES ('02', '高等数学', NULL, 6, '张风');
INSERT INTO `course` VALUES ('03', '信息系统', '01', 2, '李明');
INSERT INTO `course` VALUES ('04', '操作系统', '06', 4, '许强');
INSERT INTO `course` VALUES ('05', '数据结构', '07', 4, '路飞');
INSERT INTO `course` VALUES ('06', '算法设计', NULL, 2, '黄海');
INSERT INTO `course` VALUES ('07', 'c语言', '06', 3, '高达');

-- ----------------------------
-- Table structure for department
-- ----------------------------
DROP TABLE IF EXISTS `department`;
CREATE TABLE `department`  (
  `dno` char(4) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `dname` char(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `head` char(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  PRIMARY KEY (`dno`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of department
-- ----------------------------
INSERT INTO `department` VALUES ('1', '计算机系', '王凯锋');
INSERT INTO `department` VALUES ('2', '数学系', '李永军');
INSERT INTO `department` VALUES ('3', '物理系', '康健');
INSERT INTO `department` VALUES ('4', '中文系', '秦峰');

-- ----------------------------
-- Table structure for dorm
-- ----------------------------
DROP TABLE IF EXISTS `dorm`;
CREATE TABLE `dorm`  (
  `dormno` char(5) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `tele` char(7) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  PRIMARY KEY (`dormno`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of dorm
-- ----------------------------
INSERT INTO `dorm` VALUES ('2101', '8302101');
INSERT INTO `dorm` VALUES ('2202', '8302202');
INSERT INTO `dorm` VALUES ('2303', '8302303');
INSERT INTO `dorm` VALUES ('2404', '8302404');
INSERT INTO `dorm` VALUES ('2505', '8302505');

-- ----------------------------
-- Table structure for grade
-- ----------------------------
DROP TABLE IF EXISTS `grade`;
CREATE TABLE `grade`  (
  `sno` char(6) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `cno` char(2) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `score` int NULL DEFAULT NULL,
  PRIMARY KEY (`sno`, `cno`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of grade
-- ----------------------------
INSERT INTO `grade` VALUES ('990101', '01', 85);
INSERT INTO `grade` VALUES ('990101', '03', 65);
INSERT INTO `grade` VALUES ('990101', '04', 83);
INSERT INTO `grade` VALUES ('990101', '07', 72);
INSERT INTO `grade` VALUES ('990102', '01', NULL);
INSERT INTO `grade` VALUES ('990102', '02', 80);
INSERT INTO `grade` VALUES ('990102', '04', 81);
INSERT INTO `grade` VALUES ('990103', '01', 74);
INSERT INTO `grade` VALUES ('990103', '02', 70);
INSERT INTO `grade` VALUES ('990103', '04', 70);
INSERT INTO `grade` VALUES ('990103', '06', 74);
INSERT INTO `grade` VALUES ('990103', '07', 74);
INSERT INTO `grade` VALUES ('990104', '01', 55);
INSERT INTO `grade` VALUES ('990104', '02', 42);
INSERT INTO `grade` VALUES ('990104', '06', 0);
INSERT INTO `grade` VALUES ('990105', '03', 85);
INSERT INTO `grade` VALUES ('990105', '06', NULL);
INSERT INTO `grade` VALUES ('990301', '01', 46);
INSERT INTO `grade` VALUES ('990301', '02', 70);
INSERT INTO `grade` VALUES ('990302', '01', 85);
INSERT INTO `grade` VALUES ('990401', '01', 0);

-- ----------------------------
-- Table structure for stu0
-- ----------------------------
DROP TABLE IF EXISTS `stu0`;
CREATE TABLE `stu0`  (
  `sno` char(6) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `sname` char(8) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `sex` char(2) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `sage` int NULL DEFAULT NULL,
  `dno` char(4) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `dormno` char(5) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of stu0
-- ----------------------------
INSERT INTO `stu0` VALUES ('990599', '苗军琛', '女', 19, '1', '2272');
INSERT INTO `stu0` VALUES ('990602', '时有之', '女', 25, '1', '2390');
INSERT INTO `stu0` VALUES ('990603', '韩彪生', '女', 21, '3', '2387');
INSERT INTO `stu0` VALUES ('990604', '张山彬', '女', 21, '1', '2252');
INSERT INTO `stu0` VALUES ('990605', '时朋勇', '女', 18, '3', '2383');
INSERT INTO `stu0` VALUES ('990609', '常进健', '女', 18, '4', '2106');
INSERT INTO `stu0` VALUES ('990611', '费浩固', '女', 20, '4', '2205');
INSERT INTO `stu0` VALUES ('990612', '褚震安', '女', 24, '3', '2391');
INSERT INTO `stu0` VALUES ('990618', '卞栋思', '女', 20, '3', '2393');

-- ----------------------------
-- Table structure for stu1
-- ----------------------------
DROP TABLE IF EXISTS `stu1`;
CREATE TABLE `stu1`  (
  `sno` char(6) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `sname` char(8) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `sex` char(2) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `sage` int NULL DEFAULT NULL,
  `dno` char(4) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `dormno` char(5) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of stu1
-- ----------------------------
INSERT INTO `stu1` VALUES ('990600', '杨晨世', '男', 24, '2', '2226');
INSERT INTO `stu1` VALUES ('990601', '云翔星', '男', 24, '2', '2397');
INSERT INTO `stu1` VALUES ('990606', '郎超政', '男', 25, '1', '2339');
INSERT INTO `stu1` VALUES ('990607', '史顺庆', '男', 23, '4', '2340');
INSERT INTO `stu1` VALUES ('990608', '许林哲', '男', 19, '1', '2212');
INSERT INTO `stu1` VALUES ('990610', '严康世', '男', 22, '3', '2121');
INSERT INTO `stu1` VALUES ('990613', '方仁伯', '男', 18, '2', '2190');
INSERT INTO `stu1` VALUES ('990614', '陶龙亨', '男', 18, '1', '2172');
INSERT INTO `stu1` VALUES ('990615', '昌国航', '男', 21, '2', '2368');
INSERT INTO `stu1` VALUES ('990616', '褚策伯', '男', 21, '2', '2196');
INSERT INTO `stu1` VALUES ('990617', '曹群思', '男', 25, '1', '2353');

-- ----------------------------
-- View structure for student
-- ----------------------------
DROP VIEW IF EXISTS `student`;
CREATE ALGORITHM = UNDEFINED SQL SECURITY DEFINER VIEW `student` AS select `stu0`.`sno` AS `sno`,`stu0`.`sname` AS `sname`,`stu0`.`sex` AS `sex`,`stu0`.`sage` AS `sage`,`stu0`.`dno` AS `dno`,`stu0`.`dormno` AS `dormno` from `stu0` union select `stu1`.`sno` AS `sno`,`stu1`.`sname` AS `sname`,`stu1`.`sex` AS `sex`,`stu1`.`sage` AS `sage`,`stu1`.`dno` AS `dno`,`stu1`.`dormno` AS `dormno` from `stu1`;

SET FOREIGN_KEY_CHECKS = 1;
