
# JSON和XML

## XML

XML 指可扩展标记语言（e`X`tensible `M`arkup `L`anguage）。

XML 被设计用来传输和存储数据。HTML 被设计用来显示数据。

```xml
<?xml version="1.0" encoding="UTF-8"?>
<note>
  <to>Tove</to>
  <from>Jani</from>
  <heading>Reminder</heading>
  <body>Don't forget me this weekend!</body>
</note>
```

**什么是XML**

* XML 指可扩展标记语言（EXtensible Markup Language）。
* XML 是一种很像HTML的标记语言。
* XML 的设计宗旨是传输数据，而不是显示数据。
* XML 标签没有被预定义,需要自行定义标签。
* XML 被设计为具有自我描述性。
* XML 是 W3C 的推荐标准。XML 于 1998 年 2 月 10 日成为 W3C 的推荐标准。

**XML 和 HTML 之间的差异**

XML 不是 HTML 的替代。XML 和 HTML 为不同的目的而设计,HTML 旨在显示信息，而XML 被设计用来结构化、存储以及传输信息。XML 不会做额外的任何事情

* XML 被设计用来传输和存储数据，其焦点是数据的内容。
* HTML 被设计用来显示数据，其焦点是数据的外观。

XML 语言没有预定义的标签。HTML 中使用的标签都是预定义的。HTML 文档只能使用在 HTML 标准中定义过的标签（如 \<p\>、\<h1\> 等等）。XML 允许创作者定义自己的标签和自己的文档结构。

**XML用途**

* **XML 把数据从 HTML 分离**-如果需要在 HTML 文档中显示动态数据，那么每当数据改变时将花费大量的时间来编辑 HTML。通过 XML，数据能够存储在独立的 XML 文件中。这样就可以专注于使用 HTML/CSS 进行显示和布局，并确保修改底层数据不再需要对 HTML 进行任何的改变。通过使用几行 JavaScript 代码，就可以读取一个外部 XML 文件，并更新的网页的数据内容。
* **XML 简化数据共享**-在真实的世界中，计算机系统和数据使用不兼容的格式来存储数据。XML 数据以纯文本格式进行存储，因此提供了一种独立于软件和硬件的数据存储方法。这让创建不同应用程序可以共享的数据变得更加容易。
* **XML 简化数据传输**-对开发人员来说，其中一项最费时的挑战一直是在互联网上的不兼容系统之间交换数据。由于可以通过各种不兼容的应用程序来读取数据，以 XML 交换数据降低了这种复杂性。
* **XML 简化平台变更**-升级到新的系统（硬件或软件平台），总是非常费时的。必须转换大量的数据，不兼容的数据经常会丢失。XML 数据以文本格式存储。这使得 XML 在不损失数据的情况下，更容易扩展或升级到新的操作系统、新的应用程序或新的浏览器。
* **XML 使数据更有用**-不同的应用程序都能够访问的数据，不仅仅在 HTML 页中，也可以从 XML 数据源中进行访问。
* **XML 用于创建新的互联网语言**-很多新的互联网语言是通过 XML 创建的。XHTML；用于描述可用的 Web 服务 的 WSDL；作为手持设备的标记语言的 WAP 和 WML；用于新闻 feed 的 RSS 语言；描述资本和本体的 RDF 和 OWL；用于描述针针对 Web 的多媒体 的 SMIL

**XML 树结构**

XML 文档形成了一种树结构，它从"根部"开始，然后扩展到"枝叶"。

XML 文档必须包含根元素。该元素是所有其他元素的父元素。

XML 文档中的元素形成了一棵文档树。这棵树从根部开始，并扩展到树的最底端。

所有的元素都可以有子元素：

```xml
<bookstore>
    <book category="COOKING">
        <title lang="en">Everyday Italian</title>
        <author>Giada De Laurentiis</author>
        <year>2005</year>
        <price>30.00</price>
    </book>
    <book category="CHILDREN">
        <title lang="en">Harry Potter</title>
        <author>J K. Rowling</author>
        <year>2005</year>
        <price>29.99</price>
    </book>
    <book category="WEB">
        <title lang="en">Learning XML</title>
        <author>Erik T. Ray</author>
        <year>2003</year>
        <price>39.95</price>
    </book>
</bookstore>
```

实例中的根元素是 \<bookstore\>。文档中的所有 \<book\> 元素都被包含在 \<bookstore\> 中。

\<book\> 元素有 4 个子元素：\<title\>、\<author\>、\<year\>、\<price\>。

**XML 语法规则**

* **XML 文档必须有根元素**-
```xml
<?xml version="1.0" encoding="UTF-8"?>
<note>
  <to>Tove</to>
  <from>Jani</from>
  <heading>Reminder</heading>
  <body>Don't forget me this weekend!</body>
</note>
```
* **XML 声明**-
```xml
<?xml version="1.0" encoding="utf-8"?>
```
* **所有的 XML 元素都必须有一个关闭标签**-
* **XML 标签对大小写敏感**-
* **XML 必须正确嵌套**-
* **XML 属性值必须加引号**-
* **实体引用**

