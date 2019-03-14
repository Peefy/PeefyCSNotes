
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

Shell数组中可以存放多个值。Bash Shell只支持一维数组(不支持多维数组)，初始化时不需要定义数组大小(与PHP类似).数组元素的下标由0开始.

Shell数组用括号来表示，元素用“空格”符号分隔开，语法格式如下：
```bash
array_name=(value1 ... valuen)
```
实例
```bash
my_array=(A B "C" D)
```
```bash
array_name[0]=value0
array_name[1]=value1
array_name[2]=value2
```
读取数组元素值的一般格式是：
```bash
${array_name[index]}
```

### Shell运算符

Shell和其他编程语言一样，支持多种运算符,包括
* 算术运算符
* 关系运算符
* 布尔运算符
* 字符串运算符
* 文件测试运算符

原生bash不支持简单的数学运算，但是可以通过其他命令来实现，例如awk和expr,expr最常用,
expr是一款表达式计算工具，使用它能完成表达式的求值操作.

*注意：使用的是反引号``,而不是单引号*

```bash
#!/bin/bash
val=`expr 2 + 2`
echo "两数之和：${val}"
```

注意：

*1.表达式和运算符之间要有空格，例如2+2是不对的，必须写成2 + 2, 然而赋值号=之间不能有空格；*

*2.完整的表达式要被\` \`包含；*

**算术运算符**

加法\+ 减法\- 乘法\* 除法\/ 取余% 赋值= 相等== 不相等!= 

注意：*条件表达式要放在方括号之间，并且要有空格，例如: [ $a == $b ]*

```bash
a=10
b=20

val=`expr $a + $b`
echo "a + b : $val"

val=`expr $a - $b`
echo "a - b : $val"

val=`expr $a \* $b`
echo "a * b : $val"

val=`expr $b / $a`
echo "b / a : $val"

val=`expr $b % $a`
echo "b % a : $val"

if [ $a == $b ]
then
   echo "a 等于 b"
fi
if [ $a != $b ]
then
   echo "a 不等于 b"
fi
```

```bash
a + b : 30
a - b : -10
a * b : 200
b / a : 2
b % a : 0
a 不等于 b
```

注意：
* *乘号(\*)前边必须加反斜杠(\\)才能实现乘法运算；*
* *if...then...fi 是条件语句.*
* *在 MAC 中 shell 的 expr 语法是：$((表达式))，此处表达式中的 "\*" 不需要转义符号 "\\"*

**关系运算符**

关系运算符只支持数字，不支持字符串，除非字符串的值是数字。
下表列出常用的关系运算符，假定变量a为10，变量b为20：

运算符|说明|举例
---|---|---
-eq|检测两个数是否相等，相等返回 true|[ $a -eq $b ] 返回 false
-ne|检测两个数是否不相等，不相等返回 true|[ $a -ne $b ] 返回 true
-gt|检测左边的数是否大于右边的，如果是，则返回 true|[ $a -gt $b ] 返回 false
-lt|检测左边的数是否小于右边的，如果是，则返回 true|[ $a -lt $b ] 返回 true
-ge|检测左边的数是否大于等于右边的，如果是，则返回 true|[ $a -ge $b ] 返回 false
-le|检测左边的数是否小于等于右边的，如果是，则返回 true|[ $a -le $b ] 返回 true

```bash
a=10
b=20

if [ $a -eq $b ]
then
   echo "$a -eq $b : a 等于 b"
else
   echo "$a -eq $b: a 不等于 b"
fi
if [ $a -ne $b ]
then
   echo "$a -ne $b: a 不等于 b"
else
   echo "$a -ne $b : a 等于 b"
fi
if [ $a -gt $b ]
then
   echo "$a -gt $b: a 大于 b"
else
   echo "$a -gt $b: a 不大于 b"
fi
if [ $a -lt $b ]
then
   echo "$a -lt $b: a 小于 b"
else
   echo "$a -lt $b: a 不小于 b"
fi
if [ $a -ge $b ]
then
   echo "$a -ge $b: a 大于或等于 b"
else
   echo "$a -ge $b: a 小于 b"
fi
if [ $a -le $b ]
then
   echo "$a -le $b: a 小于或等于 b"
else
   echo "$a -le $b: a 大于 b"
fi
```

```bash
10 -eq 20: a 不等于 b
10 -ne 20: a 不等于 b
10 -gt 20: a 不大于 b
10 -lt 20: a 小于 b
10 -ge 20: a 小于 b
10 -le 20: a 小于或等于 b
```

**布尔运算符**

运算符|说明|举例
-|-|-
!|非运算，表达式为 true 则返回 false，否则返回 true|[ ! false ] 返回 true
-o|或运算，有一个表达式为 true 则返回 true|[ $a -lt 20 -o $b -gt 100 ] 返回 true
-a|与运算，两个表达式都为 true 才返回 true|[ $a -lt 20 -a $b -gt 100 ] 返回 false

```bash
#!/bin/bash
a=10
b=20

if [ $a != $b ]
then
   echo "$a != $b : a 不等于 b"
else
   echo "$a != $b: a 等于 b"
fi
if [ $a -lt 100 -a $b -gt 15 ]
then
   echo "$a 小于 100 且 $b 大于 15 : 返回 true"
else
   echo "$a 小于 100 且 $b 大于 15 : 返回 false"
fi
if [ $a -lt 100 -o $b -gt 100 ]
then
   echo "$a 小于 100 或 $b 大于 100 : 返回 true"
