
# Kubernetes(k8s)笔记

生产级容器编排调度与管理，[Github项目链接](https://github.com/kubernetes/kubernetes)

Kubernetes是一个开源系统，用于跨多个主机管理容器化的应用程序。它提供了用于部署，维护和扩展应用程序的基本机制。Kubernetes由云原生计算基金会（CNCF）托管。如果公司希望帮助塑造容器包装，动态调度和面向微服务的技术的发展，请考虑加入CNCF。

Kubernetes 脱胎于 Google 的 Borg 系统，是一个功能强大的容器编排系统。Kubernetes 及其整个生态系统（工具、模块、插件等）均使用 Go 语言编写，从而构成一套面向 API、可高速运行的程序集合，这些程序文档精良、易于参与贡献或在其上构建应用程序。

[k8s官方文档](https://kubernetes.io/docs/tutorials/kubernetes-basics/)

## Kubernetes基础

教程的作用：

* 在集群上部署容器化的应用程序。
* 扩展部署。
* 使用新的软件版本更新容器化的应用程序。
* 调试容器化的应用程序。

使用现代的Web服务，用户希望应用程序可以24/7全天候可用，而开发人员则希望每天多次部署这些应用程序的新版本。容器化有助于打包软件来实现这些目标，从而使应用程序可以轻松快速地发布和更新，而无需停机。**Kubernetes**可帮助确保那些容器化的应用程序在所需的位置和时间运行，并帮助他们找到工作所需的资源和工具。**Kubernetes是一个可投入生产的开放源代码平台**

## 创建集群

Kubernetes协调连接在一起作为单个单元工作的高可用性计算机集群。Kubernetes中的抽象允许将容器化的应用程序部署到集群，而无需将它们专门绑定到单个机器。为了利用这种新的部署模型，需要以一种将应用程序与各个主机分离的方式打包应用程序：它们需要进行容器化。容器化的应用程序比过去的部署模型更加灵活和可用，在过去的部署模型中，将应用程序直接安装在特定的计算机上，而程序包已与主机深度集成。Kubernetes以更有效的方式自动在整个集群中分配和调度应用程序容器。

Kubernetes集群包含两种类型的资源：

* 主坐标的集群
* 节点是运行应用程序的工作程序

**主机负责管理群集**。主服务器协调集群中的所有活动，例如调度应用程序，维护应用程序的所需状态，扩展应用程序以及推出新的更新。

**节点是充当Kubernetes集群中的辅助计算机的VM或物理计算机**。每个节点都有一个Kubelet，它是用于管理节点并与Kubernetes主节点通信的代理。该节点还应该具有用于​​处理容器操作的工具，例如Docker或rkt。处理生产流量的Kubernetes集群至少应具有三个节点。

在Kubernetes上部署应用程序时，告诉主机启动应用程序容器。主服务器计划容器在群集的节点上运行。**节点使用主机公开的Kubernetes API与主机进行通信**。最终用户还可以直接使用Kubernetes API与集群进行交互。

Kubernetes集群可以部署在物理机或虚拟机上。要开始Kubernetes开发，可以使用**Minikube**。**Minikube**是一种轻量级的Kubernetes实现，可在本地计算机上创建VM并部署仅包含一个节点的简单集群。**Minikube**可用于Linux，macOS和Windows系统。Minikube CLI提供了用于引导群集的基本引导程序操作，包括启动，停止，状态和删除。

## 部署应用

### 使用`kubectl`创建部署

拥有运行中的Kubernetes集群后，可以在其之上部署容器化的应用程序。为此，将创建一个Kubernetes 部署配置。部署指示Kubernetes如何创建和更新应用程序实例。创建部署后，Kubernetes主节点将调度该部署中包含的应用程序实例，使其在集群中的各个节点上运行。

创建应用程序实例后，Kubernetes部署控制器将持续监视这些实例。如果承载实例的节点发生故障或被删除，则部署控制器将实例替换为群集中另一个节点上的实例。这提供了一种**自我修复机制**来解决机器故障或维护。

在编排前的世界中，安装脚本通常用于启动应用程序，但是它们不允许从计算机故障中恢复。通过创建应用程序实例并使它们在节点上运行，Kubernetes部署为应用程序管理提供了根本不同的方法。

可以使用Kubernetes命令行界面Kubectl创建和管理部署。Kubectl使用Kubernetes API与集群进行交互。创建部署时，需要为应用程序指定容器映像以及要运行的副本数。

## 探索应用

### 查看窗格Pods和结点Nodes

在创建部署时，Kubernetes将创建一个Pod来承载应用程序实例。Pod是Kubernetes的抽象，代表一组一个或多个应用程序容器（例如Docker或rkt）以及这些容器的一些共享资源。这些资源包括：

* 共享存储（作为卷）
* 联网，作为唯一的群集IP地址
* 有关如何运行每个容器的信息，例如容器映像版本或要使用的特定端口

Pod为特定于应用程序的“逻辑主机”建模，并且可以包含相对紧密耦合的不同应用程序容器。例如，一个Pod可能同时包含带有Node.js应用程序的容器以及一个不同的容器，该容器将提供要由Node.js Web服务器发布的数据。Pod中的容器共享一个IP地址和端口空间，它们始终位于同一位置并共同调度，并在同一节点上的共享上下文中运行。

吊舱是Kubernetes平台上的原子单元。当在Kubernetes上创建Deployment时，该Deployment将在Pod中创建内部包含容器的Pod（与直接创建容器相反）。每个Pod都绑定到计划的节点上，并保持在那里，直到终止（根据重新启动策略）或删除为止。如果节点发生故障，则会在群集中的其他可用节点上调度相同的Pod。

Pod始终在Node上运行。节点是Kubernetes中的工作机，并且可以是虚拟机或物理机，具体取决于集群。每个节点由主节点管理。一个节点可以有多个Pod，Kubernetes主节点会自动处理跨集群中所有Node调度Pod的过程。主节点的自动调度考虑了每个节点上的可用资源。如果容器紧密耦合并且需要共享磁盘之类的资源，则仅应在单个Pod中一起计划容器。

每个Kubernetes节点至少运行：

* Kubelet，一个负责Kubernetes Master与Node之间通信的过程；它管理Pods和在机器上运行的容器。
* 容器运行时（例如Docker，rkt）负责从注册表中提取容器映像，解压缩容器并运行应用程序。

### 使用Kubectl进行故障排除

可以使用以下kubectl命令完成最常见的操作：

* **kubectl get**-列表资源
* **kubectl describe**-显示有关资源的详细信息
* **kubectl logs**-从容器中的容器中打印日志
* **kubectl exec**-在容器中的容器上执行命令

可以使用这些命令来查看应用程序的部署时间，它们的当前状态，运行的位置以及它们的配置。

## 使用服务公开应用

Kubernetes Pod是致命的。Pod实际上有生命周期。当工作节点死亡时，在该节点上运行的Pod也将丢失。然后，ReplicaSet可能会通过创建新Pod来动态地将群集驱动回所需的状态，以保持您的应用程序运行。作为另一个示例，请考虑具有3个副本的图像处理后端。这些副本是可交换的。前端系统不应该关心后端副本，即使Pod丢失并重新创建也是如此。也就是说，Kubernetes集群中的每个Pod都有一个唯一的IP地址，即使是同一节点上的Pod也是如此，因此需要一种自动协调Pod之间的更改的方法，以便您的应用程序继续运行。

Kubernetes中的服务是一种抽象，定义了Pod的逻辑集和访问Pod的策略。服务使从属Pod之间的松散耦合成为可能。像所有Kubernetes对象一样，使用YAML （首选）或JSON 定义服务。服务所针对的Pod集合通常由LabelSelector决定（请参见下文，了解为什么不包括selector在规范中就可能需要服务）。

尽管每个Pod都有一个唯一的IP地址，但是如果没有服务，这些IP不会暴露在群集外部。服务允许您的应用程序接收流量。通过`type`在ServiceSpec中指定可以以不同的方式公开服务：

* ClusterIP（默认）-在群集的内部IP上公开服务。这种类型使得只能从群集内访问服务。
* NodePort-使用NAT在群集中每个选定节点的相同端口上公开服务。使用可以从群集外部访问服务`<NodeIP>:<NodePort>`。ClusterIP的超集。
* LoadBalancer-在当前云中创建一个外部负载平衡器（如果支持），并为该服务分配一个固定的外部IP。NodePort的超集。
* ExternalName-`externalName`通过返回具有该名称的CNAME记录，使用任意名称（在规范中指定）公开服务。不使用代理。此类型需要v1.7或更高版本`kube-dns`。

*注意，服务中有一些用例涉及`selector`规范中未定义的情况。`selector`没有创建的服务也不会创建相应的Endpoints对象。这使用户可以将服务手动映射到特定端点。为什么没有选择器的另一种可能是您严格使用`type: ExternalName`。*

服务在一组Pod之间路由流量。服务是允许Pod在Kubernetes中死亡和复制而又不影响您的应用程序的抽象。Kubernetes Services处理在依赖的Pod（例如应用程序中的前端和后端组件）之间的发现和路由。

服务使用标签和选择器来匹配一组Pod，这是一个分组原语，允许对Kubernetes中的对象进行逻辑操作。标签是附加在对象上的键/值对，可以以多种方式使用：

* 指定用于开发，测试和生产的对象
* 嵌入版本标签
* 使用标签对对象进行分类

标签可以在创建时或以后附加到对象。可以随时修改它们。

## 扩展应用

使用`kubectl`缩放引用程序

扩展部署将确保创建新Pod并将其调度到具有可用资源的节点上。缩放会将Pod的数量增加到新的所需状态。Kubernetes还支持Pods的自动缩放，但超出了本教程的范围。缩放到零也是可能的，它将终止指定Deployment的所有Pod。

运行一个应用程序的多个实例将需要一种将流量分配给所有实例的方法。服务具有集成的负载均衡器，可以将网络流量分发到公开部署的所有Pod。服务将使用端点连续监视正在运行的Pod，以确保流量仅发送到可用Pod。

通过更改部署中的副本数来完成扩展。

一旦运行了一个应用程序的多个实例，就可以在不停机的情况下进行滚动更新。将在下一个模块中介绍它。现在，让转到在线终端并扩展应用程序。

## 更新应用

使用`kubectl`执行滚动更新

用户期望应用程序始终可用，而开发人员则需要每天多次部署它们的新版本。在Kubernetes中，这是通过滚动更新来完成的。滚动更新允许通过用新的Pod实例增量更新Pod实例，从而在零停机时间内进行Deployment的更新。新的Pod将在具有可用资源的节点上安排。

在上一个模块中，扩展了应用程序以运行多个实例。这是执行更新而不影响应用程序可用性的要求。默认情况下，在更新过程中不可用的Pod的最大数量和可以创建的新Pod的最大数量为1。这两个选项都可以配置为数字或百分比（按Pod）。在Kubernetes中，对更新进行版本控制，并且任何部署更新都可以还原为先前（稳定）的版本。

与应用程序扩展类似，如果公开公开部署，则该服务将在更新过程中仅将流量负载均衡到可用Pod。可用的Pod是可供应用程序用户使用的实例。

滚动更新允许执行以下操作：

* 将应用程序从一种环境升级到另一种环境（通过容器映像更新）
* 回滚到以前的版本
* 持续集成和持续交付应用程序，停机时间为零

## 使用ConfigMap配置Redis

* 创建一个kustomization.yaml包含以下内容的文件：
- ConfigMap生成器
- 使用ConfigMap的Pod资源配置
* 通过运行应用目录 kubectl apply -k ./
* 验证配置是否正确应用。

```sh
curl -OL https://k8s.io/examples/pods/config/redis-config

cat <<EOF >./kustomization.yaml
configMapGenerator:
- name: example-redis-config
  files:
  - redis-config
EOF
```

```yaml
apiVersion: v1
kind: Pod
metadata:
  name: redis
spec:
  containers:
  - name: redis
    image: redis:5.0.4
    command:
      - redis-server
      - "/redis-master/redis.conf"
    env:
    - name: MASTER
      value: "true"
    ports:
    - containerPort: 6379
    resources:
      limits:
        cpu: "0.1"
    volumeMounts:
    - mountPath: /redis-master-data
      name: data
    - mountPath: /redis-master
      name: config
  volumes:
    - name: data
      emptyDir: {}
    - name: config
      configMap:
        name: example-redis-config
        items:
        - key: redis-config
          path: redis.conf
```

```sh
curl -OL https://raw.githubusercontent.com/kubernetes/website/master/content/en/examples/pods/config/redis-pod.yaml

cat <<EOF >>./kustomization.yaml
resources:
- redis-pod.yaml
EOF
```

## 无状态应用-公开外部IP地址以访问群集中的应用程序

```yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  labels:
    app.kubernetes.io/name: load-balancer-example
  name: hello-world
spec:
  replicas: 5
  selector:
    matchLabels:
      app.kubernetes.io/name: load-balancer-example
  template:
    metadata:
      labels:
        app.kubernetes.io/name: load-balancer-example
    spec:
      containers:
      - image: gcr.io/google-samples/node-hello:1.0
        name: hello-world
        ports:
        - containerPort: 8080
```

```sh
kubectl apply -f https://k8s.io/examples/service/load-balancer-example.yaml
```

前面的命令创建一个 Deployment 对象和一个关联的 ReplicaSet 对象。该ReplicaSet有五个步骤，每个运行Hello World应用程序。

* 显示有关部署的信息：

```sh
kubectl get deployments hello-world
kubectl describe deployments hello-world
```

* 显示有关您的ReplicaSet对象的信息：

```sh
kubectl get replicasets
kubectl describe replicasets
```

* 创建一个公开部署的Service对象：

```sh
kubectl expose deployment hello-world --type=LoadBalancer --name=my-service
```

* 显示有关服务的信息：

```sh
kubectl get services my-service
```

* 输出类似于以下内容：

```sh
NAME         TYPE           CLUSTER-IP     EXTERNAL-IP      PORT(S)    AGE
my-service   LoadBalancer   10.3.245.137   104.198.205.71   8080/TCP   54s
```

*注意：该type=LoadBalancer服务由外部云提供商支持，此示例未涵盖此服务，有关详细信息，请参阅此页面。*

```xml
<blockquote class="note">
```

注意：如果外部IP地址显示为`<pending>`，请等待一分钟，然后再次输入相同的命令。
显示有关服务的详细信息：

```sh
kubectl describe services my-service
```

输出类似于以下内容：

```sh
 Name:           my-service
 Namespace:      default
 Labels:         app.kubernetes.io/name=load-balancer-example
 Annotations:    <none>
 Selector:       app.kubernetes.io/name=load-balancer-example
 Type:           LoadBalancer
 IP:             10.3.245.137
 LoadBalancer Ingress:   104.198.205.71
 Port:           <unset> 8080/TCP
 NodePort:       <unset> 32377/TCP
 Endpoints:      10.0.0.6:8080,10.0.1.6:8080,10.0.1.7:8080 + 2 more...
 Session Affinity:   None
 Events:         <none>
```

记下LoadBalancer Ingress您的服务公开的外部IP地址（）。在此示例中，外部IP地址为104.198.205.71。还要注意的价值Port和NodePort。在此的示例Port 是8080和NodePort32377。

在前面的输出中，您可以看到该服务具有多个终结点：10.0.0.6:8080,10.0.1.6:8080,10.0.1.7:8080 +另外2个。这些是运行Hello World应用程序的Pod的内部地址。要验证这些是pod地址，请输入以下命令：

```sh
 kubectl get pods --output=wide
```

输出类似于以下内容：

```
 NAME                         ...  IP         NODE
 hello-world-2895499144-1jaz9 ...  10.0.1.6   gke-cluster-1-default-pool-e0b8d269-1afc
 hello-world-2895499144-2e5uh ...  10.0.1.8   gke-cluster-1-default-pool-e0b8d269-1afc
 hello-world-2895499144-9m4h1 ...  10.0.0.6   gke-cluster-1-default-pool-e0b8d269-5v7a
 hello-world-2895499144-o4z13 ...  10.0.1.7   gke-cluster-1-default-pool-e0b8d269-1afc
 hello-world-2895499144-segjf ...  10.0.2.5   gke-cluster-1-default-pool-e0b8d269-cpuc
```

使用外部IP地址（LoadBalancer Ingress）访问Hello World应用程序：

```
 curl http://<external-ip>:<port>
```

服务`<external-ip>`的外部IP地址（LoadBalancer Ingress）在哪里，并且`<port>`是Port服务说明中的值。如果您使用的是minikube，键入内容minikube service my-service将在浏览器中自动打开Hello World应用程序。

对成功请求的响应是一个问候消息：

```
 Hello Kubernetes!
```

要删除服务，请输入以下命令：

```
kubectl delete services my-service
```

要删除正在运行Hello World应用程序的Deployment，ReplicaSet和Pod，请输入以下命令：

```
kubectl delete deployment hello-world
```

## 有状态的应用

[官方教程](https://kubernetes.io/docs/tutorials/stateful-application/basic-stateful-set/)

## 集群

[官方教程](https://kubernetes.io/docs/tutorials/clusters/apparmor/)
