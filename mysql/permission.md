### 权限说明

```sql
-- 前置条件
show variables like "%proxy%"; #查看当前proxy是否开启

set global check_proxy_users =on; #开启proxy 下图表示已开启
set global mysql_native_password_proxy_users = on;

REVOKE PROXY ON 'team'@'%' FROM `role_tm`@'%';

-- 查询proxy
select * from mysql.proxies_priv;

-- 刷新权限
flush privileges;

-- 查看所有权限
show privileges;

-- 移除权限 revoke SELECT on db.xsb from 'USERNAME'@'HOST';
-- 查看用户权限 show grants for 'USERNAME'@'HOST';
-- 针对字段的权限 grant update(COLUMN_NAME)  on DB_NAME.TABLE_NAME to 'USERNAME'@'HOST';
-- 增加代理权限 GRANT PROXY ON ''@'' TO 'dev'@'%' WITH GRANT OPTION; -- 一定要在服务器上执行
-- 删除用户 drop user 'USERNAME'@'HOST';

-- 数据库权限说明
-- ALL或ALL PRIVILEGES：除了grant option之外，其他所有权限的简写方式
-- ALTER：该权限用于使用ALTER TABLE语句来更改表的结构（ALTER TABLE语句除了该权限之外还需要CREATE和INSERT权限。ALTER TABLE RENAME语句需要旧表上的ALTER和DROP权限，新表上的CREATE和INSERT权限）。
-- ALTER ROUTINE：该权限用于修改或删除存储过程或存储函数。
-- CREATE：该权限用于创建库和表。
-- CREATE ROUTINE：该权限用于创建存储过程或函数。
-- CREATE TABLESPACE：该权限用于创建、修改、删除表空间文件和日志组文件。
-- CREATE TEMPORARY TABLES：该权限用于创建临时表，使用CREATE TEMPORARY TABLE语句创建临时表，一旦某会话创建临时表成功后，Server不会在该表上执行进一步的权限检查。即，创建该临时表的会话可以该临时表执行任何操作，例如：DROP TABLE、INSERT、UPDATE、SELECT等操作。
-- CREATE USER：该权限用于使用ALTER USER、CREATE USER、DROP USER、RENAME USER、REVOKE ALL PRIVILEGES语句。
-- CREATE VIEW：该权限用于使用CREATE VIEW语句。
-- DELETE：该权限用于从数据库表中删除数据记录。
-- DROP：该权限用户删除现有库、或表、或视图等对象。另外，如果在分区表上使用ALTER TABLE ... DROP PARTITION语句，必须要有表的DROP权限，要执行TRUNCATE TABLE也需要DROP权限(但要注意，如果将MySQL数据库的DROP权限授予给用户，则该用户可以删除存储MySQL访问权记录的数据库mysql）。
-- EVENT：该选项用于创建、更改、删除或查看Event Scheduler事件。
-- EXECUTE：该权限用于执行存储过过程或函数。
-- FILE：该权限用于执行LOAD DATA INFILE和SELECT ... INTO OUTFILE语句以及LOAD_FILE（）函数来读取和写入Server主机上的文件。具有FILE权限的用户可以读取Server主机上任何可读或MySQL Server可读的文件。（即，用户可读取datadir目录中的任何文件），FILE权限还使用户能够在MySQL Server有写入权限的任何目录下创建新文件。所以，作为安全保护措施，Server不会覆盖现有文件(即执行导出数据到文本时，如果文件名重叠则导出语句无法成执行)。在MySQL 5.7版本中，可以使用secure_file_priv系统变量限制FILE权限的读写目录。
-- GRANT OPTION：该权限用于授予或回收其他用户或自己拥有的权限。
-- INDEX：该权限用于创建或删除索引。INDEX权限适用于在已存在的表上使用CREATE INDEX语句，如果用户具有CREATE权限，则可以在CREATE TABLE语句中包含索引定义语句。
-- INSERT：该权限用于向表中插入数据记录行。对于ANALYZE TABLE、OPTIMIZE TABLE和REPAIR TABLE表维护语句也需要INSERT权限。
-- LOCK TABLES：该权限用于LOCK TABLES语句对表显式加锁，持有表锁的用户对该表有读写权限，未持有表锁的用户对表的读写访问会被阻塞。
-- PROCESS：该权限用于显示有关在Server内执行的线程信息（即关于会话正在执行的语句相关状态信息）。拥有该权限的用户在使用SHOW PROCESSLIST语句或mysqladmin processlist命令查看有关线程信息时除了自己的线程信息之外还可以查看到属于其他帐号的线程信息。另外，使用SHOW ENGINE语句以及查看information_schema 数据字典库中的相当一部分表也需要该权限。
-- PROXY：该权限使用户能够模仿另一个用户。
-- REFERENCES：该权限在创建外键约束时，需要用户具有父表的REFERENCES权限。
-- RELOAD：该权限允许用户使用FLUSH语句。拥有该权限的用户还可以使用与FLUSH操作等效的mysqladmin子命令：flush-hosts，flush-logs，flush-privileges，flush-status，flush-tables，flush-threads，refresh和reload
-- * mysqladmin的reload子命令会通知Server将权限表重新加载到内存中。flush-privileges作用与reload子命令作用相同。refresh子命令会通知Server关闭并重新打开日志文件并刷新所有表。类似地，其他flush-xxx子命令也会执行类似于刷新的功能，这些子命令刷新的对象更具体，例如：只想刷新日志文件则使用flush-logs子命令。
-- REPLICATION CLIENT：该权限用于使用SHOW MASTER STATUS、SHOW SLAVE STATUS和SHOW BINARY LOGS语句。
-- REPLICATION SLAVE：该权限用于从库服务器连接到主库服务器并请求主库binlog 日志。如果没有此权限，从库将无法请求主库数据库变更的binlog日志。
-- SELECT：该权限用于从数据库表中查询数据行记录。SELECT语句只有在它们实际从表中检索行记录时才需要SELECT权限。但某些SELECT语句不需要访问表，并且可以在没有任何数据库权限的情况下执行。例如，使用SELECT语句拼接的常量表达式：SELECT 1 + 1; SELECT PI()* 2;
-- * 另外，当使用UPDATE或DELETE语句时使用where子句指定了某列的条件值时，也需要该列的SELECT权限。否则，你会发现可以update不带where子句更新全表，却不能使用where语句指定更新某些行记录 。
-- * 对基表或视图使用EXPLAIN语句也需要用户对表或视图具有该权限。
-- SHOW DATABASES：该权限用于执行SHOW DATABASE语句，若没有此权限的帐户，则只能看到他们具有对应访问权限的数据库列表，如果Server使用了--skip-show-database选项启动，则没有该权限的用户即使对某库有其他访问权限也不能使用SHOW DATABASES语句查看任何数据库列表(会报：ERROR 1227 (42000): Access denied; you need (at least one of) the SHOW DATABASES privilege(s) for this operation)
-- SHOW VIEW：该权限用于执行SHOW CREATE VIEW语句。对视图使用EXPLAIN语句也需要此权限。
-- SHUTDOWN：该权限用于执行SHUTDOWN语句、mysqladmin shutdown命令和mysql_shutdown() C API函数。
-- SUPER：该权限用于如下这些操作和Server行为：
-- * 修改全局系统配置变量需要此权限。对于某些系统变量，修改会话级别的系统配置变量也需要SUPER权限(如果修改会话级别的系统配置变量值需要SUPER权限的，在变量的解释文档中会进行说明，例如：binlog_format、sql_log_bin和sql_log_off）
-- * 对全局事务特征的更改(start transaction语句) 。
-- * 从库服务器用于执行启动和停止复制的语句，包括组复制 。
-- * 从库服务器用于执行使用CHANGE MASTER TO和CHANGE REPLICATION FILTER语句 。
-- * 执行PURGE BINARY LOGS和BINLOG语句 。
-- * 如果视图或存储程序定义了DEFINER属性，则拥有SUPER权限的用户就算不是该视图或存储程序的创建者，仍然可以执行该视图或存储程序 。
-- * 执行CREATE SERVER、ALTER SERVER和DROP SERVER语句 。
-- * 执行mysqladmin debug命令 。
-- * 用于InnoDB key自旋 。
-- * 用于执行通过DES_ENCRYPT()函数启用读取DES密钥文件 。
-- * 用于执行用户自定义函数时启用版本令牌 。
-- * 对于超过了最大连接数之后具有SUPER的帐户还可以的操作 。
-- * 1)、使用KILL语句或mysqladmin kill命令来终止属于其他帐户的线程。（注意：无论是否拥有SUPER权限，用户总是可以kill自己的线程）
-- * 2)、即使Server总连接数达到max_connections系统变量定义的值，Server 也会接受来自具有SUPER权限的用户一个额外的连接 。
-- * 3)、即使Server启用了read_only系统变量，具有SUPER权限的用户仍然可以执行数据更新。另外，还有帐户管理语句GRANT和REVOKE等 。
-- * 4)、SUPER客户端连接Server时，Server不执行init_connect系统变量指定的内容 。
-- * 5)、处于脱机模式（已启用offline_mode系统变量）的Server不会中断具有SUPER权限用户的连接，且仍然接收具有SUPER权限用户的新连接请求 。
-- * 如果启用了二进制日志记录功能，则用户可能还需要SUPER权限才能创建或更改存储的功能。
-- TRIGGER：该权限用于触发器的操作。您必须拥有某表的该权限才能针对该表创建、删除、执行或查看该表的触发器。
-- UPDATE：该权限用于执行对数据库表中的数据行更新操作。
-- USAGE：该权限代表用户“无任何权限”。全局级别权限，拥有该权限的用户可以登录到数据库Server中，但默认配置下除了能够执行部分show命令之外，其他任何数据变更和数据库查询的操作都无法执行。
-- 向用户只授予用户需要的权限，不要授予额外的多余的，特别是管理权限，如下：
-- * FILE：该权限用于将任何文件读入数据库表中，MySQL Server可以在Server主机上读取任何文件。包括Server数据目录中所有可读文件。然后可以使用SELECT访问该导入数据的表，将其读取表中的内容返回给客户端 。
-- * GRANT OPTION：该权限用于执行将权限授予其他用户 。
-- * ALTER：该权限用于修改表定义，重命名表等操作 。
-- * SHUTDOWN：该权限用于终止Server服务器，如果被滥用可被用于关闭Server来达到拒绝服务的目的 。
-- * PROCESS：该权限可用于查看当前正在执行的语句的纯文本，包括设置或更改密码的语句文本 。
-- * SUPER：该权限可用于终止其他用户会话或更改服务器的运行方式。详见上述SUPER解释项。

------------------------------------------------------------------------------

-- role_bussiness，仅有prod select权限
CREATE USER 'role_bussiness'@'%';
GRANT SELECT, SHOW VIEW, CREATE VIEW ON `prod`.* TO 'role_bussiness'@'%';

-- backup
show grants for 'root'@'localhost';
GRANT PROXY ON ''@'' TO 'root'@'127.0.%.%' IDENTIFIED BY 'password' WITH GRANT OPTION ;
```
