
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

**IO流熟悉吗，用的什么设计模式？**

**介绍一下单例模式？懒汉式的单例模式如何实现单例？**

**介绍一下策略模式？**
**设计模式了解哪些，手写一下观察者模式？**

**说说你所熟悉或听说过的j2ee中的几种常用模式?及对设计模式的一些看法**

**j2ee常用的设计模式？说明工厂模式**

**开发中都用到了那些设计模式?用在什么场合?**

**简述一下你了解的Java设计模式**
