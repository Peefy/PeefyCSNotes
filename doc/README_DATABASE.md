## 数据库

### MySQL

MySQL是最流行的关系型数据库管理系统

数据库(Database)是按照数据结构来组织、存储和管理数据的仓库

每个数据库都有一个或多个不同API用于创建、访问、管理和复制所保存的数据

当然数据量较小时，也可以将数据保存于文件中，但是文件的读写速度较慢

RDBMS即关系型数据库管理系统(Ralational Database Management System)的特点:

* 数据以表格的形式出现
* 每行为各种记录名称
* 每列为记录名称所对应的数据域
* 许多的行和列组成一张表单
* 若干的表单组成database

### RDBMS 术语

* 数据库 ：数据库是一些关联别的集合
* 数据表 ：表是数据的矩阵，在一个数据库中的表看起来像一个简答的电子表格
* 列 ：一列(数据元素)包含了相同的数据，例如邮政编码的数据
* 行 ：一行(=元组,或记录)是一组相关的数据
* 冗余 ：存储两倍数据，冗余会降低性能，但是提高了数据的安全性
* 主键 ：主键是唯一的。一个数据表中智能包含一个主键，可以使用主键来查询数据
* 外键 ：外键用于关联两个表
* 复合键 ：复合键(组合键)将多个列作为一个索引键
* 索引 ：使用索引可快速访问数据库中表的特定信息。索引是对数据库表中一列或多列的值进行排序的一种结构，类似书籍的目录
* 参照完整性 ：参照完整性要求关系中不允许引用不存在的实体。与实体完整性是关系模型必须满足的完整性约束条件，目的是保证数据的一致性

### 管理MySQL的命令
```sql
USE '数据库名字'; 
```
> 选择要操作的Mysql数据库，使用该命令后所有Mysql命令都只针对该数据库
```sql
SHOW DATABASE; 
```
> 列出MySQL数据库管理系统的数据库列表
```sql
SHOW TABLES;
```
> 显示指定数据库的所有表，使用该命令前需要使用use命令来选择要操作的数据库
```sql
SHOW COLUMNS FROM 数据表;
```
> 显示数据表的属性，属性类型，主键信息，是否为NULL,默认值等其他信息
```sql
SHOW INDEX FROM 数据表; 
```
> 显示数据表的详细索引信息
```sql
SHOW TABLE STATUS LIKE FROM 'db_name' LIKE 'pattern';
```
> 输出MySQL数据库管理系统的性能及统计信息

注意：*sqL语句后面写分号；*

### MySQL连接
```php
mysql_connect(host, username, password, dbname, port, socket)
```
> host:主机名；username：用户名；password：密码；dbname：使用的数据库；port：MySQL服务器的端口号；socket：pipe

### MySQL 创建数据库
```sql
CREATE DATABASE '数据库名';
```
### MySQL 删除数据库
```sql
drop DATABASE '数据库名';
```
### MySQL 选择数据库
```sql
USE '数据库名字';
```
### MySQL 数据类型

数据类型分为三类：数值、日期/时间、字符串类型

* 数值类型

类型|大小|范围(有符号)|范围(无符号)|用途
---|---|---|---|---
TINYINT|1字节|(-128-127)|(0,255)|小整数值
SMALLINT|2字节|(-32768-32767)|(0,65535)|大整数值
MEDIUMINT|3字节|(-8388608-8388607)|(0,16777215)|大整数值
INT|4字节|(-2 147 483 648, 2 147 483 647)|(0，4 294 967 295)|大整数值
BIGINT|8字节|(-9,223,372,036,854,775,808, 9 223 372 036 854 775 807)|(0, 18 446 744 073 709 551 615)|极大整数值
FLOAT|4字节|(-3.402 823 466 E+38，-1.175 494 351 E-38)，0，(1.175 494 351 E-38，3.402 823 466 351 E+38)|0，(1.175 494 351 E-38，3.402 823 466 E+38)|单精度浮点数值
DOUBLE|8字节|(-1.797 693 134 862 315 7 E+308，-2.225 073 858 507 201 4 E-308)，0，(2.225 073 858 507 201 4 E-308，1.797 693 134 862 315 7 E+308)|0，(2.225 073 858 507 201 4 E-308，1.797 693 134 862 315 7 E+308)|双精度浮点数值
DECIMAL|DECIMAL(M,D) ，如果M>D，为M+2否则为D+2|依赖于M和D的值|依赖于M和D的值|小数值

* 日期、时间

类型|大小(字节)|范围|格式|用途
---|---|---|---|---
DATE|3|	1000-01-01/9999-12-31|YYYY-MM-DD|日期值
TIME|3| '-838:59:59'/'838:59:59'|HH:MM:SS|时间值或持续时间
YEAR|1|1901/2155|YYYY|年份值
DATETIME|8|	1000-01-01 00:00:00/9999-12-31 23:59:59|YYYY-MM-DD HH:MM:SS|混合日期和时间值
TIMESTAMP|4|1970-01-01 00:00:00/2038
结束时间是第 2147483647 秒，北京时间 2038-1-19 11:14:07，格林尼治时间 2038年1月19日 凌晨 03:14:07|YYYYMMDD HHMMSS|混合日期和时间值，时间戳

* 字符串

类型|大小|用途
---|---|---
CHAR|0-255字节|定长字符串
VARCHAR|0-65535 字节|变长字符串
TINYBLOB|0-255字节|不超过255个字符的二进制字符串
TINYTEXT|0-255字节|短文本字符串
BLOB|0-65 535字节|二进制形式的长文本数据
TEXT|0-65 535字节|长文本数据
MEDIUMBLOB|0-16 777 215字节|二进形式中的中等长度文本数据
MEDIUMTEXT|	0-16 777 215字节|中等长度文本数据
LONGBLOB|0-4 294 967 295字节|二进制形式的极大文本数据
LONGTEXT|0-4 294 967 295字节|极大文本数据

CHAR 和 VARCHAR 类型类似，但它们保存和检索的方式不同。它们的最大长度和是否尾部空格被保留等方面也不同。在存储或检索过程中不进行大小写转换。

BINARY 和 VARBINARY 类似于 CHAR 和 VARCHAR，不同的是它们包含二进制字符串而不要非二进制字符串。也就是说，它们包含字节字符串而不是字符字符串。这说明它们没有字符集，并且排序和比较基于列值字节的数值值。

BLOB 是一个二进制大对象，可以容纳可变数量的数据。有 4 种 BLOB 类型：TINYBLOB、BLOB、MEDIUMBLOB 和 LONGBLOB。它们区别在于可容纳存储范围不同。

有 4 种 TEXT 类型：TINYTEXT、TEXT、MEDIUMTEXT 和 LONGTEXT。对应的这 4 种 BLOB 类型，可存储的最大长度不同，可根据实际情况选择。

### MySQL 创建数据表

创建MySQL数据表需要以下信息：
* 表名
* 表字段名
* 定义每个表字段
通用语法：
* CREATE TABLE 'table_name' (column_name column_type);

如：
```sql
CREATE TABLE IF NOT EXISTS `dugu_table` (
    `id` INT UNSIGNED AUTO_INCREMENT,
    `title` VARCHAR(100) NOT NULL,
    `author` VARCHAR(40) NOT NULL,
    `date` DATE,
    PRIMARY KEY (`id`)
)ENGINE=InnoDB DEFAULT CHARSET=utf8;
```

* 如果不想字段为NULL,可以设置字段的树形为NOT NULL,在操作数据库时如果输入该字段的数据为NULL,就会报错
* AUTO_INCREMENT 定义为列为自增的属性，一般用于主键，数值会自动加1
* PRIMARY KEY关键字用于定义列为主键。可以使用多列来定义主键，列见以逗号分隔
* ENGINE 设置存储引擎
* CHARSET 设置编码

### MySQL 删除数据表

* 删除整个表
```sql
DROP TABLE '表名'
```

