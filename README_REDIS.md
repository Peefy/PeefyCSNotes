
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