实体引用|符号|含义
-|-|-
&lt;|	<|	less than
&gt;|	>|	greater than
&amp;|	&|	ampersand
&apos;|	'|	apostrophe
&quot;|	"|	quotation mark

* **XML 中的注释**-在 XML 中编写注释的语法与 HTML 的语法很相似。
```xml
<!-- This is a comment -->
```
* **XML 以 LF 存储换行**

在 Windows 应用程序中，换行通常以一对字符来存储：回车符（CR）和换行符（LF）。

在 Unix 和 Mac OSX 中，使用 LF 来存储新行。

在旧的 Mac 系统中，使用 CR 来存储新行。

XML 以 LF 存储换行。

**XML 元素**

XML 元素指的是从（且包括）开始标签直到（且包括）结束标签的部分。一个元素可以包含：

* 其他元素
* 文本
* 属性
* 或混合以上所有

```xml
<bookstore>
    <book category="CHILDREN">
        <title>Harry Potter</title>
        <author>J K. Rowling</author>
        <year>2005</year>
        <price>29.99</price>
    </book>
    <book category="WEB">
        <title>Learning XML</title>
        <author>Erik T. Ray</author>
        <year>2003</year>
        <price>39.95</price>
    </book>
</bookstore>
```

在上面的实例中，\<bookstore\> 和 \<book\> 都有 元素内容，因为他们包含其他元素。\<book\> 元素也有属性（category="CHILDREN"）。\<title\>、\<author\>、\<year\> 和 \<price\> 有文本内容，因为他们包含文本。

**XML 命名规则**

* 名称可以包含字母、数字以及其他的字符
* 名称不能以数字或者标点符号开始
* 名称不能以字母 xml（或者 XML、Xml 等等）开始
* 名称不能包含空格

**XML最佳命名习惯**

* 使名称具有描述性。使用下划线也可以
* 名称应简短和简单
* 避免 "-" 字符
* 避免 "." 字符
* 避免 ":" 字符
* XML 文档经常有一个对应的数据库，其中的字段会对应 XML 文档中的元素。有一个实用的经验，即使用数据库的命名规则来命名 XML 文档中的元素。

**XML 属性**

XML元素具有属性，类似 HTML。

属性（Attribute）提供有关元素的额外信息。

*XML 属性必须加引号*，属性值必须被引号包围，不过单引号和双引号均可使用。

```xml
<note date="10/01/2008">
<to>Tove</to>
<from>Jani</from>
<heading>Reminder</heading>
<body>Don't forget me this weekend!</body>
</note>
```

**XML 验证**

拥有正确语法的 XML 被称为"形式良好"的 XML。通过 DTD 验证的XML是"合法"的 XML。

* XML 文档必须有一个根元素
* XML元素都必须有一个关闭标签
* XML 标签对大小写敏感
* XML 元素必须被正确的嵌套
* XML 属性值必须加引号

```xml
<?xml version="1.0" encoding="ISO-8859-1"?>
<note>
<to>Tove</to>
<from>Jani</from>
<heading>Reminder</heading>
<body>Don't forget me this weekend!</body>
</note>
```

*XML DTD*-DTD 的目的是定义 XML 文档的结构。它使用一系列合法的元素来定义文档结构：

```xml
<!DOCTYPE note
[
<!ELEMENT note (to,from,heading,body)>
<!ELEMENT to (#PCDATA)>
<!ELEMENT from (#PCDATA)>
<!ELEMENT heading (#PCDATA)>
<!ELEMENT body (#PCDATA)>
]>
```

*XML Schema*-W3C 支持一种基于 XML 的 DTD 代替者，它名为 XML Schema：

```xml
<xs:element name="note">

<xs:complexType>
<xs:sequence>
<xs:element name="to" type="xs:string"/>
<xs:element name="from" type="xs:string"/>
<xs:element name="heading" type="xs:string"/>
<xs:element name="body" type="xs:string"/>
</xs:sequence>
</xs:complexType>

</xs:element>
```

**使用 CSS 显示 XML**

通过使用 CSS（Cascading Style Sheets 层叠样式表），可以添加显示信息到 XML 文档中。

使用 CSS 格式化 XML 不是常用的方法。

```xml
<?xml version="1.0" encoding="ISO-8859-1"?>
<?xml-stylesheet type="text/css" href="cd_catalog.css"?>
<CATALOG>
<CD>
<TITLE>Empire Burlesque</TITLE>
<ARTIST>Bob Dylan</ARTIST>
<COUNTRY>USA</COUNTRY>
<COMPANY>Columbia</COMPANY>
<PRICE>10.90</PRICE>
<YEAR>1985</YEAR>
</CD>
<CD>
<TITLE>Hide your heart</TITLE>
<ARTIST>Bonnie Tyler</ARTIST>
<COUNTRY>UK</COUNTRY>
<COMPANY>CBS Records</COMPANY>
<PRICE>9.90</PRICE>
<YEAR>1988</YEAR>
</CD>
.
.
.
</CATALOG>
```

