
## Shell

Shell是一个用C语言编写的程序，是用户使用Linux的桥梁。Shell既是一种命令语言，又是一种程序设计语言。Shell既是一种命令语言，又是一种程序设计语言。Shell是指一种应用程序，这个应用程序提供可一个界面，用户通过这个界面访问操作系统内核的服务。
Ken Thompson的sh是一种Unix Shell，Windows Explorer是一个典型的图形界面Shell。

**Shell脚本**

Shell脚本(shell script),是一种为shell编写的脚本程序。
但是shell和shell script是两个不同的概念

**Shell环境**
Shell编程跟java、php编程一样，只要有一个能编写代码的文本编辑器和一个能解释执行的脚本解释器就可以了。Linux的Shell种类：
* Bourme Shell (usr/bin/sh或)
* Bourme Again Shell (/bin/bash) *bash*
* C Shell (/usr/bin/csh)
* K Shell (/usr/bin/ksh)
* Shell for Root (/sbin/sh)
* etc.

*bash也是大多数Linux系统默认的Shell,一般不区分Bourne Shell 和 Bourne Again Shell，所以像#!bin/sh,同样可以改为#!bin/bash*

`#!`是一个约定的标记，告诉系统这个脚本需要什么解释器来执行，即使用哪一种Shell 

第一个shell脚本*first.sh*,sh代表shell

```bash
#!/bin/bash
echo "Hello World"
```

运行Shell脚本有两种方法
* 1.作为可执行程序:
将代码保存，并cd到相应目录
```cmd
chmod +x ./test.sh
./test.sh  #执行脚本
```

*注意一定写成./test.sh,而不是test.sh,运行其他二进制程序也一样，直接写test.sh,Linux系统会去PATH里面找有没有叫test.sh，而只有/bin,/sbin,/usr/bin等在PATH里,用户的当前目录通常不在PATH里面,所以写成test.sh是会找不到命令的，要用./test.sh,就在当前目录里面找*

* 2.作为解释器参数:
直接运行解释器，类似在终端里面直接运行python pyfile.py
```cmd
/bin/sh test.sh
/bin/php test.php
```

### Shell变量

定义变量
```bash
dugu_name="dugu"
```

*注意：变量名和等号之间不能有空格，这和熟悉的编程语言都不一样*
变量命名需要遵循如下规则：
* 命令只能使用英文字母，数字和下划线，首个字符不能以数字开头
* 中间不能有空格，可以使用下划线
* 不能使用标点符号 
* 不能使用bash里面的关键字(可用help命令查看保留关键字)

有效的Shell变量名字示例如下：
```cmd
RUNOOB
LD_LIBRARY_PATH
_var
var2
```

无效的变量命名：
```cmd
?var=123
user*name=dugu
```

除了显示地直接赋值，还可以用语句给变量赋值
```bash
for file in `ls /etc`
```
或者
```bash
for filr in $(ls /etc)
```

**使用变量**

在变量名字前面加美元符号`$`
```bash
duguname="qs"
echo $(duguname)
echo ${duguname}
```

变量名字外面的花括号是可选的，加不加都行，加花括号是为了帮助解释器识别变量的边界，比如下面的情况
```bash
for skill in Ada Coffe Action Java; do
    echo "I am good at ${skill}Script" 
done
```

*建议：给所有变量加上花括号*

```bash
dugu_name="name"
echo $dugu_name
dugu_name="dugu_name"
echo $dugu_name
```

*使用变量的时候才加美元符`$`*

**只读变量**

使用readonly命令可以将变量定义为只读变量，只读变量的值不能被改变
```bash
myUrl="http://www.google.com"
readonly myUrl
myUrl="http://www.baidu.com"
```

**删除变量**

```bash
myUrl="http://www.google.com"
unset myUrl
echo $myUrl
```

**变量类型**

### Shell传递参数

### Shell数组

### Shell运算符

### Shell echo命令

### Shell printf命令

### Shell test命令

### Shell 流程控制

### Shell 函数

### Shell 输入/输出重定向

### Shell 文件包含

### Shell

### Shell

### Shell

### Shell

### Shell

### Shell

### Shell
