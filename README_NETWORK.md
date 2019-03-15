# PeefyCSNotes

计算机科学与技术笔记

* 操作系统 Linux
* 计算机网络 TCP UDP HTTP
* 数据库 MySQL
* 算法
* 程序语言设计：面向对象、设计模式、容器Ioc&DI
* 编译原理

## 计算机网络

**网际互联及OSI七层模型**

* **物理层** : 定义一些电器，机械，过程和规范，如集线器(没有寻址的概念) bit
* **数据链路层** : 定义如何格式化数据，支持错误检测；以太网   frame
* **网络层** : 定义一个逻辑的寻址，选择最佳路径传输，路由数据包； packet
* **传输层** : 提供可靠和尽力而为的传输；TCP UDP 65535个端口
* **会话层** : 控制会话，建立管理终止应用程序会话；SQL ASP PHP JSP
* **表示层** : 格式化数据；ASCII JPEG MP3
* **应用层** : 控制应用程序；http，ftp

**TCP/IP协议**

TCP/IP是因特网的通信协议，是对计算机必须遵守的规则的描述，只有遵守这些规则，计算机之间才能进行通信

* 浏览器与服务器都在使用TCP/IP协议 
* E-mail使用TCP/IP协议
* 因特网网址是TCP/IP协议

TCP/IP 意味着 TCP 和 IP 在一起协同工作。
TCP 负责应用软件（比如您的浏览器）和网络软件之间的通信。
IP 负责计算机之间的通信。
TCP 负责将数据分割并装入 IP 包，然后在它们到达的时候重新组合它们。
IP 负责将包发送至接受者。

**TCP/IP定义**

TCP/IP 是供已连接因特网的计算机进行通信的通信协议。
TCP/IP 指传输控制协议/网际协议（Transmission Control Protocol / Internet Protocol）。
TCP/IP 定义了电子设备（比如计算机）如何连入因特网，以及数据如何在它们之间传输的标准。

**TCP/IP内部**

在 TCP/IP 中包含一系列用于处理数据通信的协议：
* TCP (传输控制协议) - 应用程序之间通信
* UDP (用户数据报协议) - 应用程序之间的简单通信
* IP (网际协议) - 计算机之间的通信
* ICMP (因特网消息控制协议) - 针对错误和状态
* DHCP (动态主机配置协议) - 针对动态寻址

**TCP 使用固定的连接**

TCP用于应用程序之间的通信，会发送一个通信请求。这个请求必须被送到一个确切的地址，在双方“握手”之后，TCP将在两个应用程序之间建立一个全双工(full-duplex)的通信。
这个全双工的通信将占用两个计算机之间的通信线路，直到它被一方或被双方关闭为止。
UDP和TCP很相似，但是更简单，同时可靠性低于TCP

**IP是无连接的**

IP用于计算机之间的通信，IP是无连接的通信协议。

IP是无连接的通信协议。不会占用两个正在通信的计算机之间的通信线路。这样IP降低了对网络线路的需求。每条线可以同时满足许多不同的计算机之间的通信需要。

通过IP，消息(或者其他数据)被分割为小的独立的包，并通过因特网在计算机之间传送。

IP负责将每个包路由至它的目的地

**IP路由器**

当一个IP包从一台计算机被发送，会到达一个IP路由器。

IP路由器负责将这个包路由至它的目的地，直接地或者间接地通过其他的路由器。

在一个相同的通信中，一个包所经由的路径可能会和其他的包不同，而路由器负责根据通信量、网络中的错误或者其他参数来进行正确地寻址

**IP地址**

每个计算机必须有一个IP地址才能够连入互联网

每个IP包必须有一个地址才能够发送到另一台计算机

TCP/IP使用4组数字来为计算机编址。每个计算机必须有一个唯一的4组数字的地址.每组数字必须在0到255之间，并由点号隔开，比如:192.168.1.60

32比特=4字节，TCP/IP使用32个比特来编址。一个计算机字节是8比特。所以TCP/IP使用了4个字节

**IP V6**

IPv6是"Internet Protocol Version 6"的缩写，也被称为下一代互联网协议，是由IETF小组设计用来代替现行的IPv4协议的一种新的IP协议

在RFC1884中，规定的标准语法建议把IPv6地址的128位(16个字节)写成8个16位的无符号整数，每个整数用4个十六进制位表示，这些数之间用冒号(:)分开，例如：

```
686E：8C64：FFFF：FFFF：0：1180：96A：FFFF
```

为了保证零压缩有一个清晰的解释，建议中规定，在任一地址中，只能使用一次零压缩。该技术对已建议的分配策略特别有用，因为会有许多地址包含连续的零串

**域名**

12个阿拉伯数字很难记忆。使用一个名称更容易