**使用 XSLT 显示 XML**

通过使用 XSLT，可以把 XML 文档转换成 HTML 格式。

**XMLHttpRequest 对象**

JavaScript的XMLHttpRequest 对象用于在后台与服务器交换数据。

* 在不重新加载页面的情况下更新网页
* 在页面已加载后从服务器请求数据
* 在页面已加载后从服务器接收数据
* 在后台向服务器发送数据

所有现代浏览器（IE7+、Firefox、Chrome、Safari 和 Opera）都有内建的 XMLHttpRequest 对象。

创建 XMLHttpRequest 对象的语法：
```js
xmlhttp = new XMLHttpRequest();
xmlhttp = new ActiveXObject("Microsoft.XMLHTTP"); //旧版本的Internet Explorer（IE5和IE6）中使用 ActiveX 对象：
```

**XML Parser**

所有现代浏览器都有内建的 XML 解析器。

XML 解析器把 XML 文档转换为 XML DOM 对象 - 可通过 JavaScript 操作的对象。

*js代码片段把 XML 文档解析到 XML DOM 对象中*
```js
if (window.XMLHttpRequest)
{// code for IE7+, Firefox, Chrome, Opera, Safari
xmlhttp = new XMLHttpRequest();
}
else
{// code for IE6, IE5
xmlhttp = new ActiveXObject("Microsoft.XMLHTTP");
}
xmlhttp.open("GET","books.xml",false);
xmlhttp.send();
xmlDoc = xmlhttp.responseXML;
```

*解析 XML 字符串*
```js
txt="<bookstore><book>";
txt=txt+"<title>Everyday Italian</title>";
txt=txt+"<author>Giada De Laurentiis</author>";
txt=txt+"<year>2005</year>";
txt=txt+"</book></bookstore>";

if (window.DOMParser)
{
parser=new DOMParser();
xmlDoc=parser.parseFromString(txt,"text/xml");
}
else // Internet Explorer
{
xmlDoc=new ActiveXObject("Microsoft.XMLDOM");
xmlDoc.async=false;
xmlDoc.loadXML(txt); 
}
```

**XML DOM**

`DOM`（Document Object Model 文档对象模型）定义了访问和操作文档的标准方法。

XML DOM 把 XML 文档作为树结构来查看。

所有元素可以通过 DOM 树来访问。可以修改或删除它们的内容，并创建新的元素。元素，它们的文本，以及它们的属性，都被认为是节点。

```html
<html>
<body>
<h1>W3Schools Internal Note</h1>
<div>
<b>To:</b> <span id="to"></span><br />
<b>From:</b> <span id="from"></span><br />
<b>Message:</b> <span id="message"></span>
</div>

<script>
if (window.XMLHttpRequest)
{// code for IE7+, Firefox, Chrome, Opera, Safari
xmlhttp=new XMLHttpRequest();
}
else
{// code for IE6, IE5
xmlhttp=new ActiveXObject("Microsoft.XMLHTTP");
}
xmlhttp.open("GET","note.xml",false);
xmlhttp.send();
xmlDoc=xmlhttp.responseXML;

document.getElementById("to").innerHTML=
xmlDoc.getElementsByTagName("to")[0].childNodes[0].nodeValue;
document.getElementById("from").innerHTML=
xmlDoc.getElementsByTagName("from")[0].childNodes[0].nodeValue;
document.getElementById("message").innerHTML=
xmlDoc.getElementsByTagName("body")[0].childNodes[0].nodeValue;
</script>

</body>
</html>
```

XML DOM 的 createElement() 方法创建一个新的元素节点。

XML DOM 的 createTextNode() 方法创建一个新的文本节点。

XML DOM 的 appendChild() 方法向节点添加子节点（在最后一个子节点之后）。

如需创建带有文本内容的新元素，需要同时创建元一个新的元素节点和一个新的文本节点，然后把他追加到现有的节点。

下面的实例创建了一个新的元素（\<edition\>），带有如下文本：First，然后把它添加到第一个 \<book\> 元素：

```js
// 增加元素
newel = xmlDoc.createElement("edition");
newtext = xmlDoc.createTextNode("First");
newel.appendChild(newtext);
x = xmlDoc.getElementsByTagName("book");
x[0].appendChild(newel);
// 删除元素
x = xmlDoc.getElementsByTagName("book")[0];
x.removeChild(x.childNodes[0]);
```

**HTML 页面显示 XML 数据**

