
## 设计模式

[链接](https://github.com/Peefy/DotNetCore.DesignPatternByCSharp/blob/master/README%20-%20zh.md)

## 面向对象

## 控制反转Ioc、依赖注入DI、反射Reflection、注解(Annotation)、特性(Attribute)、装饰器(Decorator)

Ioc-Inversion of Control,即为控制反转，不是什么技术，而是一种设计思想，Ioc意味着将设计好的对象交给容器去控制，而不是传统的在设计的对象内部直接控制。明确控制反转Ioc,就是明确谁控制谁，控制什么，为何反转，哪些方面反转。

传统的Java程序或者C#程序设计，直接在对象的内部通过new进行创建对象，是程序主动去创建依赖对象，**而Ioc是有专门一个容器来创建这些对象，控制了对象的外部资源获取**，正转就是平常是在自己的对象中创建依赖的对象，反转就是由Ioc容器来控制对象的创建，并帮助注入对象。
容器可以自动帮助我们查找需要哪些对象，对象只是被动的接受依赖对象，所以是反转；
是**依赖对象的获取方式发生了反转**

传统的应用程序都是在类内部创建对象，导致类与类之间高耦合，难于测试；有了Ioc容器之后，把创建和查找依赖对象的控制权交给了容器，由容器进行注入对象组合，方便测试和功能复用

DI-Dependency Injection,即“依赖注入”；*组件之间的依赖关系*由容器在运行期间决定，容器动态地将某个依赖关系注入到组件之中。依赖注入的目的并非为软件系统带来更多功能，而是为了提升组件重用的频率，并为系统搭建一个灵活、可扩展的平台。

“依赖注入”明确描述了“被注入对象依赖IoC容器配置依赖对象”

一般程序如C#和JAVA的Ioc容器书写都需要用到各自程序语言的反射

**反射是计算机程序框架的灵魂**

反射机制是在运行状态中，对于任意的一个类，都能够知道这个类的所有属性和方法；对于任意一个对象，都能够调用它的任意一个方法和属性；这种动态获取的信息以及动态调用对象的方法的功能称为反射

[Java反射的例子](https://github.com/Peefy/JavaInVSCode/blob/master/src/ReflectionDemo.java)

[C#反射的例子](https://github.com/Peefy/CSharpInVsCode/blob/master/Demos/RelectionDemo.cs)

[Java注解的例子](https://github.com/Peefy/JavaInVSCode/blob/master/src/AnnotationDemo.java)

[C#特性的例子](https://github.com/Peefy/CSharpInVsCode/blob/master/Demos/AttributeDemo.cs)

[Python装饰器的例子](https://github.com/Peefy/PythonsWithVSCode/blob/master/decorator.py)

## C++知识点

* **智能指针**
* **const**

C++ const允许指定一个语义约束，编译器会强制实施这个约束，允许程序员告诉编译器某值是保持不变的。如果在编程中确实有某个值保持不变，就应该明确使用const，这样可以获得编译器的帮助

1.const最基本的用法：修饰成员变量
```c++
#include<iostream>
using namespace std;
int main(){
    int a1 = 3;   ///non-const data
    const int a2 = a1;    ///const data

    int * a3 = &a1;   ///non-const data,non-const pointer
    const int * a4 = &a1;   ///const data,non-const pointer
    int * const a5 = &a1;   ///non-const data,const pointer
    int const * const a6 = &a1;   ///const data,const pointer
    const int * const a7 = &a1;   ///const data,const pointer

    return 0;
}
/*
只有一个const，如果const位于*左侧，表示指针所指的数据是常量，不能通过解应用修改该数据；指针本身是变量，可以指向其他内存单元

只有一个const，如果const位于*右侧，表示指针本身是常量，不能指向其他内存地址；指针所指的数据可以通过解引用修改。

两个const，*左右各一个，表示指针和指针所指数据都不能修改。
*/
```
2.const修饰函数参数
```c++
void testModifyConst(const int _x) {
     _x=5;　　　///编译出错
}
/*
传递过来的参数在函数内不可以改变，与上面修饰变量时的性质一样。
*/
```
3.const修饰成员函数
```c++
#include <iostream>
using namespace std;
class Point{
    public :
    Point(int _x):x(_x){}

    void testConstFunction(int _x) const{

        ///错误，在const成员函数中，不能修改任何类成员变量
        x=_x;

        ///错误，const成员函数不能调用非onst成员函数，因为非const成员函数可以会修改成员变量
        modify_x(_x);
    }

    void modify_x(int _x){
        x=_x;
    }

    int x;
};
/*
const修饰的成员函数不能修改任何的成员变量(mutable修饰的变量除外)

const成员函数不能调用非onst成员函数，因为非const成员函数可以会修改成员变量
*/
```
4.const修饰函数返回值
```c++
const int * mallocA(){  ///const data,non-const pointer
    int *a=new int(2);
    return a;
}

int main()
{
    const int *a = mallocA();
    ///int *b = mallocA();  ///编译错误
    return 0;
}
/*
如果返回const data,non-const pointer，返回值也必须赋给const data,non-const pointer。因为指针指向的数据是常量不能修改。
*/
```

* **static**

1.static可以用来隐藏函数和变量:当同时编译多个文件时，所有未加static前缀的全局变量和函数都具有全局可见性(使用extern就可以)，利用这一特性可以在不同的文件中定义同名函数和同名变量，而不必担心命名冲突。static可以用作函数和变量的前缀，对于子函数来讲，static的作用仅限于隐藏

2.保持变量内容的持久(static变量的记忆功能和全局生存期)：存储在静态数据的变量会在程序刚开始运行时就完成初始化，也是唯一的一次初始化。共有两种变量存储在静态存储区：全局变量和static变量，只不过和全局变量比起来，static可以控制变量的可见范围。PS:如果作为static局部变量在函数内定义，它的生存期为整个源程序，但是其作用域仍与自动变量相同，智能在定义该变量的函数内使用该变量。退出该函数后，尽管该变量还继续存在，但不能使用它

3.默认初始化为0(static变量):全局变量也具备这一属性，因为全局变量也存储在静态数据区，内存中所有的字节默认值都是0x00,某些时候这一特点可以减少程序员的工作量。再比如要把一个字符数组当字符串来用,但又觉得每次在字符数组末尾加'\0'太麻烦.如果把字符串定义成静态的，就省去了这个麻烦。

4.static的第四个作用：C++中的类成员声明static：在类中声明static变量或者函数时，初始化时使用作用域运算符来标明它所属类。因此，静态数据成员是类的成员，而不是对象的成员。(1)类的静态成员函数是属于整个类而非类的对象，所以没有this指针，导致仅能访问类的静态数据和静态成员函数;(2)不能将静态成员函数定义为虚函数;(3)由于静态成员声明于类，操作于其外，所以对其取地址操作，就多少有些特殊，变量地址是指向其数据类型的指针，函数地址类型是一个"nonmember函数指针"；(4)由于静态成员函数没有this指针，所以就差不多等同于nonmember函数,就产生一个意想不到的好处：成为一个callback函数,(5)static并没有增加程序的时空开销，相反还缩短了子类对父类静态成员的访问时间，节省了子类的内存空间;(6)静态数据成员在<定义或说明>时前面加关键字static;(7)静态数据成员是静态存储的，所以必须对它进行*初始化*;(8)静态成员初始化与一般数据化不同,初始化在类体外进行:**\<数据类型\>\<类名\>::\<静态数据成员名\>=\<值\>**;(9)为了防止父类的影响，可以在子类定义一个与父类相同的静态变量，以屏蔽父类的影响.

* **STL**
* **内存池**
* **cast函数**

C++11智能指针share_ptr<>、auto_ptr<>、make_ptr<>()

STL标准模板库 algorithm库

const、static、static_cast<>

C++内存池、内存管理、内存泄露

继承与多态override

## java知识点

JVM虚拟机，StringBuffer、StringBuilder

HashTable、HashMap、ConcurentHashMap

java注解

@override

maven包管理工具
