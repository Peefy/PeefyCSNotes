
# Vim使用笔记

## Linux vi/vim

所有的Unix Like系统都会内建vi文书编辑器，其他的不一定存在。目前使用较多是vim编辑器

Vim是从vi发展出来的一个文本编辑器，类似于Sublime，VS Code等

**三种使用模式**:
* 命令模式：

几种常用的几个命令
* i切换到输入模式，以输入字符
* **x**删除当前光标所在处的字符
* :切换到底线命令模式，以在最底一行输入命令

* 输入模式：

输入模式中可以使用的按键
* 字符按键以及Shift组合：输入字符
* ENTER:回车键，换行
* BACK SPACE:退格键，删除光标前一个字符
* DEL:删除键，删除光标后一个字符
* 方向键：在文本中移动光标
* HOME/END:移动光标到行首/行尾
* Page Up/Page Down:上/下翻页
* Insert:切换光标为输入/替换模式，光标将变成竖线/下划线
* ESC:退出输入模式，切换到命令模式

* 底线命令模式：

在命令模式下按下英文冒号就进入了底线命令模式
* q 退出程序
* w 保存文件
