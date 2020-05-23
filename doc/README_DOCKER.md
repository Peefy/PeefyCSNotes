
## Docker笔记

Docker 是一个开源的应用容器引擎，基于 Go 语言 并遵从Apache2.0协议开源。

Docker 可以让开发者打包他们的应用以及依赖包到一个轻量级、可移植的容器中，然后发布到任何流行的 Linux 机器上，也可以实现虚拟化。

容器是完全使用沙箱机制，相互之间不会有任何接口,更重要的是容器性能开销极低。

**容器和虚拟机VM之间的差异**

VM 利用 Hypervisor 虚拟化技术来模拟 CPU、内存等硬件资源，这样就可以在宿主机上建立一个 Guest OS，这是常说的安装一个虚拟机。每一个 Guest OS 都有一个独立的内核，比如 Ubuntu、CentOS 甚至是 Windows 等，在这样的 Guest OS 之下，每个应用都是相互独立的，VM 可以提供一个更好的隔离效果。但这样的隔离效果需要付出一定的代价，因为需要把一部分的计算资源交给虚拟化，这样就很难充分利用现有的计算资源，并且每个 Guest OS 都需要占用大量的磁盘空间，比如 Windows 操作系统的安装需要 10~30G 的磁盘空间，Ubuntu 也需要 5~6G，同时这样的方式启动很慢。正是因为虚拟机技术的缺点，催生出了容器技术。 容器是针对于进程而言的，因此无需 Guest OS，只需要一个独立的文件系统提供其所需要文件集合即可。所有的文件隔离都是进程级别的，因此启动时间快于 VM，并且所需的磁盘空间也小于 VM。当然了，进程级别的隔离并没有想象中的那么好，隔离效果相比 VM 要差很多。总体而言，容器和 VM 相比，各有优劣，因此容器技术也在向着强隔离方向发展。

**容器的特点**

* 容器是一个进程集合，具有自己独特的视图视角；
* 镜像是容器所需要的所有文件集合，其具备一次构建、到处运行的特点；
* 容器的生命周期和 initial 进程的生命周期是一样的；
* 容器和 VM 相比，各有优劣，容器技术在向着强隔离方向发展。

**Docker的应用场景**

* **简化程序**-Docker 让开发者可以打包他们的应用以及依赖包到一个可移植的容器中，然后发布到任何流行的 Linux 机器上，便可以实现虚拟化。Docker改变了虚拟化的方式，使开发者可以直接将自己的成果放入Docker中进行管理。方便快捷已经是 Docker的最大优势，过去需要用数天乃至数周的	任务，在Docker容器的处理下，只需要数秒就能完成。
* **避免选择恐惧症：**-如果你有选择恐惧症，还是资深患者。Docker 帮你	打包你的纠结！比如 Docker 镜像；Docker 镜像中包含了运行环境和配置，所以 Docker 可以简化部署多种应用实例工作。比如 Web 应用、后台应用、数据库应用、大数据应用比如 Hadoop 集群、消息队列等等都可以打包成一个镜像部署。
* **节省开支**-一方面，云计算时代到来，使开发者不必为了追求效果而配置高额的硬件，Docker 改变了高性能必然高价格的思维定势。Docker 与云的结合，让云空间得到更充分的利用。不仅解决了硬件管理的问题，也改变了虚拟化的方式。

**Docker 架构**

Docker 使用客户端-服务器 (C/S) 架构模式，使用远程API来管理和创建Docker容器。

Docker 容器通过 Docker 镜像来创建。

`容器`与`镜像`的关系类似于面向对象编程中的`对象`与`类`。

Docker|面向对象
-|-
容器|对象
镜像|类

