
## Redis

一个高性能的key-value数据库，REmote Dictionary Server(Redis)

**基本的数据结构**

* String :字符串
* Hash : 散列
* List : 列表
* Set : 集合
* Sorted Set : 有序集合

### Redis简介

Redis是完全开源免费的，遵守BSD协议，是一个高性能的key-value数据库 

* Redis支持数据的持久化，可以将内存中的数据保存在磁盘中，重启的时候可以再次加载进行使用
* Redis不仅支持简单的key-value类型的数据，同时还提供list、set、zset、hash等数据结构的存储
* Redis支持数据的备份，即master-slave模式的数据备份

### Redis优势

* 性能极高，Redis能读的速度是110000次/s,写的速度是81000次/s
* 丰富的数据类型-Redis支持二进制案例的Strings,Lists,Hashes,Sets及Ordered Sets数据类型操作
* 原子：Redis的所有操作都是原子性的，意思就是要么成功执行要么完全失败不执行，单个操作是原子性的，多个操作也支持事务，即原子性，通过MULTI和EXEC指令包起来
* 丰富的特性-Redis还支持publish/subcribe，通知，key，过期等等特性

### Redis配置

Redis的配置文件位于Redis安装目录下，文件名为redis.conf，也可以通过CONFIG命令查看或设置配置项

### Redis数据类型

* String (字符串)

string是redis最基本的类型，一个key对应一个value，string类型是二进制安全的，意思是redis的string可以包含任何数据，最大存储512MB

```redis
SET name "dugu"
GET name
```

* Hash (哈希)

Redis hash是一个键值(key >= value)对集合
Redis hash是一个string类型的field和value的映射表，hash特别适合用于存储对象

```redis
HMSET myhash field1 "hello" field2 "world"
HGET myhash field1
HGET myhash field2
```

* List (列表)

Redis列表是简单的字符串列表。按照插入顺序排序，可以添加一个元素到列表的头部或者尾部
列表最多能存储2的32次方减1个元素

```redis
lpush dugu redis
lpush dugu mogo
lpush dugu lalala
lrange dugu 0 10
```

* Set (集合)

Redis的Set是string类型的无序集合。集合是通过哈希表实现的，所以添加，删除，查找的复杂度都是O(1). sadd命令添加一个string元素到key对应的set集合中，成功返回1，如果元素已经在集合中返回0，如果key对应的set不存在则返回错误。

```redis
sadd dugu redis
sadd dugu mogo
sadd dugu rabitmq
sadd dugu rabitmq
smembers dugu
```

* zset(sorted set:有序集合)

Redis zset和set一样也是string类型元素的集合，且不允许重复的成员。不同的是每个元素都会关联一个double类型的分数。redis正式通过分数来为集合中的成员进行从小到大的排序。zset的成员是唯一的，但分数(score)却可以重复

```redis 
zadd dugu 0 redis 
zadd dugu 0 mogo 
zadd dugu 0 rabitmq 
zadd dugu 0 rabitmq 
ZRANGEBYSCORE dugu 0 1000 
``` 

### Redis命令

Redis命令用于在redis服务上执行操作。要在redis服务上执行命令需要一个redis客户端。Redis客户端在我们之前下载的redis的安装包中

**语法**
```redis
$ redis-cli
```

**在远程服务上执行命令**
```redis
$ redis-cli -h host -p port -a password
```

实例
```redis
$redis-cli -h 127.0.0.1 -p 6379 -a "mypass"
redis 127.0.0.1:6379>
redis 127.0.0.1:6379> PING
PONG
```

### Redis 键(key)
```
COMMAND KEY_NAME
SET dugu_key redis
DEL dugu_key
```

* DEL key | 该命令用于在key存在时删除key
* DUMP key | 序列化给定key，并返回被序列化的值
* EXISTS key | 检查给定key是否存在
* EXPIRE key seconds | 为给定key设置过期时间，以秒计
* EXPIRE key timesstamp | 设置过期时间，unix时间戳
* EXPIRE key milliseconds | 为给定key设置过期时间，以毫秒计
* EXPIRE key milliseconds-timesstamp | 设置过期时间，unix时间戳，以毫秒计
* KEYS pattern | 查找所有符合给定模式(pattern)的key
* MOVE key db | 将当前数据库的key移动到给定的数据库db当中
* PERSIST key | 移除key的过期时间，key将保持永久
* PTTL key | 以毫秒为单位返回key的剩余的过期时间
* TTL key | 以秒为单位，返回给定key 的剩余生存时间
* RANDOMKEY | 从挡球an数据库中随机返回一个key
* RENAME key newkey | 修改key的名称
* RENAMENX key newkey | 仅当newkey不存在时，将key改名为newkey
* TYPE key | 返回key所存储的值的类型

