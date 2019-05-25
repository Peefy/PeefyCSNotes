
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

**38. 哈夫曼编码**

**39. map底层为什么用红黑树实现**

**40. B+树**

**41. map和unordered_map的底层实现**

**42. map和unordered_map优点和缺点**

**43. epoll怎么实现的**

**44. C++两种map**

**45. 红黑树的性质还有左右旋转**

**46. 红黑树的原理以及erase以后迭代器的具体分布情况？**

**47. 二叉树的层序遍历并输出**

bfs + 链表

**48. 二叉树序列化反序列化**

**49. stack overflow，并举个简单例子导致栈溢出**

**50. 栈和堆的区别，以及为什么栈要快**

**51. 两个栈实现一个队列**

**52. 小根堆特点**

**53. Array&List数组和链表的区别**

**54. 一个长度为N的整形数组，数组中每个元素的取值范围是\[0,n-1\],判断该数组否有重复的数，请说一下你的思路并手写代码**

**55. 手写一下快排的代码**

**56. 求第k大的数的方法以及各自的复杂度是怎样的，另外追问一下，当有相同元素时，还可以使用什么不同的方法求第k大的元素**

**57. 各种排序算法及时间复杂度**

**58. 海量数据如何去取最大的k个**

**59. Top(K)问题**

**60. 快排的时间复杂度最差是多少？什么时候时间最差**

O(nlgn) O(n^2)

**61. 稳定排序哪几种**

**62. 快排算法；以及什么是稳定性排序，快排是稳定性的吗；快排算法最差情况推导公式**

**63. hash表的实现，包括STL中的哈希桶长度常数。**

**64. hash表如何rehash，以及怎么处理其中保存的资源**

**65. 哈希表的桶个数为什么是质数，合数有何不妥？**

**66. 解决hash冲突的方法**

**67. 合并两个有序链表**

**68. 反转链表**

**69. 链表是否为回文链表，说出你的思路并手写代码**

**70. 单向链表，如何判断两个单向链表是否相交**

**71. 加密方法都有哪些**

**72. LRU缓存**

**73. 洗牌算法**

**74. **

**75. **

**76. **

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


