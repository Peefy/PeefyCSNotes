
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

```java
class ListNode {
    int val;
    ListNode next;
    ListNode(int x) {
        val = x;
        next = null;
    }
}
```

```java
// 1.就地反转法
public ListNode reverseList1(ListNode head) {
    if (head == null)
            return head;
        ListNode dummy = new ListNode(-1);
        dummy.next = head;
        ListNode prev = dummy.next;
        ListNode pCur = prev.next;
        while (pCur != null) {
            prev.next = pCur.next;
            pCur.next = dummy.next;
            dummy.next = pCur;
            pCur = prev.next;
        }
        return dummy.next;
    }
```

```java
// 2.新建链表,头节点插入法
public ListNode reverseList2(ListNode head) {
    ListNode dummy = new ListNode(-1);
    ListNode pCur = head;
    while (pCur != null) {
        ListNode pNex = pCur.next;
        pCur.next = dummy.next;
        dummy.next = pCur;
        pCur = pNex;
    }
    return dummy.next;
}
```

**17. 随机链表的复制**

输入一个复杂链表（每个节点中有节点值，以及两个指针，一个指向下一个节点，另一个特殊指针指向任意一个节点），返回结果为复制后复杂链表的head。（注意，输出结果中请不要返回参数中的节点引用，否则判题程序会直接返回空）

* 先复制结点并连接到原结点之后，再复制随机结点。随机结点的复制方法为：遍历原来的结点，当结点有随机结点时，原结点的下一个结点（即复制结点）的随机结点为原结点的随机结点的next。最后再拆分。
```java
public class Main2 {
 
    public RandomListNode copy(RandomListNode pHead){
		cloneNode(pHead);
		connectRandom(pHead);
		return ReConnectNodes(pHead);
	}
 
	public void cloneNode(RandomListNode pHead){
		RandomListNode node = pHead;
		while(node != null){
			RandomListNode copyNode = new RandomListNode(node.label);
			copyNode.next = node.next;
			copyNode.random = null;
			node.next = copyNode;
			node = copyNode.next;
		}
	}
	
	public void connectRandom(RandomListNode pHead){
		RandomListNode node = pHead;
		while(node != null){
			RandomListNode clone = node.next;
			if(node.random != null){
				clone.random = node.random.next;
			}
			node = clone.next;
		}
	}
	
	public RandomListNode ReConnectNodes(RandomListNode pHead){
        RandomListNode tempNode = pHead;
        RandomListNode copyHead = null;
        RandomListNode cloneNode = null;
        if(tempNode != null){
        	copyHead = tempNode.next;
        	cloneNode = tempNode.next;
        	tempNode.next = cloneNode.next;
        	tempNode = tempNode.next;
        }
        while(tempNode != null){
        	cloneNode.next = tempNode.next;
        	cloneNode = tempNode.next;
        	tempNode.next = cloneNode.next;
        	tempNode = cloneNode.next;
        	
        }
        return copyHead;
    }
	
	public static void main(String[] args) {
		RandomListNode head = new RandomListNode(1);
		head.next = new RandomListNode(2);
		head.next.next = new RandomListNode(3);
		head.next.next.next = new RandomListNode(4);
		head.next.next.next.next = new RandomListNode(5);
		head.random = head.next.next;
		head.next.random = head.next.next.next;
		head.next.next.random = head.next.next.next.next;
		Main2 test = new Main2();
		RandomListNode copy = test.copy(head);
		while(copy != null){
			
			if(copy.random != null){
				System.out.println(copy.label + "," + copy.random.label);
			}
			System.out.println(copy.label);
			copy = copy.next;
		}
	}
}
 
class RandomListNode {
    int label;
    RandomListNode next = null;
    RandomListNode random = null;
 
    RandomListNode(int label) {
        this.label = label;
    }
}
```

* 可以利用哈希表来做，先复制，然后再给next和random赋值。
```java
import java.util.HashMap;
 
public class RandomListCopy {
 
	public static void main(String[] args) {
		// TODO Auto-generated method stub
		HashMap<RandomList, RandomList> map = new HashMap<>();
		RandomList p1 = new RandomList(null, null,1);
		RandomList p2 = new RandomList(null, null,2);
		RandomList p3 = new RandomList(null, null,3);
		RandomList p4 = new RandomList(null, null,4);
		p1.next=p2;
		p2.next=p3;
		p3.next=p4;
		p1.random=p3;
		p2.random=p4;
		
		RandomList cHead = copy(p1);
		while(cHead!=null){
			System.out.println(cHead.val);
			if(cHead.random!=null){
				System.out.println("Random:"+cHead.random.val);
			}
			cHead = cHead.next;
		}
	}
	
	public static RandomList copy(RandomList pHead){
		HashMap<RandomList, RandomList> map = new HashMap<>();
		RandomList head = pHead;
		while(head!=null){
			map.put(head, new RandomList(null, null, head.val));
			head=head.next;
		}
		head = pHead;
		while(head!=null){
			map.get(head).next = map.get(head.next);
			map.get(head).random = map.get(head.random);
			head=head.next;
		}
		head = pHead;
		RandomList cHead = map.get(head);
		return cHead;
	}
}
 
class RandomList{
	public int val;
	RandomList next;
	RandomList random;
	public RandomList(RandomList next, RandomList random, int val){
		this.next=next;
		this.random=random;
		this.val=val;
	}
}
```

**18. 链表-奇数位升序偶数位降序-让链表变成升序**

按奇数位和偶数位置拆分链表，偶数位链表反转，合并两个有序列表

```java
public class OddIncreaseEvenDecrease {
    /**
     * 按照奇偶位拆分成两个链表
     * @param head
     * @return
     */
    public static Node[] getLists(Node head){
        Node head1 = null;
        Node head2 = null;
        
        Node cur1 = null;
        Node cur2 = null;
        int count = 1;//用来计数
        while(head != null){
            if(count % 2 == 1){
                if(cur1 != null){
                    cur1.next = head;
                    cur1 = cur1.next;
                }else{
                    cur1 = head;
                    head1 = cur1;
                }
            }else{
                if(cur2 != null){
                    cur2.next = head;
                    cur2 = cur2.next;
                }else{
                    cur2 = head;
                    head2 = cur2;
                }
            }
            head = head.next;
            count++;
        }
        //跳出循环，要让最后两个末尾元素的下一个都指向null
        cur1.next = null;
        cur2.next = null;
        
        Node[] nodes = new Node[]{head1, head2};
        return nodes;
    }
    
    /**
     * 反转链表
     * @param head
     * @return
     */
    public static Node reverseList(Node head){
        Node pre = null;
        Node next = null;
        while(head != null){
            next = head.next;
            head.next = pre;
            pre = head;
            head = next;
        }
        return pre;
    }
    
    /**
     * 合并两个有序链表
     * @param head1
     * @param head2
     * @return
     */
    public static Node CombineList(Node head1, Node head2){
        if(head1 == null || head2 == null){
            return head1 != null ? head1 : head2;
        }
        Node head = head1.value < head2.value ? head1 : head2;
        Node cur1 = head == head1 ? head1 : head2;
        Node cur2 = head == head1 ? head2 : head1;
        Node pre = null;
        Node next = null;
        while(cur1 != null && cur2 != null){
            if(cur1.value <= cur2.value){//这里一定要有=，否则一旦cur1的value和cur2的value相等的话，下面的pre.next会出现空指针异常
                pre = cur1;
                cur1 = cur1.next;
            }else{
                next = cur2.next;
                pre.next = cur2;
                cur2.next = cur1;
                pre = cur2;
                cur2 = next;
            }
        }
        pre.next = cur1 == null ? cur2 : cur1;
        
        return head;
    }
    
    public static void main(String[] args) {
        Node head = init();
        Node[] lists = getLists(head);
        
        Node head1 = lists[0];
        Node head2 = lists[1];
        head2 = reverseList(head2);
        
        head = CombineList(head1, head2);
        while(head != null){
            System.out.println(head.value);
            head = head.next;
        }
    }
    
    public static Node init(){
        Node node1 = new Node(1);
        Node node2 = new Node(8);
        Node node3 = new Node(3);
        Node node4 = new Node(6);
        Node node5 = new Node(5);
        Node node6 = new Node(4);
        Node node7 = new Node(7);
        Node node8 = new Node(2);
        Node node9 = new Node(9);
        
        node1.next = node2;
        node2.next = node3;
        node3.next = node4;
        node4.next = node5;
        node5.next = node6;
        node6.next = node7;
        node7.next = node8;
        node8.next = node9;
        return node1;
    }
}
```