### Redis 字符串 (String)

* SET key value | 设定指定key的值
* GET key | 获取指定key的值
* GETRANGE key start end | 返回key中字符串的子字符
* GETSET key value | 将给定key的值设为value，并返回key的旧值(old value)
* GETBIT key offset | 对key所存储的字符串值，获取指定偏移量上的位(bit)
* MGET key1 [key2..] | 获取所有(一个或多个)给定key的值
* SETBIT key offset value | 对key所存储的字符串值，设置或清除指定偏移量上的位(bit)
* SETEX key seconds value | 将值value关联到key，并将key的过期时间设为seconds (以秒为单位)
* SETNX key value | 只有在key不存在时设置key的值
* SETRANGE key offset value | 用value参数覆写给定key所存储的字符串值，从偏移量offset开始
* STRLEN key | 返回key所存储的字符串值的长度
* MSET key value [key value...] | 同时设置一个或多个key-value对
* MSETNX key value [key value...] | 同时设置一个或多个key-value对，当且仅当所有给定key都不存在
* PSETEX key milliseconds value | 这个命令和SETEX命令相似，但它以毫秒为单位设置key的生存时间，而不是像SETEX命令那样，以秒为单位
* INCR key | 将key中存储的数字值增一
* INCRBY key increment | 将key所存储的值加上给定的增量值 (increment)
* INCRBYFLOAT key increment | 将key所存储的值加上给定的浮点增量值 (increment)
* DECR key | 将key中存储的数字值减一
* DECRBY key decrement | key所存储的值减去给定的减量值 (decrement)
* APPEND key value | 如果key已经存在并且是一个字符串，APPEND命令将制定的value追加到该key原来值(value)的末尾

### Redis 哈希 (Hash) 

Redis hash是一个string类型的field和value的映射表，hash特别适合用于存储对象
Redis中每个hash可以存储2的32次方-1键值对(40多亿)

* HDEL key field1 [field2] | 删除一个或多个哈希表字段
* HEXIST key field | 查看哈希表key中，制定的字段是否存在
* HGET key field | 获取存储在哈希表中指定字段的值
* HGETALL key | 获取在哈希表中指定key的所有字段和值
* HINCRBY key field increment | 为哈希表key中的指定字段的整数值加上增量increment
* HINCRBYFLOAT key field increment | 为哈希表key中的指定字段的浮点数值加上增量increment
* HKEYS key | 获取所有哈希表中的字段
* HLEN key | 获取哈希表中字段的数量
* HMGET key field1 [field2] | 获取所有给定字段的值
* HMSET key field1 value1 [field2 value2] | 同时将多个field-value(域-值)对设置到哈希表key中
* HSET key field value | 将哈希表key中的字段field的值设为value
* HSETNX key field value | 只有在字段field不存在时，设置哈希表字段的值
* HVALS key | 获取哈希表中的所有值
* HSCAN key cursor [MATCH pattern] [COUNT count] | 迭代哈希表中的键值对

### Redis 列表 (List)

Redis列表是简单的字符串列表，按照插入顺序排序。可以添加一个元素到列表的头部或尾部,一个列表最多可以包含2的32次方减1个元素*(超过40亿个元素)

* BLPOP key1 [key2] timeout | 移出并获取列表的第一个元素，如果列表没有元素会阻塞列表直到等待超时或发现可弹出元素为止
* BRPOP key1 [key2] timeout | 移出并获取列表的最后一个元素，如果列表没有元素会阻塞直到等待超时或发现可弹出元素为止
* BRPOPLPUSH source destination timeout | 从列表中弹出一个值，将弹出元素插入到另外一个列表中并返回它；如果列表没有元素会阻塞列表直到等待超时或发现可弹出元素为止 
* LINDEX key index | 通过索引获取列表中的元素
* LINSERT key BEFORE|AFTER pivot value | 在列表的元素前或者后插入元素
* LLEN key | 获取列表长度
* LPOP key | 移出并获取列表的第一个元素
* LPUSH key value1 [value2] | 将一个或多个值插入到列表头部
* LPUSHX key value | 将一个值插入到已存在的列表头部
* LRANGE key start stop | 获取列表指定范围内的元素
* LREM key count value | 移除列表元素
* LSET key index value | 通过索引设置列表元素的值
* LTRIM key start stop | 对一个列表进行修剪(trim),就是说，让列表只保留指定区间内的元素，不在指定区间之内的元素都将被删除
* RPOP key | 移除列表的最后一个元素，返回值为移除的元素
* RPOPLPUSH source destination | 移除列表的最后一个元素，并将该元素添加到另一个列表并返回
* RPUSH key value1 [value2] | 在列表中添加一个或多个值
* RPUSHX key value | 为已存在的列表添加值

