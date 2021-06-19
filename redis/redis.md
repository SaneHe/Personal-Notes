### `Redis`

#### 数据类型

- `string` (简单动态字符串（SDS） 和 直接存储)
- `hash`
- `list`
- `set`
- `zset`
- `bitmap`
- `hyperlog`
- `geo`
- `stream`

#### 持久化机制

- `RDB(Redis DataBase)`
>周期性的把内存的数据以快照的形式保存到硬盘(对数据丢失容忍性高)

- `AOF（Append Only File）`
>将每一个执行过的写命令记录下来

- `混合模式`
>`fork` 出子进程将全量数据以 `RDB` 方式写入到 `AOF` 文件中，然后再将 `AOF` 以增量命令写到 `AOF` 文件

#### 淘汰机制(`LRU` 算法淘汰数据)

- `volatile-lru`: 有过期时间的 `key`
- `alkeys-lru`: 最近最少使用的 `key` 
- `volatile-random`: 有过期时间的 `key` 随机淘汰
- `allkeys-random`: 所有 `key` 随机淘汰
- `volatile-ttl`: 有过期时间的 `key` ，淘汰最早过期
- `noeviction`: 永不过期，返回错误

#### 过期策略

- `惰性清除`
>无论键是否过期，每次取值时判断，过期立即删除
- `定时清除`
>设置键过期时间设置一个定时器，过期时间来临时，执行删除
- `定期清除`
>每隔一段时间对库进行检查，过期立即删除

#### 延时队列实现

>利用 `zset` 类型，延时时间作为 `Score`, 使用 `zrangebyscore` 命令查找前一段时间内元素即可


#### tips

- > `keys` 匹配键时会造成阻塞，可以考虑使用 `scan` 无阻塞的取出元素，但是结果集需要进行去重操作
- > `Redis` 事务是不支持回滚的
- > `pub /sub` 模式会因消费者下线丢失数据