* 删除表内数据使用delete;
```sql
delete from '表名' where '删除条件';
```
如：
```sql
delete from students where s_name = "";
```
注意：*只是删除，不会释放空间(不论是InnoDB还是MyISAM)，delete from 表以后虽然未释放磁盘空间，但是下次插入数据的时候，仍然可以使用这部分空间。*

* 清除表内数据，保存表的结构(*相当于清空数据，但是表不删除*)
```sql
truncate table '表名';
```
注意：*只是删除，不会释放空间(不论是InnoDB还是MyISAM)*

* delete后使用如下操作可以释放空间
```sql
optimize table '表名'
```

### MySQL 插入数据

```sql
INSERT INTO '表名' ('field1', 'field2',... 'fieldN') VALUES ('value1', 'value2',... 'valueN');
```
如：
```sql
INSERT INTO table
    -> (title, author, date)
    -> VALUES
    -> ("title", "author", 'NOW()');
```

注释：NOW()是一个MySQL函数，该函数返回日期和时间,

### MySQL 查询数据

```sql

SELECT 'column_name', 'column_name' 
FROM 'table_name'
[WHERE condition1 [AND [OR]] condition2.....
[LIMIT N][OFFSET N];

```

* 查询语句中可以使用一个或者多个表，表之间用逗号(,)分隔，并使用WHERE语句来设定查询条件
* SELECT 命令可以读取一条或者多条记录
* 可以使用星号(*)来代替其他字段,SELECT局域会返回表的所有字段数据
* 可以使用WHERE语句来包含任何条件
* 可以使用LIMIT属性来设定返回的记录数据
* 通过OFFSET制定SELECT语句开始查询的数据偏移量,默认情况下偏移量为0

### MySQL WHERE 子句

WHERE 类似于程序语言中的if条件，可以使用AND和OR连接，可以用于SELECT,DELETE,UPDATE
使用BINARY指定是否区分大小写

```sql

SELECT * from runoob_tbl WHERE BINARY runoob_author='RUNOOB.COM';

```

注意：是否等于使用一个等于号=,不是两个等于==

### MySQL UPDATE 查询

```sql

UPDATE 'table_name' SET field1 = new_value1, field2 = new_value2 WHERE conditions;

```

如：
```sql

update students_table set age = age + 1 WHERE age > 13;

```

```sql

UPDATE dugu_table SET title = REPLACE(runoob_title, 'C++', 'Python') where 
id = 3;

```

```sql

update students set name = "小明", age = 19 where tel = "13288097888";

```

### MySQL DELETE 语句

```sql

DELETE FROM 'table_name' WHERE conditions;

```

注意：*如果没有指定WHERE子句，MySQL表中的所有记录将被删除，可以在WHERE子句中指定任何条件，可以在单个表中一次性删除记录*

如：
```sql

DELETE FROM table WHERE tb_id = 3;

```

```sql

delete from students where age < 20;

```

delete、drop、truncate都有删除表的作用，区别如下：
* delete和truncate仅删除表的数据，drop连表数据和表结构一起删除
* delete是DML语句，操作完之后可以回滚；truncate和drop是DDL语句，操作完不能回滚
* 执行速度：drop > truncate > delete

### MySQL LIKE 子句

WHERE语句实现固定条件判断，LIKE语句实现类似正则表达式的模式匹配，如获取某字符串字段含均有"COM"的列数据

SQL LIKE 子句中使用百分号%字符来表示任意字符，类似UNIX或正则表达式中的*号，如果没有使用百分号%,LIKE子句与等号=的效果是一样的

```sql

SELECT field1, field2,... fieldN
FROM table_name
WHERE field1 LIKE condition [AND [OR]] field2 = 'somevalue';

```

* 可以在WHERE子句中指定任何条件
* 可以在WHERE子句中使用LIKE子句
* 可以使用LIKE子句代替等号=
* LIKE通常与%一同使用，类似于一个元字符的搜索
* 可以使用AND或者OR指定一个或多个条件
* 可以在DELETE或UPDATE命令中使用WHERE...LIKE子句来指定条件

如：
```sql

SELECT dugu_id from tbl WHERE dugu_name LIKE '%COM';

```

LIKE语句实现 匹配/模糊匹配：
* '%a'      `以a结尾的数据`
* 'a%'      `以a开头的数据`
* '%a%'     `含有a的数据`
* '\_a\_'   `三位且中间字母是a的`
* '\_a%'    `两位且结尾字母是a的`
* 'a\_%'    `两位且开头字母是a的`

### MySQL UNION

MySQL UNION操作符用于连接两个以上的SELECT语句的结果组合到一个结果集合中。多个SELECT语句会删除重复的数据

select ... union select ...

```sql

SELECT expression1, expression2,... expression_n
FROM tables
[WHERE conditions]
UNION [ALL | DISTINCT]
SELECT expression1, expression2,... expression_n
FROM tables
[WHERE conditions];  

```

参数：
* expression1, expression2,... expression_n 要检索的列
* tables: 要检索的数据库
* WHERE conditions: 可选，检索条件
* DISTINCT: 可选，删除结果集中重复的数据。默认情况下UNION操作符已经删除了重复数据，所以DISTINCT修饰符对结果没啥影响
* ALL: 可选，返回所有结果集，包含重复数据

如：
```sql

SELECT country FROM Websites
UNION ALL
SELECT country FROM apps
ORDER BY country;

```

```sql

SELECT country, duguname FROM Websites
WHERE country = 'CN'
UNION DISTINCT
SELECT country, appname FROM apps
WHERE country = 'CN'
ORDER BY country;

```

### MySQL 排序

如果需要对数据库中读取的数据进行排序，就使用ORDER BY子句设定想按哪个字段哪种方式来进行排序，再返回搜索结果

```sql

SELECT field1, field2,... fieldN table_name1, table_name2...
ORDER BY field, [field2...] [ASC [DESC]]

```

* 可以使用任何字段作为排序的条件，从而返回排序后的查询结果
* 可以设定多个字段来排序
* 可以使用ASC或DESC关键字来设置查询结果是按升序还是降序
* 可以添加WHERE...LIKE子句来设置条件

如：
```sql

SELECT * from dugu_tbl ORDER BY sub_date ASC;

```

```sql

SELECT * from dugu_tbl WHERE age > 18 ORDER BY sub_date DESC;

```

> MySQL拼音排序:如果字符集采用的是gbk(汉字编码字符集),直接在查询语句后边添加ORDER BY:

```sql

SELECT * FROM dugu_table ORDER BY dugu_title;

```

> 如果字符集采用的是utf6(万国码),需要先对字段进行转码然后排序

```sql

SELECT * FROM dugu_table ORDER BY CONVERT(dugu_title using gbk);

```

### MySQL 分组

GROUP BY语句根据一个或多个列对结果集进行分组.
在分组的列上可以使用COUNT,SUM,AVG等函数

```sql

SELECT column_name, function(column_name)
FROM table_name
WHERE column_name `operator` value
GROUP BY column_name;

```

如：
```sql

SELECT coalesce(duguname, '总数'), COUNT(*) as sign_count FROM dugu_table GROUP BY duguname WITH ROLLUP

```

```sql

SELECT name ,sum(*)  FROM employee_tbl WHERE id<>1 GROUP BY name  HAVING sum(*)>5 ORDER BY sum(*) DESC;

```

### MySQL 连接的使用

之前的操作都是从一个表中读取数据，但是真正的应用中需要从多个数据表中读取数据

可以使用SELECT, UPDATE和DELETE语句中使用MySQL的JOIN来联合多表查询，JOIN按照功能大致分为如下三类：
* INNER JOIN(内连接,或等值连接)：获取两个表中字段匹配关系的记录
* LEFT JOIN(左连接)：获取左表所有记录，即使右表没有对应匹配的记录
* RIGHT JOIN(右连接)：与LEFT JOIN相反，用于获取右表所有记录，即使左表没有对应匹配的记录

```sql

SELECT a.id, a.author, b.count FROM dugu_tbl a INNER JOIN tcount_tbl b ON a.author = b.author;

```

等价于：

```sql

SELECT a.id a.author b.count FROM dugu_tbl a,
tcount b WHERE a.author = b.author;

```

