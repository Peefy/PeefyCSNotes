
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
* **::**
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