else
   echo "$a 小于 100 或 $b 大于 100 : 返回 false"
fi
if [ $a -lt 5 -o $b -gt 100 ]
then
   echo "$a 小于 5 或 $b 大于 100 : 返回 true"
else
   echo "$a 小于 5 或 $b 大于 100 : 返回 false"
fi
```

```bash
10 != 20 : a 不等于 b
10 小于 100 且 20 大于 15 : 返回 true
10 小于 100 或 20 大于 100 : 返回 true
10 小于 5 或 20 大于 100 : 返回 false
```

**逻辑运算符**
运算符|说明|举例
-|-|-
&&|	逻辑的 AND |[[ $a -lt 100 && $b -gt 100 ]] 返回 false
\|\||逻辑的 OR|[[ $a -lt 100 || $b -gt 100 ]] 返回 true

```bash
#!/bin/bash

a=10
b=20

if [[ $a -lt 100 && $b -gt 100 ]]
then
   echo "返回 true"
else
   echo "返回 false"
fi

if [[ $a -lt 100 || $b -gt 100 ]]
then
   echo "返回 true"
else
   echo "返回 false"
fi
```

```bash
返回 false
返回 true
```

**字符串运算符**

运算符|说明|举例
-|-|-
=|检测两个字符串是否相等，相等返回 true|[ $a = $b ] 返回 false
!=|检测两个字符串是否相等，不相等返回 true|[ $a != $b ] 返回 true
-z|检测字符串长度是否为0，为0返回 true|[ -z $a ] 返回 false
-n|检测字符串长度是否为0，不为0返回 true|[ -n "$a" ] 返回 true
$|检测字符串是否为空，不为空返回 true|[ $a ] 返回 true

```bash
#!/bin/bash

a="abc"
b="efg"

if [ $a = $b ]
then
   echo "$a = $b : a 等于 b"
else
   echo "$a = $b: a 不等于 b"
fi
if [ $a != $b ]
then
   echo "$a != $b : a 不等于 b"
else
   echo "$a != $b: a 等于 b"
fi
if [ -z $a ]
then
   echo "-z $a : 字符串长度为 0"
else
   echo "-z $a : 字符串长度不为 0"
fi
if [ -n "$a" ]
then
   echo "-n $a : 字符串长度不为 0"
else
   echo "-n $a : 字符串长度为 0"
fi
if [ $a ]
then
   echo "$a : 字符串不为空"
else
   echo "$a : 字符串为空"
fi
```

```bash
abc = efg: a 不等于 b
abc != efg : a 不等于 b
-z abc : 字符串长度不为 0
-n abc : 字符串长度不为 0
abc : 字符串不为空
```

**文件测试运算符**

文件测试运算符用于检测Unix文件的各种属性,属性检测描述如下：

操作符|说明|举例
-|-|-
-b file|检测文件是否是块设备文件，如果是，则返回 true|[ -b $file ] 返回 false
-c file|检测文件是否是字符设备文件，如果是，则返回 true|[ -c $file ] 返回 false
-d file|检测文件是否是目录，如果是，则返回 true|[ -d $file ] 返回 false
-f file|检测文件是否是普通文件（既不是目录，也不是设备文件），如果是，则返回 true|[ -f $file ] 返回 true
-g file|检测文件是否设置了 SGID 位，如果是，则返回 true|[ -g $file ] 返回 false
-k file|检测文件是否设置了粘着位(Sticky Bit)，如果是，则返回 true|[ -k $file ] 返回 false
-p file|检测文件是否是有名管道，如果是，则返回 true|[ -p $file ] 返回 false
-u file|检测文件是否设置了 SUID 位，如果是，则返回 true|[ -u $file ] 返回 false
-r file|检测文件是否可读，如果是，则返回 true|[ -r $file ] 返回 true
-w file|检测文件是否可写，如果是，则返回 true|[ -w $file ] 返回 true
-x file|检测文件是否可执行，如果是，则返回 true|[ -x $file ] 返回 true
-s file|检测文件是否为空（文件大小是否大于0），不为空返回 true|[ -s $file ] 返回 true
-e file|检测文件（包括目录）是否存在，如果是，则返回 true|[ -e $file ] 返回 true

### Shell echo命令

echo命令都是用于字符串的输出

**1.显示普通字符串**

```bash
echo "It is a test"
```

**2.显示转义字符**

```bash
echo "\"It is a test\""
```

**3.显示变量**

```bash
read name
echo "It is my ${name}"
```

**4.显示换行**

```bash
#!/bin/sh
read name 
echo "$name It is a test"
```

**5.显示不换行**

```bash
#!bin/sh
echo -e "OK! \c" # -e 开启转义 \c 不换行
echo "It is a test"
```

**6.显示结果定向至文件**

```bash
echo "It is a test" > myfile
```

**7.原样输出字符串，不进行转义或取变量(用单引号)**

```bash
echo '$name\"'
```

**8.显示命令执行结果**

```bash
echo `date`
```

注意：*显示命令使用的是反引号\` \`,而不是单引号*

**read命令**

read命令一个一个词组地接收输入的参数，每个词组需要使用空格进行分隔，如果输入的词组个数大于需要的参数个数，则多出的词组将被作为整体为最后一个参数接收

选项与参数说明
* **-p** 输入提示文字
* **-n** 输入字符长度限制(达到6位,自动结束)
* **-t** 输入限时
* **-s** 隐藏输入内容

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
