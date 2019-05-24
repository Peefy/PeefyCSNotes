
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

**Java IO流熟悉吗，用的什么设计模式？**

```java
public void testInputStreamReader() throws Exception {
    private static final String SEPARATOR = File.separator;

    File file = new File("e:" + SEPARATOR + "io" + SEPARATOR + "test.txt");
    //BufferedReader bufferedReader = new BufferedReader(new InputStreamReader(new FileInputStream(file)));
    // 备注上面这个初始化过程就是多次使用包装来完成的,不推荐这么写,会让新手看不懂。
    // 1.获得字节输入流
    FileInputStream fileInputStream = new FileInputStream(file);
    // 2.构造转换流(是继承Reader的)
    InputStreamReader inputStreamReader = new InputStreamReader(fileInputStream);
    // 3.构造缓冲字符流
    BufferedReader bufferedReader = new BufferedReader(inputStreamReader);
    // 备注1，2两步骤体现出了适配器模式
    // 2步骤体现了InputStreamReader类具有将字节输入流转换为字符输入流的功能
    // 2,3两步骤体现了装饰模式(wrapper包装模式)   
}
```

*io中的适配器模式*

由于InputStream是字节流不能享受到字符流读取字符那么便捷的功能，因此借助InputStreamReader将其转为Reader子类，因此可以拥有便捷操作文本文件方法.
OutputStream同理

*io中的装饰(包装)模式*

将InputStream字节流包装为BufferedReader过程就是装饰的过程。一开始InputStream只有read一个字节的方法，包装为Reader之后拥有read一个字符的功能，在包装成BufferdReader之后就拥有read一行字符串功能。OutputStream同理.

**介绍一下单例模式？懒汉式的单例模式如何实现单例？**

单例模式是一种常见的设计模式，单例模式的写法有好几种，这里主要介绍三种：懒汉式单例、饿汉式单例。单例模式有以下特点：1.单例类只能有一个实例；2.单例类必须自己创建自己的唯一实例；3.单例类必须给所有其他对象提供这一实例.

*饿汉式代码(类一加载就创建对象)*

```java
public class Student {
    private Student(){}

    private static Student stu = new Student();

    public static Student getStudent(){
        return stu;
    }
}
```

*懒汉式代码(用的时候，才去创建对象)*

```java
public class Teacher() {
    private Teacher(){}
    private static Teacher tea = null;
    public synchronized static Teacher getTeacher(){
        if (tea == null){
            tea = new Teacher();
        }
    }
}

public class Test {
    public static void main(String[] args) {
        Teacher t1 = Teacher.getTeacher();
        Teacher t2 = Teacher.getTeacher();
        System.out.println(t1 == t2)
    }
}
```

**介绍一下策略模式？**

在策略模式（Strategy Pattern）中，一个类的行为或其算法可以在运行时更改。这种类型的设计模式属于行为型模式。

在策略模式中，我们创建表示各种策略的对象和一个行为随着策略对象改变而改变的 context 对象。策略对象改变 context 对象的执行算法。

```java
public interface Strategy {
    public int doOperation(int num1, int num2);
}

public class OperationAdd implements Strategy {
    @Override
    public int doOperation(int num1, int num2){
        return num1 + num2;
    }
}

public class OperationSubstract implements Strategy{
   @Override
   public int doOperation(int num1, int num2) {
      return num1 - num2;
   }
}

public class OperationMultiply implements Strategy{
   @Override
   public int doOperation(int num1, int num2) {
      return num1 * num2;
   }
}

public class Context {
    private Strategy strategy;

    public Context(Strategy strategy){
        this.strategy = strategy;
    }

    public int executeStrategy(int num1, int num2) {
        return strategy.doOperation(num1, num2);
    }
}

public class StrategyPatternDemo {
    public static void main(String[] args) {
        Context context = new Context(new OperationAdd());
        System.out.println("10 + 5 = " + context.executeStrategy(10, 5));
 
        context = new Context(new OperationSubstract());      
        System.out.println("10 - 5 = " + context.executeStrategy(10, 5));
 
        context = new Context(new OperationMultiply());    
        System.out.println("10 * 5 = " + context.executeStrategy(10, 5));
    }
}
```

**设计模式了解哪些，手写一下观察者模式？**

当对象间存在一对多关系时，则使用观察者模式（Observer Pattern）。比如，当一个对象被修改时，则会自动通知它的依赖对象。观察者模式属于行为型模式。

```java
public class Subject {
   
   private List<Observer> observers 
      = new ArrayList<Observer>();
   private int state;
 
   public int getState() {
      return state;
   }
 
   public void setState(int state) {
      this.state = state;
      notifyAllObservers();
   }
 
   public void attach(Observer observer){
      observers.add(observer);      
   }
 
   public void notifyAllObservers(){
      for (Observer observer : observers) {
         observer.update();
      }
   }  
}

public abstract class Observer {
   protected Subject subject;
   public abstract void update();
}

public class BinaryObserver extends Observer{
 
   public BinaryObserver(Subject subject){
      this.subject = subject;
      this.subject.attach(this);
   }
 
   @Override
   public void update() {
      System.out.println( "Binary String: " 
      + Integer.toBinaryString( subject.getState() ) ); 
   }
}

public class OctalObserver extends Observer{
 
   public OctalObserver(Subject subject){
      this.subject = subject;
      this.subject.attach(this);
   }
 
   @Override
   public void update() {
     System.out.println( "Octal String: " 
     + Integer.toOctalString( subject.getState() ) ); 
   }
}

public class HexaObserver extends Observer{
 
   public HexaObserver(Subject subject){
      this.subject = subject;
      this.subject.attach(this);
   }
 
   @Override
   public void update() {
      System.out.println( "Hex String: " 
      + Integer.toHexString( subject.getState() ).toUpperCase() ); 
   }
}

public class ObserverPatternDemo {
   public static void main(String[] args) {
      Subject subject = new Subject();
 
      new HexaObserver(subject);
      new OctalObserver(subject);
      new BinaryObserver(subject);
 
      System.out.println("First state change: 15");   
      subject.setState(15);
      System.out.println("Second state change: 10");  
      subject.setState(10);
   }
}
```

**说说你所熟悉或听说过的j2ee中的几种常用模式?及对设计模式的一些看法**



**j2ee常用的设计模式？说明工厂模式**



**开发中都用到了那些设计模式?用在什么场合?**



**简述一下你了解的Java设计模式**