**19. bucket如果用链表存储，它的缺点是什么？**

不支持随机访问，查找的时间复杂度是O(n)

**20. 何判断链表检测环**

双指针slow,fast

```c++
position IsLoop(list l){
    if (l == NULL) {
        printf("Invalid parameter for function IsLoop!\n");
        exit(-1);
    }
    list fast, slow;
    fast = slow = 1;
    while (fast != NULL && fast-> next != NULL) {
        slow = slow->next;
        fast = fast->next->next;
        if (slow == fast)
            return slow;
    }
    return NULL;
}
```

**21. 寻找一数组中前K个最大的数**

* 算法1: 降序快速排序,取前k个数
* 算法2: 前面k个数比后面的数的最大值要大，则前面k个数就是最大的k个
* 算法3: 构建最大堆，然后调整k次

```java
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;
 
//给定一个长度为n的数组，寻找其中最大的k个数
public class FindKthElements {
	
	//算法一：排序，时间复杂度O(nlogn)，空间复杂度O(1)
	public ArrayList<Integer> findKthElements(int[] arr, int k) {
		
		ArrayList<Integer> res = new ArrayList<Integer>();
		if(arr.length <= 0 || arr == null || arr.length < k) {
			return res;
		}
		
		Arrays.sort(arr);
		for(int i = arr.length - 1;i > arr.length - 1 - k;i --) {
			res.add(arr[i]);
		}
		return res;
	}
	
	//算法二；前面k个数都比后面的数的最大值要大，则前面k个数就是最大的k个，时间复杂度O(k*(n-k))，空间复杂度O(1)
	public ArrayList<Integer> findKthElements2(int[] arr, int k) {
		
		ArrayList<Integer> res = new ArrayList<Integer>();
		if(arr.length <= 0 || arr == null || arr.length < k) {
			return res;
		}
		
		for(int i = 0;i < k;i ++) {
			int maxValueIndex = this.getMaxValueIndex(arr, k);
			if(arr[maxValueIndex] > arr[i]) {
				int temp = arr[maxValueIndex];
				arr[maxValueIndex] = arr[i];
				arr[i] = temp;
			}
		}
		
		for(int i = 0;i < k;i ++) {
			res.add(arr[i]);
		}
		return res;
	}
	
	//选择排序：选出最大值的下标
	public int getMaxValueIndex(int[] arr, int k) {
		
		int maxValueIndex = k;
		for(int i = k + 1;i < arr.length;i ++) {
			if(arr[i] > arr[maxValueIndex]) {
				maxValueIndex = i;
			}
		}
		return maxValueIndex;
	}
	
	//算法三：构建大顶堆，然后调整k次，得到最大的k个数。时间复杂度(k+1)O(nlogn)，空间复杂度O(1)
	public ArrayList<Integer> findKthElements3(int[] arr, int k) {
		
		ArrayList<Integer> res = new ArrayList<Integer>();
		if(arr.length <= 0 || arr == null || arr.length < k) {
			return res;
		}
		//构建大顶堆
		int len = arr.length;
		for(int i = len / 2;i < len;i ++) {
			heapSort(arr, i, len);
		}
		//调整k次大顶堆
		for(int i = arr.length - 1;i > arr.length - 1 - k;i --) {
			//交换最大的值到底部
			int temp = arr[i];
			arr[i] = arr[0];
			arr[0] = temp;
			res.add(arr[i]);
			heapSort(arr, 0, i);
		}
		return res;
	}
	
	public void heapSort(int[] arr, int start, int len) {
		
		int parent = start;
		int leftChild = parent * 2 + 1;
		int parentValue = arr[parent];
		while(leftChild < len) {
			int rightChild = leftChild + 1;
			if(rightChild < len && arr[leftChild] < arr[rightChild]) {	//在左右孩子里选一个较大的出来
				leftChild = rightChild;
			}			
			if(parentValue > arr[leftChild]) {
				break;
			}
			arr[parent] = arr[leftChild];
			parent = leftChild;
			leftChild = parent * 2 + 1;
		}
		arr[parent] = parentValue;
	}
	
	public static void main(String[] args) {
		
		int[] arr = {9,4,5,8,2};
		FindKthElements fke = new FindKthElements();
		List<Integer> res = fke.findKthElements3(arr, 3);
		System.out.println(res);
	}
}
```

**22. 求一个数组中连续子向量的最大和**

```java
/*
 * 如果向量中包含负数,是否应该包含某个负数,并期望旁边的正数会弥补它呢？
 * 例如:{6,-3,-2,7,-15,1,2,2},连续子向量的最大和为8(从第0个开始,到第3个为止)。
 * [-2,-8,-1,-5,-9]
 * 问题：求一个数组中连续子向量的最大和
 */
public class FindGreatestSumOfSubArray {
	public int findGreatestSumOfSubArray(int[] array) {
		int sum = array[0];
		int max = array[0];
		
		for(int i = 1;i < array.length;i ++) {
			//前面sum大于0，认为是有贡献的，可以叠加在上面。否则认为没有贡献，另起炉灶
			if(sum >= 0) {
				sum = sum + array[i];
			}
			else {
				sum = array[i];
			}
			
			if(sum > max) {
				max = sum;
			}
		}
		
		return max;
	}
	
	public static void main(String[] args) {
		int[] array = {6,-3,-2,7,-15,1,2,2};
		System.out.println(new FindGreatestSumOfSubArray().findGreatestSumOfSubArray(array));
	}
}
```

**23. 找出数组中和为S的一对组合，找出一组就行**

```java
public class Solution {
    public int[] twoSum(int[] nums, int target) {
        int[] result = new int[2];
        result[0] = 1;
        result[1] = 2;
        ArrayList<Integer> list = new ArrayList<Integer>(10);
        for(int num : nums)
        {
            list.add(num);
        }
        Collections.sort(list);
        int num = nums.length;
        for(int i = 0;i < num;++i)
        {
            for(int j = i + 1;j < num; ++j)
            {
                if(nums[i] + nums[j] == target){
                    result[0] = i;
                    result[1] = j;
                }
            }
        }
        return result;
    }
}
```

**24. 一个数组，除一个元素外其它都是两两相等，求那个元素?**

异或运算满足交换律，相同数异或为0，结果就是 0 xor x = x

```c++
int a = 0;
for(auto i : nums)
    a ^= i;
return a;
```

**25. 算法题：将一个二维数组顺时针旋转90度，说一下思路。**

```java
public class twoDimensionalArrayRotate {

    public static void main(String[] args) {
        int[][] numsix={
                {1,2,3},
                {4,5,6},
                {7,8,9}
        };
        int[][] rotate = rotate(numsix);
    }

    public static int[][] rotate(int[][] matrix) {
        int abs1 = 0;
        int abs2 = matrix.length - 1;
        int times = 0;
        while (abs1 <= abs2) {
            int p1 = abs1;
            int p2 = abs2;
            while (p1 != abs2) {
                // 转换的思路：
                // 1.先保存左上的值到临时变量
                // 2.左下--> 左上， 右下-->左上， 右上-->右下，临时变量内的左上-->右上
                int temp = matrix[abs1][p1];         //左上
                matrix[abs1][p1] = matrix[p2][abs1]; //左上 = 左下
                matrix[p2][abs1] = matrix[abs2][p2]; //左下 = 右下
                matrix[abs2][p2] = matrix[p1][abs2]; //右下 = 右上
                matrix[p1][abs2] = temp;             //右上 = 左上
                p1 += 1;
                p2 -= 1;
            }
            abs1 += 1;
            abs2 -= 1;
        }
        return matrix;
    }
}
```

**26. 排序算法知道哪些，时间复杂度是多少，解释一下快排？**

