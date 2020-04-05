
## 编程语言

[C++笔记](https://github.com/Peefy/CppInVSCode/tree/master/)

[Java笔记](https://github.com/Peefy/JavaInVSCode/tree/master/)

[Python笔记](https://github.com/Peefy/PythonsWithVSCode/blob/master/doc/README_NOTE.md)

[C#笔记](https://github.com/Peefy/CSharpInVsCode/blob/master/doc/NOTE.md)

[Go笔记](https://github.com/Peefy/GoInVSCode/blob/master/doc/Note.md)

[Ruby笔记](https://github.com/Peefy/RubyInVSCode/blob/master/doc/NOTE.md)

[Lua笔记](https://github.com/Peefy/LuaInVSCode/blob/master/doc/NOTE.md)

[Scala笔记](https://github.com/Peefy/ScalaInVSCode/blob/master/doc/NOTE.md)

[Rust笔记](https://github.com/Peefy/RustInVSCode/blob/master/doc/NOTE.md)

[PHP笔记](https://github.com/Peefy/PHPInVSCode/blob/master/doc/NOTE.md)

## 前端H5知识点

[H5笔记](https://github.com/Peefy/H5_CSS_JS_TS_Collection)

## 面向对象

面向对象(Object Oriented,OO)是软件开发方法。

三大特性：

* **封装**-封装，就是把客观事物封装成抽象的类，并且类可以把自己的数据和方法只让可信的类或者对象操作，对不可信的进行信息隐藏。
* **继承**-继承，指可以让某个类型的对象获得另一个类型的对象的属性的方法。它支持按级分类的概念。
* **多态**-多态，是指一个类实例的相同方法在不同情形有不同表现形式。多态机制使具有不同内部结构的对象可以共享相同的外部接口。

## 设计模式

[Java实现的设计模式](https://github.com/Peefy/PeefyCSNotes/blob/master/doc/README_DESIGN_PATTERNS.md)

[C#实现的设计模式](https://peefy.github.io/blog/2018/04/13/CSharp-DesignPatterns/)

*设计模式遵循的原则有6个*:

* **开闭原则（Open Close Principle）**-对扩展开放，对修改关闭。
* **里氏代换原则（Liskov Substitution Principle）**-只有当衍生类可以替换掉基类，软件单位的功能不受到影响时，基类才能真正被复用，而衍生类也能够在基类的基础上增加新的行为。
* **依赖倒转原则（Dependence Inversion Principle）**-这个是开闭原则的基础，对接口编程，依赖于抽象而不依赖于具体。
* **接口隔离原则（Interface Segregation Principle）**-使用多个隔离的借口来降低耦合度。
* **迪米特法则（最少知道原则）（Demeter Principle）**-一个实体应当尽量少的与其他实体之间发生相互作用，使得系统功能模块相对独立。
* **合成复用原则（Composite Reuse Principle）**-原则是尽量使用合成/聚合的方式，而不是使用继承。继承实际上破坏了类的封装性，超类的方法可能会被子类修改。

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