```html
<html>
<body>

<script>
if (window.XMLHttpRequest)
{// code for IE7+, Firefox, Chrome, Opera, Safari
xmlhttp=new XMLHttpRequest();
}
else
{// code for IE6, IE5
xmlhttp=new ActiveXObject("Microsoft.XMLHTTP");
}
xmlhttp.open("GET","cd_catalog.xml",false);
xmlhttp.send();
xmlDoc=xmlhttp.responseXML; 

document.write("<table border='1'>");
var x=xmlDoc.getElementsByTagName("CD");
for (i=0;i<x.length;i++)
{ 
document.write("<tr><td>");
document.write(x[i].getElementsByTagName("ARTIST")[0].childNodes[0].nodeValue);
document.write("</td><td>");
document.write(x[i].getElementsByTagName("TITLE")[0].childNodes[0].nodeValue);
document.write("</td></tr>");
}
document.write("</table>");
</script>

</body>
</html>
```

**XML 命名空间**

XML 命名空间提供避免元素命名冲突的方法。

* **使用前缀来避免命名冲突**-在 XML 中的命名冲突可以通过使用名称前缀从而容易地避免。

```xml
<h:table>
<h:tr>
<h:td>Apples</h:td>
<h:td>Bananas</h:td>
</h:tr>
</h:table>

<f:table>
<f:name>African Coffee Table</f:name>
<f:width>80</f:width>
<f:length>120</f:length>
</f:table>
```

* **XML 命名空间 - xmlns 属性**-

当在 XML 中使用前缀时，一个所谓的用于前缀的命名空间必须被定义。

命名空间是在元素的开始标签的 xmlns 属性中定义的。

命名空间声明的语法如下。xmlns:前缀="URI"。

```xml
<root>

<h:table xmlns:h="http://www.w3.org/TR/html4/">
<h:tr>
<h:td>Apples</h:td>
<h:td>Bananas</h:td>
</h:tr>
</h:table>

<f:table xmlns:f="http://www.w3cschool.cc/furniture">
<f:name>African Coffee Table</f:name>
<f:width>80</f:width>
<f:length>120</f:length>
</f:table>

</root>
```

*统一资源标识符（URI，全称 Uniform Resource Identifier）*

统一资源标识符（URI）是一串可以标识因特网资源的字符。

最常用的 URI 是用来标识因特网域名地址的统一资源定位器（URL）。另一个不那么常用的 URI 是统一资源命名（URN）。

在的实例中，仅使用 URL。

**XML CDATA**

XML 文档中的所有文本均会被解析器解析。只有 CDATA 区段中的文本会被解析器忽略。

*PCDATA - 被解析的字符数据*-XML 解析器通常会解析 XML 文档中所有的文本。当某个 XML 元素被解析时，其标签之间的文本也会被解析：
```xml
<message>This text is also parsed</message>
```

*CDATA - （未解析）字符数据*

术语 CDATA 是不应该由 XML 解析器解析的文本数据。

像 "<" 和 "&" 字符在 XML 元素中都是非法的。

"<" 会产生错误，因为解析器会把该字符解释为新元素的开始。

"&" 会产生错误，因为解析器会把该字符解释为字符实体的开始。

某些文本，比如 JavaScript 代码，包含大量 "<" 或 "&" 字符。为了避免错误，可以将脚本代码定义为 CDATA。

CDATA 部分中的所有内容都会被解析器忽略。

CDATA 部分由 "<![CDATA[" 开始，由 "]]>" 结束：

```xml
<script>
<![CDATA[
function matchwo(a,b)
{
if (a < b && a < 0) then
{
return 1;
}
else
{
return 0;
}
}
]]>
</script>
```

*注意：CDATA 部分不能包含字符串 "]]>"。也不允许嵌套的 CDATA 部分。标记 CDATA 部分结尾的 "]]>" 不能包含空格或换行。*

**XML 编码**

XML 文档可以包含非 ASCII 字符，比如挪威语 æ ø å，或者法语 ê è é

*Windows 记事本编码*-Windows 记事本默认会将文件保存为单字节的 ANSI（ASCII）。如果选择 "另存为..."，就可以指定 ANSI、UTF-8、Unicode（UTF-16）或 Unicode Big。

* 始终使用编码属性
* 使用支持编码的编辑器
* 确保知道编辑器使用什么编码
* 在编码属性中使用相同的编码

**服务器上的 XML**

XML 文件是类似 HTML 文件的纯文本文件。XML 能够通过标准的 Web 服务器轻松地存储和生成。

**XML 相关技术**