[排序算法汇总](https://github.com/Peefy/IntroductionToAlgorithm.Python/tree/master/src/dugulib)

**27. 如何得到一个数据流中的中位数？**

```c++
class Solution {
public:
    /**
     * @param nums: A list of integers.
     * @return: The median of numbers
     */
    vector<int> medianII(vector<int> &nums) {
        // write your code here
        multiset<int> left, right;
        vector<int> res;
        bool flag = true;
        for (int n : nums) {
            int tmp = n;
            if (flag) {
                if (!right.empty() && n > *right.begin()) {
                    right.insert(n);
                    tmp = *right.begin();
                    right.erase(right.find(tmp));
                }
                left.insert(tmp);
            } else {
                if (!left.empty() && n < *left.rbegin()) {
                    left.insert(n);
                    tmp = *left.rbegin();
                    left.erase(left.find(tmp));
                }
                right.insert(tmp);
            }
            flag = !flag;
            res.push_back(*left.rbegin());
        }
        return res;
    }
};
```

**28. 堆排序的原理是什么？**

堆排序是利用堆的性质进行的一种选择排序。下面先讨论一下堆, 利用大顶堆(小顶堆)堆顶记录的是最大关键字(最小关键字)这一特性，使得每次从无序中选择最大记录(最小记录)变得简单。

```c++
#include <iostream>
#include <algorithm>
#include <stdio.h>
using namespace std;

int n,a[100];      //大顶堆

int Heap_Adjust(int *a,int i,int n){ //调整堆，i待调整节点，n 总结点
    int i_left=2*i;
    int i_right=2*i+1;
    int temp=i;   //临时变量
    if(i<=n/2)     //i为叶子节点 无需调整
    {
        if(i_left<=n&&a[i_left]>a[temp])
            temp=i_left;
        if(i_right<=n&&a[i_right]>a[temp])
            temp=i_right;
        if(temp!=i)
        {
            swap(a[i],a[temp]);
            Heap_Adjust(a,temp,n);     //避免调整之后以temp为父节点的子树不是堆
        }
    }
}
void BuildHeap(int *a,int size)    //建立堆
{
    int i;
    for(i=size/2;i>=1;i--)    //非叶节点最大序号值为size/2
    {
        Heap_Adjust(a,i,size);
    }
}
void Heap_Sort(int *a,int size)
{
    int i;
    BuildHeap(a,size);
    for(i=size;i>=1;i--)
    {
        cout<<a[1]<<endl;
        swap(a[1],a[i]);
        Heap_Adjust(a,1,i-1);

    }

}

int main(int argc, char *argv[])
{
     //int a[]={0,16,20,3,11,17,8};
    int a[100];
    int size;
    while(scanf("%d",&size)==1&&size>0)
    {
        int i;
        for(i=1;i<=size;i++)
            cin>>a[i];
        Heap_Sort(a,size);

    }
    return 0;
}
```

**29. 归并排序的原理是什么？**

归并排序是一种递归算法，不断将列表拆分为一半，如果列表为空或有一个项，则按定义进行排序。如果列表有多个项，我们分割列表，并递归调用两个半部分的合并排序。一旦对两半排序完成，获取两个较小的排序列表并将它们组合成单个排序的新列表的过程

**30. 排序都有哪几种方法？请列举出来。**

[排序算法汇总](https://github.com/Peefy/IntroductionToAlgorithm.Python/tree/master/src/dugulib)

**31. 如何用java写一个冒泡排序？**

```java
for(int i = 0;i < arr.length - 1; i++){//外层循环控制排序趟数
　　for(int j = 0; j < arr.length - 1 - i; j++){//内层循环控制每一趟排序多少次
　　　　if ( arr[j] > arr[j+1] ) {
　　　　　　int temp = arr[j];
　　　　　　arr[j] = arr[j + 1];
　　　　　　arr[j + 1] = temp;
　　　　}
　　}
} 
```

**32. 堆与栈的不同是什么？**

* 栈区（stack）— 由编译器自动分配释放 ，存放函数的参数值，局部变量的值等。其操作方式类似于数据结构中的栈。
* 堆区（heap） — 一般由程序员分配释放， 若程序员不释放，程序结束时可能由OS回收 。注意它与数据结构中的堆是两回事，分配方式倒是类似于链表

栈是先入后出，堆是二项堆

**33. heap和stack有什么区别。**

* 栈区（stack）— 由编译器自动分配释放 ，存放函数的参数值，局部变量的值等。其操作方式类似于数据结构中的栈。
* 堆区（heap） — 一般由程序员分配释放， 若程序员不释放，程序结束时可能由OS回收 。注意它与数据结构中的堆是两回事，分配方式倒是类似于链表

栈是先入后出，堆是二项堆

**34. 解释内存中的栈(stack)、堆(heap)和静态区(static area)的用法。**

* 栈区（stack）— 由编译器自动分配释放 ，存放函数的参数值，局部变量的值等。其操作方式类似于数据结构中的栈。
* 堆区（heap） — 一般由程序员分配释放， 若程序员不释放，程序结束时可能由OS回收 。注意它与数据结构中的堆是两回事，分配方式倒是类似于链表
* 全局区（静态区）（static）—，全局变量和静态变量的存储是放在一块的，初始化的全局变量和静态变量在一块区域， 未初始化的全局变量和未初始化的静态变量在相邻的另一块区域

**35. 什么是Java优先级队列(Priority Queue)？**

PriorityQueue是一个基于优先级堆的无界队列。它的元素是按照自然顺序排序的。在创建元素的时候，我们给它一个一个负责排序的比较器。PriorityQueue不允许null值，因为

它们没有自然排序，或者说没有任何相关联的比较器。最后PriorityQueue不是线程安全的，出对和入队的时间复杂度都是O(log(n))

**36. 1亿个数中找到最大的前100个数**

找最大的前100个数，那么我们就创建一个大小为100的最小化堆，每来一个元素就与堆顶元素比较，因为堆顶元素是目前前100大数中的最小数，前来的元素如果比该元素大，那么就把原来的堆顶替换掉。

**37. 红黑树和AVL树的定义，特点，以及二者区别**

一棵红黑树是指一棵满足下述性质的二叉搜索树（BST, binary search tree）： 1. 每个结点或者为黑色或者为红色。 2. 根结点为黑色。 3. 每个叶结点(实际上就是NULL指针)都是黑色的。 4. 如果一个结点是红色的，那么它的两个子节点都是黑色的（也就是说，不能有两个相邻的红色结点）。 5. 对于每个结点，从该结点到其所有子孙叶结点的路径中所包含的黑色结点数量必须相同。红黑树能够以O(log2 n) 的时间复杂度进行搜索、插入、删除操作。此外，由于它的设计，任何不平衡都会在三次旋转之内解决。

AVL树是最先发明的自平衡二叉查找树。在AVL树中任何节点的两个儿子子树的高度最大差别为一，所以它也被称为高度平衡树。查找、插入和删除在平均和最坏情况下都是O(log n)。增加和删除可能需要通过一次或多次树旋转来重新平衡这个树。
引入二叉树的目的是为了提高二叉树的搜索的效率,减少树的平均搜索长度.为此,就必须每向二叉树插入一个结点时调整树的结构,使得二叉树搜索保持平衡,从而可能降低树的高度,减少的平均树的搜索长度.为了保证平衡，AVL树中的每个结点都有一个平衡因子（balance factor，以下用BF表示），它表示这个结点的左、右子树的高度差，也就是左子树的高度减去右子树的高度的结果值。AVL树上所有结点的BF值只能是-1、0、1。反之，只要二叉树上一个结点的BF的绝对值大于1，则该二叉树就不是平衡二叉树。下图演示了平衡二叉树和非平衡二叉树。

*区别*

红黑树和AVL树的区别在于平衡二叉树追求的是全局平衡，而红黑树只追求局部平衡，因此在操作时对红黑树的平衡调整更高效。红黑树并不是严格意义上的左右子树深度差不大于1，但它依然保持平衡，并保持好的查找时间复杂度。

**38. 哈夫曼编码**

哈夫曼编码(Huffman Coding)，又称霍夫曼编码，是一种编码方式，可变字长编码(VLC)的一种。Huffman于1952年提出一种编码方法，该方法完全依据字符出现概率来构造异字头的平均长度最短的码字，有时称之为最佳编码，一般就叫做Huffman编码（有时也称为霍夫曼编码）。

哈夫曼编码，主要目的是根据使用频率来最大化节省字符（编码）的存储空间。

简易的理解就是，假如我有A,B,C,D,E五个字符，出现的频率（即权值）分别为5,4,3,2,1,那么我们第一步先取两个最小权值作为左右子树构造一个新树，即取1，2构成新树，其结点为1+2=3，

```python

from __future__ import division, absolute_import, print_function
from copy import deepcopy as _deepcopy

class HuffmanTreeNode:
    '''
    Huffman二叉树结点
    '''
    def __init__(self, left = None, right = None, f = None, p = None, character=None, index=None):
        '''
        Huffman二叉树结点

        Args
        ===
        `left` : BTreeNode : 左儿子结点

        `right`  : BTreeNode : 右儿子结点

        `f` : 结点自身频度

        '''
        self.left = left
        self.right = right
        self.f = f
        self.p = p
        self.character = character
        self.coding = ''
        self.index = None

class HuffmanTree:
    def __init__(self):
        self.root = None
        self.__nodes = []
        self.codings = []
        self.characters = []
        self.fs = []
        self.__coding = ""
        
    def addnode(self, node):
        '''
        加入二叉树结点

        Args
        ===
        `node` : `HuffmanTreeNode` 结点

        '''
        self.__nodes.append(node)

    def buildnodecodingformcharacter(self, node):
        if node is not None:
            if node.p is None:
                return
            if node.p.left == node:
                self.__coding += '0'
            if node.p.right == node:
                self.__coding += '1'
            self.buildnodecodingformcharacter(node.p)
        
    def __findnode(self, f):
        '''
        根据`f`从`nodes`中寻找结点
        '''
        if f is None:
            return None
        for node in self.__nodes:
            if f == node.f:
                return node
            if node.left is not None:
                if f == node.left.f:
                    return node.left
            if node.right is not None:
                if f == node.right.f:
                    return node.right
        return None

    def __findnode_f_c(self, f, c):
        '''
        根据`f`从`nodes`中寻找结点
        '''
        if f is None:
            return None
        for node in self.__nodes:
            if f == node.f and c == node.character:
                return node
            if node.left is not None:
                if f == node.left.f and c == node.left.character:
                    return node.left
            if node.right is not None:
                if f == node.right.f and c == node.right.character:
                    return node.right
        return None

    def __findnodefromc(self, c):
        '''
        根据`f`从`nodes`中寻找结点
        '''
        if c is None:
            return None
        for node in self.__nodes:
            if c == node.character:
                return node
            if node.left is not None:
                if c == node.left.character:
                    return node.left
            if node.right is not None:
                if c == node.right.character:
                    return node.right
        return None

    def renewall(self):
        '''
        更新/连接/构造二叉树
        '''
        for node in self.__nodes:
            if node.left is not None:
                node.left = self.__findnode_f_c(node.left.f, node.left.character)
                node.left.p = node
            if node.right is not None:
                node.right = self.__findnode_f_c(node.right.f, node.right.character)
                node.right.p = node
    
    def renewnode(self, node):
        '''
        更新/连接/构造二叉树结点
        '''
        if node is None:
            return
        if node.left is not None:
            node.left = self.__findnode_index(node.left.index)
            node.left.p = node
        if node.right is not None:
            node.right = self.__findnode_index(node.right.index)
            node.right.p = node

    def renewallcoding(self, characters):
        n = len(characters)
        for i in range(n):
            c = characters[i]
            node = self.__findnodefromc(c)
            self.__coding = ""
            self.buildnodecodingformcharacter(node)
            if node is not None:
                node.coding = self.__coding[::-1]
                self.codings.append(node.coding)

class HuffmanTreeBuilder:
    '''
    HuffmanTree 构造器
    '''
    def __init__(self, C : list, f : list):
        self.C = C
        self.f = f

    def extract_min(self, C : list):
        min_val = min(C)
        C.remove(min_val)
        node = HuffmanTreeNode(None, None, min_val)
        return node

    def build_character(self, C : list, f : list, node : HuffmanTreeNode):
        try:
            index = f.index(int(node.f))
            f.pop(index)
            node.character = C[index]
            C.pop(index)
        except Exception as err:
            pass

    def huffman(self, C : list, f : list):
        '''
        赫夫曼编码

        算法自底向上的方式构造出最优编码所对应的树T

        Args
        ===
        `C` : 一个包含n个字符的集合，且每个字符都是一个出现频度为f[c]的对象

        '''
        n = len(f)
        Q = _deepcopy(f)
        tree = HuffmanTree()
        tree.characters = _deepcopy(self.C)
        tree.fs = _deepcopy(self.f)
        index = 0
        for i in range(n - 1):
            x = self.extract_min(Q)
            self.build_character(C, f, x)
            x.index = index
            index += 1
            y = self.extract_min(Q)
            self.build_character(C, f, y)
            y.index = index
            index += 1
            z = HuffmanTreeNode(x, y, x.f + y.f)
            z.index = index
            index += 1
            x.p = z
            y.p = z
            tree.addnode(z)
            Q.append(z.f)
        tree.renewall()
        tree.root = z
        tree.renewallcoding(tree.characters)
        
        return tree

    def build(self):
        '''
        构造一个HuffmanTree
        '''
        return self.huffman(self.C, self.f)
        
```

**哈夫曼树构建过程**

对于给定的一组权值w={1,4,9,16,25,36,49,64,81,100},构造具有最小带权外部路径长度的扩充二叉树，并求出他的的带权外部路径长度。

* 首先我们对这一组数字进行排序。规则是从小到大排列
* 在这些数中 选择两个最小的数字（哈夫曼树是从下往上排列的）

[哈夫曼树带权路径长度计算](https://blog.csdn.net/xueba8/article/details/78477892)

**39. map底层为什么用红黑树实现**

HashMap新引进的红黑树树化的过程，与原来的链表相比当同一个bucket上存储很多entry的话树形的查找结构明显要比链表线性的的效率要高。

**40. B+树**

+树：B+树是B-树的变体，也是一种多路搜索树：其定义基本与B-树同，除了：非叶子结点的子树指针与关键字个数相同；非叶子结点的子树指针P\[i\]，指向关键字值属于\[K\[i\], K\[i+1\])的子树（B-树是开区间）；为所有叶子结点增加一个链指针；所有关键字都在叶子结点出现；B+的搜索与B-树也基本相同，区别是B+树只有达到叶子结点才命中（B-树可以在非叶子结点命中），其性能也等价于在关键字全集做一次二分查找；

B+的特性：所有关键字都出现在叶子结点的链表中（稠密索引），且链表中的关键字恰好是有序的；不可能在非叶子结点命中；非叶子结点相当于是叶子结点的索引（稀疏索引），叶子结点相当于是存储（关键字）数据的数据层；更适合文件索引系统；增删文件（节点）时，效率更高，因为B+树的叶子节点包含所有关键字，并以有序的链表结构存储，这样可很好提高增删效率。

**41. map和unordered_map的底层实现**

map底层采用红黑树实现，有序映射，unordered_map底层采用哈希表实现，无序映射

**42. map和unordered_map优点和缺点**

* **内部实现机理不同**-map： map内部实现了一个红黑树（红黑树是非严格平衡二叉搜索树，而AVL是严格平衡二叉搜索树），红黑树具有自动排序的功能，因此map内部的所有元素都是有序的，红黑树的每一个节点都代表着map的一个元素。因此，对于map进行的查找，删除，添加等一系列的操作都相当于是对红黑树进行的操作。map中的元素是按照二叉搜索树（又名二叉查找树、二叉排序树，特点就是左子树上所有节点的键值都小于根节点的键值，右子树所有节点的键值都大于根节点的键值）存储的，使用中序遍历可将键值按照从小到大遍历出来。
unordered_map: unordered_map内部实现了一个哈希表（也叫散列表，通过把关键码值映射到Hash表中一个位置来访问记录，查找的时间复杂度可达到O(1)，其在海量数据处理中有着广泛应用）。因此，其元素的排列顺序是无序的
* **优缺点以及适用处**-

map：

优点：
有序性，这是map结构最大的优点，其元素的有序性在很多应用中都会简化很多的操作
红黑树，内部实现一个红黑书使得map的很多操作在lgn的时间复杂度下就可以实现，因此效率非常的高
缺点： 空间占用率高，因为map内部实现了红黑树，虽然提高了运行效率，但是因为每一个节点都需要额外保存父节点、孩子节点和红/黑性质，使得每一个节点都占用大量的空间
适用处：对于那些有顺序要求的问题，用map会更高效一些

unordered_map：

优点： 因为内部实现了哈希表，因此其查找速度非常的快
缺点： 哈希表的建立比较耗费时间
适用处：对于查找问题，unordered_map会更加高效一些，因此遇到查找问题，常会考虑一下用unordered_map

**43. epoll怎么实现的**

epoll是Linux内核为处理大批量文件描述符而作了改进的poll，是Linux下多路复用IO接口select/poll的增强版本，它能显著提高程序在大量并发连接中只有少量活跃的情况下的系统CPU利用率。另一点原因就是获取事件的时候，它无须遍历整个被侦听的描述符集，只要遍历那些被内核IO事件异步唤醒而加入Ready队列的描述符集合就行了。epoll除了提供select/poll那种IO事件的水平触发（Level Triggered）外，还提供了边缘触发（Edge Triggered），这就使得用户空间程序有可能缓存IO状态，减少epoll_wait/epoll_pwait的调用，提高应用程序效率。

**44. C++两种map**

map和unordered_map

**45. 红黑树的性质还有左右旋转**

一棵红黑树是指一棵满足下述性质的二叉搜索树（BST, binary search tree）： 1. 每个结点或者为黑色或者为红色。 2. 根结点为黑色。 3. 每个叶结点(实际上就是NULL指针)都是黑色的。 4. 如果一个结点是红色的，那么它的两个子节点都是黑色的（也就是说，不能有两个相邻的红色结点）。 5. 对于每个结点，从该结点到其所有子孙叶结点的路径中所包含的黑色结点数量必须相同。红黑树能够以O(log2 n) 的时间复杂度进行搜索、插入、删除操作。此外，由于它的设计，任何不平衡都会在三次旋转之内解决。

**46. 红黑树的原理以及erase以后迭代器的具体分布情况？**

C++ 中经常使用的容器类有vector，list，map。其中vector和list的erase都是返回迭代器，但是map就比较不一样。究其原因是map 是关联容器,对于关联容器来说，如果某一个元素已经被删除，那么其对应的迭代器就失效了，不应该再被使用；

```c++
for(auto iter=mapTest.begin();iter!=mapTest.end();)
{
cout<<iter->first<<":"<<iter->second<<endl;
mapTest.erase(iter++);
}
```

**47. 二叉树的层序遍历并输出**

bfs + 链表

**48. 二叉树序列化反序列化**

先序序列化二叉树==定义一个stringbuilder保存序列过程中的结果：按照先序遍历方式遍历二叉树，若结点非空则把 "结点值!" append到builder中；若结点空则把  "#!" append到builder中；

```java
public class TreeToString {
    public String toString(TreeNode root) {
        StringBuilder builder=new StringBuilder();
        pre(root,builder);
        return builder.toString();
    }
    public void pre(TreeNode root,StringBuilder builder){
        if(root==null){
            builder.append("#!");
        }else{
            builder.append(root.val+"!");
        //注意递归边界：如果当前结点不是null则递归左右儿子；如果不判断当前结点是否为空，则在递归到null时出现空指针异常
            pre(root.left,builder);
            pre(root.right,builder);
        }
    }
}
```

二叉树的反序列化是指：根据某种遍历顺序得到的序列化字符串结果str，重构二叉树

**49. stack overflow，并举个简单例子导致栈溢出**

windows栈大小默认为1M，超过1M就会报错提示栈溢出:stack overflow

```c
char maxStack[1024][1024];
```

**50. 栈和堆的区别，以及为什么栈要快**

* 栈区（ stack ) ——由编译器自动分配释放，存放为运行函数而分配的局部变量、函数参数、返回数据、返回地址等。其操作方式类似于数据结构中的栈；
* 堆区（ heap ）——一般由程序员分配释放， 若程序员不释放，程序结束时可能由 OS 回收 。分配方式类似于链表；

栈是机器系统提供的数据结构，而堆栈是C/C++函数库提供的。所以栈要更快 

**51. 两个栈实现一个队列**

* 思路1：将stack1作为存储空间，将stack2作为临时缓冲区，入队时，直接压入stac1，出队时，将stack1中的元素依次出栈压入stack2中，再将stack2的栈顶元素弹出，最后将stack2中的元素再倒回给stack1
* 思路2：入队时，判断stack1是否为空，如果stack1为空，则将stack2中的所有元素都倒入stack1中，再将元素直接压入stack1，否则，直接压入stack1中；出队时，判断stack2是否为空，如果stack2为空，则将stack1中的元素倒入stack2中，在将stack2的栈顶元素弹出，否则，直接弹出stack2的栈顶元素  
* 思路3：入队时，直接压入stack1中；出队时，判断stack2是否为空，如果stack2为空，则将stack1中的元素倒入stack2中，否则直接弹出stack2中的元素

```java
//入队操作
void EnQueue(stack<int> &s1,stack<int> &s2,int m)
{
    s1.push(m);
}

//出队操作
void DeQueue(stack<int> &s1,stack<int> &s2,int &m)
{
    if (s2.empty())
    {
        int p = s1.size();
        for (int i=0;i<p;i++)
        {
            s2.push(s1.top());
            s1.pop();
        }    
    }
    m = s2.top();
    s2.pop();
}
```

**52. 小根堆特点**

大顶堆(小顶堆)堆顶记录的是最大关键字(最小关键字)这一特性

**53. Array&List数组和链表的区别**

不同：链表是链式的存储结构；数组是顺序的存储结构。

链表通过指针来连接元素与元素，数组则是把所有元素按次序依次存储。

链表的插入删除元素相对数组较为简单，不需要移动元素，且较为容易实现长度扩充，但是寻找某个元素较为困难；

数组寻找某个元素较为简单，但插入与删除比较复杂，由于最大长度需要再编程一开始时指定，故当达到最大长度时，扩充长度不如链表方便。
相同：两种结构均可实现数据的顺序存储，构造出来的模型呈线性结构。

**54. 一个长度为N的整形数组，数组中每个元素的取值范围是\[0,n-1\],判断该数组否有重复的数，请说一下你的思路并手写代码**

```c++

bool IsDuplicateNumber(int *array, int n)
{	
    if(array==NULL) return false;	
    int i,temp;
    for(i=0;i<n;i++)		
    {	
        while(array[i]!=i)			
        {		
            if(array[array[i]]==array[i]) 
				return true;	
            temp=array[array[i]];	
            array[array[i]]=array[i];		
            array[i]=temp;			
        }		
    }	
    return false;	
}
```

**55. 手写一下快排的代码**

```c++
using namespace std;
 
void Qsort(int arr[], int low, int high){
    if (high <= low) return;
    int i = low;
    int j = high + 1;
    int key = arr[low];
    while (true)
    {
        /*从左向右找比key大的值*/
        while (arr[++i] < key)
        {
            if (i == high){
                break;
            }
        }
        /*从右向左找比key小的值*/
        while (arr[--j] > key)
        {
            if (j == low){
                break;
            }
        }
        if (i >= j) break;
        /*交换i,j对应的值*/
        int temp = arr[i];
        arr[i] = arr[j];
        arr[j] = temp;
    }
    /*中枢值与j对应值交换*/
    int temp = arr[low];
    arr[low] = arr[j];
    arr[j] = temp;
    Qsort(arr, low, j - 1);
    Qsort(arr, j + 1, high);
}
```

**56. 求第k大的数的方法以及各自的复杂度是怎样的，另外追问一下，当有相同元素时，还可以使用什么不同的方法求第k大的元素**

* 方法1：先把数组排序，然后再取下标为K的对应数组元素。平均时间复杂度O(n*logn)
* 方法2：利用堆调整算法的性质，建立一个大小为K的堆，然后将整个数组元素添加到其中，利用其自动调整的性质，不断移除最小的元素，最后取堆顶的元素。总的时间复杂度为O(n*logK)
* 方法3：方法3：利用快速排序分治的思想，每次根据枢轴元素的对数组进行划分，并根据胡枢轴元素的位置和K的大小，决定向枢轴元素左侧或者右侧元素进行进一步划分。这样最坏时间复杂度为O(K\*N)。平均时间复杂度为O(K\*logK)。

**57. 各种排序算法及时间复杂度**

<img src="https://github.com/Peefy/IntroductionToAlgorithm.Python/tree/master/src/dugulib/sort.png"/>

**58. 海量数据如何去取最大的k个(10亿个数中找出最大的K个数 top K问题)**

先拿K个数建堆，然后一次添加剩余元素，如果大于堆顶的数（K中最小的），将这个数替换堆顶，并调整结构使之仍然是一个最小堆，这样，遍历完后，堆中的K个数就是所需的最大的K个。建堆时间复杂度是O（mlogm），算法的时间复杂度为O（nmlogm）（n为10亿，m为K）。

**59. Top(K)问题**

先拿K个数建堆，然后一次添加剩余元素，如果大于堆顶的数（K中最小的），将这个数替换堆顶，并调整结构使之仍然是一个最小堆，这样，遍历完后，堆中的K个数就是所需的最大的K个。建堆时间复杂度是O（mlogm），算法的时间复杂度为O（nmlogm）（n为10亿，m为K）。

**60. 快排的时间复杂度最差是多少？什么时候时间最差**

平均时间复杂度O(nlgn)，最差请去昂时间复杂度为 O(n^2)。
在最坏的情况下，待排序的序列为正序或者逆序。

**61. 稳定排序哪几种**

稳定排序：冒泡排序，插入排序，并归排序，计数排序，桶排序，基数排序

非稳定排序：选择排序，希尔排序，快速排序，堆排序

**62. 快排算法；以及什么是稳定性排序，快排是稳定性的吗；快排算法最差情况推导公式**

快排是非稳定排序算法那，快排最差情况为待排序序列已经升序或者降序排好序。

**63. hash表的实现，包括STL中的哈希桶长度常数。**

哈希表（Hash table，也叫散列表）， 是根据关键码值(Key value)而直接进行访问的数据结构。也就是说，它通过把关键码值映射到表中一个位置来访问记录，以加快查找的速度。这个映射函数叫做散列函数，存放记录的数组叫做散列表。

采用的是开放式寻址法，哈希桶为映射单元，桶内部用链表来维护。

开始确定一个素数，根据表的填装因子，然后表满了就以两倍的容量进行扩展，移动数据到新的表中。

**64. hash表如何rehash，以及怎么处理其中保存的资源**

两倍的容量进行扩展

移动数据到新的表中

**65. 哈希表的桶个数为什么是质数，合数有何不妥？**

在实际中往往关键字有某种规律，例如大量的等差数列，那么公差和模数不互质的时候发生碰撞的概率会变大，而用质数就可以很大程度上回避这个问题。基本可以保证c的每一位都参与H( c )的运算，从而在常见应用中减小冲突几率.

质数比合数更容易避免冲撞，也就是说使用质数时，哈希效果更好，原始数据经哈希后分布更均匀

**66. 解决hash冲突的方法**

* **开放定址法**-用开放定址法解决冲突的做法是：当冲突发生时，使用某种探查(亦称探测)技术在散列表中形成一个探查(测)序列。沿此序列逐个单元地查找，直到找到给定 的关键字，或者碰到一个开放的地址(即该地址单元为空)为止（若要插入，在探查到开放的地址，则可将待插入的新结点存人该地址单元）。查找时探查到开放的 地址则表明表中无待查的关键字，即查找失败。

*线性探查法(Linear Probing)*-将散列表T\[0..m-1\]看成是一个循环向量，若初始探查的地址为d(即h(key)=d)，则最长的探查序列为：

*线性补偿探测法*-线性补偿探测法的基本思想是：
将线性探测的步长从 1 改为 Q ，即将上述算法中的 j ＝ (j ＋ 1) % m 改为： j ＝ (j ＋ Q) % m ，而且要求 Q 与 m 是互质的，以便能探测到哈希表中的所有单元。

*随机探测*-随机探测的基本思想是：将线性探测的步长从常数改为随机数，即令： j ＝ (j ＋ RN) % m ，其中 RN 是一个随机数。在实际程序中应预先用随机数发生器产生一个随机序列，0将此序列作为依次探测的步长。

* **拉链法**-

拉链法解决冲突的做法是：将所有关键字为同义词的结点链接在同一个单链表中。若选定的散列表长度为m，则可将散列表定义为一个由m个头指针组成的指针数 组T\[0..m-1\]。凡是散列地址为i的结点，均插入到以T\[i\]为头指针的单链表中。T中各分量的初值均应为空指针。在拉链法中，装填因子α可以大于 1，但一般均取α≤1。如java的HashMap取初始装填因子为0.75

**67. 合并两个有序链表**

```java
public static Node CombineList(Node head1, Node head2){
    if(head1 == null || head2 == null){
        return head1 != null ? head1 : head2;
    }
    Node head = head1.value < head2.value ? head1 : head2;
    Node cur1 = head == head1 ? head1 : head2;
    Node cur2 = head == head1 ? head2 : head1;
    Node pre = null;
    Node next = null;
    while(cur1 != null && cur2 != null){
        if(cur1.value <= cur2.value){//这里一定要有=，否则一旦cur1的value和cur2的value相等的话，下面的pre.next会出现空指针异常
            pre = cur1;
            cur1 = cur1.next;
        }else{
            next = cur2.next;
            pre.next = cur2;
            cur2.next = cur1;
            pre = cur2;
            cur2 = next;
        }
    }
    pre.next = cur1 == null ? cur2 : cur1;    
    return head;
```

**68. 反转链表**

```java
public static Node reverseList(Node head){
    Node pre = null;
    Node next = null;
    while(head != null){
        next = head.next;
        head.next = pre;
        pre = head;
        head = next;
    }
    return pre;
}
```

**69. 链表是否为回文链表，说出你的思路并手写代码**

```c++
/**
 * Definition for singly-linked list.
 * struct ListNode {
 *     int val;
 *     ListNode *next;
 *     ListNode(int x) : val(x), next(NULL) {}
 * };
 */
class Solution {
public:
    bool isPalindrome(ListNode* head) 
    {
        ListNode *point1, *point2, *point3;
        point3 = point2 = head;
        point1 = NULL;
        long int sum = 0;
        int n = 1;
        if(head == NULL || head->next == NULL
            return true;
        while(point3->next != NULL)//第一次遍历，取值并逆置
        {
            sum += n*point3->val;
            n++;
            point3 = point3->next;
            point2->next = point1;
            point1 = point2;
            point2 = point3;
        }
        sum += n*point3->val;
        point2->next = point1;
        n = 1;
        while(point2 != NULL)//第二次遍历
        {
            sum -= n*point2->val;
            n++;
            point2 = point2->next;
        }
        if(sum == 0)
            return true;
        else
            return false;
    }
};
```

**70. 单向链表，如何判断两个单向链表是否相交**

```c++
bool check(const node* head)
{
    if(head==NULL) return false;
    node *low=head, *fast=head->next;
    while(fast!=NULL && fast->next!=NULL)
    {
        low=low->next;
        fast=fast->next->next;
        if(low==fast) return true;
    }
    return false;
}
```

**71. 加密方法都有哪些**

**密钥**-密钥是一种参数，它是在使用密码（cipher）算法过程中输入的参数。同一个明文在相同的密码算法和不同的密钥计算下会产生不同的密文。很多知名的密码算法都是公开的，密钥才是决定密文是否安全的重要参数，通常密钥越长，破解的难度越大，比如一个8位的密钥最多有256种情况，使用穷举法，能非常轻易的破解，知名的DES算法使用56位的密钥，目前已经不是一种安全的加密算法了，主要还是因为56位的密钥太短，在数小时内就可以被破解。密钥分为对称密钥与非对称密钥。

**明文/密文**-明文（plaintext）是加密之前的原始数据，密文是通过密码（cipher）运算后得到的结果成为密文（ciphertext）

**对称密钥**-对称密钥（Symmetric-key algorithm）又称为共享密钥加密，对称密钥在加密和解密的过程中使用的密钥是相同的，常见的对称加密算法有DES、3DES、AES、RC5、RC6。对称密钥的优点是计算速度快，但是他也有缺点，密钥需要在通讯的两端共享，让彼此知道密钥是什么对方才能正确解密，如果所有客户端都共享同一个密钥，那么这个密钥就像万能钥匙一样，可以凭借一个密钥破解所有人的密文了，如果每个客户端与服务端单独维护一个密钥，那么服务端需要管理的密钥将是成千上万，这会给服务端带来噩梦。下面就是一个简单的对称加密，将明文加密成ASCII。

**非对称密钥**-非对称密钥（public-key cryptography），又称为公开密钥加密，服务端会生成一对密钥，一个私钥保存在服务端，仅自己知道，另一个是公钥，公钥可以自由发布供任何人使用。客户端的明文通过公钥加密后的密文需要用私钥解密。非对称密钥在加密和解密的过程的使用的密钥是不同的密钥，加密和解密是不对称的，所以称之为非对称加密。与对称密钥加密相比，非对称加密无需在客户端和服务端之间共享密钥，只要私钥不发给任何用户，即使公钥在网上被截获，也无法被解密，仅有被窃取的公钥是没有任何用处的。常见的非对称加密有RSA，非对称加解密的过程： 
服务端生成配对的公钥和私钥 
私钥保存在服务端，公钥发送给客户端 
客户端使用公钥加密明文传输给服务端 
服务端使用私钥解密密文得到明文 

**数字密钥**-数据在浏览器和服务器之间传输时，有可能在传输过程中被冒充的盗贼把内容替换了，那么如何保证数据是真实服务器发送的而不被调包呢，同时如何保证传输的数据没有被人篡改呢，要解决这两个问题就必须用到数字签名，数字签名就如同日常生活的中的签名一样，一旦在合同书上落下了你的大名，从法律意义上就确定是你本人签的字儿，这是任何人都没法仿造的，因为这是你专有的手迹，任何人是造不出来的。那么在计算机中的数字签名怎么回事呢？数字签名就是用于验证传输的内容是不是真实服务器发送的数据，发送的数据有没有被篡改过，它就干这两件事，是非对称加密的一种应用场景。不过他是反过来用私钥来加密，通过与之配对的公钥来解密。 
第一步：服务端把报文经过Hash处理后生成摘要信息Digest，摘要信息使用私钥private-key加密之后就生成签名，服务器把签名连同报文一起发送给客户端。

常见的对称加密算法：DES、3DES、DESX、Blowfish、IDEA、RC4、RC5、RC6和AES

常见的Hash算法：MD2、MD4、MD5、HAVAL、SHA、SHA-1、HMAC、HMAC-MD5、HMAC-SHA1

DES（Data Encryption Standard）：数据加密标准，速度较快，适用于加密大量数据的场合。

3DES（Triple DES）：是基于DES，对一块数据用三个不同的密钥进行三次加密，强度更高。

AES（Advanced Encryption Standard）：高级加密标准，是下一代的加密算法标准，速度快，安全级别高；

RSA：由 RSA 公司发明，是一个支持变长密钥的公共密钥算法，需要加密的文件块的长度也是可变的；

DSA（Digital Signature Algorithm）：数字签名算法，是一种标准的 DSS（数字签名标准）；

ECC（Elliptic Curves Cryptography）：椭圆曲线密码编码学。

**72. LRU缓存**

内存管理的一种页面置换算法，对于在内存中但又不用的数据块（内存块）叫做LRU，操作系统会根据哪些数据属于LRU而将其移出内存而腾出空间来加载另外的数据。

关于`操作系统的内存管理`，如何节省利用容量不大的内存为最多的`进程`提供资源，一直是研究的重要方向。而内存的虚拟存储管理，是现在最通用，最成功的方式—— 在内存有限的情况下，**扩展一部分外存作为虚拟内存**，真正的内存只存储当前运行时所用得到信息。

<img src="https://github.com/Peefy/PeefyCSNotes/tree/master/src/LRU.jpg" />

> 可以基于 哈希表HashMap 和 双向链表实现 LRU 

可以使用 HashMap 存储 key，这样可以做到 save 和 get key的时间都是 O(1)，而 HashMap 的 Value 指向双向链表实现的 LRU 的 Node 节点，如图所示。LRU 存储是基于双向链表实现的，其中 head 代表双向链表的表头，tail 代表尾部。首先预先设置 LRU 的容量，如果存储满了，可以通过 O(1) 的时间淘汰掉双向链表的尾部，每次新增和访问数据，都可以通过 O(1)的效率把新的节点增加到对头，或者把已经存在的节点移动到队头。

```c++
#include <iostream>
#include <hash_map>
#include <list>
#include <utility>
using namespace std;
using namespace stdext;

class LRUCache{
public:
    LRUCache(int capacity) {
        m_capacity = capacity ;
    }
    int get(int key) {
        int retValue = -1 ;
        hash_map<int, list<pair<int, int> > :: iterator> ::iterator it = cachesMap.find(key) ;
        //如果在Cashe中，将记录移动到链表的最前端
        if (it != cachesMap.end())
        {
            retValue = it ->second->second ;
            //移动到最前端
            list<pair<int, int> > :: iterator ptrPair = it -> second ;
            pair<int, int> tmpPair = *ptrPair ;
            caches.erase(ptrPair) ;
            caches.push_front(tmpPair) ;
            //修改map中的值
            cachesMap[key] = caches.begin() ;
        }
        return retValue ;
    }
    void set(int key, int value) {
        hash_map<int, list<pair<int, int> > :: iterator> ::iterator it = cachesMap.find(key) ;
        if (it != cachesMap.end()) //已经存在其中
        {
            list<pair<int, int> > :: iterator ptrPait = it ->second ;
            ptrPait->second = value ;
            //移动到最前面
            pair<int , int > tmpPair = *ptrPait ;
            caches.erase(ptrPait) ;
            caches.push_front(tmpPair) ;
            //更新map
            cachesMap[key] = caches.begin() ;
        }
        else //不存在其中
        {
            pair<int , int > tmpPair = make_pair(key, value) ;


            if (m_capacity == caches.size()) //已经满
            {
                int delKey = caches.back().first ;
                caches.pop_back() ; //删除最后一个


                //删除在map中的相应项
                hash_map<int, list<pair<int, int> > :: iterator> ::iterator delIt = cachesMap.find(delKey) ;
                cachesMap.erase(delIt) ;
            }


            caches.push_front(tmpPair) ;
            cachesMap[key] = caches.begin() ; //更新map
        }
    }

private:
    int m_capacity ;                                               //cashe的大小
    list<pair<int, int> > caches ;                                 //用一个双链表存储cashe的内容
    hash_map< int, list<pair<int, int> > :: iterator> cachesMap ;  //使用map加快查找的速度
};
```

**73. 洗牌算法**

* **Fisher-Yates Shuffle算法**-基本思想就是从原始数组中随机取一个之前没取过的数字到新的数组中
```c++
#define N 10
#define M 5
void Fisher_Yates_Shuffle(vector<int>& arr,vector<int>& res)
{
     srand((unsigned)time(NULL));
     int k;
     for (int i=0;i<M;++i)
     {
     	k=rand()%arr.size();
     	res.push_back(arr[k]);
     	arr.erase(arr.begin()+k);
     }
}
```
* **Knuth-Durstenfeld Shuffle算法**-在原始数组上对数字进行交互，省去了额外O(n)的空间。该算法的基本思想和 Fisher 类似，每次从未处理的数据中随机取出一个数字，然后把该数字放在数组的尾部，即数组尾部存放的是已经处理过的数字。
```c++
void Knuth_Durstenfeld_Shuffle(vector<int>&arr)
{
	for (int i=arr.size()-1;i>=0;--i)
	{
		srand((unsigned)time(NULL));
		swap(arr[rand()%(i+1)],arr[i]);
	}
}
```
* **Inside-Out Algorithm**-基本思思是从前向后扫描数据，把位置i的数据随机插入到前i个（包括第i个）位置中（假设为k），这个操作是在新数组中进行，然后把原始数据中位置k的数字替换新数组位置i的数字。其实效果相当于新数组中位置k和位置i的数字进行交互。
```c++
void Inside_Out_Shuffle(const vector<int>&arr,vector<int>& res)
{
	res.assign(arr.size(),0);
	copy(arr.begin(),arr.end(),res.begin());
	int k;
	for (int i=0;i<arr.size();++i)
	{
		srand((unsigned)time(NULL));
		k=rand()%(i+1);
		res[i]=res[k];
		res[k]=arr[i];
	}
}
```

**74. 单链表如何判断有环**

算法的思想是设定两个指针p, q，其中p每次向前移动一步，q每次向前移动两步。那么如果单链表存在环，则p和q相遇；否则q将首先遇到null。 

(p和q同时在操场跑步，其中q的速度是p的两倍，当他们两个同时出发时，p跑一圈到达起点，而q此时也刚 好跑完两圈到达起点。) 

**75. 哈希表——线性探测法、链地址法、查找成功、查找不成功的平均长度**

*概念：*-哈希表(Hash Table)也叫散列表，是根据关键码值（Key Value）而直接进行访问的数据结构。它通过把关键码值映射到哈希表中的一个位置来访问记录，以加快查找的速度。这个映射函数就做散列函数，存放记录的数组叫做散列表。

*散列存储的基本思路*-以数据中每个元素的关键字K为自变量，通过散列函数H（k）计算出函数值，以该函数值作为一块连续存储空间的的单元地址，将该元素存储到函数值对应的单元中。

*哈希表查找的时间复杂度*-哈希表存储的是键值对，其查找的时间复杂度与元素数量多少无关，哈希表在查找元素时是通过计算哈希码值来定位元素的位置从而直接访问元素的，因此，哈希表查找的时间复杂度为O（1）。

**常用的哈希函数**

* **直接寻址法**-取关键字或者关键字的某个线性函数值作为哈希地址,即H(Key)=Key或者H(Key)=a*Key+b(a,b为整数),这种散列函数也叫做自身函数.如果H(Key)的哈希地址上已经有值了,那么就往下一个位置找,知道找到H(Key)的位置没有值了就把元素放进去.
* **数字分析法**-分析一组数据,比如一组员工的出生年月,这时我们发现出生年月的前几位数字一般都相同,因此,出现冲突的概率就会很大,但是我们发现年月日的后几位表示月份和具体日期的数字差别很大,如果利用后面的几位数字来构造散列地址,则冲突的几率则会明显降低.因此数字分析法就是找出数字的规律,尽可能利用这些数据来构造冲突几率较低的散列地址.
* **平方取中法**-取关键字平方后的中间几位作为散列地址.一个数的平方值的中间几位和数的每一位都有关。因此，有平方取中法得到的哈希地址同关键字的每一位都有关，是的哈希地址具有较好的分散性。该方法适用于关键字中的每一位取值都不够分散或者较分散的位数小于哈希地址所需要的位数的情况。
* **折叠法**-折叠法即将关键字分割成位数相同的几部分,最后一部分位数可以不同,然后取这几部分的叠加和(注意:叠加和时去除进位)作为散列地址.数位叠加可以有移位叠加和间界叠加两种方法.移位叠加是将分割后的每一部分的最低位对齐,然后相加;间界叠加是从一端向另一端沿分割界来回折叠,然后对齐相加.
* **随机数法**-选择一个随机数,去关键字的随机值作为散列地址,通常用于关键字长度不同的场合.
* **除留余数法**-取关键字被某个不大于散列表表长m的数p除后所得的余数为散列地址.即H(Key)=Key MOD p,p<=m.不仅可以对关键字直接取模,也可在折叠、平方取中等运算之后取模。对p的选择很重要，一般取素数或m，若p选得不好，则很容易产生冲突。一般p取值为表的长度tableSize。

**哈希冲突的处理方法**

* **开放定址法——线性探测**-线性探测法的地址增量di = 1, 2, ... , m-1，其中，i为探测次数。该方法一次探测下一个地址，知道有空的地址后插入，若整个空间都找不到空余的地址，则产生溢出。线性探测容易产生“聚集”现象。
* **开放地址法——二次探测**-二次探测法的地址增量序列为 di = 1^2， -1^2， 2^2， -2^2，… ， q^2, -q^2 (q <= m/2)。二次探测能有效避免“聚集”现象，但是不能够探测到哈希表上所有的存储单元
* **链地址法**-链地址法也成为拉链法。其基本思路是：将所有具有相同哈希地址的而不同关键字的数据元素连接到同一个单链表中。如果选定的哈希表长度为m，则可将哈希表定义为一个有m个头指针组成的指针数组T\[0..m-1\]，

**哈希表的装填因子**-装填因子 = （哈希表中的记录数） /  （哈希表的长度）
装填因子是哈希表装满程度的标记因子。值越大，填入表中的数据元素越多，产生冲突的可能性越大。

**不同处理冲突的平均查找长度**

处理冲突方法|查找成功时|查找不成功时
-|-|-
线性探测法| 0.5(1 + 1/(1-a) ) | 0.5(1 + 1/(1-a)^2 )
二次探测法与双哈希法| -1/aln(1-a) | 1/(1-a)
链地址法| 1 + a/2 | a + exp(-a)

例子：假设散列表的长度是13，三列函数为H(K) = k % 13，给定的关键字序列为{32， 14， 23， 01， 42， 20， 45， 27， 55， 24， 10， 53}。分别画出用线性探测法和拉链法解决冲突时构造的哈希表，并求出在等概率情况下，这两种方法的查找成功和查找不成功的平均查找长度。

* **线性探测法**
查找成功时的查找次数等于插入元素时的比较次数,查找成功的平均查找长度为：
ASL = （1+2+1+4+3+1+1+3+9+1+1+3)/12 = 2.5

查找成功时的查找次数：第n个位置不成功时的比较次数为，第n个位置到第1个没有数据位置的距离：如第0个位置取值为1，第1个位置取值为2.

查找不成功的平均查找次数为：

ASL = （1+2+3+4+5+6+7+8+9+10+11+12）/ 13 = 91/13

* **链地址法**

查找成功时的平均查找长度：

ASL = (1\*6+2\*4+3\*1+4\*1)/12 = 7/4

查找不成功时的平均查找长度：

ASL = (4+2+2+1+2+1)/13

注意：查找成功时，分母为哈希表元素个数，查找不成功时，分母为哈希表长度。

**76. KMP字符串匹配算法**

KMP算法的主体是，在失去匹配时，查询最后一个匹配字符所对应的“部分匹配表“中的值，然后向前移动，移动位数为：

```java
private int[] getNext(String pattern) {
    char[] p = pattern.toCharArray();
    int[] next = new int[p.length];
    // 第一位设为-1，方便判断当前位置是否为搜索词的最开始
    next[0] = -1;
    int i = 0;
    int j = -1;

    while(i < p.length - 1) {
        if (j == -1 || p[i] == p[j]) {
            i++;
            j++;
            next[i] = j;
        } else {
            j = next[j];
        }
    }

    return next;
}

public int KMP(String t, String p) {
    char[] target = t.toCharArray();
    char[] pattern = p.toCharArray();
    // 目标字符串下标
    int i = 0;
    // 搜索词下标
    int j = 0;
    // 整体右移一位的部分匹配表
    int[] next = getNext(pattern);

    while (i < target.length && j < patter.length) {
        // j == -1 表示从搜索词最开始进行匹配
        if (j == -1 || target[i] == pattern[j]) {
            i++;
            j++;
        // 匹配失败时，查询“部分匹配表”，得到搜索词位置j以前的最大共同前后缀长度
        // 将j移动到最大共同前后缀长度的后一位，然后再继续进行匹配
        } else {
            j = next[j];
        }
    }

    // 搜索词每一位都能匹配成功，返回匹配的的起始位置
    if (j == pattern.length)
        return i - j;
    else
        return -1;
}
```

**77. **

**78. **

**79. **

**80. **

**81. **

**82. **

**83. **

**84. **

**85. **

**86. **

**87. **

**88. **

**89. **

**90. **

**91. **

**92. **

**93. **

**94. **

**95. **

**96. **

**97. **

**98. **

**99. **

**100. **

**101. **

**102. **

**103. **

**104. **

**105. **

**106. **

**107. **

**108. **

**109. **

**110. **

**111. **

**112. **

**113. **

**114. **

**115. **

**116. **

**117. **

**118. **

**119. **

**120. **

**121. **

**122. **

**123. **

**124. **

**125. **

**126. **

**127. **

**128. **

**129. **

**130. **

**131. **

**132. **

**133. **

**134. **

**135. **

**136. **

**137. **

**138. **

**139. **

**140. **

**141. **

**142. **

**143. **

**144. **

**145. **

**146. **

**147. **

**148. **

**149. **

**150. **

**151. **

**152. **

**153. **

**154. **

**155. **

**156. **

**157. **

**158. **

**159. **

**160. **

**161. **

**162. **

**163. **

**164. **

**165. **

**166. **

**167. **

**168. **

**169. **

**170. **

**171. **

**172. **

**173. **

**174. **

**175. **

**176. **

**177. **

**178. **

**179. **

**180. **

**181. **

**182. **

**183. **

**184. **

**185. **

**186. **

**187. **

**188. **

**189. **

**190. **

**191. **

**192. **

**193. **

**194. **

**195. **

**196. **

**197. **

**198. **

**199. **