LEFT JOIN 和 RIGHT JOIN

```sql

SELECT a.runoob_id, a.runoob_author, b.runoob_count FROM runoob_tbl a LEFT JOIN tcount_tbl b ON a.runoob_author = b.runoob_author;

```

```sql

SELECT a.runoob_id, a.runoob_author, b.runoob_count FROM runoob_tbl a RIGHT JOIN tcount_tbl b ON a.runoob_author = b.runoob_author;

```

LEFT JOIN、INNER JOIN、RIGHT JOIN的区别：
INNER JOIN可以理解为A与B两个集合的交集，LEFT JOIN可以理解为A与B两个集合的交集再与A的集合并集，RIGHT JOIN以理解为A与B两个集合的交集再与B的集合并集


### MySQL NULL值处理

当使用查询子句SELECT时，当提供的查询条件字段为NULL时，该命令可能就无法正常工作,为了处理这种情况，MySQL提供了三大运算符

* IS NULL : 当列的值是NULL,此运算符返回true
* IS NOT NULL : 当列的值不为NULL,运算符返回true
* <=> : 比较操作符(不同于=运算符)，当比较的两个值为NULL时返回true

关于NULL的条件比较运算符是比较特殊的。不能使用=NULL或者!=NULL在列中查找NULL值.

在MySQL中,NULL值与任何其他值的比较(即使是NULL)永远返回false,即NULL=NULL返回false,MySQL中处理NULL使用IS NULL和IS NOT NULL运算符

```sql

select *, columnName1 + ifnull(columnName1, 0) from tableName;

```

```sql
SELECT * FROM dugu_tbl WHERE dugu_count IS NULL;
```

### MySQL 正则表达式

MySQL除了可以通过LIKE ...% 来进行模糊匹配,也支持其他正则表达式的匹配,在MySQL中使用REGEXP操作符来进行正则表达式匹配

模式|描述
---|---
^|匹配输入字符串的开始位置。如果设置了RegExp对象的Multiline属性,^也匹配'\n'或'\r'之后的位置
$|匹配输入字符串的结束位置。如果设置了RegExp对象的Multiline属性,^也匹配'\n'或'\r'之前的位置
.|匹配除'\n'之外的任何单个字符。要匹配包括'\n'在内的任何字符,请使用象'[\.\n]'的模式
[\.\.\.]|字符集合。匹配所包含的任意一个字符
[^\.\.\.]|负值字符集合。匹配未包含的任意字符
p1\|p2\|p3|匹配p1或p2或p3
*|匹配前面的子表达式一次或者多次,等价于{0,}
+|匹配前面的子表达式一次或者多次,等价于{1,}
{n}|n是一个非负整数.匹配确定的n次
{n,m}|n和m均为非负整数,其中n<=m。最少匹配n次且最多匹配m次

实例：

* 查找name字段中以'st'为开头的所有数据:
```sql
SELECT names FROM dugu_table WHERE names REGEXP '^st';
```
* 查找name字段中以'ok'为结尾的所有数据:
```sql
SELECT names FROM dugu_table WHERE names REGEXP 'ok$';
```
* 查找name字段中包含'mar'字符串的所有数据:
```sql
SELECT names FROM dugu_table WHERE names REGEXP 'mar';
```
* 查找name字段中以元音字符开头或以'ok'字符串结尾的所有数据:
```sql
SELECT names FROM dugu_table WHERE names REGEXP '^[aeiou]|ok$';
```

### MySQL 事物

MySQL事物主要用于处理操作量大，复杂度高的数据。比如：在人员管理系统中，删除一个人员，即需要删除人员的基本资料，也要删除和该人员的相关信息，如信箱，文章等等，这样，这些数据库操作语句就构成一个事物

* 在MySQL中只有使用了Innodb数据库引擎的数据库表才支持事物
* 事务处理可以用来维护数据库的完整性，保证成批的SQL语句要么全部执行，要么全部不执行
* 事务用来管理insert,update,delete语句

一般来说,事物是必须满足4个条件(ACID):原子性(**A**tomicity,或称不可分割性)、一致性(**C**onsistency)、隔离性(**I**solation,又称独立性)、持久性(**D**urability)

* **原子性**：一个事务要么全部完成，要么全部不完成：在任何一个环节发生错误，就会回滚(Rollback)到事务开始前的状态，就像这个事务从来没有执行过一样
* **一致性**：在事务开始之前和事务结束以后，数据库的完整性没有被破坏
* **隔离性**：数据库允许多个并发事务同时对其数据进行读写和修改的能力。事务隔离分为不同级别，包括读未提交、读提交、可重复读和串行化
* **持久性**：事务处理结束后，对数据的修改就是永久的，即便系统故障也不会丢失

注意：*在MySQL命令行的默认设置下，事物都是自动提交的，即执行SQL语句后就会马上执行COMMIT操作。因此要显式地开启一个事务必须使用命令BEGIN或START TRANSACTION,或者执行命令SET AUTOCOMMIT=0,用来进制使用当前会话的自动提交*

事务控制语句:

* BEGIN或START TRANSACTION; 显式地开启一个事务
* COMMIT;也可以使用COMMIT WORK,不过二者是等价的。COMMIT会提交事务,并使已对数据进行的所有修改称为永久性的；
* ROLLBACK;有可以使用ROLLBACK WORK,不过二者是等价的。回滚会结束用户的事务，并赊销正在进行的所有未提交的修改；
* SAVEPOINT identifier: SAVEPOINT允许在事务中创建一个保存点，一个事务中有多个SAVEPOINT;
* RELEASE SAVEPOINT identifier; 删除一个事务的保存点，当没有指定的保存点时，执行该语句会抛出一个异常；
* ROLLBACK TO identifier；把事务回滚到标记点;
* SET TRANSACTION;用来设置事务的隔离级别。InnoDB存储引擎提供事务的隔离级别有READ UNCOMMITTED、READ COMMITTED、REPRATABLE READ 和 SERIALIZABLE

MySQL事务处理主要有两种方法：

1.用BEGIN,ROLLBACK,COMMIT来实现：
* BEGIN开始一个事务
* ROLLBACK事务回滚
* COMMIT事务确认
2.直接用SET来改变MySQL的自动提交模式；
* SET AUTOCOMMIT=0 禁止自动提交
* SET AUTOCOMMIT=1 开始自动提交

```sql

SET AUTOCOMIT = 0;
INSERT INTO dugutable (id) values(9);

```

### MySQL ALTER命令

当需要*修改数据表名*或者*修改数据表字段(增加，删除)*时,就需要使用到MySQL ALTER命令。

删除，添加或者修改表字段

如下命令使用了ALTER命令及DROP子句来删除以上创建表的i字段;

```sql

ALTER TABLE test_table DROP i;

```

注意：*如果数据库中只剩余一个字段则无法使用DROP来删除字段*

MySQL中使用ADD子句来向数据表中添加列，如下实例在表test_table中添加i字段，并定义数据类型

```sql

ALTER TABLE test_table ADD i INT;

```

执行以上命令以后，i字段会自动添加到数据表字段的末尾

如果要指定新增字段的位置，可以使用MySQL提供的关键字FIRST(设定为第一列),AFTER字段名(设定位于某个字段之后)。尝试以下ALTER TABLE语句，在执行成功后，使用SHOW COLUMNS查看表结构的变化

```sql

ALTER TABLE test_table DROP i;
ALTER TABLE test_table ADD i INT FIRST;
ALTER TABLE test_table DROP i;
ALTER TABLE test_table ADD i INT AFTER c;

```

如果需要修改字段类型及名称，可以在ALTER命令中使用MODIFY或CHANGE子句

```sql
ALTER TABLE test_table MODIFY c CHAR(10);
```

```sql
ALTER TABLE test_table CHANGE j j INT;
```

```sql

ALTER TABLE testalter_tbl 
    -> MODIFY j BIGINT NOT NULL DEFAULT 100;

```

修改数据表类型

```sql

ALTER TABLE test_table ENGINE = MYISAM

```

修改字段的相对位置

```sql

ALTER TABLE test_table modify 'name1' 'type1' first/after 'name2'

```