### Redis 集合 (Set)

Redis的Set是String类型的无序集合，集合成员是唯一的，意味着集合中不能出现重复的数据。
Redis中集合是通过哈希表实现的，所以添加，删除，查找的复杂度都是O(1),集合中最大的成员数为2的32次方减1 (每个集合可存储40多亿个成员)

* SADD key member1 [member2] | 向集合添加一个或多个成员
* SCARD key | 获取集合的成员数
* SDIFF key1 [key2] | 返回给定所有集合的差集
* SDIFFSTORE destination key1 [key2] | 返回给定所有集合的差集并存储在destination中
* SINTER key1 [key2] | 返回给定所有集合的交集
* SINTERSTORE destination key1 [key2] | 返回给定所有集合的交集并存储在destination中
* SISMEMBER key member | 判断member元素是否是集合key的成员 
* SMEMBERS key | 返回集合中的所有成员
* SMOVE source destination member | 将 member 元素从 source 集合移动到 destination 集合
* SPOP key | 移除并返回集合中的一个随机元素
* SRANDMEMBER key [count] | 返回集合中一个或多个随机数
* SREM key member1 [member2] | 移除集合中一个或多个成员
* SUNION key1 [key2] | 返回所有给定集合的并集
* SUNIONSTORE destination key1 [key2] | 所有给定集合的并集存储在 destination 集合中
* SSCAN key cursor [MATCH pattern] [COUNT count] | 迭代集合中的元素

### Redis 有序集合 (sorted set)

Redis有序集合和集合一样也是string类型元素的集合，且不允许重复的成员.不同的是每个元素都会关联一个double类型的分数。Redis正是通过分数来为集合中的成员进行从小到大的排序。有序集合的成员是唯一的，但分数score却可以重复。

集合是通过哈希表实现的，所以添加，删除，查找的复杂度都是O(1),集合中最大的成员数为2的32次方减1 (每个集合可存储40多亿个成员)

* ZADD key score1 member1 [score2 member2] 
* ZCARD key 
* ZCOUNT key min max 
* ZINCRBY key increment member 
* ZINTERSTORE destination numkeys key [key ...] 
* ZLEXCOUNT key min max 
* ZRANGE key start stop [WITHSCORES] 
* ZRANGEBYLEX key min max [LIMIT offset count] 
* ZRANGEBYSCORE key min max [WITHSCORES] [LIMIT] 
* ZRANK key member 
* ZREM key member [member ...] 
* ZREMRANGEBYLEX key min max 
* ZREMRANGEBYRANK key start stop 
* ZREMRANGEBYSCORE key min max 
* ZREVRANGE key start stop [WITHSCORES] 
* ZREVRANGEBYSCORE key max min [WITHSCORES] 
* ZREVRANK key member 
* ZSCORE key member 
* ZUNIONSTORE destination numkeys key [key ...] 
* ZSCAN key cursor [MATCH pattern] [COUNT count] 

### Redis HyperLogLog

HyperLogLog是用来做基数统计的算法，HyperLogLog的优点是，在输入元素的数量或者体积非常非常大时，计算基数所需的空间总是固定的、并且是很小的。

在Redis里面，每个HyperLogLog键只需要花费12KB的内存，就可以计算接近2^64个不同元素的基数，这和计算基数时，元素越多耗费内存就越多的集合形成鲜明对比

但是因为HyperLogLog只会根据输入元素来计算基数，而不会存储输入元素本身，所以HyperLogLog不能像集合那样，返回输入的各个元素

**基数**
比如数据集{1,3,7,5,7,8},那么这个数据集的基数集为{1,3,5,7,8},基数(不重复元素)为5.基数估计就是在误差可接受的范围内，快速计算基数

* PFADD key element [element...] | 添加指定元素到 HyperLogLog 中。
* PFCOUNT key [key...] | 返回给定 HyperLogLog 的基数估算值。
* PFMERGE destkey sourcekey [sourcekey...] | 将多个 HyperLogLog 合并为一个 HyperLogLog

### Redis发布订阅

Redis发布订阅是一种消息通信模式：发送者(pub)发送消息，订阅者(sub)接收消息

* PSUBSCRIME pattern [pattern...] | 订阅一个或多个符合给定模式的频道
* PUBSUB subcommand [argument [augument...]] | 查看订阅与发布系统状态。
* PUBLISH channel message | 将信息发送到指定的频道。
* PUBSUBSCRIBE [pattern [pattern...]] | 退订所有给定模式的频道。
* SUBSCRIBE channel [channel..] | 订阅给定的一个或多个频道的信息。
* UNSUBSCRIBE [channel [channel...]] | 指退订给定的频道。

### Redis事务