* **XHTML (可扩展 HTML)**-更严格更纯净的基于 XML 的 HTML 版本。
* **XML DOM (XML 文档对象模型)**-访问和操作 XML 的标准文档模型。
* **XSL (可扩展样式表语言)**-XSLT (XSL 转换) - 把 XML 转换为其他格式，比如 HTML;XSL-FO (XSL 格式化对象)- 用于格式化 XML 文档的语言;XPath - 用于导航 XML 文档的语言
* **XQuery (XML 查询语言)**-基于 XML 的用于查询 XML 数据的语言。
* **DTD (文档类型定义)**-用于定义 XML 文档中的合法元素的标准。
* **XSD (XML 架构)**-基于 XML 的 DTD 替代物。
* **XLink (XML 链接语言)**-在 XML 文档中创建超级链接的语言。
* **XPointer (XML 指针语言)**-允许 XLink 超级链接指向 XML 文档中更多具体的部分。
* **SOAP (简单对象访问协议)**-允许应用程序在 HTTP 之上交换信息的基于 XML 的协议。
* **WSDL (Web 服务描述语言)**-用于描述网络服务的基于 XML 的语言。
* **RDF (资源描述框架)**-用于描述网络资源的基于 XML 的语言。
* **RSS (真正简易聚合)**-聚合新闻以及类新闻站点内容的格式。
* **SVG (可伸缩矢量图形)**-定义 XML 格式的图形。

### XPath

XPath即为XML路径语言（XML Path Language），它是一种用来确定XML文档中某部分位置的语言。

* XPath 使用路径表达式在 XML 文档中进行导航
* XPath 包含一个标准函数库
* XPath 是 XSLT 中的主要元素
* XPath 是一个 W3C 标准

#### XPath 路径表达式

XPath 使用路径表达式来选取 XML 文档中的节点或者节点集。这些路径表达式和在常规的电脑文件系统中看到的表达式非常相似。

#### XPath 标准函数

XPath 含有超过 100 个内建的函数。这些函数用于字符串值、数值、日期和时间比较、节点和 QName 处理、序列处理、逻辑值等等。

#### XPath 术语

**节点**

在 XPath 中，有七种类型的节点：元素、属性、文本、命名空间、处理指令、注释以及文档（根）节点。XML 文档是被作为节点树来对待的。树的根被称为文档节点或者根节点。

```xml
<?xml version="1.0" encoding="UTF-8"?>

<bookstore>
  <book>
    <title lang="en">Harry Potter</title>
    <author>J K. Rowling</author>
    <year>2005</year>
    <price>29.99</price>
  </book>
</bookstore>
```

**XPath 语法**

XPath 使用路径表达式来选取 XML 文档中的节点或节点集。节点是通过沿着路径 (path) 或者步 (steps) 来选取的。

```xml
<?xml version="1.0" encoding="UTF-8"?>
 
<bookstore>
 
<book>
  <title lang="eng">Harry Potter</title>
  <price>29.99</price>
</book>
 
<book>
  <title lang="eng">Learning XML</title>
  <price>39.95</price>
</book>
 
</bookstore>
```

XPath 使用路径表达式在 XML 文档中选取节点。节点是通过沿着路径或者 step 来选取的。 下面列出了最有用的路径表达式：

表达式|	描述
-|-
`nodename`|	选取此节点的所有子节点。
`/`|	从根节点选取。
`//`|	从匹配选择的当前节点选择文档中的节点，而不考虑它们的位置。
`.`|	选取当前节点。
`..`|	选取当前节点的父节点。
`@`|	选取属性。

在下面的表格中，已列出了一些路径表达式以及表达式的结果：

路径表达式|	结果
-|-
`bookstore`|	选取 bookstore 元素的所有子节点。
`/bookstore`|  选取根元素 bookstore。注释：假如路径起始于正斜杠( / )，则此路径始终代表到某元素的绝对路径！
`bookstore/book`|	选取属于 bookstore 的子元素的所有 book 元素。
`//book` |	选取所有 book 子元素，而不管它们在文档中的位置。
`bookstore//book`|	选择属于 bookstore 元素的后代的所有 book 元素，而不管它们位于 bookstore 之下的什么位置。
`//@lang` |	选取名为 lang 的所有属性。

**谓语（Predicates）**

谓语用来查找某个特定的节点或者包含某个指定的值的节点。

谓语被嵌在方括号中。

在下面的表格中，列出了带有谓语的一些路径表达式，以及表达式的结果：

路径表达式|	结果
-|-
`/bookstore/book[1]`|	选取属于 bookstore 子元素的第一个 book 元素。
`/bookstore/book[last()]`|	选取属于 bookstore 子元素的最后一个 book 元素。
`/bookstore/book[last()-1]`|	选取属于 bookstore 子元素的倒数第二个 book 元素。
`/bookstore/book[position()<3]`|	选取最前面的两个属于 bookstore 元素的子元素的 book 元素。
`//title[@lang]`|	选取所有拥有名为 lang 的属性的 title 元素。
`//title[@lang='eng']`|	选取所有 title 元素，且这些元素拥有值为 eng 的 lang 属性。
`/bookstore/book[price>35.00]`|	选取 bookstore 元素的所有 book 元素，且其中的 price 元素的值须大于 35.00。
`/bookstore/book[price>35.00]//title`|	选取 bookstore 元素中的 book 元素的所有 title 元素，且其中的 price 元素的值须大于 35.00。