Docker内容|介绍
-|-
Docker 镜像(Images)|Docker 镜像是用于创建 Docker 容器的模板。
Docker 容器(Container)|容器是独立运行的一个或一组应用。
Docker 客户端(Client)|Docker 客户端通过命令行或者其他工具使用 Docker API 与 Docker 的守护进程通信。
Docker 主机(Host)|一个物理或者虚拟的机器用于执行 Docker 守护进程和容器。
Docker 仓库(Registry)|Docker 仓库用来保存镜像，可以理解为代码控制中的代码仓库。Docker Hub(https://hub.docker.com) 提供了庞大的镜像集合供使用。
Docker Machine|Docker Machine是一个简化Docker安装的命令行工具，通过一个简单的命令行即可在相应的平台上安装Docker，比如VirtualBox、 Digital Ocean、Microsoft Azure。

**Docker Hello World**

Docker 允许在容器内运行应用程序， 使用 docker run 命令来在容器内运行一个应用程序。

```linux
docker run ubuntu:15.10 /bin/echo "Hello world"
```

各个参数解析:
* **docker**-Docker 的二进制执行文件。
* **run**-与前面的 docker 组合来运行一个容器。
* **ubuntu:15.10**-指定要运行的镜像，Docker首先从本地主机上查找镜像是否存在，如果不存在，Docker 就会从镜像仓库 Docker Hub 下载公共镜像。
* **/bin/echo "Hello world"**-在启动的容器里执行的命令

**运行交互式的容器**

通过docker的两个参数 -i -t，让docker运行的容器实现"对话"的能力

* **-t**-在新容器内指定一个伪终端或终端。
* **-i**-允许你对容器内的标准输入 (STDIN) 进行交互。

**启动容器（后台模式）**

使用以下命令创建一个以进程方式运行的容器

```bash
> runoob@runoob:~$ docker run -d ubuntu:15.10 /bin/sh -c "while true; do echo hello world; sleep 1; done"
> 2b1b7a428627c51ab8810d541d759f072b4fc75487eed05812646b8534a2fe63
```

这个长字符串叫做容器ID, 对每个容器来说都是唯一的, 可以通过容器ID来查看对应的容器发生了什么。

可以通过docker ps 查看是否有容器在运行.

* **CONTAINER ID**-容器ID
* **NAMES**-自动分配的容器名称

在容器内使用docker logs命令，查看容器内的标准输出

```bash
docker logs 2b1b7a428627
```

**停止容器**

使用 `docker stop` 命令来停止容器:

**Docker 容器使用**

`docker客户端`非常简单 ,我们可以直接输入 docker 命令来查看到 Docker 客户端的所有命令选项。

可以通过命令 **docker command --help** 更深入的了解指定的 Docker 命令使用方法。

**通过运行一个web应用**

将在docker容器中运行一个 Python Flask 应用来运行一个web应用。

```bash
> docker pull training/webapp  # 载入镜像
docker run -d -P training/webapp python app.py
```

参数说明：
* **-d**-让容器在后台运行。
* **-P**-将容器内部使用的网络端口映射到我们使用的主机上

使用 docker ps 来查看正在运行的容器：

```linux
> docker ps
CONTAINER ID        IMAGE               COMMAND             ...        PORTS                 
d3d5e39ed9d3        training/webapp     "python app.py"     ...        0.0.0.0:32769->5000/tcp
```

**网络端口的快捷方式**

通过 `docker ps` 命令可以查看到容器的端口映射，`docker` 还提供了另一个快捷方式 `docker port`，使用 `docker port` 可以查看指定 （ID 或者名字）容器的某个确定端口映射到宿主机的端口号。

上面我们创建的 web 应用容器 ID 为 `bf08b7f2cd89` 名字为 `wizardly_chandrasekhar`。

我可以使用 `docker port bf08b7f2cd89` 或 `docker port wizardly_chandrasekhar` 来查看容器端口的映射情况。

**查看 WEB 应用程序日志**

docker logs \[ID或者名字\] 可以查看容器内部的标准输出。

**-f**:让 docker logs 像使用 tail -f 一样来输出容器内部的标准输出。

**查看WEB应用程序容器的进程**

使用 docker top 来查看容器内部运行的进程

```bash
> docker top wizardly_chandrasekhar
UID     PID         PPID          ...       TIME                CMD
root    23245       23228         ...       00:00:00            python app.py
```

**检查 WEB 应用程序**

使用 **docker inspect** 来查看 Docker 的底层信息。它会返回一个 JSON 文件记录着 Docker 容器的配置和状态信息。

```bash
> docker inspect wizardly_chandrasekhar
[
    {
        "Id": "bf08b7f2cd897b5964943134aa6d373e355c286db9b9885b1f60b6e8f82b2b85",
        "Created": "2018-09-17T01:41:26.174228707Z",
        "Path": "python",
        "Args": [
            "app.py"
        ],
        "State": {
            "Status": "running",
            "Running": true,
            "Paused": false,
            "Restarting": false,
            "OOMKilled": false,
            "Dead": false,
            "Pid": 23245,
            "ExitCode": 0,
            "Error": "",
            "StartedAt": "2018-09-17T01:41:26.494185806Z",
            "FinishedAt": "0001-01-01T00:00:00Z"
        },
......
```

**Docker 镜像使用**

当运行容器时，使用的镜像如果在本地中不存在，docker 就会自动从 docker 镜像仓库中下载，默认是从 Docker Hub 公共镜像源下载。

* 管理和使用本地 Docker 主机镜像
* 创建镜像

可以使用 *docker images* 来列出本地主机上的镜像

```bash
> docker images
REPOSITORY        TAG      IMAGE ID        CREATED         SIZE
ubuntu            14.04   90d5884b1ee0    5 days ago     188 MB
php               5.6     f40e9e0f10c8    9 days ago     444.8 MB
nginx            latest   6f8d099c3adc    12 days ago    182.7 MB
mysql             5.6     f2e8d6c772c0    3 weeks ago    324.6 MB
httpd            latest   02ef73cf1bc0    3 weeks ago    194.4 MB
ubuntu           15.10    4e3b13c8a266    4 weeks ago    136.3 MB
hello-world      latest   690ed74de00f    6 months ago   960 B
training/webapp  latest   6fae60ef3446    11 months ago  348.8 MB
```

各个选项说明:

* **REPOSITORY**-表示镜像的仓库源
* **TAG**-镜像的标签
* **IMAGE ID**-镜像ID
* **CREATED**-镜像创建时间
* **SIZE**-镜像大小

**获取一个新的镜像**

当我们在本地主机上使用一个不存在的镜像时 `Docker` 就会自动下载这个镜像。如果我们想预先下载这个镜像，我们可以使用 `docker pull` 命令来下载它。

**查找镜像**

我们可以从 Docker Hub 网站来搜索镜像，Docker Hub 网址为： https://hub.docker.com/
我们也可以使用 docker search 命令来搜索镜像。比如我们需要一个httpd的镜像来作为我们的web服务。我们可以通过 docker search 命令搜索 httpd 来寻找适合我们的镜像。

```bash
dock search httpd
```

* **NAME**-镜像仓库源的名称
* **DESCRIPTION**-镜像的描述
* **OFFICIAL**-是否docker官方发布

**创建镜像**

从docker镜像仓库中下载的镜像不能满足我们的需求时，我们可以通过以下两种方式对镜像进行更改。
* 从已经创建的容器中更新镜像，并且提交这个镜像
* 使用 Dockerfile 指令来创建一个新的镜像

**更新镜像**

在运行的容器内使用 apt-get update 命令进行更新。

在完成操作之后，输入 exit命令来退出这个容器。

```bash
> docker commit -m="has update" -a="runoob" e218edb10161 runoob/ubuntu:v2
> sha256:70bf1840fd7c0d2d8ef0a42a817eb29f854c1af8f7c59fc03ac7bdee9545aff8
```

各个参数说明：
* **-m**-提交的描述信息
* **-a**-指定镜像作者
* **e218edb10161**-容器ID
* **runoob/ubuntu:v2**-指定要创建的目标镜像名

**构建镜像**

使用命令 `docker build` ， 从零开始来创建一个新的镜像。为此，我们需要创建一个 Dockerfile 文件，其中包含一组指令来告诉 Docker 如何构建我们的镜像。

参数说明
* **-t**-指定要创建的目标镜像名
* **.**-Dockerfile 文件所在目录，可以指定Dockerfile 的绝对路径

**Docker 容器连接**

前面实现了通过网络端口来访问运行在 docker 容器内的服务。下面我们来实现通过端口连接到一个 docker 容器

**网络端口映射**

```bash
> docker run -d -P training/webapp python app.py
> fce072cc88cee71b1cdceb57c2821d054a4a59f67da6b416fceb5593f059fc6d
```

使用 `-P` 参数创建一个容器，使用 `docker ps` 可以看到容器端口 5000 绑定主机端口 32768。

也可以使用 -p 标识来指定容器端口绑定到主机端口。

*区别*

* **-P**-是容器内部端口随机映射到主机的高端口。
* **-p**-是容器内部端口绑定到指定的主机端口。

*docker port*-命令可以让我们快捷地查看端口的绑定情况。

**Docker容器连接**

端口映射并不是唯一把 docker 连接到另一个容器的方法。docker 有一个连接系统允许将多个容器连接在一起，共享连接信息。docker 连接会创建一个父子关系，其中父容器可以看到子容器的信息。

**Docker 命令大全**

* **容器生命周期管理**-
    1. run
    2. start/stop/restart
    3. kill
    4. rm
    5. pause/unpause
    6. create
    7. exec
* **容器操作**-
    1. ps
    2. inspect
    3. top
    4. attach
    5. events
    6. logs
    7. wait
    8. export
    9. port
* **容器rootfs命令**-
    1. commit
    2. cp
    3. diff
* **镜像仓库**-
    1. login
    2. pull
    3. push
    4. search
* **本地镜像管理**-
    1. images
    2. rmi
    3. tag
    4. build
    5. history
    6. save
    7. load
    8. import
* **info|version**-
    1. info
    2. version