* 批量操作在发送EXEC命令前被放入队列缓存
* 收到EXEC命令后进入事务执行，事务中任意命令执行失败，其余的命令依然被执行
* 在事务执行过程，其他客户端提交的命令请求不会插入到事务执行命令序列中

一个事务，单个Redis命令的执行是原子性的,但Redis没有在事务上增加任何维持原子性的机制，所以Redis事务的执行并不是原子性的。事务可以理解为一个打包的批量执行脚本，但批量指令并非是原子化的操作，中间某条指令的失败不会导致前面已做指令的回滚，也不会造成后续的指令不做。

* DISCARD | 取消事务，放弃执行事务块内的所有命令。
* EXEC | 执行所有事务块内的命令。
* MULTI | 标记一个事务块的开始。
* UNWATCH | 取消 WATCH 命令对所有 key 的监视。
* WATCH key [key...] | 监视一个(或多个) key ，如果在事务执行之前这个(或这些) key 被其他命令所改动，那么事务将被打断。

### Redis脚本

Redis脚本使用Lua解释器来执行脚本。Redis2.6版本通过内嵌支持Lua环境。执行脚本的常用命令为EVAL

* EVAL script numkeys key [key...] arg [arg...] | 执行 Lua 脚本。
* EVALSHA script sha1 numkeys key [key...] arg [arg...] | 执行 Lua 脚本。
* SCRIPT EXISIS script [script...] | 查看指定的脚本是否已经被保存在缓存当中。
* SCRIPT FLUSH | 从脚本缓存中移除所有脚本。
* SCRIPT KILL | 杀死当前正在运行的 Lua 脚本。
* SCRIPT LOAD script | 将脚本 script 添加到脚本缓存中，但并不立即执行这个脚本。

### Redis连接

Redis连接命令主要是用于连接Redis服务

* AUTH password | 验证密码是否正确
* ECHO message | 打印字符串
* PING | 查看服务是否运行
* QUIT | 关闭当前连接
* SELECT index | 切换到指定的数据库

### Redis服务器

Redis服务器命令主要是用于管理redis服务

* BGREWRITEAOF | 异步执行一个 AOF（AppendOnly File） 文件重写操作
* BGSAVE | 在后台异步保存当前数据库的数据到磁盘
* CLIENT KILL [ip:port] [ID client-id] | 关闭客户端连接
* CLIENT LIST | 获取连接到服务器的客户端连接列表
* CLIENT GETNAME | 获取连接的名称
* CLIENT PAUSE timeout | 在指定时间内终止运行来自客户端的命令
* CLIENT SETNAME connection-name | 设置当前连接的名称
* CLUSTER SLOTS | 获取集群节点的映射数组
* COMMAND | 获取 Redis 命令详情数组
* COMMAND COUNT | 获取 Redis 命令总数
* COMMAND GETKEYS | 获取给定命令的所有键
* TIME | 返回当前服务器时间
* COMMAND INFO command-name [command-name] | 获取指定 Redis 命令描述的数组
* CONFIG GET parameter | 获取指定配置参数的值
* CONFIG REWRITE | 对启动 Redis 服务器时所指定的 redis.conf 配置文件进行改写
* CONFIG SET parameter value | 修改 redis 配置参数，无需重启
* CONFIG RESETSTAT | 重置 INFO 命令中的某些统计数据
* DBSIZE | 返回当前数据库的 key 的数量
* DEBUG OBJECT key | 获取 key 的调试信息
* DEBUG SEGFUALT | 让 Redis 服务崩溃
* FLUSHALL | 删除所有数据库的所有key
* FLUSHDB | 删除当前数据库的所有key
* INFO [section] | 获取 Redis 服务器的各种信息和统计数值
* LASTSAVE | 返回最近一次 Redis 成功将数据保存到磁盘上的时间，以 UNIX 时间戳格式表示
* MONITOR | 实时打印出 Redis 服务器接收到的命令，调试用
* ROLE | 返回主从实例所属的角色
* SAVE | 同步保存数据到硬盘
* SHUTDOWN [NOSAVE] [SAVE] | 异步保存数据到硬盘，并关闭服务器
* SLAEOF host port | 将当前服务器转变为指定服务器的从属服务器(slave server)
* SLOWLOG subcommand [argument] | 管理 redis 的慢日志
* SYNC | 用于复制功能(replication)的内部命令

### Redis数据备份与恢复

Redis **SAVE** 命令用于创建当前数据库的备份 

该命令将在redis安装目录中创建dump.rdb文件

**恢复数据**

如果要恢复数据，只需将备份文件(dump.rdb)移动到redis安装目录并启动服务即可。获取redis目录可以使用CONFIG命令，如下所示

**Bgsave**

创建redis备份文件也可以使用命令BGSAVE，该命令在后台执行

### Redis安全


