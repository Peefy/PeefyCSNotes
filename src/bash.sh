echo "Hello World"
# 变量命名需要遵循如下规则：
:<<EOF
* 命令只能使用英文字母，数字和下划线，首个字符不能以数字开头
* 中间不能有空格，可以使用下划线
* 不能使用标点符号 
* 不能使用bash里面的关键字(可用help命令查看保留关键字)
EOF
dugu_name="dugu"
# 在变量名字前面加美元符号`$`
duguname="qs"
echo $(duguname)
echo ${duguname}
# 变量名字外面的花括号是可选的，加不加都行，加花括号是为了帮助解释器识别变量的边界，比如下面的情况
for skill in Ada Coffe Action Java; do
    echo "I am good at ${skill}Script" 
done

# 只读变量

myUrl="http://www.google.com"
readonly myUrl
myUrl="http://www.baidu.com"

# 删除变量

myUrl="http://www.google.com"
unset myUrl
echo $myUrl

# 字符串
your_name='runoob'
str="Hello, I know you are \"$your_name\"! \n"
echo -e $str

your_name="dugu"
# 使用双引号拼接
greeting="hello, "$your_name" !"
greeting_1="hello, ${your_name} !"
echo $greeting $greeting_1
# 使用单引号拼接
greeting_2='hello, '$your_name' !'
greeting_3='hello, ${your_name} !'
echo $greeting_2 $greeting_3

string="abcd"
echo ${#string} #输出4

string="abcdefg"
echo `expr index "$string" cd` #输出 4

echo "-- \$* 演示 ---"
for i in "$*"; do
    echo $i
done

for i in "$*"; do
    echo $i
done