**选取未知节点**

XPath 通配符可用来选取未知的 XML 元素。

通配符|	描述
-|-
`*`|	匹配任何元素节点。
`@*`|	匹配任何属性节点。
`node()`|	匹配任何类型的节点。

在下面的表格中，列出了一些路径表达式，以及这些表达式的结果：

路径表达式|	结果
-|-
`/bookstore/*`|	选取 bookstore 元素的所有子元素。
`//*`|	选取文档中的所有元素。
`//title[@*]`|	选取所有带有属性的 title 元素。

**选取若干路径**

通过在路径表达式中使用"|"运算符，可以选取若干个路径。

在下面的表格中，列出了一些路径表达式，以及这些表达式的结果：

路径表达式|	结果
-|-
`//book/title | //book/price` |	选取 book 元素的所有 title 和 price 元素。
`//title | //price` |	选取文档中的所有 title 和 price 元素。
`/bookstore/book/title | //price` |	选取属于 bookstore 元素的 book 元素的所有 title 元素，以及文档中所有的 price 元素。

**XPath 轴（Axes）**

```xml
<?xml version="1.0" encoding="UTF-8"?>
 
<bookstore>
 
<book>
  <title lang="en">Harry Potter</title>
  <price>29.99</price>
</book>
 
<book>
  <title lang="en">Learning XML</title>
  <price>39.95</price>
</book>
 
</bookstore>
```

轴可定义相对于当前节点的节点集。


轴名称|	结果
-|-
`ancestor`|	选取当前节点的所有先辈（父、祖父等）。
`ancestor-or-self`	选取当前节点的所有先辈（父、祖父等）以及当前节点本身。
`attribute`|	选取当前节点的所有属性。
`child`|	选取当前节点的所有子元素。
`descendant`|	选取当前节点的所有后代元素（子、孙等）。
`descendant-or-self`|	选取当前节点的所有后代元素（子、孙等）以及当前节点本身。
`following`|	选取文档中当前节点的结束标签之后的所有节点。
`following-sibling`|	选取当前节点之后的所有兄弟节点
`namespace`|	选取当前节点的所有命名空间节点。
`parent`|	选取当前节点的父节点。
`preceding`|	选取文档中当前节点的开始标签之前的所有节点。
`preceding-sibling`|	选取当前节点之前的所有同级节点。
`self`|	选取当前节点。

**XPath 运算符**

运算符|	描述|	实例|	返回值
-|-|-
`|`|	计算两个节点集	//book | //cd	返回所有拥有 book 和 cd 元素的节点集
`+`|	加法	6 + 4	10
`-`|	减法	6 - 4	2
`*`|	乘法	6 * 4	24
`div`|	除法	8 div 4	2
`=`|	等于	price=9.80	如果 price 是 9.80，则返回 true。如果 price 是 9.90，则返回 false。
`!=`|	不等于	price!=9.80	如果 price 是 9.90，则返回 true。如果 price 是 9.80，则返回 false。
`<`|	小于	price<9.80	如果 price 是 9.00，则返回 true。如果 price 是 9.90，则返回 false。
`<=`|	小于或等于	price<=9.80	 如果 price 是 9.00，则返回 true。 如果 price 是 9.90，则返回 false。
`>`|	大于	price>9.80	 如果 price 是 9.90，则返回 true。如果 price 是 9.80，则返回 false。
`>=`|	大于或等于	price>=9.80	 如果 price 是 9.90，则返回 true。如果 price 是 9.70，则返回 false。
`or`|	或	price=9.80 or price=9.70 如果 price 是 9.80，则返回 true。如果 price 是 9.50，则返回 false。
`and`|	与	price>9.00 and price<9.90	如果 price 是 9.80，则返回 true。如果 price 是 8.50，则返回 false。
`mod`|	计算除法的余数	5 mod 2	1

**XML实例文档**

`books.xml`

```xml
<?xml version="1.0" encoding="UTF-8"?>

<bookstore>

<book category="COOKING">
  <title lang="en">Everyday Italian</title>
  <author>Giada De Laurentiis</author>
  <year>2005</year>
  <price>30.00</price>
</book>

<book category="CHILDREN">
  <title lang="en">Harry Potter</title>
  <author>J K. Rowling</author>
  <year>2005</year>
  <price>29.99</price>
</book>

<book category="WEB">
  <title lang="en">XQuery Kick Start</title>
  <author>James McGovern</author>
  <author>Per Bothner</author>
  <author>Kurt Cagle</author>
  <author>James Linn</author>
  <author>Vaidyanathan Nagarajan</author>
  <year>2003</year>
  <price>49.99</price>
</book>

<book category="WEB">
  <title lang="en">Learning XML</title>
  <author>Erik T. Ray</author>
  <year>2003</year>
  <price>39.95</price>
</book>

</bookstore>
```

