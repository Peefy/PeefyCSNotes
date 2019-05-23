
**1. hashset存的数是有序的吗？**

hashset继承的是set接口，set是无序集合。

**2. Object作为HashMap的key的话，对Object有什么要求吗？**

Hashmap不允许有重复的key，所以要重写它的hashcode和equal方法，以便确认key是否重复

**3. 一致性哈希算法**

一致性哈希算法在1997年由麻省理工学院的Karger等人在解决分布式Cache中提出的，设计目标是为了解决因特网中的热点(Hot spot)问题，初衷和CARP十分类似。一致性哈希修正了CARP使用的简单哈希算法带来的问题，使得DHT可以在P2P环境中真正得到应用。

但现在一致性hash算法在分布式系统中也得到了广泛应用，研究过memcached缓存数据库的人都知道，memcached服务器端本身不提供分布式cache的一致性，而是由客户端来提供，具体在计算一致性hash时采用如下步骤：

* 首先求出memcached服务器（节点）的哈希值，并将其配置到0～232的圆（continuum）上。
* 然后采用同样的方法求出存储数据的键的哈希值，并映射到相同的圆上。
* 然后从数据映射到的位置开始顺时针查找，将数据保存到找到的第一个服务器上。如果超过232仍然找不到服务器，就会保存到第一台memcached服务器上。

考虑到分布式系统每个节点都有可能失效，并且新的节点很可能动态的增加进来，如何保证当系统的节点数目发生变化时仍然能够对外提供良好的服务，这是值得考虑的，尤其实在设计分布式缓存系统时，如果某台服务器失效，对于整个系统来说如果不采用合适的算法来保证一致性，那么缓存于系统中的所有数据都可能会失效（即由于系统节点数目变少，客户端在请求某一对象时需要重新计算其hash值（通常与系统中的节点数目有关），由于hash值已经改变，所以很可能找不到保存该对象的服务器节点），因此一致性hash就显得至关重要，良好的分布式cahce系统中的一致性hash算法应该满足以下几个方面：

* **平衡性(Balance)**-平衡性是指哈希的结果能够尽可能分布到所有的缓冲中去，这样可以使得所有的缓冲空间都得到利用。很多哈希算法都能够满足这一条件。
* **单调性(Monotonicity)**-单调性是指如果已经有一些内容通过哈希分派到了相应的缓冲中，又有新的缓冲区加入到系统中，那么哈希的结果
* **分散性(Spread)**-在分布式环境中，终端有可能看不到所有的缓冲，而是只能看到其中的一部分。 
* **负载(Load)**- 负载问题实际上是从另一个角度看待分散性问题。
* **平滑性(Smoothness)**-平滑性是指缓存服务器的数目平滑改变和缓存对象的平滑改变是一致的。 

**4. 什么是hashmap?**

map就是用于存储键值对（\<key,value\>）的集合类，也可以说是一组键值对的映射（数学概念）。注意，我这里说的只是map的概念，是为了通俗易懂，面试时候方便记忆，但是你自己一定要明白，在java中map是一个接口，是和collection接口同一等级的集合根接口。

把任意长度的输入（输入叫做预映射，知道就行），通过一种函数（hashCode() 方法），变换成固定长度的输出，该输出就是哈希值（hashCode），这种函数就叫做哈希函数，而计算哈希值的过程就叫做哈希。哈希的主要应用是哈希表和分布式缓存。

这里有个问题，哈希算法和哈希函数不是一个东西，哈希函数是哈希算法的一种实现，以后面试就说哈希函数就行。

在将键值对存入数组之前，将key通过哈希算法计算出哈希值，把哈希值作为数组下标，把该下标对应的位置作为键值对的存储位置，通过该方法建立的数组就叫做哈希表，而这个存储位置就叫做桶（bucket）。数组是通过整数下标直接访问元素，哈希表是通过字符串key直接访问元素，也就说哈希表是一种特殊的数组（关联数组），哈希表广泛应用于实现数据的快速查找（在map的key集合中，一旦存储的key的数量特别多，那么在要查找某个key的时候就会变得很麻烦，数组中的key需要挨个比较，哈希的出现，使得这样的比较次数大大减少。）

哈希表选用哈希函数计算哈希值时，可能不同的 key 会得到相同的结果，一个地址怎么存放多个数据呢？这就是哈希冲突（碰撞）。解决哈希冲突有两种方法，拉链法（链接法）和开放定址法（这种没用过）。拉链法：将键值对对象封装为一个node结点，新增了next指向，这样就可以将碰撞的结点链接成一条单链表，保存在该地址（数组位置）中。

