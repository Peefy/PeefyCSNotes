
## 设计模式

[C#实现的设计模式](https://peefy.github.io/blog/2018/04/13/CSharp-DesignPatterns/)

**Java中有哪些代理模式？**

代理模式：代理模式是一种设计模式，简单说即是在不改变源码的情况下，实现对目标对象的功能扩展。

* **静态代理**-
```java
public interface ISinger{
    void sing();
}

public class SingerProxy implements ISinger{
    private ISinger _iSinger;
    public UserDaoProxy(ISinger iSinger){
        _iSinger = iSinger;
    }
    public void sing(){
        System.out.println("向观众问好");
        target.sing();
        System.out.println("谢谢大家");
    }
}
```
* **动态代理(JDK代理)**-利用JDK的反射
```java
public interface ISinger {
    void sing();
}

/**
 *  目标对象实现了某一接口
 */
public class Singer implements ISinger{
    public void sing(){
        System.out.println("唱一首歌");
    }  
}

public class Test{
    public static void main(String[] args) {
        Singer target = new Singer();
        ISinger proxy  = (ISinger) Proxy.newProxyInstance(
                target.getClass().getClassLoader(),
                target.getClass().getInterfaces(),
                new InvocationHandler() {
                    @Override
                    public Object invoke(Object proxy, Method method, Object[] args) throws Throwable {
                        System.out.println("向观众问好");
                        //执行目标对象方法
                        Object returnValue = method.invoke(target, args);
                        System.out.println("谢谢大家");
                        return returnValue;
                    }
                });
        proxy.sing();
    }
}
```
* **Cglib代理**-
```java
/**
 * Cglib子类代理工厂
 */
public class ProxyFactory implements MethodInterceptor{
    // 维护目标对象
    private Object target;

    public ProxyFactory(Object target) {
        this.target = target;
    }

    // 给目标对象创建一个代理对象
    public Object getProxyInstance(){
        //1.工具类
        Enhancer en = new Enhancer();
        //2.设置父类
        en.setSuperclass(target.getClass());
        //3.设置回调函数
        en.setCallback(this);
        //4.创建子类(代理对象)
        return en.create();
    }

    @Override
    public Object intercept(Object obj, Method method, Object[] args, MethodProxy proxy) throws Throwable {
        System.out.println("向观众问好");
        //执行目标对象的方法
        Object returnValue = method.invoke(target, args);
        System.out.println("谢谢大家");
        return returnValue;
    }
}
```

**如何实现动态代理**

代理模式是常用的java设计模式，他的特征是代理类与委托类有同样的接口，代理类主要负责为委托类预处理消息、过滤消息、把消息转发给委托类，以及事后处理消息等。代理类与委托类之间通常会存在关联关系，一个代理类的对象与一个委托类的对象关联，代理类的对象本身并不真正实现服务，而是通过调用委托类的对象的相关方法，来提供特定的服务。简单的说就是，我们在访问实际对象时，是通过代理对象来访问的，代理模式就是在访问实际对象时引入一定程度的间接性，因为这种间接性，可以附加多种用途。

* **静态代理**

```java
public interface Person{
    void giveMoney();
}

public class Student implements Person{
    private String name;
    public Student(String name){
        this.name = name;
    }

    @Override
    public void giveMoney(){
        System.out.println(name + "上交班费50元");
    }
}

public class StudentProxy implements Person{
    Student stu;
    public StudentProxy(Person stu){
        this.stu = (Student)stu;
    }

    public void giveMoney(){
        stu.giveMoney();
    }
}

public class StaticProxyTest{
    public static void main(String[] args){
        Person zhangsan = new Student("张三");
        Person monitor = new StudentProxy(zhangsan);
        monitor.giveMoney();
    }
}

public class StudentsProxy implements Person{
    Student stu;

    public StudentsProxy(Person stu){
        if(stu.getClass() == Student.class){
            this.stu = (Student)stu;
        }
    }

    public void giveMoney(){
        System.out.println("张三最近学习有进步!");
        stu.giveMoney();
    }
}

```

* **动态代理**

代理类在程序运行时创建的代理方式被称为动态代理。代理类(studentProxy)是自己定义好的，在程序运行之前就已经编译完成。然而动态代理，代理类并不是在java代码中定义的，而是在运行时根据在java代码中的“指示”动态生成的。相比于静态代理，动态代理的优势在于可以很方便的对代理类的函数进行统一的处理，而不用修改每个代理类中的方法。比如说：想要的在每个代理的方法前都加上一个处理方法：

```java
public void giveMoney(){
    beforeMethod();
    stu.giveMoney();
}
```

*动态代理的简单实现*：在java的java.lang.reflect包下提供了Proxy类和一个InvocationHandler接口，通过这个类和这个接口可以生成JDK动态代理类和动态代理对象。

* 创建一个InvocationHandler对象
```java
//创建一个与代理对象相关联的InvocationHandler
InvocationHandler stuHandler = new MyInvocationHandler<Person>(stu);
```
* 使用Proxy类的getProxyClass静态方法生成一个动态代理类stuProxyClass 
```java
Class<?> stuProxyClass = Proxy.getProxyClass(Person.class.getClassLoader(), new Class<?>[] {Person.class});
```
* 获得stuProxyClass 中一个带InvocationHandler参数的构造器constructor
```java
Constructor<?> constructor = PersonProxy.getConstructor(InvocationHandler.class);
```
* 通过构造器constructor来创建一个动态实例stuProxy
```java
Person stuProxy = (Person) cons.newInstance(stuHandler);
```
* 就此，一个动态代理对象就创建完毕，当然，上面四个步骤可以通过Proxy类的newProxyInstances方法来简化：
```java
//创建一个与代理对象相关联的InvocationHandler
InvocationHandler stuHandler = new MyInvocationHandler<Person>(stu);
//创建一个代理对象stuProxy，代理对象的每个执行方法都会替换执行Invocation中的invoke方法
Person stuProxy= (Person) Proxy.newProxyInstance(Person.class.getClassLoader(), new Class<?>[]{Person.class}, stuHandler);
```

```java
public interface Person{
    void giveMoney();
}

public class Student implements Person{
    private String name;
    public Student(String name){
        this.name = name;
    }

    @Override
    public void giveMoney(){
        try{
            Thread.sleep(1000);
        } catch (InterruptedException e){
            e.printStackTrace();
        }
        System.out.println(name + "上交班费50元");
    }
}
```

再定义一个检测方法执行时间的工具类，在任何方法执行前先调用start方法，执行后调用finsh方法，就可以计算出该方法的运行时间，这也是一个最简单的方法执行时间检测工具。

```java
public class MonitorUtil{
    private static ThreadLocal<Long> tl = new ThreadLocal<>();

    public static void start(){
        tl.set(System.currentTimeMillis());
    }

    public static void finish(String methodName){
        long finishTime = System.currentTimeMillis();
        System.out.println(methodName + "方法耗时" + (finishTime - tl.get()) + "ms");
    }
}
```

创建StuInvocationHandler类，实现InvocationHandler接口，这个类中持有一个被代理对象的实例target。InvocationHandler中有一个invoke方法，所有执行代理对象的方法都会被替换成执行invoke方法。

再再invoke方法中执行被代理对象target的相应方法。当然，在代理过程中，我们在真正执行被代理对象的方法前加入自己其他处理。这也是Spring中的AOP实现的主要原理，这里还涉及到一个很重要的关于java反射方面的基础知识。

```java
public class StuInvocationHandler<T> implements InvocationHandler{
    T target;

    public StuInvocationHandler(T target){
        this.target = target;
    }

    @Override
    public Object invoke(Object proxy, Method method, Object[] args) throws Throwable{
        MonitorUtil.start();
        Object result = method.invoke(target, args);
        MonitorUtil.finish(method.getName());
        return result;
    }
}
```

**IO流熟悉吗，用的什么设计模式？**



**介绍一下单例模式？懒汉式的单例模式如何实现单例？**



**介绍一下策略模式？**



**设计模式了解哪些，手写一下观察者模式？**



**说说你所熟悉或听说过的j2ee中的几种常用模式?及对设计模式的一些看法**



**j2ee常用的设计模式？说明工厂模式**



**开发中都用到了那些设计模式?用在什么场合?**



**简述一下你了解的Java设计模式**