### MySQL 索引

MySQL索引的建立对于MySQL的高效运行是很重要的，索引可以大大提高MySQL的检索速度.

索引分为单列索引和组合索引。单列索引，一个索引只包含单个列，一个表可以有多个单列索引，但这不是组合索引。组合索引，即一个索引包含多个列。创建索引时，需要确保该索引是应用在SQL查询语句的条件（一般作为WHERE子句的条件）

实际上，索引也是一张表，该表保存了主键与索引字段，并指向实体表的记录。

过多的使用索引将会造成滥用，因此索引也会有它的缺点；虽然索引大大提高了查询速度，同时却会降低更新表的速度，如对表进行INSERT、UPDATE和DELETE.因为更新表时，MySQL不仅要保存数据，还要保存一下索引文件。

建立索引会占用磁盘空间的索引文件

**普通索引**

普通索引创建的方式：

* 直接创建

```sql

CREATE INDEX 'indexname' ON 'table_name(username(length))';

```

注意：*如果是CHAR，VARCHA类型,length可以小于字段实际长度；如果是BLOB和TEXT类型，必须指定length*

* 修改表结构(添加索引)

```sql
ALTER TABLE 'table_name' ADD INDEX indexName(columnName);
```

* 创建表的时候直接指定

```sql
CREATE TABLE mytable(
ID INT NOT NULL,
username VARCHAR(16) NOT NULL,
INDEX [indexName] username(length)
);
```

删除索引的语法：
```sql
DROP INDEX [indexName] ON mytable
```

**唯一索引**

与普通索引类似，不同的是：索引列的值必须唯一，但允许有空值。如果是组合索引，则列值的组合必须唯一。它有以下几种创建方式

创建唯一索引的方式：

* 直接创建

```sql

CREATE UNIQUE INDEX 'indexname' ON 'table_name(username(length))';

```

注意：*如果是CHAR，VARCHA类型,length可以小于字段实际长度；如果是BLOB和TEXT类型，必须指定length*

* 修改表结构(添加索引)

```sql
ALTER TABLE 'table_name' ADD UNIQUE indexName(columnName);
```

* 创建表的时候直接指定

```sql
CREATE TABLE mytable(
ID INT NOT NULL,
username VARCHAR(16) NOT NULL,
UNIQUE [indexName] username(length)
);
```

**使用ALTER命令添加和删除索引**

```sql
ALTER TABLE tbl_name ADD PRIMARY KEY (column_list); 
```
该语句添加一个主键，这意味着索引值必须是唯一的,且不能为NULL
```sql
ALTER TABLE tbl_name ADD UNIQUE index_name(column_list);
```
这条语句创建的索引的值必须是唯一的(除了NULL外,NULL可能会出现多次)
```sql
ALTER TABLE tbl_name ADD INDEX index_name(column_list);
```
添加普通索引，索引值可出现多次
```sql
ALTER TABLE tbl_name ADD FULLTEXT index_name(column_list);
```
该语句指定了索引为FULLTEXT，用于全文索引

如下实例为在表中添加索引
```sql
ALTER TABLE test_table ADD INDEX (c);
```
```sql
ALTER TABLE test_table DROP INDEX c;
```

**使用ALTER命令添加和删除主键**
```sql
ALTER TABLE test_table MODIFY i INT NOT NULL;
```
```sql
ALTER TABLE test_table DROP PRIMARY KEY;
```
**显示索引信息**
```sql
SHOW INDEX FROM table_name; \G
```

### MySQL 临时表

临时表只是在当前可见，当关闭连接时，MySQL会自动删除表并释放所有空间.

临时表在MySQL3.23版本中添加.

临时表语句是在正常建表建表语句中加入TEMPORARY

```sql

CREATE TEMPORARY TABLE dugu_table(
    product_name VARCHAR(50) NOT NULL,
    sales DECIMAL(12, 2) NOT NULL DEFAULT 0.00,
    price DECIMAL(12, 2) NOT NULL DEFAULT 0.00,
    sold INT UNSIGNED NOT NULL DEFAULT 0
);

```

当使用SHOW TABLES命令显示数据表列表时间，将无法看到创建的临时表

**删除MySQL临时表**

默认情况下，当断开与数据库的连接后，临时表就会自动被销毁，当然也可以执行语句来销毁临时表

```sql

DROP TABLE dugu_table;

```

### MySQL 复制表

如果我们需要完全的赋值MySQL的数据表，包括表的结构，索引，默认值等。
如果仅仅使用CREATE TABLE ...SELECT命令，是无法实现的

完整的复制MySQL数据表的步骤:
* 使用SHOW CREATE TABLE 命令获取创建数据表(CREATE TABLE)语句，该语句包含了原数据表的结构，索引等。
* 复制以下命令显示的SQL语句，修改数据表名，并执行SQL语句，通过以上命令将完全的复制数据表结构。
* 如果想复制表的内容，就可以使用INSERT INTO ... SELECT 语句来实现

```sql

SHOW CREATE TABLE dugu_table \G;

>>> Create Table: CREATE TABLE `dugu_table` (
  `runoob_id` int(11) NOT NULL auto_increment,
  `runoob_title` varchar(100) NOT NULL default '',
  `runoob_author` varchar(40) NOT NULL default '',
  `submission_date` date default NULL,
  PRIMARY KEY  (`runoob_id`),
  UNIQUE KEY `AUTHOR_INDEX` (`runoob_author`)
) ENGINE=InnoDB 
```

```sql

CREATE TABLE `copy_dugu_table` (
  `runoob_id` int(11) NOT NULL auto_increment,
  `runoob_title` varchar(100) NOT NULL default '',
  `runoob_author` varchar(40) NOT NULL default '',
  `submission_date` date default NULL,
  PRIMARY KEY  (`runoob_id`),
  UNIQUE KEY `AUTHOR_INDEX` (`runoob_author`)
) ENGINE=InnoDB; 

```

```sql

INSERT INTO copy_dugu_table (runoob_id,
    ->                        runoob_title,
    ->                        runoob_author,
    ->                        submission_date)
    -> SELECT runoob_id,runoob_title,
    ->        runoob_author,submission_date
    -> FROM runoob_tbl;

```

第二种完整复制表的方法
```sql

CREATE TABLE copy_dugu_table LIKE dugu_table;
INSERT INTO copy_dugu_table SELECT * FROM dugu_table

```

### MySQL 元数据

MySQL的三种信息:
* **查询结果信息**：SELECT, UPDATE或DELETE语句影响的记录数
* **数据库和数据表的信息**：包含了数据库及数据表的结构信息
* **MySQL**：包含了数据库服务器的当前状态，版本号等

在MySQL的命令提示符中，可以调用简单的语句或者以上服务器信息，但是如果使用Perl或者PHP等脚本语言，就需要调用特定的接口函数获取。
因为查询语句会影响数据库的记录数.

**数据库和数据表列表**

可以很容易地在MySQL服务器中获取数据库和数据表列表.如果没有足够的权限，结果将返回null.可以使用SHOW TABLES或SHOW DATABASES 语句来获取数据库和数据表列表。

**获取服务器元数据**

* SELECT VERSION() 服务器版本信息
* SELECT DATABASE() 当前数据库名
* SELECT USER() 当前用户名
* SHOW STATUS 服务器状态
* SHOW VARIABLES 服务器配置变量

### MySQL 序列使用

MySQL序列是一组整数：1,2,3...,由于一张数据表只能有一个字段自增主键,如果想实现其他字段也实现自动增加,就可以使用MySQL序列来实现

**使用AUTO_INCREMENT**

MySQL中最简单使用序列的方法就是使用MySQL AUTO_INCREMENT来定义列

**获取AUTO_INCREMENT**

在MySQL的客户端中可以使用SQL中的LAST_INSERT_ID()函数来获取最后的插入表中的自增列的值

**重置序列**

如果删除了数据表中的多条记录，并希望对剩下数的AUTO_INCREMENT列进行重新排列,那么你可以通过删除自增的列，然后重新添加来实现。不过该操作要非常小心,如果在删除的同时又有新纪录添加，有可能会出现数据混乱。

