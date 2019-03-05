
## 操作系统

线程、进程的区别？

## Linux

### Linux简介

Linux是一套免费使用核自由传播的类Unix操作系统，是一个基于POSIX和UNIX的多用户、多任务、支持多线程和多CPU的操作系统

Linux能运行主要的UNIX工具软件、应用程序和网络协议。支持32位和64位硬件。Linux继承了Unix以网络为核心的设计思想，是一个性能稳定的多用户网络操作系统

**Linux的发行版本**

Linux的发行版本说简单点就是将Linux内核与应用软件做一个打包

知名的发行版：Ubuntu、RedHat、CentOS、Debian、Fedora、SuSE、OpenSUSE、Arch Linux、SolusOS等

**Linux应用领域**

各种场合都适用各种Linux发行版，从嵌入式设备到超级计算机，并且在服务器领域确定了地位，通常服务器适用LAMP(Linux+Apache+MySQL+PHP)或(Linux+Nginx+MySQL+PHP)组合

### Linux安装

[64位Linux系统CentOS](http://www.runoob.com/linux/linux-install.html)

### Linux系统启动过程

* 内核引导：打开电源，BIOS开机自检，按照设置的启动设备（硬盘）启动，操作系统接管硬件，首先读入/boot目录下的内核文件
* 运行init：init进程是系统所有进程的起点，是所有进程的老祖宗，没有这个进程，系统中任何进程都不会启动，init进程首先读取配置文件/etc/inittab。

许多程序需要开机启动，在windows叫做服务(service)，在linux叫做守护进程(daemon),但是不同的场合需要启动不同的程序，比如用作服务器时，需要启动Apache，用作桌面就不需要。Linux允许为不同的场合，分配不同的开机启动程序，这就叫做“运行级别”(runlevel),就是说，启动时根据“运行级别”，确定要运行哪些程序。

Linux系统由7个运行级别

* 系统初始化：在init的配置文件中有这么一行：si::sysinit"/etc/rc.d/rc.sysinit 调用了/etc/rc.d/rc.sysinit,而它是bash shell脚本
* 建立终端：rc执行完毕后，返回init。这时基本系统环境已经建立好了，各种守护进程也已经启动了。init接下来会打开6个终端，以便用户登录系统，
* 用户登录系统：命令行登录、ssh登录、图形界面登录

**图形模式与文字模式相互切换**

Linux预设提供了六个命令窗口终端机让我们登录，默认登录窗口tty1，可以按下Ctrl+Alt+F1~F6来切换，如果安装了图形界面，默认情况进入图形界面，Ctrl+Alt+F7可以从文字模式界面回到图形模式界面

**Linux关机**

在Linux领域内大多用在服务器上，很少遇到关机的操作。服务器上跑一个服务是永无止境的，除非特殊情况下

正确关机的流程：sync > shutdown > reboot > halt

关机指令为：shutdown，可以使用man shutdown来看一下帮助文档

sync: 将数据由内存同步到硬盘中

### Linux系统结构目录

在Linux或Unix操作系统中，所有的文件和目录都被组织成以一个根结点开始的倒置的树状结构。文件系统的最顶层是由根目录开始的，系统使用/来表示根目录
* . : 代表当前的目录，也可以使用./来表示
* .. : 代表上一层目录，也可以../来代表

登录系统后，在当前命令窗口下输入命令，可以看到树状目录结构
```shell
ls /
```

* /bin : bin是Binary的缩写，存放着最经常使用的命令
* /boot : 存放的是启动Linux时使用的一些核心文件，包括一些连接文件以及镜像文件
* /dev : dev是Device(设备)的缩写，该目录下存放的是Linux的外部设备，在Linux中访问设备的方式和访问文件的方式是相同的。
* /etc : 这个目录用来存放所有的系统管理所需要的配置文件和子目录
* /home : 用户的主目录，在Linux中，每个用户都有一个自己的目录，一般该目录名是以用户的账号命名的
* /lib : 存放着系统最基本的动态链接共享库，类似于Windows里的DLL文件。几乎所有的应用程序都需要用到这些共享库
* /lost+found : 这个目录一般情况下是空的，当系统非法关机后，这里就存放了一些文件
* /media : linux系统会自动识别一些设备，例如一些设备，例如U盘，光驱等等，当识别后，linux会把识别的设备挂到这个目录下
* /mnt : 系统提供该目录是为了让用户临时挂载别的文件系统的，可以将光驱挂载在/mnt/上，然后进入该目录就可以查看光驱里的内容
* /opt : 这是给主机额外安装软件所摆放的目录。比如你安装一个ORACLE数据库则就可以放到这个目录下，默认是空的
* /proc : 虚拟的目录，系统内存的映射
* /root : 该目录为系统管理员，也称作超级权限者的用户主目录
* /sbin : s就是Super User的意思，这里存放的是系统管理员使用的系统管理程序
* /selinux : 这个目录是Redhat/CentOS所特有的目录，Selinux是一个安全机制，类似于windows的防火墙，但是这套机制比较复杂，这个目录就是存放selinux相关的文件的
* /srv : 该目录存放一些服务启动之后需要提取的数据
* /sys : 这是linux2.6内核一个很大的变化，该目录下安装了2.6内核中新出现的一个文件系统sysfs文件系统集成了下面3中文件系统的信息：针对进程信息的proc文件系统、针对设备的devfs文件系统以及针对伪终端的devpts文件系统
* /tmp : 存放一些临时文件
* /usr : 这是一个非常重要的目录，用户的很多应用程序和文件都放在这个目录下，类似于windows的program files目录
* /usr/bin : 系统用户使用的应用程序
* /usr/sbin : 超级用几用户使用的比较高级的管理程序和系统守护程序
* /usr/src : 内核源代码默认的放置目录
* /var : 
* /run : 

在Linux系统中，有几个目录是比较重要的，注意不要误删除或者随意更改内部文件。

/etc : 上边也提到了，是系统的配置文件，如果更改了该目录下的某个文件可能会导致系统不能启动

/bin,/sbin,/usr/bin,/usr/sbin : 这是系统预设的执行文件的放置目录，比如ls就是/bin/ls目录下的。值得提出的是，/bin,/usr/bin是给系统用户使用的指令(除root外的通用户),而/sbin,/usr/sbin则是给root使用的指令。

/var : 非常重要的目录，系统上跑了很多程序，那么每个程序都会有相应的日志产生，而这些日志就被记录到这个目录下，具体在/var/log目录下，另外mail的预设放置也是在这里.

/run : 临时文件系统，存储系统启动以来的信息。当系统重启时，这个目录下的文件应该被删除或清除。如果系统上有/var/run目录,应该指向run

### Linux忘记密码解决方法

忘记密码后，不需要重新安装系统，进入单用户模式更改一下root密码即可。

### Linux远程登录

### Linux文件基本属性

### Linux文件与目录管理

### Linux用户和用户组管理

### Linux磁盘管理

### Linux vi/vim

### Linux yum命令

### Linux命令大全

[菜鸟教程链接](http://www.runoob.com/linux/linux-command-manual.html)

## Shell

### Shell教程

### Shell变量

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
