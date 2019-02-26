## 数据库

### Redis

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

### MySQL 正则表达式

### MySQL 事物

### MySQL ALTER命令

### MySQL 索引

### MySQL 临时表

### MySQL 复制表

### MySQL 元数据

### MySQL 序列使用

### MySQL 处理重复数据

### MySQL SQL注入

### MySQL 导出数据

### MySQL 导入数据

### MySQL 函数

### MySQL 运算符


