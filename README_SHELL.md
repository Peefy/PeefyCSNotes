
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

* 局部变量: 局部变量在脚本或命令中定义，仅在当前shell实例中有效，其他shell启动的程序不能访问局部变量
* 环境变量: 所有的程序，包括shell启动的程序，都能访问环境变量，有些程序需要环境变量来保证其正常运行。必要的时候shell脚本也可以定义环境变量
* shell变量: shell变量是由shell程序设置的特殊变量。shell变量中有一部分是环境变量，有一部分是局部变量，这些变量保证了shell的正常运行

**Shell字符串**

字符串是shell编程中最常用最有用的数据类型（基本就是数字和字符串）字符串可以用单引号，也可以用双引号，也可以不用引号。

单引号

```bash
str='this is a string'
```

单引号字符串的限制：
* 单引号里的任何字符串都会原样输出，单引号字符串中的变量是无效的
* 单引号子串不能出现单独一个单引号(对单引号使用转义符后也不行),但可成对出现，作为字符串拼接使用

双引号

```bash
your_name='runoob'
str="Hello, I know you are \"$your_name\"! \n"
echo -e $str
```

双引号的优点：
* 双引号里面可以有变量
* 双引号可以出现转义字符

**拼接字符串**

```bash
your_name="dugu"
# 使用双引号拼接
greeting="hello, "$your_name" !"
greeting_1="hello, ${your_name} !"
echo $greeting $greeting_1
# 使用单引号拼接
greeting_2='hello, '$your_name' !'
greeting_3='hello, ${your_name} !'
echo $greeting_2 $greeting_3
```

输出结果为
> hello, dugu ! hello, dugu !
> hello, dugu ! hello, ${your_name} !

**获取字符串长度**

```bash
string="abcd"
echo ${#string} #输出4
```

**提取子字符串**

从字符串第2个字符开始截取4个字符
```bash
string="abcdefghi"
echo ${string:1:4} # 输出bcde
```

**查找子字符串**

查找字符i或o的位置

```bash
string="abcdefg"
echo `expr index "$string" cd` #输出 4
```

**Shell数组**

bash支持一维数组（不支持多维数组），并且没有限定数组的大小.
类似于C语言，数组元素的下标由0开始编号。获取数组中的元素要利用下标,下标可以是整数或算术表达式,其值应大于或等于0

**定义数组**

在Shell中，用括号来表示数组，数组元素用“空格”符号分隔开。定义数组的一般形式为:
```bash
数组名=(值1 值2 ... 值n)
```
```bash
array_name=(value0 value1 value2 value3)
```

*shell数组可以不使用连续的下标，而且下标的范围没有限制*

**读取数组**

读取数组元素值的一般格式是：
```bash
${数组名[下标]}
```

例如:
```bash
value=${array_name[@]}
```

**获取数组的长度**

获取数组长度的方法与获取字符串长度的方法相同,例如：
```bash
# 取得数组元素的个数
length=${#array_name[@]}
# 或者
length=${#array_name[*]}
# 取得数组单个元素的长度
lengthn=${#array_name[n]}
```

**Shell注释**

以`#`开头的行就是注释，会被解释器忽略
通过每一行加一个#号设置多行注释,像这样:

多行注释
```bash
:<<EOF
注释内容...
注释内容...
注释内容...
EOF
```
当然`EOF`也可以使用其他符号
```bash
:<<!
注释内容...
注释内容...
注释内容...
!
```

### Shell传递参数

可以在执行Shell脚本时，像脚本传递参数，脚本内获取参数的格式为：$n.n代表一个数字，1为执行脚本的第一个参数，2为执行脚本的第二个参数

```bash
echo "Shell 传递参数实例!"
echo "执行的文件名为:$0"
echo "第一个参数为:$1"
echo "第二个参数为:$2"
echo "第三个参数为:$3"
```

```shell
$ chmod +x test.sh
$ ./test.sh 1 2 3
Shell 传递参数实例！
执行的文件名：./test.sh
第一个参数为：1
第二个参数为：2
第三个参数为：3
```

选项与参数说明
* $# 传递到脚本的参数个数
* $* 以一个单字符串显示所有向脚本传递的参数。如"$*"用「"」括起来的情况、以"$1 $2 … $n"的形式输出所有参数。
* $$ 脚本运行的当前进程ID号
* $! 后台运行的最后一个进程的ID号
* $@ 与$*相同，但是使用时加引号，并在引号中返回每个参数。
* $~ 显示Shell使用的当前选项，与set命令功能相同。
* $? 显示最后命令的退出状态。0表示没有错误，其他任何值表明有错误。

```bash
echo "Shell 传递参数实例！";
echo "第一个参数为：$1";
echo "参数个数为：$#";
echo "传递的参数作为一个字符串显示：$*";
```

```bash
$ chmod +x test.sh 
$ ./test.sh 1 2 3
Shell 传递参数实例!
第一个参数为：1
参数个数为：3
传递的参数作为一个字符串显示：1 2 3
```

`$*` 与 `$@` 区别：
* 相同点：都是引用所有参数
* 不同点：只有在双引号中体验出来。假设在脚本运行时写了三个参数1,2,3,则“*”等价于"1 2 3"(传递了一个参数),而“@”等价于"1","2","3" (传递了三个参数)

```bash
echo "-- \$* 演示 ---"
for i in "$*"; do
    echo $i
done

echo "-- \$* 演示 ---"
for i in "$*"; do
    echo $i
done
```

```bash
$ chmod +x test.sh 
$ ./test.sh 1 2 3
-- $* 演示 ---
1 2 3
-- $@ 演示 ---
1
2
3
```

在为shell脚本传递的参数中*如果包含空格，应该使用单引号或者双引号将该参数括起来，以便于脚本将这个参数作为整体来接收*

在有参数时，可以使用对参数进行校验的方式处理以减少错误发生

```bash
if [ -n $1$ ]; then
    echo "包含第一个参数"
done
    echo "没有包含第一个参数"
fi
```

注意：*中括号`[]`与其中间的代码应该有空格隔开*

Shell里面的中括号（包括单中括号与双中括号）可以用于一些条件的测试：
* 算术比较，比如一个变量是否为0，[ $var -eq 0 ].
* 文件属性测试，比如一个文件是否存在，[ -e $var ], 是否是目录，[ -d $var ]
* 字符串比较，比如两个字符串是否相同，[[ $var1 = $var2 ]]

*[]常常可以用test命令代替*

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