**5. Java中的HashMap的工作原理是什么？**

Java 中的 HashMap 是以键值对(key-value)的形式存储元素的。HashMap 需要一个hash函数，它使用 has hCode()和 equals()方法来向集合/从集合添加和检索元素。当调用 put()方法的时候，HashMap会计算 key 的 hash 值，然后把键值对存储在集合中合适的索引上。如果 key 已经存在了，value 会被更新成新值。HashMap 的一些重要的特性是它的容量(capacity)，负载因子(load factor)和扩容极限(threshold resizing)。

**6. hashCode()和equals()方法的重要性体现在什么地方？**

因为Object的equal方法默认是两个对象的引用的比较，意思就是指向同一内存,地址则相等，否则不相等；如果你现在需要利用对象里面的值来判断是否相等，则重载equal方法。 

一般的地方不需要重载hashCode，只有当类需要放在HashTable、HashMap、HashSet等等hash结构的集合时才会 重载hashCode，那么为什么要重载hashCode呢？就HashMap来说，好比HashMap就是一个大内存块，里面有很多小内存块，小内存块 里面是一系列的对象，可以利用hashCode来查找小内存块hashCode%size(小内存块数量)，所以当equal相等时，hashCode必 须相等，而且如果是object对象，必须重载hashCode和equal方法。

因为是按照hashCode来访问小内存块，所以hashCode必须相等。

之所以hashCode相等，却可以equal不等，就比如ObjectA和ObjectB他们都有属性name，那么hashCode都以name计算，所以hashCode一样，但是两个对象属于不同类型，所以equal为false。

**7. 说一下B+树/B-树/B*树？**

B-tree，即B树，不是B减树，它是一种多路搜索树（并不是二叉的）：

定义任意非叶子结点最多只有M个儿子；且M>2；根结点的儿子数为[2, M]；除根结点以外的非叶子结点的儿子数为[M/2, M]；每个结点存放至少M/2-1（取上整）和至多M-1个关键字；（至少2个关键字）；非叶子结点的关键字个数=指向儿子的指针个数-1；非叶子结点的关键字：K\[1\], K\[2\], …, K\[M-1\]；且K\[i\] < K\[i+1\]；非叶子结点的指针：P\[1\], P\[2\], …, P\[M\]；其中P\[1\]指向关键字小于K\[1\]的子树，P\[M\]指向关键字大于K\[M-1\]的子树，其它P\[i\]指向关键字属于(K\[i-1\], K\[i\])的子树；所有叶子结点位于同一层；

B-树的搜索，从根结点开始，对结点内的关键字（有序）序列进行二分查找，如果命中则结束，否则进入查询关键字所属范围的儿子结点；重复，直到所对应的儿子指针为空，或已经是叶子结点；

B-树的特性：关键字集合分布在整颗树中；任何一个关键字出现且只出现在一个结点中；搜索有可能在非叶子结点结束；其搜索性能等价于在关键字全集内做一次二分查找；自动层次控制； 由于限制了除根结点以外的非叶子结点，至少含有M/2个儿子，确保了结点的至少利用率，其最底搜索性能为：

B+树：B+树是B-树的变体，也是一种多路搜索树：其定义基本与B-树同，除了：非叶子结点的子树指针与关键字个数相同；非叶子结点的子树指针P\[i\]，指向关键字值属于\[K\[i\], K\[i+1\])的子树（B-树是开区间）；为所有叶子结点增加一个链指针；所有关键字都在叶子结点出现；B+的搜索与B-树也基本相同，区别是B+树只有达到叶子结点才命中（B-树可以在非叶子结点命中），其性能也等价于在关键字全集做一次二分查找；

B+的特性：所有关键字都出现在叶子结点的链表中（稠密索引），且链表中的关键字恰好是有序的；不可能在非叶子结点命中；非叶子结点相当于是叶子结点的索引（稀疏索引），叶子结点相当于是存储（关键字）数据的数据层；更适合文件索引系统；增删文件（节点）时，效率更高，因为B+树的叶子节点包含所有关键字，并以有序的链表结构存储，这样可很好提高增删效率。

B*树：是B+树的变体，在B+树的非根和非叶子结点再增加指向兄弟的指针；