**设置序列的开始值**
```sql

CREATE TABLE dugu_table(
    id INT UNSIGNED NOT NULL AUTO_INCREMENT,
    PRIMARY KEY (id),
    dname VARCHAR(30) NOT NULL,
    ddate DATE NOT NULL,
    origin VARCHAR(30) NOT NULL
)engine=innodb auto_increment=100 charset=utf8;

```

```sql
ALTER TABLE dugu_table AUTO_INCREMENT = 100;
```

### MySQL 处理重复数据

有些MySQL数据表可能存在重复的记录，有些情况允许重复数据的存在，有时也需要删除这些重复的数据

**防止表中出现重复数据**

可以在MySQL数据表中设置指定的字段为PRIMARY KEY或者UNIQUE唯一索引来保证数据的唯一性,如果设置了唯一索引，那么在插入重复数据时,SQL语句将无法执行成功,并抛出错误.

如果想设置表中字段first_name,last_name 数据不能重复,可以设置双主键模式来设置数据的唯一,注意：*设置了主键的字段默认值不能为NULL*
```sql

CREATE TABLE person_table(
    first_name CHAR(20) NOT NULL,
    last_name CHAR(20) NOT NULL,
    sex CHAR(10),
    PRIMARY KEY (last_name, first_name)
);

```

```sql
CREATE TABLE person_table
(
   first_name CHAR(20) NOT NULL,
   last_name CHAR(20) NOT NULL,
   sex CHAR(10),
   UNIQUE (last_name, first_name)
);
```

**使用INSERT IGNORE INTO**

INSERT IGNORE INTO语句会忽略数据库已经存在的数据，如果数据库没有数据就插入新的数据，如果有数据的话就跳过这段数据

**统计重复数据**

以下实例将统计表中first_name和last_name的重复记录数
```sql
SELECT COUNT(*) as repetitions, last_name, first_name 
-> FROM person_table
-> GROUP BY last_name, first_name
-> HAVING repetitions > 1;
```

**过滤重复数据**
```sql
SELECT DISTINCT last_name, first_name FROM person_table;
```

**删除重复数据**
```sql
CREATE TABLE tmp SELECT last_name, first_name, sex FROM person_table GROUP BY (last_name, first_name, sex);

DROP TABLE person_table;

ALTER TABLE tmp RENAME TO person_table;

```

**向已有的表中添加INDEX(索引)和PRIMARY KEY(主键)**
```sql
ALTER INGORE TABLE person_table
-> ADD PRIMARY KEY (last_name, first_name)
```

### MySQL SQL注入

如果通过网页获取用户输入的数据并将其插入一个MySQL数据库,那么就有可能发生SQL注入安全的问题.可以通过脚本来过滤SQL中注入的字符

SQL注入，就是通过把SQL命令插入到Web表单递交或输入域名或页面请求的查询字符串，最终达到欺骗服务器执行恶意的SQL命令

防止SQL注入的要点
* 1.对用户的输入进行校验：正则表达式、限制长度；对单引号和双“-”进行转换等
* 2.不使用动态拼装sql,可以使用参数化的sql或者直接使用存储过程进行数据查询存取
* 3.不要使用管理员权限的数据连接，为每个应用使用单独的权限有限的数据库连接
* 4.不要把机密信息直接存放，加密或者hash掉密码和敏感的信息.
* 5.应用的异常信息应该该处尽可能少的提示，最好使用自定义的错误信息对原始错误信息进行包装
* 6.sql注入的检测方法一般采用辅助软件或网站平台来检测，软件一般采用sql注入检测工具jsky,网站平台就有亿思网站安全平台检测工具。MDCSOFT SCAN等。采用MDCSOFT-IPS可以有效的防御SQL注入，XSS攻击等。

**防止SQL注入**

在脚本语言中，可以对用户输入的数据进行转义从而来放置SQL注入

**Like语句中的注入**

like查询时，如果用户输入的值有\_和\%，则会出现如下情况：

> 用户本来只是想查询"abcd\_",查询结果中却有“abcd\_”,"abcde","abcdf"等等,用户要查询“30%”（注：百分之三十）时也会出现问题

### MySQL 导出数据

使用SELECT...INTO OUTFILE语句来简单地导出数据到文本文件上

```sql
SELECT * FROM dugu_table INTO OUTFILE '/tmp/dugu.txt'
```

可以通过命令行选项来设置数据输出的指定格式，以下实例为导出CSV格式

```sql
SELECT * FROM passwd INTO OUTFILE '/tmp/runoob.txt'
    -> FIELDS TERMINATED BY ',' ENCLOSED BY '"'
    -> LINES TERMINATED BY '\r\n';
```

在下面的例子中，生成一个文件，各值用逗号隔开。这种格式可以被许多程序使用

```sql
SELECT a,b,a+b INTO OUTFILE 'tmp/dugu.txt'
FIELDS TERMINATED BY ',' OPTIONALLY ENCLOSED BY '"'
LINES TERMINATED BY '\n'
FROM test_table;
```

**SELECT...INTO OUTFILE的属性**

* LOAD DATA INFILE是SELECT...INTO OUTFILE的逆操作，SELECT句法。为了将一个数据库的数据写入一个文件，使用SELECT...INTO OUTFILE,为了将文件读回数据库，使用LOAD DATA INFILE
* SELECT...INTO OUTFILE 'file_name'形式的SELECT可以把被选择的行写入一个文件中,该文件被创建到服务器主机上，因此必须拥有FILE权限，才能使用此语法
* 输出不能是一个已存在的文件，放置文件数据被篡改
* 需要有一个登陆服务器的账号来检索文件。否则SELECT...INTO OUTFILE不会起任何作用
* 在UNIX中，该文件被创建后是可读的，权限由MySQL服务器所拥有。虽然你可以读取该文件，但可能无法将其删除

**导出表作为原始数据**
mysqldump是mysql用于转存数据库的实用程序。主要生产一个SQL脚本，其中包含从头重新创建数据库所必需的命令CREATE TABLE INSERT等

### MySQL 导入数据

几种简单的MySQL导出的数据的命令:
* 1.mysql命令导入
```sql
# mysql -uroot -p123456 < dugu.sql
```
* 2.source命令导入
```sql
create database abc;
use abc;
set names utf8;
source /home/abc/abc.sql;
```
* 3.使用LOAD DATA导入数据
```sql
LOAD DATA LOCAL INFILE 'dump.txt' INTO TABLE mytbl;
```

```sql
LOAD DATA LOCAL INFILE 'dump.txt' INTO TABLE mytbl
  -> FIELDS TERMINATED BY ':'
  -> LINES TERMINATED BY '\r\n';
```

* 4.使用mysqliimport导入数据
mysqlimport客户端提供了LOAD DATA INFILEQL语句的一个命令行接口。mysqlimport的大多数选项直接对应LOAD DATA INFILE子句。

从文件dump.txt中将数据导入到mytbl数据表中,可以使用以下命令
```
mysqlimport -u root -p --local data_base dump.txt
```

```
mysqlimport -u root -p --local --columns=b,c,a \
    database_name dump.txt
```

### MySQL 函数

字符串函数、数字函数、日期函数、高级函数、