用于TCP/IP地址的名字被称为域名。当键入一个域名，域名会被DNS程序翻译为数字

在全世界，数量庞大的DNS服务器被连入因特网。DNS服务器负责将域名翻译为TCP/IP地址，同时负责使用新的域名信息更新彼此的系统

当一个新的域名连同其TCP/IP地址一起注册后，全世界的DNS服务器都会对此信息进行更新

**TCP/IP 是基于 TCP 和 IP 这两个最初的协议之上的不同的通信协议的大集合。**

* **TCP-传输控制协议**
TCP用于从应用程序到网络的数据传输控制，TCP负责在数据传送之前将它们分割为IP包，然后在它们到达的时候将它们重组
* **IP-网际协议(Internet Protocol)**
IP负责计算机之间的通信，IP负责在因特网上发送和接收数据包
* **HTTP-超文本传输协议(Hyper Text Transfer Protocol)**
HTTP负责web服务器与web浏览器之间的通信。HTTP用于从web客户端(浏览器)向web服务器发送请求，并从web服务器向web客户端返回内容(网页).
* **HTTPS-安全的HTTP(HTTP Secure)**
HTTPS负责在web服务器和web浏览器之间的安全通信。
作为有代表性的应用,HTTPS会用于处理信用卡交易和其他的敏感数据
* **SSL-安全套接字层(Secure Sockets Layer)**
SSL协议用于为安全数据传输加密数据
* **SMTP-简易邮件传输协议(Simple Mail Transfer Protocol)**
SMTP用于电子邮件的传输
* **MIME-多用途因特网邮件扩展(Multi-purpose Internet Mail Extensions)**
MIME协议使SMTP有能力通过TCP/IP网络传输多媒体文件，包括声音，视频和二进制数据
* **IMAP-因特网消息访问协议(Internet Message Access Protocol)**
IMAP用于存储和取回电子邮件
* **POP-邮局协议(Post Office Protocol)**
POP用于从电子邮件服务器向个人电脑下载电子邮件
* **FTP-文件传输协议(File Transfer Protocol)**
FTP负责计算机之间的文件传输
* **NTP-网络时间协议(Network Time Protocol)**
NTP用于在计算机之间同步时间(钟)
* **DHCP-动态主机配置协议(Dynamic Host Configuration Protocol)**
DHCP用于向网络中的计算机分配动态IP地址
* **SNMP-简单网络管理协议(Simple Network Management Protocol)**
SNMP用于计算机网络的管理
* **LDAP-轻量级的目录访问协议(Lightweight Directory Access Protocol)**
LDAP用于从因特网搜集关于用户和电子邮件地址的信息
* **ICMP-因特网消息控制协议(Internet Control Message Protocol)**
ICMP负责网络中的错误处理
* **ARP-地址解析协议(Address Resolution Protocol)**
ARP- 用于通过IP来查找基于IP地址的计算机网卡的硬件地址
* **RARP-反向地址转换协议(Reverse Address Resolution Protocol)**
RARP用于通过IP查找基于硬件地址的计算机网卡的IP地址
* **BOOTP-自举协议(Boot Protocol)**
BOOTP用于从网络启动计算机
* **PPTP-点对点隧道协议(Point to Point Tunneling Protocol)**
PPTP用于私人网络之间的连接(隧道)

**HTTP协议**

HTTP协议(HyperText Transfer Protocol,超文本传输协议)是因特网上应用最为广泛的一种网络传输协议，所有的WWW文件都必须遵守这个标准

HTTP是一个基于TCP/IP通信协议来传递数据(HTML文件,图片文件,查询结果)

**HTTP 工作原理**

HTTP协议工作于客户端-服务端架构上。浏览器作为HTTP客户端通过URL向HTTP服务端即WEB服务器发送所有请求

*Web服务器有：Apache服务器，IIS服务器(Internet Information Services),Ngnix服务器*

Web服务器根据接收到的请求后，向客户端发送响应信息.HTTP默认端口号为80,但是也可以更改为8080或者其他端口

HTTP三点注意事项：

* **HTTP是无连接的**：无连接的含义是限制每次连接只处理一个请求。服务器处理完客户请求，并收到客户的应答后，即断开连接。采用这种方式可以节省传输时间
* **HTTP是媒体独立的**：只要客户端和服务器知道如何处理的数据内容，任何类型的数据都可以通过HTTP发送，客户端以及服务器指定使用适合的MIME-type内容类型
* **HTTP是无状态的**：HTTP协议是无状态协议。无状态是指协议对于事务处理没有记忆能力。缺少状态意味着如果后续处理需要前面的信息，则必须重传，这样可能导致每次连接传送的数据量增大。