* B树：二叉树，每个结点只存储一个关键字，等于则命中，小于走左结点，大于走右结点；
* B-树：多路搜索树，每个结点存储M/2到M个关键字，非叶子结点存储指向关键字范围的子结点；所有关键字在整颗树中出现，且只出现一次，非叶子结点可以命中；
* B+树：在B-树基础上，为叶子结点增加链表指针，所有关键字都在叶子结点中出现，非叶子结点作为叶子结点的索引；B+树总是到叶子结点才命中；它更适合文件索引系统；相对于B树，B+树空间利用率更高，因为B+树的内部节点只是作为索引使用，而不像B-树那样每个节点都需要存储硬盘指针。增删文件（节点）时，效率更高，因为B+树的叶子节点包含所有关键字，并以有序的链表结构存储，这样可很好提高增删效率。
*  B*树：在B+树基础上，为非叶子结点也增加链表指针，将结点的最低利用率从1/2提高到2/3；

**8. 怎么求一个二叉树的深度?**

```java
class TreeNode {
    char val;
    TreeNode left = null;
    TreeNode right = null;

    TreeNode(char _val) {
        this.val = _val;
    }
}

public static int getMaxDepth(TreeNode root){
    if (root == null)
        return 0;
    else{
        int left = getMaxDepth(root.left);
        int right = getMaxDepth(root.right);
        return 1 + Math.max(left, right);
    }
}

public static int getMaxWidth(TreeNode root){
    if (root == null)
        return 0;
    Queue<TreeNode> queue = new ArrayQueue<TreeNode>();
    int maxWidth = 1;
    queue.add(root);
    while (true){
        int len = queue.size();
        if (len == 0)
            break;
        while (len > 0){
            TreeNode t = queue.poll();
            len--;
            if (t.left != null)
                queue.add(t.left);
            if (t.right != null)
                queue.add(t.right);
        }
        maxWidth = Math.max(maxWidth, queue.size());
    }
    return maxWidth;
}
```

**9. 算法题：二叉树层序遍历，进一步提问：要求每层打印出一个换行符**

使用队列数据结构广度优先搜索遍历bfs

**10. 二叉树任意两个节点之间路径的最大长度**

动态规划问题DP,假设某个节点node,到它的最低节点的长度为len(node),所求的最长路径必然经过一个最高节点high_node,则它到最低叶节点high_node,则它到最低叶子结点的长度为
len(high_node) = max(len(high_node->left), len(high_node->right) + 1),路径长度为sum=len(high_node->left) +len(high_node->right) + 2;

```c++
int MaxDistance(TreeNode* root, int* max)
{
    if (root->pLeft == nullptr && root->pRight == nullptr)
    {
        return 0;
    }

    int left_len = 0, right_len = 0;
    if (root->pLeft != nullptr)
    {   
        left_len = MaxDistance(root->pLeft, max) + 1;
    }
    if (root->pRight != nullptr)
    {   
        right_len = MaxDistance(root->pRight, max) + 1;
    }

    int sum = left_len + right_len + 2;
    *max = (*max > sum) ? *max : sum;

    return (left_len > right_len) ? left_len : right_len;
}
```

**11. 如何实现二叉树的深度**

```java
public static int treeDepth(TreeNode root) {
    if (root == null) {
        return 0;
    }
    // 计算左子树的深度
    int left = treeDepth(root.left);
    // 计算右子树的深度
    int right = treeDepth(root.right);
    // 树root的深度=路径最长的子树深度 + 1
    return left >= right ? (left + 1) : (right + 1);
}
```

**12. 如何打印二叉树每层的节点**

广度优先搜索和队列结合，逐层打印.

前序，中序和后序遍历

**13. TreeMap和TreeSet在排序时如何比较元素？Collections工具类中的sort()方法如何比较元素？**

TreeSet要求存放的对象所属的类必须实现Comparable接口，该接口提供了比较元素的compareTo()方法，当插入元素时会回调该方法比较元素的大小。TreeMap要求存放的键值对映射的键必须实现Comparable接口从而根据键对元素进行排序。Collections工具类的sort方法有两种重载的形式，第一种要求传入的待排序容器中存放的对象比较实现Comparable接口以实现元素的比较；第二种不强制性的要求容器中的元素必须可比较，但是要求传入第二个参数，参数是Comparator接口的子类型（需要重写compare方法实现元素的比较），相当于一个临时定义的排序规则，其实就是通过接口注入比较元素大小的算法，也是对回调模式的应用（Java中对函数式编程的支持）