* **选取所有 title**-`/bookstore/book/title`
* **选取第一个 book 的 title**-`/bookstore/book[1]/title`
* **选取所有价格**-`/bookstore/book/price/text()`
* **选取价格高于 35 的 price 节点**-`/bookstore/book[price>35]/price`
* **选取价格高于 35 的 title 节点**-`/bookstore/book[price>35]/title`

## JSON

* JSON: JavaScript Object Notation(JavaScript 对象表示法)
* JSON 是存储和交换文本信息的语法。类似 XML。
* JSON 比 XML 更小、更快，更易解析。
* JSON 指的是 JavaScript 对象表示法（`J`ava`S`cript `O`bject `N`otation）
* JSON 是轻量级的文本数据交换格式
* JSON 独立于语言：JSON 使用 Javascript语法来描述数据对象，但是 JSON 仍然独立于语言和平台。JSON 解析器和 JSON 库支持许多不同的编程语言。 目前非常多的动态（PHP，JSP，.NET）编程语言都支持JSON。
* JSON 具有自我描述性，更易理解

```html
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title>菜鸟教程(runoob.com)</title>
</head>
<body>
<h2>JavaScript 创建 JSON 对象</h2>
<p>
网站名称: <span id="jname"></span><br /> 
网站地址: <span id="jurl"></span><br /> 
网站 slogan: <span id="jslogan"></span><br /> 
</p>
<script>
var JSONObject= {
    "name":"菜鸟教程",
    "url":"www.runoob.com", 
    "slogan":"学的不仅是技术，更是梦想！"
};
document.getElementById("jname").innerHTML=JSONObject.name 
document.getElementById("jurl").innerHTML=JSONObject.url 
document.getElementById("jslogan").innerHTML=JSONObject.slogan
</script>
 
</body>
</html>
```

**JSON与 XML 相同之处**

* JSON 是纯文本
* JSON 具有"自我描述性"（人类可读）
* JSON 具有层级结构（值中存在值）
* JSON 可通过 JavaScript 进行解析
* JSON 数据可使用 AJAX 进行传输

**JSON与 XML 不同之处**

* 没有结束标签
* 更短
* 读写的速度更快
* 能够使用内建的 JavaScript eval() 方法进行解析
* 使用数组
* 不使用保留字

**JSON 语法规则**

JSON 语法是 JavaScript 对象表示语法的子集。
* 数据在名称/值对中
* 数据由逗号分隔
* 大括号保存对象
* 中括号保存数组

**JSON 名称/值对**

JSON 数据的书写格式是：名称/值对。

名称/值对包括字段名称（在双引号中），后面写一个冒号，然后是值

```json
{
    "name" : "菜鸟教程"
}
```

**JSON 值**

* 数字（整数或浮点数）
* 字符串（在双引号中）
* 逻辑值（true 或 false）
* 数组（在中括号中）
* 对象（在大括号中）
* null

**JSON 数字**

JSON 数字可以是整型或者浮点型：
```json
{ "age":30 }
```

**JSON 对象**
JSON 对象在大括号（{}）中书写：

对象可以包含多个名称/值对：
```json
{ "name":"菜鸟教程" , "url":"www.runoob.com" }
```
这一点也容易理解，与这条 JavaScript 语句等价：
```js
name = "菜鸟教程"
url = "www.runoob.com"
```

**JSON 数组**

JSON 数组在中括号中书写：

数组可包含多个对象：
```json
{
    "sites": [
        { "name":"菜鸟教程" , "url":"www.runoob.com" }, 
        { "name":"google" , "url":"www.google.com" }, 
        { "name":"微博" , "url":"www.weibo.com" }
    ]
}
```

**JSON 布尔值**

JSON 布尔值可以是 true 或者 false：
```json
{ "flag":true }
```

**JSON null**

JSON 可以设置 null 值：
```json
{ "runoob":null }
```

**JSON 使用 JavaScript 语法**

因为 JSON 使用 JavaScript 语法，所以无需额外的软件就能处理 JavaScript 中的 JSON。

通过 JavaScript，可以创建一个对象数组，并像这样进行赋值：
```js
var sites = [
    { "name":"runoob" , "url":"www.runoob.com" }, 
    { "name":"google" , "url":"www.google.com" }, 
    { "name":"微博" , "url":"www.weibo.com" }
];
```

**JSON 文件**

* JSON 文件的文件类型是 ".json"
* JSON 文本的 MIME 类型是 "application/json"

**JSON 对象语法**

```json
{ "name":"runoob", "alexa":10000, "site":null }
```

SON 对象使用在大括号({})中书写。

对象可以包含多个 key/value（键/值）对。

key 必须是字符串，value 可以是合法的 JSON 数据类型（字符串, 数字, 对象, 数组, 布尔值或 null）。

key 和 value 中使用冒号(:)分割。

每个 key/value 对使用逗号(,)分割。

**JSON 数组**

JSON 数组在中括号中书写。

