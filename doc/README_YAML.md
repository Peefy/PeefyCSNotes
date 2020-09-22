
# YML文件简介

一种配置文件 `*.yml`

## 一、YAML是什么

YAML (YAML Aint Markup Language)是一种标记语言，通常以.yml为后缀的文件，是一种直观的能够被电脑识别的数据序列化格式，并且容易被人类阅读，容易和脚本语言交互的，可以被支持YAML库的不同的编程语言程序导入，一种专门用来写配置文件的语言。可用于如： Java，C/C++, Ruby, Python, Perl, C#, PHP等。

## 二、YML优点

* YAML易于人们阅读。
* YAML数据在编程语言之间是可移植的。
* YAML匹配敏捷语言的本机数据结构。
* YAML具有一致的模型来支持通用工具。
* YAML支持单程处理。
* YAML具有表现力和可扩展性。
* YAML易于实现和使用。

## 三、YML语法

### 1. 约定

* k: v 表示键值对关系，冒号后面必须有一个空格
* 使用空格的缩进表示层级关系，空格数目不重要，只要是左对齐的一列数据，都是同一个层级的
* 大小写敏感
* 缩进时不允许使用Tab键，只允许使用空格。
* 松散表示，java中对于驼峰命名法，可用原名或使用-代替驼峰，如java中的lastName属性,在yml中使用lastName或 last-name都可正确映射。

### 2. 键值关系

#### (1) 普通值(字面量)

k: v：字面量直接写；

字符串默认不用加上单引号或者双绰号；

"": 双引号；不会转义字符串里面的特殊字符；特殊字符会作为本身想表示的意思

​name: "zhangsan \n lisi"：输出；zhangsan 换行 lisi

​''：单引号；会转义特殊字符，特殊字符最终只是一个普通的字符串数据

```yml
name1: zhangsan
name2: 'zhangsan \n lisi'
name3: "zhangsan \n lisi"
age: 18
flag: true
```

#### (2) 日期

```yml
date: 2019/01/01
```

#### (3) 对象(属性和值)、Map(键值对)

* 缩进写法

```yml
people:
    name: zhangsan
    age: 20
```

* 行内写法

```yml
people: {name: zhangsan,age: 20}
```

#### (4) 数组、list、set

* 缩进写法

```yml
pets:
    - dog
    - pig
    - cat
```

* 行内写法

```yml
pets: [dog,pig,cat]
```

#### (5) 数组对象、list对象、set对象

```yml
peoples: 
    - name: zhangsan
      age: 22
```

#### (6) java代码示例

```java
public class Person {

    private String lastName;
    private Integer age;
    private Boolean boss;

    private Date birth;
    private Map<String,Object> maps;
    private List<Dog> lists;
    private Dog dog;
    private String[] arr;
｝
public class Dog {
    private String name;
    private Integer age;
}
```

```yml
person:
  boss: false
  maps:
    k1: v1
    k2: 14
  lists:
    - name: d1
      age: 2
    - name: d2
      age: 3
    - {name: d3,age: 4}
  birth: 2017/12/15
  dog:
    name: p_dog
    age: 15
  age: 13
  last-name: 张三
  arr: [s1,s2,s3]
```

### 3. 文档块

对于测试环境，预生产环境，生产环境可以使用不同的配置，如果只想写到一个文件中，yml与是支持的,每个块用----隔开

```yml
server:
  port: 8081
spring:
  profiles:
    active: prod #激活对应的文档块

---
server:
  port: 8083
spring:
  profiles: dev #指定属于哪个环境


---

server:
  port: 8084
spring:
  profiles: prod  #指定属于哪个环境
```

### 4. Yaml类型

yaml有数据类型，基本的方式隐式构建，显式类型可以通过两个感叹号`!!`指定。
