-- 1、尝试建立三个用户Tom、Mike、Mary
CREATE USER 'Tom' @'localhost' IDENTIFIED BY '123';
CREATE USER 'Mike' @'localhost' IDENTIFIED BY '456';
CREATE USER 'Mary' @'localhost' IDENTIFIED BY '789';
-- CREATE ROLE 'Tom' @'localhost';
-- CREATE ROLE 'Mike' @'localhost';
-- CREATE ROLE 'Mary' @'localhost';
-- 查看用户
SELECT *
FROM mysql.user;
-- 2、Tom要求具有student表的所有权限
GRANT ALL PRIVILEGES ON student TO 'Tom' @'localhost';
-- 3、Tom将自己对student表的update权限给Mike，并允许Mike授权给其他人
GRANT UPDATE ON student TO 'Mike' @'localhost' WITH
GRANT OPTION;
-- 4、Mike将自己对student表的update权限给Mary，但不允许Mary授权给其他人
GRANT UPDATE ON student TO 'Mary' @'localhost';
-- 5、Tom从Mike回收权限
REVOKE
UPDATE ON student
FROM 'Mike' @'localhost';
-- 删除之前建立的用户
DROP UESR 'Tom' @'localhost';
DROP UESR 'Mike' @'localhost';
DROP UESR 'Mary' @'localhost';
-- 查看用户
SELECT *
FROM mysql.user;
-- SQL Server
EXEC sp_addlogin 'Tom', '123';
EXEC sp_addlogin 'Mike', '456';
EXEC sp_addlogin 'Mary', '789';
EXEC sp_grantdbaccess 'Tom',
'Tom';
EXEC sp_grantdbaccess 'Mike',
'Mike';
EXEC sp_grantdbaccess 'Mary',
'Mary';
GRANT ALL ON student TO Tom with
grant option;
GRANT UPDATE ON student TO Mike with
grant option;
GRANT UPDATE ON student TO Mary;
REVOKE
UPDATE ON student
FROM Mike CASCADE;