JSON 中数组值必须是合法的 JSON 数据类型（字符串, 数字, 对象, 数组, 布尔值或 null）。

JavaScript 中，数组值可以是以上的 JSON 数据类型，也可以是 JavaScript 的表达式，包括函数，日期，及 undefined。

```json
{
    "name":"网站",
    "num":3,
    "sites":[ "Google", "Runoob", "Taobao" ]
}
```

```js
myObj = {
    "name":"网站",
    "num":3,
    "sites": [
        { "name":"Google", "info":[ "Android", "Google 搜索", "Google 翻译" ] },
        { "name":"Runoob", "info":[ "菜鸟教程", "菜鸟工具", "菜鸟微信" ] },
        { "name":"Taobao", "info":[ "淘宝", "网购" ] }
    ]
}

for (i in myObj.sites) {
    x += "<h1>" + myObj.sites[i].name + "</h1>";
    for (j in myObj.sites[i].info) {
        x += myObj.sites[i].info[j] + "<br>";
    }
}
```

**JSON.parse()**

JSON 通常用于与服务端交换数据。

在接收服务器数据时一般是字符串。

可以使用 JSON.parse() 方法将数据转换为 JavaScript 对象。

```js
JSON.parse(text[, reviver])
```
* **text**-一个有效的 JSON 字符串。
* **reviver**-可选，一个转换结果的函数， 将为对象的每个成员调用此函数。

*从服务端接收 JSON 数据*
```js
var xmlhttp = new XMLHttpRequest();
xmlhttp.onreadystatechange = function() {
    if (this.readyState == 4 && this.status == 200) {
        myObj = JSON.parse(this.responseText);
        document.getElementById("demo").innerHTML = myObj.name;
    }
};
xmlhttp.open("GET", "/try/ajax/json_demo.txt", true);
xmlhttp.send();
```

*从服务端接收数组的 JSON 数据*
```js
var xmlhttp = new XMLHttpRequest();
xmlhttp.onreadystatechange = function() {
    if (this.readyState == 4 && this.status == 200) {
        myArr = JSON.parse(this.responseText);
        document.getElementById("demo").innerHTML = myArr[1];
    }
};
xmlhttp.open("GET", "/try/ajax/json_demo_array.txt", true);
xmlhttp.send();
```

**JSON.stringify()**

JSON 通常用于与服务端交换数据。

在向服务器发送数据时一般是字符串。

可以使用 JSON.stringify() 方法将 JavaScript 对象转换为字符串。

```js
JSON.stringify(value[, replacer[, space]])
```

* **value**-必需， 要转换的 JavaScript 值（通常为对象或数组）。
* **replacer**-可选。用于转换结果的函数或数组。如果 replacer 为函数，则 JSON.stringify 将调用该函数，并传入每个成员的键和值。使用返回值而不是原始值。如果此函数返回 undefined，则排除成员。根对象的键是一个空字符串：""。如果 replacer 是一个数组，则仅转换该数组中具有键值的成员。成员的转换顺序与键在数组中的顺序一样。当 value 参数也为数组时，将忽略 replacer 数组。
* **space**-可选，文本添加缩进、空格和换行符，如果 space 是一个数字，则返回值文本在每个级别缩进指定数目的空格，如果 space 大于 10，则文本缩进 10 个空格。space 也可以使用非数字，如：\t。

**JavaScript 对象转换**

```js
var obj = { "name":"runoob", "alexa":10000, "site":"www.runoob.com"};
var myJSON = JSON.stringify(obj);

var obj = { "name":"runoob", "alexa":10000, "site":"www.runoob.com"};
var myJSON = JSON.stringify(obj);
document.getElementById("demo").innerHTML = myJSON;
```

**JavaScript 数组转换**

```js
var arr = [ "Google", "Runoob", "Taobao", "Facebook" ];
var myJSON = JSON.stringify(arr);

var arr = [ "Google", "Runoob", "Taobao", "Facebook" ];
var myJSON = JSON.stringify(arr);
document.getElementById("demo").innerHTML = myJSON;
```

**JSONP(JSON with Padding)**

Jsonp(JSON with Padding) 是 json 的一种"使用模式"，可以让网页从别的域名（网站）那获取资料，即跨域读取数据。

为什么从不同的域（网站）访问数据需要一个特殊的技术(JSONP )呢？这是因为同源策略。

同源策略，它是由Netscape提出的一个著名的安全策略，现在所有支持JavaScript 的浏览器都会使用这个策略。

### XML问答

**1.XML文档定义有几种形式？它们之间有何本质区别？解析XML文档有哪几种方式？**

### JSON问答

**1.** 

### WebService

1、WEB SERVICE名词解释，JSWDL开发包的介绍，JAXP、JAXM的解释。SOAP、UDDI,WSDL解释。

2、请谈谈对SOAP、WSDL、UDDI的了解？

3、谈谈Java规范中和Web Service相关的规范有哪些？