转自菜鸟教程
[http://www.runoob.com/mysql/mysql-functions.html]

### MySQL 运算符

算术运算符、比较运算符、逻辑运算符、位运算符

转自菜鸟教程
[http://www.runoob.com/mysql/mysql-operator.html]

## Redis

[笔记](https://github.com/Peefy/PeefyCSNotes/blob/master/doc/README_REDIS.md)

## 数据库问答

**1. MySQL的端口号是多少，如何修改这个端口号**

* 登录mysql 
```sql
mysql -uroot -p
mysql> show global variables like 'port'
```

修改端口，编辑/etc/my.cnf文件，早期版本有可能是my.conf文件名，增加端口参数，并且设定端口，注意该端口未被使用，保存退出。

**2. 数据库事务以及四个特性**

* **原子性（Atomicity）**-原子性是指事务包含的所有操作要么全部成功，要么全部失败回滚，这和前面两篇博客介绍事务的功能是一样的概念，因此事务的操作如果成功就必须要完全应用到数据库，如果操作失败则不能对数据库有任何影响。
* **一致性（Consistency）**-一致性是指事务必须使数据库从一个一致性状态变换到另一个一致性状态，也就是说一个事务执行之前和执行之后都必须处于一致性状态。
* **隔离性（Isolation）**-隔离性是当多个用户并发访问数据库时，比如操作同一张表时，数据库为每一个用户开启的事务，不能被其他事务的操作所干扰，多个并发事务之间要相互隔离。
* **持久性（Durability）**-持久性是指一个事务一旦被提交了，那么对数据库中的数据的改变就是永久性的，即便是在数据库系统遇到故障的情况下也不会丢失提交事务的操作。

**3. 数据库的三大范式**

* **第一范式**-每一列属性都是不可再分的属性值，确保每一列的原子性，两列的属性相近或相似或一样，尽量合并属性一样的列，确保不产生冗余数据。
* **第二范式**-每一行的数据只能与其中一列相关，即一行数据只做一件事。只要数据列中出现数据重复，就要把表拆分开来。
* **第三范式**-数据不能存在传递关系，即没个属性都跟主键有直接关系而不是间接关系。像：a-->b-->c  属性之间含有这样的关系，是不符合第三范式的。

**4. 数据库的ACID特性**

数据库事务必须具备ACID特性，ACID是Atomic（原子性）、Consistency（一致性）、Isolation（隔离性）和Durability（持久性）的英文缩写。

* **原子性（Atomicity）**-原子性是指事务包含的所有操作要么全部成功，要么全部失败回滚，这和前面两篇博客介绍事务的功能是一样的概念，因此事务的操作如果成功就必须要完全应用到数据库，如果操作失败则不能对数据库有任何影响。
* **一致性（Consistency）**-一致性是指事务必须使数据库从一个一致性状态变换到另一个一致性状态，也就是说一个事务执行之前和执行之后都必须处于一致性状态。
* **隔离性（Isolation）**-隔离性是当多个用户并发访问数据库时，比如操作同一张表时，数据库为每一个用户开启的事务，不能被其他事务的操作所干扰，多个并发事务之间要相互隔离。
* **持久性（Durability）**-持久性是指一个事务一旦被提交了，那么对数据库中的数据的改变就是永久性的，即便是在数据库系统遇到故障的情况下也不会丢失提交事务的操作。

**5. 数据库索引**

索引是对数据库表中一列或多列的值进行排序的一种结构，使用索引可快速访问数据库表中的特定信息。如果想按特定职员的姓来查找他或她，则与在表中搜索所有的行相比，索引有助于更快地获取信息。

**6. 数据库事务**

数据库事务（简称：事务）是数据库管理系统执行过程中的一个逻辑单位，由一个有限的数据库操作序列构成。

一个数据库事务通常包含了一个序列的对数据库的读/写操作。它的存在包含有以下两个目的：

* 为数据库操作序列提供了一个从失败中恢复到正常状态的方法，同时提供了数据库即使在异常状态下仍能保持一致性的方法。
* 当多个应用程序在并发访问数据库时，可以在这些应用程序之间提供一个隔离方法，以防止彼此的操作互相干扰。

**7. 数据库事务隔离**

如果事务不隔离会出现脏读、不可重复读、幻读等情况

* **读未提交（Read Uncommitted）**-就是可以读到未提交的内容。如无特殊情况，基本是不会使用这种隔离级别的。
* **读提交（Read Committed）**-就是只能读到已经提交了的内容。这是各种系统中最常用的一种隔离级别，也是SQL Server和Oracle的默认隔离级别。这种隔离级别能够有效的避免脏读，但除非在查询中显示的加锁，避免“脏读”，但是可能出现“不可重复读”和“幻读”。
* **可重复读(Repeated Read)**-就是专门针对“不可重复读”这种情况而制定的隔离级别，自然，它就可以有效的避免“不可重复读”。而它也是MySql的默认隔离级别。在这个级别下，普通的查询同样是使用的“快照读”，但是，和“读提交”不同的是，当事务启动时，就不允许进行“修改操作（Update）”了.避免出现“脏读”、“不可重复读”，但是可能出现“幻读”。
* **串行化（Serializable）**-这是数据库最高的隔离级别，这种级别下，事务“串行化顺序执行”，也就是一个一个排队执行。这种级别下，“脏读”、“不可重复读”、“幻读”都可以被避免，但是执行效率奇差，性能开销也最大

**8. inner join和left join**

* **left join(左联接)**-返回包括左表中的所有记录和右表中联结字段相等的记录
* **right join(右联接)**-返回包括右表中的所有记录和左表中联结字段相等的记录
* **inner join(等值连接)**-只返回两个表中联结字段相等的行

**9. 数据库事物的一致性**

事务是指由一系列数据库操作组成的一个完整的逻辑过程，这个过程中的所有操作要么都成功，要么都不成功。

一致性(consistency): 指的是逻辑上的一致性，即所有操作是符合现实当中的期望的。

* **内部一致性**-修改丢失：丢失修改是事务A和B先后更改数据数据x（假设初始是x0)，但是在A未正式更改前，B已经读取了原先的数据x0，最后A更改后为x1，B更改的并不是A更新后的x1，而是更改的x0，更改后假设为x2，这时x2将x1覆盖了，相当于事务A针对x的更改丢失了。脏读： 事务T1读取了T2更改的x，但是T2在实际存储数据时可能出错回滚了，这时T1读取的实际是无效的数据，这种情况下就是脏读。不可重复读：是说在T1读取x时，由于中间T2更改了x，所以T1前后两次读取的x值不相同，这就是所谓的不可重复读。幻读：在T1读取符合某个条件的所有记录时，T2增加了一条符合该条件的记录，这就导致T1执行过程中前后读取的记录可能不一致，即T2之后读取时会多出一条记录。
* **外部一致性**-强一致性：指系统中的某个数据被成功更新后，后续任何对该数据的读取操作都将得到更新后的值。弱一致性：弱一致性是相对于强一致性而言，它不保证总能得到最新的值；最终一致性：是弱一致性的特殊形式，即保证在没有新的更新的条件下，经过一段“不一致时间窗口”，最终所有的访问都是最后更新的值。最常见的是DNS服务，更新域名指向的机器后，多级缓存要等到expiration time的时候才会更新，但是随着时间的推移，最终数据会趋于一致。

**10. 索引是什么，多加索引一定会好吗**

索引是对数据库表中一列或多列的值进行排序的一种结构，使用索引可快速访问数据库表中的特定信息。如果想按特定职员的姓来查找他或她，则与在表中搜索所有的行相比，索引有助于更快地获取信息。

索引的级数越多，访问速度不一定越快。像是字典的目录结构一样，目录比字典内容还多。

关于索引的使用要注意几个事项 :

* 首先数据量小的表不需要建立索引,因为小的表即使建立索引也不会有大的用处,还会增加额外的索引开销
* 不经常引用的列不要建立索引,因为不常用,即使建立了索引也没有多大意义
* 经常频繁更新的列不要建立索引,因为肯定会影响插入或更新的效率
* 索引并不是一劳永逸的,用的时间长了需要进行整理或者重建

**11. k-v存储中，key有哪些要求？**

字符串类型，可以求其hash值

**12. 介绍数据库中的WAL技术**

WAL的全称是Write Ahead Logging，它是很多数据库中用于实现原子事务的一种机制

WAL机制的原理是：修改并不直接写入到数据库文件中，而是写入到另外一个称为WAL的文件中；如果事务失败，WAL中的记录会被忽略，撤销修改；如果事务成功，它将在随后的某个时间被写回到数据库文件中，提交修改。

同步WAL文件和数据库文件的行为被称为checkpoint（检查点），它由SQLite自动执行，默认是在WAL文件积累到1000页修改的时候；当然，在适当的时候，也可以手动执行checkpoint，SQLite提供了相关的接口。执行checkpoint之后，WAL文件会被清空。

### Mysql

**13. mysql的四种隔离状态**

隔离级别|脏读|不可重复读（NonRepeatable Read）|幻读（Phantom Read） 
-|-|-|-
未提交读（Read uncommitted）|可能|可能|可能
已提交读（Read committed）|不可能|可能|可能
可重复读（Repeatable read）|不可能|不可能|可能
可串行化（Serializable ）|不可能|不可能|不可能

* **未提交读(Read Uncommitted)**-允许脏读，也就是可能读取到其他会话中未提交事务修改的数据
* **提交读(Read Committed)**-只能读取到已经提交的数据。Oracle等多数数据库默认都是该级别 (不重复读)
* **可重复读(Repeated Read)**-可重复读。在同一个事务内的查询都是事务开始时刻一致的，InnoDB默认级别。在SQL标准中，该隔离级别消除了不可重复读，但是还存在幻象读
* **串行读(Serializable)**-完全串行化的读，每次读都需要获得表级共享锁，读写相互都会阻塞

**14. mysql的MVCC机制**

MVCC：多版本并发控制（MVCC,Multiversion Currency Control）。一般情况下，事务性储存引擎不是只使用表锁，行加锁的处理数据，而是结合了MVCC机制，以处理更多的并发问题。Mvcc处理高并发能力最强，

MYSQL中，MyISAM使用的是表锁，InnoDB使用的是行锁。而InnoDB的事务分为四个隔离级别，其中默认的隔离级别REPEATABLE READ需要两个不同的事务相互之间不能影响，而且还能支持并发，这点悲观锁是达不到的，所以REPEATABLE READ采用的就是乐观锁，而乐观锁的实现采用的就是MVCC。正是因为有了MVCC，才造就了InnoDB强大的事务处理能力。

MVCC是通过保存数据在某个时间点的快照来实现的. 不同存储引擎的MVCC实现是不同的,典型的有乐观并发控制和悲观并发控制.

**15. SQL优化方法有哪些**

* 选择最合适的字段属性
* 尽量把字段设置为NOT NULL
* 使用连接(JOIN)来代替子查询(Sub-Queries)

**16. MySQL引擎和区别**

* **InnoDB**-（默认的存储引擎）InnoDB是一个事务型的存储引擎，有行级锁定和外键约束。Innodb引擎提供了对数据库ACID事务的支持，并且实现了SQL标准的四种隔离级别，该引擎还提供了行级锁和外键约束，它的设计目标是处理大容量数据库系统，它本身其实就是基于MySQL后台的完整数据库系统，MySQL运行时Innodb会在内存中建立缓冲池，用于缓冲数据和索引。但是该引擎不支持FULLTEXT类型的索引，而且它没有保存表的行数，当SELECT COUNT(*) FROM TABLE时需要扫描全表。
* **MyIsam**-MyIASM是MySQL默认的引擎，但是它没有提供对数据库事务的支持，也不支持行级锁和外键，因此当INSERT(插入)或UPDATE(更新)数据时即写操作需要锁定整个表，效率便会低一些。
* **Memory**-使用存在内存中的内容来创建表。每个MEMORY表只实际对应一个磁盘文件。MEMORY类型的表访问非常得快，因为它的数据是放在内存中的，并且默认使用HASH索引。
* **Mrg_Myisam**-
* **Blackhole**-

### Redis

**17. mongodb和redis的区别**

MongoDB更类似Mysql，支持字段索引、游标操作，其优势在于查询功能比较强大，擅长查询JSON数据，能存储海量数据，但是不支持事务。Mysql在大数据量时效率显著下降，MongoDB更多时候作为关系数据库的一种替代。

* **内存管理机制**-Redis数据全部存在内存，定期写入磁盘，当内存不够时，可以选择指定的LRU算法删除数据。MongoDB数据存在内存，由linux系统mmap实现，当内存不够时，只将热点数据放入内存，其他数据存在磁盘。
* **支持的数据结构**-Redis支持的数据结构丰富，包括hash、set、list等。MongoDB数据结构比较单一，但是支持丰富的数据表达，索引，最类似关系型数据库，支持的查询语言非常丰富。
* **性能**-二者性能都比较高，应该说都不会是瓶颈。
* **可靠性**-二者均支持持久化。
* **集群**-MongoDB集群技术比较成熟，Redis从3.0开始支持集群。

**18. Redis的定时机制怎么实现的**

暂时不会

**19. Redis是单线程的，但是为什么这么高效呢?**

* 完全基于内存，绝大部分请求是纯粹的内存操作，非常快速。数据存在内存中，类似于HashMap，HashMap的优势就是查找和操作的时间复杂度都是O(1)；
* 数据结构简单，对数据操作也简单，Redis中的数据结构是专门进行设计的；
* 采用单线程，避免了不必要的上下文切换和竞争条件，也不存在多进程或者多线程导致的切换而消耗 CPU，不用去考虑各种锁的问题，不存在加锁释放锁操作，没有因为可能出现死锁而导致的性能消耗；
* 使用多路I/O复用模型，非阻塞IO；
* 使用底层模型不同，它们之间底层实现方式以及与客户端之间通信的应用协议不一样，Redis直接自己构建了VM 机制 ，因为一般的系统调用系统函数的话，会浪费一定的时间去移动和请求；

**20. Redis的数据类型有哪些，底层怎么实现?**

类型常量|对象名称
-|-
REDIS_STRING|字符串对象
REDIS_LIST|列表对象
REDIS_HASH|哈希对象
REDIS_SET|集合对象
REDIS_ZSET|有序集合对象

```c
/*
 * Redis 对象
 */
typedef struct redisObject {
 
    // 类型
    unsigned type:4;        
 
    // 不使用(对齐位)
    unsigned notused:2;
 
    // 编码方式
    unsigned encoding:4;
 
    // LRU 时间（相对于 server.lruclock）
    unsigned lru:22;
 
    // 引用计数
    int refcount;
 
    // 指向对象的值
    void *ptr;
 
} robj;
```

```c
#define REDIS_ENCODING_EMBSTR_SIZE_LIMIT 39
robj *createStringObject(char *ptr, size_t len) {
    if (len <= REDIS_ENCODING_EMBSTR_SIZE_LIMIT)
        return createEmbeddedStringObject(ptr,len);
    else
        return createRawStringObject(ptr,len);
}
```

```c
typedef struct dict {
    dictType *type;
    void *privdata;
    dictht ht[2];
    long rehashidx; /* rehashing not in progress if rehashidx == -1 */
    int iterators; /* number of iterators currently running */
} dict;
```

dict是一个字典，其中的指针dicht ht[2] 指向了两个哈希表

```c
typedef struct dictht {
    dictEntry **table;
    unsigned long size;
    unsigned long sizemask;
    unsigned long used;
} dictht;
```

skiplist是一种跳跃表，它实现了有序集合中的快速查找，在大多数情况下它的速度都可以和平衡树差不多。但它的实现比较简单，可以作为平衡树的替代品。它的结构比较特殊。

```c
/*
 * 跳跃表
 */
typedef struct zskiplist {
    // 头节点，尾节点
    struct zskiplistNode *header, *tail;
    // 节点数量
    unsigned long length;
    // 目前表内节点的最大层数
    int level;
} zskiplist;
/* ZSETs use a specialized version of Skiplists */
/*
 * 跳跃表节点
 */
typedef struct zskiplistNode {
    // member 对象
    robj *obj;
    // 分值
    double score;
    // 后退指针
    struct zskiplistNode *backward;
    // 层
    struct zskiplistLevel {
        // 前进指针
        struct zskiplistNode *forward;
        // 这个层跨越的节点数量
        unsigned int span;
    } level[];
} zskiplistNode;
```

有序集合ZSET是有跳跃表和hashtable共同形成的。

```c
typedef struct zset {
    // 字典
    dict *dict;
    // 跳跃表
    zskiplist *zsl;
} zset;
```

**21. Redis的rehash怎么做的，为什么要渐进rehash，渐进rehash又是怎么实现的?**

随着操作的不断进行，哈希表保存的键值对会逐渐的增多或减少，为了让哈希表的负载因子维持在一个合理的范围内，当哈希表保存的键值对数量太多或太少，就对哈希表进行扩展或收缩。

整个rehash过程并不是一步完成的，而是分多次、渐进式的完成。如果哈希表中保存着数量巨大的键值对时，若一次进行rehash，很有可能会导致服务器宕机。

*rehash的步骤*

* 为字典的ht\[1\]哈希表分配空间:若是扩展操作，那么ht\[1\]的大小为>=ht\[0\].used*2的2^n;若是收缩操作，那么ht\[1\]的大小为>=ht\[0\].used的2^n
* 将保存在ht\[0\]中的所有键值对rehash到ht\[1\]中，rehash指重新计算键的哈希值和索引值，然后将键值对放置到ht\[1\]哈希表的指定位置上。
* 当ht\[0\]的所有键值对都迁移到了ht\[1\]之后（ht\[0\]变为空表），释放ht\[0\]，将ht\[1\]设置为ht\[0\],新建空白的哈希表ht\[1\]，以备下次rehash使用。

*渐进rehash的步骤*

* 为ht\[1\]分配空间，让字典同时持有ht\[0\]和ht\[1\]两个哈希表
* 维持索引计数器变量rehashidx，并将它的值设置为0，表示rehash开始
* 每次对字典执行增删改查时，将ht\[0\]的rehashidx索引上的所有键值对rehash到ht\[1\]，将rehashidx值+1。
* 当ht\[0\]的所有键值对都被rehash到ht\[1\]中，程序将rehashidx的值设置为-1，表示rehash操作完成

**22. Redis和memcached的区别1**

* **Redis和Memcache都是将数据存放在内存中**-都是内存数据库。不过memcache还可用于缓存其他东西，例如图片、视频等等；
* **不同的数据结构**-Redis不仅仅支持简单的k/v类型的数据，同时还提供list，set，hash等数据结构的存储；
* **虚拟内存**-Redis当物理内存用完时，可以将一些很久没用到的value 交换到磁盘；
* **过期策略**-memcache在set时就指定，例如set key1 0 0 8,即永不过期。Redis可以通过例如expire 设定，例如expire name 10；
* **分布式**-设定memcache集群，利用magent做一主多从;redis可以做一主多从。都可以一主一从；
* **存储数据安全**-memcache挂掉后，数据没了；redis可以定期保存到磁盘（持久化）；
* **灾难恢复**-memcache挂掉后，数据不可恢复; redis数据丢失后可以通过aof恢复；
* **数据备份**-Redis支持数据的备份，即master-slave模式的数据备份；

**23. Redis怎么实现的定期删除功能**

定时删除，用一个定时器来负责监视key，当这个key过期就自动删除，虽然内存及时释放，但是十分消耗CPU资源，在大并发请求下CPU要尽可能的把时间都用在处理请求，而不是删除key，因此没有采用这一策略

定期删除+惰性删除：定时删除，redis默认每100ms检查是否有过期的key，有过期的key则删除。需要说明的是redis不是每个100ms将所有的key检查一次，而是随机抽取进行检查（如果每100ms，全部key进行检查，redis岂不是卡死了）。因此，如果只采用定期策略，会导致很多key到时间没有删除。也就是使用定时删除会导致删除不完全，于是惰性删除就登场了。也就是说你在获取key的时候，redis会检查一下，这个key如果设置过期时间那么是否过期了？如果过期 此时就删除。

**24. Redis对应的命令和数据类型...**

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

**25. Redis、memcached、mongoDB的区别**

* **性能**-都比较高，性能对我们来说应该都不是瓶颈。总体来讲，TPS方面redis和memcache差不多，要大于mongodb
* **操作的便利性**-memcache数据结构单一。redis丰富一些，数据操作方面，redis更好一些，较少的网络IO次数。mongodb支持丰富的数据表达，索引，最类似关系型数据库，支持的查询语言非常丰富。
* **内存空间的大小和数据量的大小**-redis在2.0版本后增加了自己的VM特性，突破物理内存的限制；可以对key value设置过期时间（类似memcache）。memcache可以修改最大可用内存,采用LRU算法。mongoDB适合大数据量的存储，依赖操作系统VM做内存管理，吃内存也比较厉害，服务不要和别的服务在一起。
* **可用性（单点问题）**-redis，依赖客户端来实现分布式读写；主从复制时，每次从节点重新连接主节点都要依赖整个快照,无增量复制，因性能和效率问题，所以单点问题比较复杂；不支持自动sharding,需要依赖程序设定一致hash 机制。Memcache本身没有数据冗余机制，也没必要；对于故障预防，采用依赖成熟的hash或者环状的算法，解决单点故障引起的抖动问题。
mongoDB支持master-slave,replicaset（内部采用paxos选举算法，自动故障恢复）,auto sharding机制，对客户端屏蔽了故障转移和切分机制。
* **可靠性（持久化）**-redis支持（快照、AOF）：依赖快照进行持久化，aof增强了可靠性的同时，对性能有所影响；memcache不支持，通常用在做缓存,提升性能；MongoDB从1.8版本开始采用binlog方式支持持久化的可靠性
* **数据一致性（事务支持）**-Memcache 在并发场景下，用cas保证一致性；redis事务支持比较弱，只能保证事务中的每个操作连续执行；mongoDB不支持事务
* **数据分析**-mongoDB内置了数据分析的功能(mapreduce),其他不支持
* **应用场景**-redis：数据量较小的更性能操作和运算上；memcache：用于在动态系统中减少数据库负载，提升性能;做缓存，提高性能（适合读多写少，对于数据量比较大，可以采用sharding）；MongoDB:主要解决海量数据的访问效率问题。

**26. MySQL 的增删查改**

查看数据库

```sql
SHOW DATABASE;
```

创建数据库

```sql
CREATE DATABASE sqlname;
```

增

```sql
INSERT INTO table_name ( field1, field2,...fieldN )VALUES( value1, value2,...valueN );
```

删

```sql
DELETE FROM table_name WHERE `id`>10
```

查

```sql
SELECT column_name,column_name FROM table_name
```

改

```sql
UPDATE table_name SET field1='value' WHERE `id`>10
```

**27. 一个学生表，一个课程成绩表，怎么找出学生课程的最高分数**

```sql
select c.student, MAX(g.grade) from grade_table g,child_table c where c.id=g.childid group by c.id;
```

**28. 数据库水平切分和垂直切分的区别**

* **水平切分**-上面谈到垂直切分只是把表按模块划分到不同数据库，但没有解决单表大数据量的问题，而水平切分就是要把一个表按照某种规则把数据划分到不同表或数据库里。

* **垂直切分**-垂直拆分就是要把表按模块划分到不同数据库表中（当然原则还是不破坏第三范式），这种拆分在大型网站的演变过程中是很常见的。

**29. 索引的底层实现**

哈希索引，B树索引

**30. 数据库的三范式**

* **第一范式**-当关系模式R的所有属性都不能在分解为更基本的数据单位时，称R是满足第一范式的，简记为1NF。满足第一范式是关系模式规范化的最低要求，否则，将有很多基本操作在这样的关系模式中实现不了。
* **第二范式**-如果关系模式R满足第一范式，并且R得所有非主属性都完全依赖于R的每一个候选关键属性，称R满足第二范式，简记为2NF。
* **第三范式**-设R是一个满足第一范式条件的关系模式，X是R的任意属性集，如果X非传递依赖于R的任意一个候选关键字，称R满足第三范式，简记为3NF.

**31. 数据库的乐观锁和悲观锁**

* **悲观锁**：悲观锁认为并发是每时每刻都在发生的。因此为了防止并发，我们在update数据库的数据行之前，需要先把这行数据先锁定起来。

* **乐观锁**：乐观锁认为并发并不是每时每刻都在发生。有可能会发生，但是大概率不会发生。乐观锁是通过在db行上加上版本的方式来实现的。

**32. **

**33. **

**34. **

**35. **

**36. **

**37. **

**38. **

**39. **
