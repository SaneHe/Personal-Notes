### 事务

#### 定义: 一个最小的不可再分的工作单元

#### 特点:

- `原子性 (Atomicity)` - 事务是最小单元, 不可再分; 即一个事务中的所有操作要么都成功, 要么都失败
- `一致性 (Consistency)` - 事务总是从一个一致性状态转移成另一个一致性状态
- `隔离性 (Isolation)` - 一个事务处理对另一个事务是没有影响对
- `持久性 (Durability)` - 一旦事务提交, 则其所做对修改会永久保存

#### 常用操作

- `Start Transaction`   开启事务
- `End Transaction`     结束事务
- `Commit Transaction`  提交事务
- `Rollback Transaction`    回滚事务

#### 隔离级别

- `读未提交 (RU)` READ-UNCOMMITTED
- `读提交 (RC)` READ COMMITTED
- `可重复读 (RR)` REPEATABLE READ (默认)
- `串行化 (SERIALIZABLE)` 

#### 问题

- `脏读 (Dirty Reads)`: 一个事务读到了另一个事务未提交的数据
- `不可重复读 (Non-Repeatable Reads)`: 一个事务同一个条件多次查询, 查询到不同的结果 (同一记录)
- `幻读 (Phantom Reads)`: 一个事务同一个条件多次查询, 得到了不同的结果集 (不同记录)

| 隔离级别        | 脏读   |  不可重复读  | 幻读 |
| :-----:   | :-----:  | :-----:  | :-----: |
| RU     | √ |   √      |  √  |
| RC        |   x   |   √    |   √   |
| RR        |   x    |  x  |  √  |
| serializable |  x  |  x  |  x  |

#### 实现: 基于多版本并发控制 (`MVCC，Multiversion Concurrency Control`)

- `redo_log (重做日志)`: 实现持久性和原子性
- `undo_log (回滚日志)`: 实现一致性和MVCC
- `lock (锁)`: 保证隔离性

#### 锁

- `Record Lock (行锁)`: 单条记录上的锁
- `Gap Lock (间隙锁)`: 范围内的记录锁, 但不包含数据本身
- `Next-Key Lock (Record Lock + Gap Lock)`: 范围内的记录锁, 包含数据本身

> - 单条索引上锁, 锁住的永远是索引, 而非数据本身; 如果 `Innodb` 表中没有索引, 会自动创建一个隐藏的聚簇索引, 然后锁住此索引
> - 当查询的索引含有唯一属性时 (主键索引、唯一索引), `Innodb` 引擎会对 `Next-Key Lock` 进行优化, 将其降级为 `Record Lock`, 锁住索引本身
> - 若查询为辅助索引时 (非唯一), 此时会使用 `Next-Key Lock` 锁定一个索引范围, 并且还会增加该辅助索引的下一个值的 `Gap Lock` (索引是有序的)

#### 参考

- [InnoDB事务模型和锁定](https://www.mysqlzh.com/doc/215/427.html)
- [mysql 一文梳理](https://mp.weixin.qq.com/s/3ansSRo6sJl8W5A05vEVxQ)
- [mysql 一文梳理](https://database.51cto.com/art/201901/591260.htm)
- [mysql 锁](http://article.nxpop.com/mysql/15693.html)
