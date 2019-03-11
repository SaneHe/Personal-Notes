## MySQL主从复制(Master-Slave)实践

   MySQL数据库自身提供的主从复制功能可以方便的实现数据的多处自动备份，实现数据库的拓展。
多个数据备份不仅可以加强数据的安全性，通过实现读写分离还能进一步提升数据库的负载性能。

### 多个数据库间主从复制与读写分离的模型

![运行原理](/media/master-slave-1.png)

![运行原理](/media/master-slave-2.png)

> MySQL之间数据复制的基础是二进制日志文件（binary log file）。
> 一台MySQL数据库一旦启用二进制日志后，其作为master，
> 它的数据库中所有操作都会以“事件”的方式记录在二进制日志中，
> 其他数据库作为slave通过一个I/O线程与主服务器保持通信，
> 并监控master的二进制日志文件的变化，
> 如果发现master二进制日志文件发生变化，则会把变化复制到自己的中继日志中，
> 然后slave的一个SQL线程会把相关的“事件”执行到自己的数据库中，
> 以此实现从数据库和主数据库的一致性，也就实现了主从复制。

## 实现MySQL主从复制需要进行的配置：

* 主服务器：
    * 开启二进制日志
    * 配置唯一的server-id
    * 获得master二进制日志文件名及位置
    * 创建一个用于slave和master通信的用户账号
* 从服务器：
    * 配置唯一的server-id
    * 使用master分配的用户账号读取master二进制日志
    * 启用slave服务

## 主数据库 `Master` 修改：

1. 修改 `mysql` 配置
    * 找到主数据库的配置文件 `my.cnf` (或者 `my.ini`)，我的在 `/etc/mysql/my.cnf`,在 `[mysqld]` 部分插入如下两行：
   
        ```
        [mysqld]
            log-bin=mysql-bin #开启二进制日志
            server-id=1 #设置server-id
        ```

2. 重启 `mysql` ，创建用于同步的用户账号
    * 打开 `mysql` 会话 `shell>mysql -hlocalhost -uname -ppassword`
    * 创建用户并授权：用户：rel1 密码：slavepass

        ```sql
        mysql> CREATE USER 'repl'@'123.57.44.85' IDENTIFIED BY 'slavepass';#创建用户
        mysql> GRANT REPLICATION SLAVE ON *.* TO 'repl'@'123.57.44.85';#分配权限
        mysql> flush privileges;   #刷新权限
        ```
    * 查看master状态，记录二进制文件名(mysql-bin.000003)和位置(73)： `SHOW MASTER STATUS`

## 从数据库 `Slave` 修改：

1. 修改 `mysql` 配置
    * 同样找到my.cnf配置文件，添加server-id
        ```
        [mysqld]
        server-id=2 #设置server-id，必须唯一
        ```

2. 重启mysql，打开mysql会话，执行同步SQL语句
    * 需要主服务器主机名，登陆凭据，二进制文件的名称和位置

        ```sql
        mysql> CHANGE MASTER TO MASTER_HOST='182.92.172.80', 
        MASTER_USER='rep1',  
        MASTER_PASSWORD='slavepass', MASTER_LOG_FILE='mysql-bin.000003', MASTER_LOG_POS=73;
        ```

3. 启动 `Slave` 同步进程 `start slave;`

4. 查看 `Slave` 状态 `show slave status\G;`
    * 当Slave_IO_Running和Slave_SQL_Running都为YES的时候就表示主从同步设置成功了。

## 其他

> `master` 开启二进制日志后默认记录所有库所有表的操作，
> 可以通过配置来指定只记录指定的数据库甚至指定的表的操作，
> 具体在 `mysql` 配置文件的`[mysqld]` 可添加修改如下选项

```ini
# 不同步哪些数据库  
binlog-ignore-db = mysql  
binlog-ignore-db = test  
binlog-ignore-db = information_schema  
  
# 只同步哪些数据库，除此之外，其他不同步  
binlog-do-db = game
```