# PeefyCSNotes

计算机科学与技术笔记

* 操作系统 Linux
* 计算机网络 Socket TCP UDP HTTP
* 数据库 MySQL
* 算法
* 程序语言设计：面向对象、设计模式、容器Ioc&DI
* 编译原理

## 操作系统

### Linux
### Docker
### Shell Bash
### CMake

## 计算机网络

### Http1.0 2.0
### TCP UDP Socket

## 编译原理

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

* USE 数据库名字; : 
> 选择要操作的Mysql数据库，使用该命令后所有Mysql命令都只针对该数据库
* SHOW DATABASE; : 
> 列出MySQL数据库管理系统的数据库列表
* SHOW TABLES; : 
> 显示指定数据库的所有表，使用该命令前需要使用use命令来选择要操作的数据库
* SHOW COLUMNS FROM 数据表; :
> 显示数据表的属性，属性类型，主键信息，是否为NULL,默认值等其他信息
* SHOW INDEX FROM 数据表; : 
> 显示数据表的详细索引信息
* SHOW TABLE STATUS LIKE FROM 'db_name' LIKE 'pattern';
> 输出MySQL数据库管理系统的性能及统计信息

### MySQL连接

* mysql_connect(host, username, password, dbname, port, socket)

> host:主机名；username：用户名；password：密码；dbname：使用的数据库；port：MySQL服务器的端口号；socket：pipe



