-- 创建事务transaction_insert_check_delete_rollback
DROP PROCEDURE IF EXISTS transaction_insert_check_delete_rollback;
-- 如果存在先删除该储存过程
CREATE PROCEDURE transaction_insert_check_delete_rollback() BEGIN START TRANSACTION;
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
-- 调用存储过程
call transaction_insert_check_delete_rollback();