```java
public class Student implements Comparable<Student> {
    private String name;        // 姓名
    private int age;            // 年龄

    public Student(String name, int age) {
        this.name = name;
        this.age = age;
    }

    @Override
    public String toString() {
        return "Student [name=" + name + ", age=" + age + "]";
    }

    @Override
    public int compareTo(Student o) {
        return this.age - o.age; // 比较年龄(年龄的升序)
    }

    public static void main(String[] args){
        Set<Student> set = new TreeSet<>();     // Java 7的钻石语法(构造器后面的尖括号中不需要写类型)
        set.add(new Student("Hao LUO", 33));
        set.add(new Student("XJ WANG", 32));
        set.add(new Student("Bruce LEE", 60));
        set.add(new Student("Bob YANG", 22));

        for(Student stu : set) {
            System.out.println(stu);
        }
        List<Student> list = new ArrayList<>();     // Java 7的钻石语法(构造器后面的尖括号中不需要写类型)
        list.add(new Student("Hao LUO", 33));
        list.add(new Student("XJ WANG", 32));
        list.add(new Student("Bruce LEE", 60));
        list.add(new Student("Bob YANG", 22));

        // 通过sort方法的第二个参数传入一个Comparator接口对象
        // 相当于是传入一个比较对象大小的算法到sort方法中
        // 由于Java中没有函数指针、仿函数、委托这样的概念
        // 因此要将一个算法传入一个方法中唯一的选择就是通过接口回调
        Collections.sort(list, new Comparator<Student> () {

            @Override
            public int compare(Student o1, Student o2) {
                return o1.getName().compareTo(o2.getName());    // 比较学生姓名
            }
        });
    }
}
```

**14. 编程题：写一个函数，找到一个文件夹下所有文件，包括子文件夹**

java递归

```java
private void walk(File file){
    if (file != null){
        if (file.isDirectory()){
            File f[] = file.listFiles();
            if (f != null){
                for (int i = 0;i < f.length;++i){
                    walk(f[i]);
                }
            }
        }else{
            result.add(file);
        }
    }
}
```

**15. 二叉树 Z 字型遍历**

bfs遍历 使用双向队列，层与层之间倒序遍历

```java
public class Solution{
    List<List<Integer> > result = new ArrayList<List<Integer>>();
    if (root == null){
        return result;
    }
    LinkedList<TreeNode> queue = new LinkedList<>();
    int depth = 0;
    queue.offer(root);
    while(!queue.isEmpty()){
        int size = queue.size();
        List<Integer> tmp = new ArrayList<>();
        for(int i = 0; i < size; i++){
            TreeNode node = null;
            //因为是走z字形，所有相邻两层的节点处理是相反的
            if(depth%2 == 0){
                node = queue.pollLast();//获取链表最后一个节点
                if(node.left != null){
                    queue.offerFirst(node.left);
                }
                if(node.right != null){
                    queue.offerFirst(node.right);
                }
            }else{
                node = queue.poll();//获取链表第一个节点
                if(node.right != null){
                    queue.offer(node.right);
                }
                if(node.left != null){
                    queue.offer(node.left);
                }
            }
            tmp.add(node.val);
        }
        depth++;
        result.add(tmp);
    }
    return result;
}
```

**16. 反转单链表**

**17. 随机链表的复制**

**18. 链表-奇数位升序偶数位降序-让链表变成升序**

**19. bucket如果用链表存储，它的缺点是什么？**

**20. 何判断链表检测环**

**21. 寻找一数组中前K个最大的数**

**22. 求一个数组中连续子向量的最大和**

**23. 找出数组中和为S的一对组合，找出一组就行**

**24. 一个数组，除一个元素外其它都是两两相等，求那个元素?**

**25. 算法题：将一个二维数组顺时针旋转90度，说一下思路。**

**26. 排序算法知道哪些，时间复杂度是多少，解释一下快排？**

**27. 如何得到一个数据流中的中位数？**

**28. 堆排序的原理是什么？**

**29. 归并排序的原理是什么？**

**30. 排序都有哪几种方法？请列举出来。**

**31. 如何用java写一个冒泡排序？**

**32. 堆与栈的不同是什么？**

**33. heap和stack有什么区别。**

**34. 解释内存中的栈(stack)、堆(heap)和静态区(static area)的用法。**

**35. 什么是Java优先级队列(Priority Queue)？**

**36. **

**37. **

**38. **

**39. **

**40. **
