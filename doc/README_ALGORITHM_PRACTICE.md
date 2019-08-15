
**1. 给定三角形ABC和一点P(x,y,z)，判断点P是否在ABC内**

最常用的两种方法：面积法、向量同向法。

```c++
template<typename T> class Vec2 {
 T x, y;
public:
 typedef T value_type;
 Vec2(T xx = 0, T yy = 0) : x(xx), y(yy) {};
 T cross(const Vec2& v) const { return x * v.y - y * v.x;} // 矢量积
 Vec2 operator-(const Vec2& v) const { return Vec2(x - v.x, y - v.y); }
};

typedef Vec2<double> Vd2;

bool is_in_triangle(const Vd2& a, const Vd2& b, const Vd2& c, const Vd2& p)
{
Vd2 ab(b -a), ac(c - a), ap(p - a);
//用矢量积计算面积，下面4个值的绝对值，是对应的三角形的面积的两倍，
double abc = ab.cross(ac);
double abp = ab.cross(ap);
double apc = ap.cross(ac);
double pbc = abc - abp - apc;   //等于pb.cross(pc)
//面积法：4个三角形的面积差 等于 0
double delta = fabs(abc) - fabs(abp) - fabs(apc) - fabs(pbc);
return fabs(delta) < DBL_EPSILON;        
}
```

**2. 怎么判断一个数是二的倍数，怎么求一个数中有几个1**

```c++
int mian()
{
    int num = 119;
    /*判断是否是二的倍数*/
    if (num & 0b1)
    {
        cout<<"odd"<<endl;
    }
    else
    {
        cout<<"even"<<endl;
    }
 
    /*10进制1的个数*/
    int m10 = num, sum10 = 0;
    while (m10)
    {
        if (m10 % 10 == 1)
            sum10++;
        m10 /= 10;
    }
    cout<<sum10<<endl;
 
    /*2进制1的个数*/
    int m2 = num, sum2 = 0;
    while (m2)
    {
         sum2++;
         m2 = m2 & (m2-1);
    }  cout<<sum10<<endl;
    return 0;
}
```

**3. n个整数的无序数组，找到每个元素后面比它大的第一个数，要求时间复杂度为O(N)**

```java
public int[] findMaxRightWithStack(int[] array) {
        if(array == null) {
            return array;
        }
        int size = array.length;
        int[] result = new int[size];
        Stack<Integer> stack = new Stack<>();
        stack.push(0);
        int index = 1;
        while(index < size) {
            if(!stack.isEmpty() && array[index] > array[stack.peek()]) {
                result[stack.pop()] = array[index];
            } else {
                stack.push(index);
                index++;
            }
        }
        if(!stack.isEmpty()) {
            result[stack.pop()] = -1;
        }
        return result;
    }
```

**4. 动态规划DP:最长公共子序列**

最长公共子序列模板：

```c++
#include<cstdio>
#include<cstring>
#include<algorithm>
using namespace std;
const int N = 1000;
char a[N],b[N];
int dp[N][N];
int main()
{
    int lena,lenb,i,j;
    while(scanf("%s%s",a,b)!=EOF)
    {
        memset(dp,0,sizeof(dp));
        lena=strlen(a);
        lenb=strlen(b);
        for(i=1;i<=lena;i++)
        {
            for(j=1;j<=lenb;j++)
            {
                if(a[i-1]==b[j-1])
                {
                    dp[i][j]=dp[i-1][j-1]+1;
                }
                else
                {
                    dp[i][j]=max(dp[i-1][j],dp[i][j-1]);
                }
            }
        }
        printf("%d\n",dp[lena][lenb]);
    }
    return 0;
}
```

最长公共子序列打印路径的模板:递归方法

```c++
#include<cstdio>
#include<cstring>
#include<algorithm>
using namespace std;
const int N = 1010;
char a[N],b[N];
int dp[N][N];
int flag[N][N];
void Print(int i,int j)
{
    if(i==0||j==0)///递归终止条件
    {
        return ;
    }
    if(!flag[i][j])
    {
        Print(i-1,j-1);
        printf("%c",a[i-1]);
    }
    else if(flag[i][j]==1)
    {
        Print(i-1,j);
    }
    else if(flag[i][j]=-1)
    {
        Print(i,j-1);
    }
}
int main()
{
    int lena,lenb,i,j;
    while(scanf("%s%s",a,b)!=EOF)
    {
        memset(dp,0,sizeof(dp));
        memset(flag,0,sizeof(flag));
        lena=strlen(a);
        lenb=strlen(b);
        for(i=1;i<=lena;i++)
        {
            for(j=1;j<=lenb;j++)
            {
                if(a[i-1]==b[j-1])
                {
                    dp[i][j]=dp[i-1][j-1]+1;
                    flag[i][j]=0;///来自于左上方
                }
                else
                {
                    if(dp[i-1][j]>dp[i][j-1])
                    {
                        dp[i][j]=dp[i-1][j];
                        flag[i][j]=1;///来自于左方
                    }
                    else
                    {
                        dp[i][j]=dp[i][j-1];
                        flag[i][j]=-1;///来自于上方
                    }
                }
            }
        }
        Print(lena,lenb);
    }
    return 0;
}
```

最长公共子序列打印路径的模板:非递归方法

```c++
#include<stdio.h>
#include<string.h>
#include<stack>
#include<algorithm>
using namespace std;
#define N 1010
int dp[N][N];
char c;
int main()
{
    char a[N];
    char b[N];
    scanf("%s%s",a,b);
    int la=strlen(a);
    int lb=strlen(b);
    memset(dp,0,sizeof(dp));
    for(int i=1; i<=la; i++)
    {
        for(int j=1; j<=lb; j++)
        {
            if(a[i-1]==b[j-1])
                dp[i][j]=dp[i-1][j-1]+1;
            else
                dp[i][j]=max(dp[i-1][j],dp[i][j-1]);
        }
    }
    int i=la,j=lb;
    stack<char>s;
    while(dp[i][j])
    {
        if(dp[i][j]==dp[i-1][j])///来自于左方向
        {
            i--;
        }
        else if(dp[i][j]==dp[i][j-1])///来自于上方向
        {
            j--;
        }
        else if(dp[i][j]>dp[i-1][j-1])///来自于左上方向
        {
            i--;
            j--;
            s.push(a[i]);
        }
    }
    while(!s.empty())
    {
        c=s.top();
        printf("%c",c);
        s.pop();
    }
    return 0;
}
```

**5. 动态规划DP:人民币组合**

给定一个数值sum，假设我们有m种不同类型的硬币{V1, V2, ..., Vm}，如果要组合成sum，求所有可能的组合数。

dp\[i\]\[sum\] = ∑dp\[i - 1\]\[sum - k * Vm\]

```java
import java.util.Scanner;
 
/**
 * @author Administrator
 *
 */
public class CoinCounts {
 
	/**
	 * @param args
	 */
	public static void main(String[] args) {
		Scanner in = new Scanner(System.in);
		while (in.hasNext()) {
			int num = in.nextInt();
			System.out.println(coin_counts(num));
		}
		in.close();
	}
 
	public static int coin_counts(int n) {
		int[] coins = { 1, 5, 10, 20, 50, 100, 200 };
		int[] dp = new int[100001];
		dp[0] = 1;
		for (int i = 0; i < 7; ++i) {
			for (int j = coins[i]; j <= n; ++j) {
				dp[j] = dp[j] + dp[j - coins[i]];
			}
		}
		return dp[n];
	}
}
```

**6. 求A同学比B同学牌总和大的概率**

```c++
#include <iostream>
#include <list>
#include <map>
#include <vector>
#include <stdio.h>

int main()
{
    // A已经拿到的3张牌
    int a1, b1, c1;
    // B已经拿到的3张牌
    int a2, b2, c2;
    // A获胜的次数
    double success = 0;
    // A失败的次数
    double lose = 0;
    // 整幅扑克牌
    map<int, int> poker;
    // 拿走6张剩下的扑克牌
    vector<int, int> pokerlist;
    // 一副扑克牌包括 52张 (除去大小王)
    for(int i = 1;i <= 13;++i)
        poker[i] = 4;
    cin >> a1 >> b1 >> c1;
    cin >> a2 >> b2 >> c2;
    int sub = (a1 + b1 + c1) - (a2 + b2 + c2);
    poker[a1]--;poker[b1]--;poker[c1]--;
    poker[a2]--;poker[b2]--;poker[c2]--;
    // 剩下46张扑克牌
    for(int i = 1;i <= 13;++i){
        for(int j = 0;j < poker[i];++j)
            pokerlist.push_back(i);
    }
    // 剩下的牌一共有46 * 45种拿法
    for(int i = 0;i < 46;++i){
        for(int j = 0;j <46;++j){
            if (i == j)
                continue;
            if (pokerlist[i] - pokerlist[j] + sub > 0)
                success = success + 1;
            else
                lose = lose + 1;
        }
    }
    // 输出概率
    printf("%.4f", success / (success + lose));
    return -1;
}

```

**7.在矩阵内星星个数**

```c++
#include <iostream>
#include <list>
#include <map>
#include <stdio.h>

int main()
{
    int n, m;
    int x, y;
    int a1, b1, a2, b2;
    map<int, int> h;
    list<int> ans;
    cin >> n;
    for(int i = 0;i < n;++i){
        cin >> x >> y
        // 用表格存储星星的位置
        h[x + y * 1001] = 1;
    }
    cin >> m;
    for(int i = 0;i < m;++m){
        cin >> a1 >> b1 >> a2 >> b2;
        int count = 0;
        // 只在矩形框内所有的点判断
        for(int j = a1;j <= a2;++j){
            for(int k = b1;k <= b2;++k)
                count += h[j + k * 1001] == 1;
                ans.push_back(count);
        }
    }
    for (auto i = ans.begin();i != ans.end();++i){
        cout << (*i) << endl;
    }
    return -1;
}

```

**8. 查找最长回文子串Longest Palindromic Substring**

* **暴力求解**-

```java
 public static String longestPalindrome(String s) {
    if(s.length() <= 1)
        return s;
    for(int i = s.length();i > 0; i--) {//子串长度
        for (int j = 0; j <= s.length() - i; j++) {
            String sub = s.substring(j , i + j);//子串位置
            int count = 0;//计数，用来判断是否对称
            for (int k = 0; k < sub.length() / 2; k++) {//左右对称判断
                if (sub.charAt(k) == sub.charAt(sub.length() - k - 1))
                    count++;
            }
            if (count == sub.length() / 2)
                return sub;
        }
    }
    return "";//表示字符串中无回文子串
}
```

* **O(n^2)时间复杂度方法——从中心向外扩散**-

```java
private static int maxLen = 0;

private static String sub = "";

public static String longestPalindrome(String s) {
        if(s.length() <= 1)
            return s;

        for(int i = 0;i < s.length()-1;i++){

            findLongestPalindrome(s,i,i);//单核回文

            findLongestPalindrome(s,i,i+1);//双核回文
        }
        return sub;
    }
    public static  void findLongestPalindrome(String s,int low,int high){
        while (low >= 0 && high <= s.length()-1){
            if(s.charAt(low) == s.charAt(high)){
                if(high - low + 1 > maxLen){
                    maxLen = high - low + 1;
                    sub = s.substring(low , high+1);
                }
                low --;//向两边扩散找当前字符为中心的最大回文子串
                high ++;
            }
            else
                break;
        }
    }
```

* **O(n)时间复杂度方法——Manacher算法**-

将原字符串S的每个字符间都插入一个永远不会在S中出现的字符（比如“#”），在S的首尾也插入该字符，使得到的新字符串S_new长度为2*S.length()+1，保证Len的长度为奇数

```java
public String longestPalindrome(String s) {
        List<Character> s_new = new ArrayList<>();
        for(int i = 0;i < s.length();i++){
            s_new.add('#');
            s_new.add(s.charAt(i));
        }
        s_new.add('#');
        List<Integer> Len = new ArrayList<>();
        String sub = "";//最长回文子串
        int sub_midd = 0;//表示在i之前所得到的Len数组中的最大值所在位置
        int sub_side = 0;//表示以sub_midd为中心的最长回文子串的最右端在S_new中的位置
        Len.add(1);
        for(int i = 1;i < s_new.size();i++){
            if(i < sub_side) {//i < sub_side时，在Len[j]和sub_side - i中取最小值，省去了j的判断
                int j = 2 * sub_midd - i;
                if(j >= 2 * sub_midd - sub_side &&  Len.get(j) <= sub_side - i){
                    Len.add(Len.get(j));
                }
                else
                    Len.add(sub_side - i + 1);
            }
            else//i >= sub_side时，从头开始匹配
                Len.add(1);
            while( (i - Len.get(i) >= 0 && i + Len.get(i) < s_new.size()) && (s_new.get(i - Len.get(i)) == s_new.get(i + Len.get(i))))
                Len.set(i,Len.get(i) + 1);//s_new[i]两端开始扩展匹配，直到匹配失败时停止
            if(Len.get(i) >= Len.get(sub_midd)){//匹配的新回文子串长度大于原有的长度
                sub_side = Len.get(i) + i - 1;
                sub_midd = i;
            }
        }
        sub = s.substring((2*sub_midd - sub_side)/2,sub_side /2);//在s中找到最长回文子串的位置
        return sub;
    }
```

**9. n个人的座位随机打乱，有k个人正好坐在自己原来位置的概率为**

C(n, k)∑i~(n-k)(C(n,k)\*(-1)^i\*i!)/ A(n,k)

**10. 网格走法数目**

有一个X*Y的网格，小团要在此网格上从左上角到右下角，只能走格点且只能向右或向下走。请设计一个算法，计算小团有多少种走法。给定两个正整数int x,int y，请返回小团的走法数目。

如 输入3 2, 输出10

*解法1：递归*

```c++
#include<iostream>
using namespace std;
int step(int m,int n){
    if(m == 0 || n == 0)
        return 1;
    return step(m - 1,n) + step(m,n -1);
}
int main(){
    int x,y;
    cin >> x >> y;
    cout << step(x,y) <<endl;
}
```

*解法2：循环*

```c++
#include<iostream>
#include<vector>
using namespace std;
 
int main()
{
    int x, y;
    cin >> x >> y;
    int dp[11][11];
    for (int j = 0; j <= y; j++)
        dp[0][j] = 1;
    for (int i = 0; i <= x; i++)
        dp[i][0] = 1;
    for (int i = 1; i <= x; i++)
    {
        for (int j = 1; j <= y; j++)
          {
             dp[i][j] = dp[i - 1][j] + dp[i][j-1];
          }
    }
    cout << dp[x][y] << endl;
}
```

**11. 有n个带编号的人和n个带编号的座位，求每个人都不坐在相同号码座位的方案数目**

动态规划的思想，利用表格或者RLU缓存存储数据，避免重复计算

f(1) = 0
f(2) = 1
f(i) = (i-1) * ( f(i-1) + f(i-2) )

**12. 二叉树的中序遍历（Stack类型的写法）**

```c++
class Solution {
public:
    vector<int> inorderTraversal(TreeNode* root) {
        auto cur = root;
        vector<int> res;
        stack<TreeNode*> stk;
        while(cur||!stk.empty()){
            if(cur){
                stk.push(cur);
                cur = cur->left;
            }else{
                cur = stk.top();
                stk.pop();
                res.push_back(cur->val);
                cur = cur->right;
            }
        }
        return res;
    }
};
```

**13. 一个无序数组求第K大数**

```c++
class Solution_1 {
  public:
    int partion(vector<int> &nums, int left, int right) {
        int pivot = nums[right], i = left;
        while (left < right) {
            if (nums[left] < pivot) {
                swap(nums[left], nums[i]);
                i++;
            }
            left++;
        }
        swap(nums[i], nums[right]);
        return i;
    }
    int partion2(vector<int> &nums, int left, int right) {//第二种partion的写法
        int i = left, j = right + 1;
        int pivot = nums[left];
        while (i < j) {
            while (i < right && nums[++i] < pivot);
            while (j > left && nums[--j] > pivot);
            if (i >= j) {
                break;
            }
            swap(nums[i], nums[j]);
        }
        swap(nums[left], nums[j]);
        return j;
    }
    int findKthLargest(vector<int> &nums, int k) {
        int m = nums.size();
        k = m - k;
        return helper(nums, 0, m - 1, k);
    }
    int helper(vector<int> &nums, int left, int right, int k) {
        int pos = partion(nums, left, right);
        if (pos == k) {
            return nums[pos];
        }
        if (pos < k) {
            return helper(nums, pos + 1, right, k);
        }
        return helper(nums, left, pos - 1, k);
    }
};
```

**14. 插入排序链表**

```c++
// 链表排序 leetcode147
struct ListNode {
    int val;
    ListNode *next;
    ListNode(int x) : val(x), next(NULL) {}
};

class Solution {
  public:
    ListNode *insertionSortList(ListNode *head) {
        ListNode result(0);
        ListNode *cur = head, *pre = &result;
        while (cur) {
            ListNode *temp = cur->next;
            pre = &result;
            ListNode *inp = pre->next;
            while (inp && inp->val < cur->val) {
                inp = inp->next;
                pre = pre->next;
            }
            cur->next = inp;
            pre->next = cur;
            cur = temp;
        }
        return result.next;
    }
};
```

**15. 归并排序链表**

```c++
// lc148 链表排序
class Solution_0 {
  public:
    ListNode *sortList(ListNode *head) {
        if (head == NULL || head->next == NULL) {
            return head;
        }
        ListNode *walker = head, *runner = head->next;
        while (runner && runner->next) {
            walker = walker->next;
            runner = runner->next->next;
        }
        ListNode *head_2 = sortList(walker->next);
        walker->next = NULL;
        ListNode *head_1 = sortList(head);
        return mergerList(head_1, head_2);
    }
    ListNode *mergerList(ListNode *head_1, ListNode *head_2) {
        if (head_1 == NULL) {
            return head_2;
        }
        if (head_2 == NULL) {
            return head_1;
        }
        if (head_1->val < head_2->val) {
            head_1->next = mergerList(head_1->next, head_2);
            return head_1;
        } else {
            head_2->next = mergerList(head_1, head_2->next);
            return head_2;
        }
    }
};
```

**16. 二叉树转中序链表**

```c++
// 牛客剑指offer26题
class Solution {
  public:
    TreeNode *Convert(TreeNode *root) {
        if (root == nullptr) {
            return nullptr;
        }
        TreeNode *current = nullptr;
        helper(root, current);
        while (current->left) {
            current = current->left;
        }
        return current;
    }
    void helper(TreeNode *root, TreeNode *&pre) {
        if (root == nullptr) {
            return;
        }
        helper(root->left, pre);
        root->left = pre;
        if (pre) {
            pre->right = root;
        }
        pre = root;
        helper(root->right, pre);
    }
};
```

**17. 无序数组的中位数**

```c++
// https://www.cnblogs.com/shizhh/p/5746151.html
class Solution_1 {
  public:
    double median(vector<int> nums) {
        priority_queue<int> max_heap;
        int m = nums.size();
        int size = m / 2 + 1;
        for (int i = 0; i < size; i++) {
            max_heap.push(nums[i]);
        }
        for (int i = size; i < m; i++) {
            if (max_heap.top() > nums[i]) {
                max_heap.pop();
                max_heap.push(nums[i]);
            }
        }
        double res = 0;
        if (m & 1 == 1) {
            return max_heap.top();
        } else {
            res += max_heap.top();
            max_heap.pop();
            res += max_heap.top();
            return res;
        }
    }
};

// lc 215 类似 不过是找第k大的位数
class Solution_1 {
  public:
    int partion(vector<int> &nums, int left, int right) {
        int pivot = nums[right], i = left;
        while (left < right) {
            if (nums[left] < pivot) {
                swap(nums[left], nums[i]);
                i++;
            }
            left++;
        }
        swap(nums[i], nums[right]);
        return i;
    }
    int findKthLargest(vector<int> &nums, int k) {
        int m = nums.size();
        k = m - k;
        return helper(nums, 0, m - 1, k);
    }
    int helper(vector<int> &nums, int left, int right, int k) {
        int pos = partion(nums, left, right);
        if (pos == k) {
            return nums[pos];
        }
        if (pos < k) {
            return helper(nums, pos + 1, right, k);
        }
        return helper(nums, left, pos - 1, k);
    }
};
```

**18. LRU Cache数据结构**

```c++
#include <bits/stdc++.h>
using namespace std;

class LRUCache {
  public:
    LRUCache(int capacity) { this->capacity = capacity; }

    int get(int key) {
        if (dir.count(key)) {
            vistied(key);
            return dir[key]->second;
        }
        return -1;
    }

    void put(int key, int value) {
        if (dir.count(key)) {
            vistied(key);
        } else {
            if (capacity <= dir.size()) {
                dir.erase(cacheList.back().first);
                cacheList.pop_back();
            }
            cacheList.push_front(make_pair(key, value));
            dir[key] = cacheList.begin();
        }
        dir[key]->second = value;
    }
    void vistied(int key) {
        auto p = *dir[key];
        cacheList.erase(dir[key]);
        cacheList.push_front(p);
        dir[key] = cacheList.begin();
    }

  private:
    unordered_map<int, list<pair<int, int>>::iterator> dir;
    list<pair<int, int>> cacheList;
    int capacity;
};
```

**19. 旋转数组最小值**

```c++
#include <bits/stdc++.h>
using namespace std;
/**
 * 原题链接
 * https://leetcode.com/problems/find-minimum-in-rotated-sorted-array/description/
 */
class Solution {
  public:
    int findMin(vector<int> &rotateArray) {
        int left = 0, right = rotateArray.size() - 1;
        while (left < right) {
            int mid = (left + right) / 2;
            if (rotateArray[mid] < rotateArray[right]) {
                right = mid;
            } else {
                left = mid + 1;
            }
        }
        return rotateArray[left];
    }
};
```

**20. 旋转数组最小值（有重复的数）**

```c++
#include <bits/stdc++.h>
using namespace std;
/**
 * 原题链接
 * https://leetcode.com/problems/find-minimum-in-rotated-sorted-array-ii/description/
 */
class Solution {
  public:
    int findMin(vector<int> &nums) {
        int m = nums.size();
        int left = 0, right = m - 1;
        while (left < right) {
            int middle = (left + right) / 2;
            if (nums[middle] < nums[right]) {
                right = middle;
            } else if (nums[middle] > nums[right]) {
                left = middle + 1;
            } else {
                // if里面能找到真正的旋转点，而不是最小值
                if (nums[right - 1] > nums[right]) {
                    left = right;
                    break;
                }
                right--;
            }
        }
        return nums[left];
    }
};
```

**21. 旋转数组的某个值(无重复值)**

```c++
#include <bits/stdc++.h>
using namespace std;
/**
 * https://leetcode.com/problems/search-in-rotated-sorted-array/discuss/14425/Concise-O(log-N)-Binary-search-solution
 *
 */
class Solution_2 {
  public:
    int find_min_in_rotateArr(vector<int> &nums) {
        int m = nums.size();
        int left = 0, right = m - 1;
        while (left < right) {
            int mid = (left + right) / 2;
            if (nums[mid] < nums[right]) {
                right = mid;
            } else {
                left = mid + 1;
            }
        }
        return left;
    }
    int search(vector<int> &nums, int target) {
        int m = nums.size();
        int min_index = find_min_in_rotateArr(nums);
        int left = 0, right = m - 1;
        while (left <= right) {
            int mid = (left + right) / 2;
            int real_mid = (mid + min_index) % m;
            if (nums[real_mid] == target) {
                return real_mid;
            } else if (nums[real_mid] < target) {
                left = mid + 1;
            } else {
                right = mid - 1;
            }
        }
        return -1;
    }
};

class Solution_0 {
  public:
    int search(vector<int> &nums, int target) {
        if (nums.empty()) {
            return -1;
        }
        int m = nums.size();
        int left = 0, right = m - 1;
        while (left <= right) {
            int mid = (left + right) / 2;
            if (nums[mid] == target) {
                return mid;
            }
            if (nums[mid] < nums[right]) {
                if (nums[mid] < target && target <= nums[right]) {
                    left = mid + 1;
                } else {
                    right = mid - 1;
                }
            } else {
                if (nums[mid] > target && nums[left] <= target) {
                    right = mid - 1;
                } else {
                    left = mid + 1;
                }
            }
        }
        return -1;
    }
};
```

**22. 旋转数组的某个值(有重复值)**

```c++
/**
 * leetcode.com/problems/find-minimum-in-rotated-sorted-array-ii/discuss/48808/My-pretty-simple-code-to-solve-it/48840
 */
class Solution {
  public:
    int find_min_in_rotateArr(vector<int> &nums) {
        int m = nums.size();
        int left = 0, right = m - 1;
        while (left < right) {
            int mid = (left + right) / 2;
            if (nums[mid] < nums[right]) {
                right = mid;
            } else if (nums[mid] > nums[right]) {
                left = mid + 1;
            } else {
                // if里面能找到真正的旋转点，而不是最小值
                if (nums[right - 1] > nums[right]) {
                    left = right;
                    break;
                }
                right--;
            }
        }
        return left;
    }
    bool search(vector<int> &nums, int target) {
        int m = nums.size();
        int min_index = find_min_in_rotateArr(nums);
        int left = 0, right = m - 1;
        while (left <= right) {
            int mid = (left + right) / 2;
            int real_mid = (mid + min_index) % m;
            if (nums[real_mid] == target) {
                return true;
            } else if (nums[real_mid] < target) {
                left = mid + 1;
            } else {
                right = mid - 1;
            }
        }
        return false;
    }
};

// https://leetcode.com/problems/search-in-rotated-sorted-array-ii/
class Solution {
  public:
    bool search(vector<int> &nums, int target) {
        int left = 0, right = nums.size() - 1;
        while (left <= right) {
            int mid = (left + right) / 2;
            if (nums[mid] == target) {
                return true;
            }
            if (nums[left] == nums[mid] && nums[right] == nums[mid]) {
                left++;
                right--;
            } else if (nums[left] <= nums[mid]) {
                if (nums[left] <= target && nums[mid] > target)
                    right = mid - 1;
                else
                    left = mid + 1;
            } else {
                if (nums[right] >= target && nums[mid] < target) {
                    left = mid + 1;
                } else {
                    right = mid - 1;
                }
            }
        }
        return false;
    }
};
```

**23. 二叉树右视图**

```c++
#include <bits/stdc++.h>
using namespace std;
/**
 * 原题链接
 * https://leetcode.com/problems/binary-tree-right-side-view/description/
 */

struct TreeNode {
    int val;
    TreeNode *left;
    TreeNode *right;
    TreeNode(int x) : val(x), left(NULL), right(NULL) {}
};
class Solution {
  public:
    vector<int> rightSideView(TreeNode *root) {
        vector<int> res;
        helper(root, 0, res);
        return res;
    }
    void helper(TreeNode *root, int level, vector<int> &res) {
        if (root == NULL)
            return;
        if (res.size() == level)
            res.push_back(root->val);
        helper(root->right, level + 1, res);
        helper(root->left, level + 1, res);
    }
};
```

**24. 数据流的中位数**

```c++
class MedianFinder {
  public:
    /** initialize your data structure here. */
    MedianFinder() {}

    void addNum(int num) {
        min_heap.push(num);
        max_heap.push(min_heap.top());
        min_heap.pop();
        if (min_heap.size() < max_heap.size()) {
            min_heap.push(max_heap.top());
            max_heap.pop();
        }
    }

    double findMedian() {
        int m = max_heap.size() + min_heap.size();
        if (m & 1 == 1) {
            return min_heap.top();
        }
        return (max_heap.top() + min_heap.top()) / 2.0;
    }

  private:
    priority_queue<int, vector<int>, less<int>> max_heap;
    priority_queue<int, vector<int>, greater<int>> min_heap;
};
```

**25. 合并两个有序的链表**

```c++
// https://leetcode.com/problems/merge-two-sorted-lists/description/
class Solution {
public:
    ListNode* mergeTwoLists(ListNode* l1, ListNode* l2) {
        if(l1==NULL){
            return l2;
        }
        if(l2==NULL){
            return l1;
        }
        ListNode *result;
        if(l1->val<l2->val){ 
            l1->next = mergeTwoLists(l1->next,l2);
            return l1;
        }else{
            l2->next = mergeTwoLists(l1,l2->next);
            return l2;
        }
    }
};
```

**26. 合并K个有序链表**

```c++
#include <bits/stdc++.h>
using namespace std;
struct ListNode {
    int val;
    ListNode *next;
    ListNode(int x) : val(x), next(NULL) {}
};
/**
 * https://leetcode.com/problems/merge-k-sorted-lists/description/
 */
class Solution {
  public:
    struct compare_listNode {
        bool operator()(const ListNode *p, const ListNode *q) {
            return p->val > q->val;
        }
    };
    ListNode *mergeKLists(vector<ListNode *> &lists) {
        ListNode result(0);
        ListNode *pre = &result;
        priority_queue<ListNode *, vector<ListNode *>, compare_listNode>
            min_heap;
        int m = lists.size();
        for (int i = 0; i < m; i++) {
            if (lists[i]) {
                min_heap.push(lists[i]);
            }
        }
        while (!min_heap.empty()) {
            ListNode *cur = min_heap.top();
            min_heap.pop();
            pre->next = cur;
            if (cur->next) {
                min_heap.push(cur->next);
            }
            pre = pre->next;
        }
        return result.next;
    }
};
```

**27. Swap Nodes in Pairs**

```c++
#include <bits/stdc++.h>
using namespace std;

struct ListNode {
    int val;
    ListNode *next;
    ListNode(int x) : val(x), next(NULL) {}
};

/**
 * https://leetcode.com/problems/swap-nodes-in-pairs/description/
 */
class Solution {
  public:
    ListNode *swapPairs(ListNode *head) {
        ListNode **cur = &head, *a, *b;
        while ((a = *cur) && (b = a->next)) {
            a->next = b->next;
            b->next = a;
            cur = &(a->next);
        }
    }
};

class Solution_1 {
  public:
    ListNode *swapPairs(ListNode *head) {
        if (head == NULL || head->next == NULL) {
            return head;
        }
        ListNode *first = head, *second = head->next;
        ListNode *tail = swapPairs(second->next);
        second->next = first;
        first->next = tail;
        return second;
    }
};
```

**28. 入栈和出栈**

```c++
#include <bits/stdc++.h>
using namespace std;
class Solution {
  public:
    bool IsPopOrder(vector<int> pushV, vector<int> popV) {
        stack<int> stk;
        int j = 0;
        for (int i = 0; i < pushV.size(); i++) {
            stk.push(pushV[i]);
            while (!stk.empty() && stk.top() == popV[j]) {
                stk.pop();
                j++;
            }
        }
        return j == popV.size();
    }
};
```

**29. 两个有序数组找中位数**

```c++
// lc4
class Solution {
public:
    double findMedianSortedArrays(vector<int> &nums1, vector<int> &nums2) {
        int m = nums1.size(), n = nums2.size();
        int left = (m + n + 1) / 2, right = (m + n + 2) / 2;
        return (find_kth(nums1.begin(), m, nums2.begin(), n, left) +
                find_kth(nums1.begin(), m, nums2.begin(), n, right)) /
               2.0;
    }
    int find_kth(vector<int>::iterator a, int m, vector<int>::iterator b, int n,
                 int k) {
        if(m>n){
            return find_kth(b,n,a,m,k);
        }
        if(m==0){
            return b[k-1];
        }
        if(k==1){
            return min(a[0],b[0]);
        }
        int i = min(m,k/2),j = k - i;
        if(a[i-1]<b[j-1]){
            return find_kth(a+i,m-i,b,j,k-i);
        }else if(a[i-1]>b[j-1]){
            return find_kth(a,i,b+j,n-j,k-j);
        }
        return a[i-1];
    }
};
```

**30. LRU的设计**

```c++
class LRUCache {
  public:
    LRUCache(int capacity) { this->capacity = capacity; }

    int get(int key) {
        if(dir.count(key)){
            vistied(key);
            return dir[key]->second;
        }
        return -1;
    }

    void put(int key, int value) {
        if(dir.count(key)){
            vistied(key);
            dir[key]->second = value;
        }else{
            if(cacheList.size()>=capacity){      
                dir.erase(cacheList.back().first);
                cacheList.pop_back();
            }
            cacheList.push_front(make_pair(key,value));
            dir[key] = cacheList.begin();
        }
    }
    void vistied(int key) {
        auto it = *dir[key];
        cacheList.erase(dir[key]);
        cacheList.push_front(it);
        dir[key] = cacheList.begin();
    }

  private:
    unordered_map<int, list<pair<int, int>>::iterator> dir;
    list<pair<int, int>> cacheList;
    int capacity;
};
```

**31. 猜数游戏**

牛牛和羊羊在玩一个有趣的猜数游戏。在这个游戏中,牛牛玩家选择一个正整数,羊羊根据已给的提示猜这个数字。第i个提示是"Y"或者"N",表示牛牛选择的数是否是i的倍数。
例如,如果提示是"YYNYY",它表示这个数使1,2,4,5的倍数,但不是3的倍数。
注意到一些提示会出现错误。例如: 提示"NYYY"是错误的,因为所有的整数都是1的倍数,所以起始元素肯定不会是"N"。此外,例如"YNNY"的提示也是错误的,因为结果不可能是4的倍数但不是2的倍数。
现在给出一个整数n,表示已给的提示的长度。请计算出长度为n的合法的提示的个数。
例如 n = 5:
合法的提示有:
YNNNN YNNNY YNYNN YNYNY YYNNN YYNNY
YYNYN YYNYY YYYNN YYYNY YYYYN YYYYY
所以输出12

**输入描述**
> 输入包括一个整数n(1 ≤ n ≤ 10^6),表示已给提示的长度。

**输出描述**
> 输出一个整数,表示合法的提示个数。因为答案可能会很大,所以输出对于1000000007的模

**示例**-输入5，输出12

**解析**
>思路： 1.第i个数是素数，那么dp\[i\]=dp\[i-1\]*

> 2，这是因为素数和前面的所有数都没有依赖关系，因此YN都行 2.第i个数不是素数的幂次，也就是像6这样的数字，你会发现，它已经被2,3唯一确定了，例如23分别是YY，那么6一定是Y，23分别是YN或NY或NN，6一定是N，所以说这时候有dp\[i\]=dp\[i-1\]

> 3.第i个数是素数的幂次，它不能唯一确定，比如4，当2为Y时，4不确定，可以是Y，也可以是N。将4和2放入集合，若2取，4必定取，所以有NN，YN，YY三种情况。那么引申一下，加入8就是3个元素的集合，共4种情况，9就是2个元素的集合（3、9），有3种情况，以此类推。最后将这些情况相乘即可，因为这些集合之间相互不影响

```c++
#include <iostream>
#include <vector>
#include <cstring>
#include <string>
using namespace std;
  
const int MOD = 1E9+7;
const int maxn = 1e6+5;
  
int vis[maxn];
  
int main()
{
    int n;
    while(cin >> n)
    {
        long long ans = 1;
          
        for(int i = 2; i <= n; i++)
        {
            int cnt = 0;
            if(vis[i])
                continue;
            for(int j = i+i; j <= n; j += i)        //处理他的倍数
            {
                vis[j] = 1;
            }
            //求i的幂次
            long long mi = i;       //用 int 会溢出
            while(mi <= n)
            {
                cnt++;
                mi *= i;
            }
              
            ans = ans * (cnt + 1) % MOD;
        }
        cout << ans << endl;
    }
}
 //找规律....
 //例子 n=16  2的4次幂在16之内  3的2次幂在16之内  5的1次幂在16之内 
 //           7的1次幂在16之内  11的1次幂在16之内  13的1次幂在16之内 
 //接下来  把 (幂+1) 相乘  即:(4+1)*(2+1)*(1+1)*(1+1)*(1+1)*(1+1)=5*3*2*2*2*2=240
 //流程就是  把素数的幂找一遍  +1  相乘
```

```java
import java.util.Scanner;
    public class Main {
        public static void main(String[] args) {
            Scanner scanner = new Scanner(System.in);
            int len=scanner.nextInt();
            long ans=1;
            boolean[] visited = new boolean[len+1];
            for(int i=2; i<=len; i++) {
                if(visited[i])
                    continue;
                for(int j=2*i; j<=len; j+=i)
                    visited[j] = true;
                int count=0;
                long k = i;  //int会溢出
                while(k<=len) {
                    k *= i;
                    count++;
                }
                ans=ans*(count+1)%1000000007;
            }
            System.out.println(ans);
        }
    }
```

**32. 给定一个01矩阵，求最大矩形的面积**

```c
#include <iostream>
#include <algorithm>
#include <cstdio>
#include <cstdlib>
#include <cstring>
#include <ctime>
#include <cmath>
#define debug(x) cout<<#x<<" = "<<x<<endl;
#define maxn 1005
using namespace std;
 
int n,m,len,ans;
char s[3];
int a[maxn][maxn],l[maxn][maxn],r[maxn][maxn],up[maxn][maxn];
 
int read()
{
	int xx=0,kk=1;char ch=' ';
	while(!isdigit(ch)){ch=getchar();if(ch=='-')kk=-1;}
	while(isdigit(ch)){xx=xx*10+ch-'0';ch=getchar();}
	return kk*xx;
}
 
int main()
{
	n=read(),m=read();
	for(int i=1;i<=n;++i)
	for(int j=1;j<=m;++j)
	{
		scanf("%s",s+1);
		a[i][j]=s[1]=='F'?1:0;
	}
	for(int i=1;i<=n;++i)
	for(int j=1;j<=m;++j)
	{
		l[i][j]=r[i][j]=j;
		up[i][j]=1;
	}
	for(int i=1;i<=n;++i)
	    for(int j=2;j<=m;++j)
	        if(a[i][j]&&a[i][j-1])
	            l[i][j]=l[i][j-1];
	for(int i=1;i<=n;++i)
	    for(int j=m-1;j>=1;--j)
	        if(a[i][j]&&a[i][j+1])
	            r[i][j]=r[i][j+1];
	for(int i=2;i<=n;++i)
	    for(int j=1;j<=m;++j)
	    {
		    if(a[i][j]&&a[i-1][j])
		    {
			    l[i][j]=max(l[i][j],l[i-1][j]);
			    r[i][j]=min(r[i][j],r[i-1][j]);
			    up[i][j]=up[i-1][j]+1;
		    }
		    len=r[i][j]-l[i][j]+1;
		    ans=max(ans,len*up[i][j]);
	    }
	printf("%d",ans*3);
	return 0;
}
```

**33. 给一个大小为n*n的矩阵，和k个障碍物的坐标，求最大正方形的边长**

```c

#include <iostream>
#include <algorithm>
#include <cstring>
#include <cstdlib>
#include <cstdio>
#include <cmath>
#include <ctime>
#define debug(x) cout<<#x<<" = "<<x<<endl;
#define maxn 2005
using namespace std;
 
int n,m,len,ans,x,y,a[maxn][maxn];
int l[maxn][maxn],r[maxn][maxn],up[maxn][maxn];
 
int read()
{
	int xx=0,kk=1;char ch=' ';
	while(!isdigit(ch)){ch=getchar();if(ch=='-')kk=-1;}
	while(isdigit(ch)){xx=xx*10+ch-'0';ch=getchar();}
	return kk*xx;
}
 
int main()
{
	n=read(),m=read();
	for(int i=1;i<=n;++i)
	for(int j=1;j<=n;++j)
	{
		l[i][j]=r[i][j]=j;//将能到达的最左和最右的端点的列数赋为自己本身所在的列数（即还未扩张）
		up[i][j]=a[i][j]=1; //可以向上扩张的列数为1（即本行） 
    }
	for(int i=1;i<=m;++i)
	   x=read(),y=read(),a[x][y]=0;
	for(int i=1;i<=n;++i)
	for(int j=2;j<=n;++j)
	    if(a[i][j]&&a[i][j-1])
	        l[i][j]=l[i][j-1];//求得i行j列向左扩展最多能扩展到的地方 
	for(int i=1;i<=n;++i)
	for(int j=n-1;j>=1;--j)
	    if(a[i][j]&&a[i][j+1])
	        r[i][j]=r[i][j+1];//求得i行j列向右扩展最多能扩展到的地方
	for(int i=2;i<=n;++i)
	for(int j=1;j<=n;++j)
	{
		if(a[i][j]&&a[i-1][j])//第i-1行j列元素和第i行j列元素都符合要求，说明最大矩阵可以更新 
		{
			l[i][j]=max(l[i][j],l[i-1][j]); 
			r[i][j]=min(r[i][j],r[i-1][j]);// 取该行和上一行分别向扩展的最大距离
			up[i][j]=up[i-1][j]+1;//可以向上扩张的行数（包括本行） 
		}
		len=r[i][j]-l[i][j]+1;//可扩张的区间长度 
		ans=max(ans,min(len,up[i][j]));//由于题目要求最大正方形，在左右扩张长度和向上扩张长度取min就ok啦 
	}
	printf("%d",ans);
	return 0;
```

**34. 从一个整数数组中找出总和为S的所有子集**

```java
public void populateSubset(final int[] data, int fromIndex, int endIndex) {  
    if (sumInStack >= TARGET_SUM) {  
        if (sumInStack == TARGET_SUM) {  
            print(stack);  
        }  
        return;  
    }  
  
    for (int currentIndex = fromIndex; currentIndex < endIndex; currentIndex++) {  
        if (sumInStack + data[currentIndex] <= TARGET_SUM) {  
            stack.push(data[currentIndex]);  
            sumInStack += data[currentIndex];  
            populateSubset(data, currentIndex + 1, endIndex);  
            sumInStack -= (Integer) stack.pop();  
        }  
    }  
}  
```

**35. 数组中的逆序对**

在数组中的两个数字，如果前面一个数字大于后面的数字，则这两个数字组成一个逆序对。输入一个数组,求出这个数组中的逆序对的总数P。并将P对1000000007取模的结果输出。 即输出P%1000000007

**采用并归排序的思想**

```java
public class Solution {
 
    /**主要是剑指offer的思想，用了归并排序，用count来记录数量
     * 所不同的是用的--而不是++
     * 每一次归并之前，记录当前有的个数，
     * @param array
     * @return
     */
	int count = 0;
    public int InversePairs(int [] array) {
    	if(array == null || array.length ==0)
    		return 0;
    	mergeSort(array, 0, array.length -1);
    	return count;
    	
    }
    public void mergeSort(int []array, int start, int end) {
		if(start < end) {
			int mid = (start + end)/2;
			mergeSort(array, start, mid);
			mergeSort(array, mid + 1, end);
			merge(array, start, mid, mid+ 1, end);
		}
	}
    public void merge(int []array,int start1,int end1, int start2, int end2) {
		int i = end1;
		int j = end2;
		int k = end2 - start1 ;
		int [] temp = new int[end2- start1 +1];
		while(i >= start1 && j >=start2) {
			if(array[i] > array[j]) { 
				//假设此时两个归并的是17 19 22 || 16 18 21
				//那么22大于21，所以可以看出对应22
			    //有三个，22 16 22 18 22 21
				temp[k--] = array[i--];
				count = count + j - start2 +1;
				count %= 1000000007;
			}
			else
				temp[k--] = array[j--];
		}
		while(i >= start1)
			temp[k--] = array[i--];
		while(j >= start2)
			temp[k--] = array[j--];
 
        int m = start1;
        for(int element:temp)
        	array[m++] = element;
		
	}
}
```

**36. 数字在排序数组中出现的次数**

统计一个数字在排序数组中出现的次数。

思路：二分查找数字第一次出现的索引，二分查找数字最后一次出现的索引

```java
public class Solution {
    /**
     * 博客上的解题思路，也就是剑指offer的思路
     * 首先用递归二分法找到第一个k和最后一个k，然后得到个数
     * @param array
     * @param k
     * @return
     */
    public int GetNumberOfK(int [] array , int k) {
        int num = 0;
        if (array != null && array.length >0) {
			int firstk = getFirstK(array, k,0, array.length-1);
			int lastk = getLastK(array, k,0, array.length-1);
			if (firstk > -1 && lastk > -1) 
				num = lastk -firstk +1;
			
			
		}
        return num;
    }
    /*
     * 找到第一个出现的数字的下标
     */
    public int getFirstK(int [] array, int k,int start, int end) {
    	if(start > end)
    		return -1;
		int midindex = (start + end)/2;
		int middata = array[midindex];
		if (middata == k) {
			//判断是不是第一个K，前一个不等于K，就是第一个K
			if(midindex > 0 && array[midindex - 1]!=k||midindex == 0)
				return midindex;
			else
				end = midindex -1;//如果不是第一个k，那么肯定是在前面找，所以end要往前放
				
		}
		else if (middata > k) {
			end = midindex -1; //二分，如果这个大于k，所以要在前面找
		}
		else
			start = midindex + 1;// 如果小于k，说明要往后找
		return getFirstK(array,k, start, end);
	}
 
    /*
   * 找到最后一个出现的数字的下标
   */
    public int getLastK(int [] array, int k,int start, int end) {
		if(start > end)
			return -1;
		int midindex = (start + end)/2;
		int middata = array[midindex];
		if(middata == k) {
			 //判断是不是最后一个K，后一个不等于K，就是最后一个K
			if(midindex < array.length-1 && array[midindex + 1]!= k||midindex ==array.length -1)
		            return midindex;
			else
				start = midindex + 1;
		}
		else if (middata > k) {
			end = midindex - 1;
		}
		else 
			start = midindex +1;
		return getLastK(array, k,start, end);
	}
}
```

**37. 把数组排成最小的数**

输入一个正整数数组，把数组里所有数字拼接起来排成一个数，打印能拼接出的所有数字中最小的一个。例如输入数组{3，32，321}，则打印出这三个数字能排成的最小数字为321323。

```
/* 解题思路： * 考虑到大数问题，先将整型数组转换成String数组，然后将String数组排序，最后将排好序的字符串数组拼接出来。关键就是制定排序规则。 * 排序规则如下： * 若ab > ba 则 a > b， * 若ab < ba 则 a < b， * 若ab = ba 则 a = b； * 解释说明： * 比如 "3" < "31"但是 "331" > "313"，所以要将二者拼接起来进行比较 */
```

```java
public class Solution {
 
	    /**
	     * 主要就是规则的制定，将两个数字转换为字符串，防止溢出
	     * 假设两个数字m和n，拼接有mn和nm
	     * 如果mn>nm, 我们打印nm，此时定义n小于m。（此处小于是我们定义的）
	     * 不是m和n的大小关系，
	     * 而是看拼了之后的大小，来决定m和n的大小。
	     * 如果mn<nm 那么就是m小于n。
	     * 
	     * @param numbers
	     * @return
	     */
	    public String PrintMinNumber(int [] numbers) {
             if(numbers == null || numbers.length == 0)
            	 return "";
             int len = numbers.length;
             String[] str = new String[len];
             StringBuffer sb = new StringBuffer();
             //将数字型的放在字符串数组中。
             for (int i = 0; i < len; i++) {
				str[i] = String.valueOf(numbers[i]);
			}
             //根据定义的规则重新堆str进行升序排序
            Arrays.sort(str, new Comparator<String>() {
 
				@Override
				public int compare(String s1, String s2) {
					// TODO Auto-generated method stub
					String c1 = s1 + s2;
					String c2 = s2 + s1;
					
					return c1.compareTo(c2);
				}

			});
            //根据规则排好序，将结果依次放入stringbuffer中就行了
            for (int i = 0; i < len; i++) {
				sb.append(str[i]);
			}
            
            return sb.toString();
	    }
}
```

**38. 带括号的加减乘除运算器**

```java

public class Calc {
    public static void main(String[] args) {
        String str = "-3+5.0*-4-9/-3";
        Result(str);
    }

    private static void Result(String str) {
        ArrayList<String> ops = getOps(str);
        ArrayList<Double> num = getNum(str);
        // 先乘除再加减
        for (int i = 0; i < ops.size(); i++) {
            if (ops.get(i).contains("*") || ops.get(i).contains("/")) {
                String op = ops.remove(i);
                if (op.equals("*")) {
                    // 从数字集合取对应和后面一位数字
                    double d1 = num.remove(i);
                    double d2 = num.remove(i);

                    double number = d1*d2;
                    //再加上
                    num.add(i,number);
                }
                if (op.equals("/")) {
                    double d1 = num.remove(i);
                    double d2 = num.remove(i);
                    double number = d1/d2;
                    num.add(i, number);
                }
                i--;    //刚刚移掉两个,却又刚加上一个新数,所以i要--,因为i++,所以才能取到,如果不加那么虽然貌似正常,但是如果如8*3/3,*/连在一起就报错了;因为连着的两个if;
            }
        }
        //到+-,按顺序的所以就用while()了
        while (ops.size() != 0) {
            String op = ops.remove(0);
            double d1 = num.remove(0);
            double d2 = num.remove(0);

            if (op.equals("+")) {
                double number = d1+d2;
                //再加入
                num.add(0, number);
            }
            if (op.equals("-")) {
                double number = d1-d2;
                num.add(0, number);
            }
        }
        System.out.println(num);
    }

    /**
     * 获取符号 1.首位 和 * /后面 的-变成@,其他的-不用
     */
    private static ArrayList getNum(String str) {
        // -变成@
        str = change(str);
        ArrayList<Double> list = new ArrayList();

        String[] split = str.split("[\\+\\-\\*/]");
        for (int i = 0; i < split.length; i++) { // @3,5,@4,9,@3
            String s = split[i];
            // 再把@变成-
            if (s.contains("@")) {
                s = '-' + s.substring(1);
            }
            list.add(Double.parseDouble(s));
        }

        return list;
    }

    private static String change(String str) {
        char[] chars = str.toCharArray();
        for (int i = 0; i < chars.length; i++) {
            // @3+5*-4-9/-3
            if (i == 0 && chars[i] == '-') {
                str = '@' + str.substring(i + 1);
            }
            // @3+5*@4-9/@3
            if (chars[i] == '*' && chars[i + 1] == '-' || chars[i] == '/' && chars[i + 1] == '-') {
                str = str.substring(0, i + 1) + '@' + str.substring(i + 2);
            }
        }
        return str;
    }

    // 获取符号
    private static ArrayList getOps(String str) {
        ArrayList<String> list = new ArrayList();
        // @变-
        str = change(str);
        // @3+5*@4-9/@3
        String[] split = str.split("[0-9\\.@]");// 表示0-9包括小数和@
        for (int i = 0; i < split.length; i++) {
            if (split[i].contains("+") || split[i].contains("-") || split[i].contains("*") || split[i].contains("/")) {
                list.add(split[i]);
            }
        }
        return list;
    }
}

private static void calcDemo() {
        String str = "3+12/(2-8)+7*((55+1)/2+0.2*(9-1))/2+10";
        // 括弧:先判断左括号和右括号是否相等,再判断括号是否左右是否匹配
        if (!isPiPei(str)) {
            return;
        }
        if (str.contains("()")) {
            System.out.println("包含了空的括号，不符合,请检查重新输入");
            return;
        }
        /*--------------集合存单字符,用于随时移除和添加--------------*/
        // 加上括号,这样就能当作最终的表达式并判断，最终求出结果
        str = "(" + str + ")";

        ArrayList str_list = new ArrayList();

        for (int i = 0; i < str.length(); i++) {
            str_list.add(str.charAt(i));
        }
        /*--------------获取所有的单位括号内容--------------*/
        //关键是获取每一次“对称的括号”，并逐个计算，小到大，所以用栈是最好的方法。
        Stack<Integer> stack = new Stack();
        for (int i = 0; i < str_list.size(); i++) {
            if (str_list.get(i) == '(') {
                stack.add(i);
            }
            if (str_list.get(i) == ')') {
                // 移除栈记录的内容角标
                int s = stack.pop();

                // 获取式子内容
                StringBuilder sb = new StringBuilder();
                for (int j = s; j <= i; j++) {
                    sb.append(str_list.get(j));
                }

                int sbLength = i - s + 1;// 重点(这部把是最容易出错的了,(sb.Length()按照的是字符串,看似满足其实不满足list,因为8123488或者再长的小树，在list只占一位,这里用i-s+1才满足所有))

                for (int k = 0; k < sbLength; k++) {
                    str_list.remove(s);// 移除这个位置长度次
                }
                // 获取括号中的式子,计算成结果,在放入集合变成新的式子
                String strCalc = sb.substring(1, sb.length() - 1);
                double num = Calc.Result(strCalc);
                str_list.add(s, num);

                System.out.println(str_list);
                i = i - sbLength + 1; // 移掉后,占一位,++后要能获取"本来i位置"的下一位
                if (i < -1) {// 防越界
                    break;
                }
            }
        }
    }

    /**
     * 判断字符串里的"左和右"括号是否"相等"
     */
    private static boolean isCountEqual(String str) {
        char[] chars = str.toCharArray();
        int left = 0;
        int right = 0;
        for (int i = 0; i < chars.length; i++) {
            if (chars[i] == '(') {
                left++;
            }
        }
        for (int i = 0; i < chars.length; i++) {
            if (chars[i] == ')') {
                right++;
            }
        }
        if (left == right) {

        } else {
            System.out.println("表达式括号不匹配");
        }
        return left == right;
    }

    /**
     * 判断字符串里的"左和右"括号是否"匹配"
     */
    private static boolean isPiPei(String str) {
        boolean isPiPei = false;
        //先判断是否相等
        if (!isCountEqual(str)) {
            return false;
        }
        //定义栈记录左
        Stack<Character> stack = new Stack<>();
        char pop;
        char[] chs = str.toCharArray();
        fo:
        for (int i = 0; i < chs.length; i++) {
            switch (chs[i]) {
                case '(':
                    stack.add(chs[i]);// 放在前面
                    break;
                case ')':
                    pop = stack.pop();// 获取并移除
                    if (pop == '(') {
                        isPiPei = true;
                    } else {
                        isPiPei = false;
                        // 并停止所有
                        break fo;
                    }
                    break;
            }
        }
        return isPiPei;
    }
```

**39. 给定一个数字数组，写一个函数，将所有0元素移动到它的末端，同时保持非零元素的相对顺序**

**双指针**记录数据

```java
public void moveZeros(int[] nums){
    int slow = 0, fast = 0;
    while (fast < nums.length){
        if (num[fast] != 0){
            nums[slow] = nums[fast];
            slow += 1;
            fast += 1;
        }
        else {
            fast += 1;
        }
    }
    for (i = slow;i < nums.length;++i) {
        nums[i] = 0;
    }
}
```

**40. 如何利用快排对一个单链表进行排序**

```c++

struct ListNode {
    int _val;
    ListNode* _next;

    ListNode(const int x):_val(x),_next(NULL){

    }
};

//快速排序(前后指针法)
//这里注意一定要传引用，如果不传引用会导致连接不上的问题
void sort_quick(ListNode* &head, ListNode* &end){
    if (head == NULL&&head == end){
        return;
    }
    //设置快排基准值，将基准值进行单独保存
    int key = head->_val;
    ListNode* ret = head->_next;
    head->_next = NULL;
    //标识两个分区的头尾，pre用来向后标识记录节点
    ListNode* head1 = NULL;
    ListNode* pre1 = NULL;
    ListNode* end1 = NULL;

    ListNode* head2 = NULL;
    ListNode* pre2 = NULL;
    ListNode* end2 = NULL;

    //head1链表存放大于key的数值
    while (ret != NULL){
        if (ret->_val > key){
            if (head1 == NULL){
                head1 = ret;
                pre1 = ret;
            }
            else{
                pre1->_next = ret;
                pre1 = ret;
            }
            ret = ret->_next;
            pre1->_next = NULL;
        }
        //head2存放小于基准值的数据
        else{
            if (head2 == NULL){
                head2 = ret;
                pre2 = ret;
            }
            else{
                pre2->_next = ret;
                pre2 = ret;
            }
            ret = ret->_next;
            pre2->_next = NULL;
        }
    }
    //记录尾节点
    end1 = pre1;
    end2 = pre2;

    //对分区进行同样的操作
    sort_quick(head1, end1);
    sort_quick(head2, end2);

    //将分区进行连接
    if (head1 != NULL&&head2 != NULL){
        end1->_next = head;
        head->_next = head2;
        head = head1;
        end = end2;
    }
    else if (head1 != NULL){
        end1->_next = head;
        end = head;
        head = head1;
    }
    else if (head2 != NULL){
        head->_next = head2;
        end = end2;
    }
}

```

**41. 判断一棵二叉树是否是平衡二叉树**

左右子树的高度差不超过1的二叉树是平衡二叉树

int IsBalance(BNode *root){
	if (root == NULL){
		return 1;
	}
	int isBalance = IsBalance(root->left);
	if (isBalance == 0){
		return 0;
	}
	int leftHight = GetHeight(root->left);
	int rightHight = GetHeight(root->right);
	int diff = leftHight - rightHight;
	if (diff < -1 && diff>1){
		return 0;
	}
	else {
		return 1;
	}
}

**42. 字符串反转**

abc -> cba

www.tencent.com.cn -> cn.com.tencent.www

```c++
#include <stdlib.h>
#include <string.h>
#include <stdio.h>

#define N 1000

void reverseString(char * s, int start, int end){
    while (start < end){
        char tmp = s[start];
        s[start] = s[end];
        s[end] = tmp;
        start++;
        end--;
    }
}

int main(void)
{
	char buf[N] = "www.tencent.com.cn";  
    char split = '.';
    scanf("%s, %c", buf, &split);
    auto n = strlen(buf);
    reverseString(buf, 0, n - 1);
    int slow = 0;
    int flag = 0;
    for (int i = 0;i < n;++i){
        if (s[i] == split){
            reverseString(buf, slow, i - 1);
            slow = i + 1;
            flag = 1;
        }
    }
    if (flag == 1){
        reverseString(buf, slow, n - 1);
    }
	printf("buf:%s\n", buf);
	system("pause");
	return 0;
}
```

**43. 快速排序的稳定方法实现**

原始快速排序是一种非稳定算法，实现快排的稳定性是在交换时用额外的空间存储要交换的数据

**44. 一个数组的中位数**

* 快排的分堆程序
* 最小堆

```c++
int PartSort(int *arr, int start, int end)
{
    int left = start;
    int right = end;
    int key = arr[end];   //选取关键字
    while (left < right)
    {
        while (left < right && arr[left] <= key)  //左边找比key大的值
        {
            ++left;
        }
        while (left < right && arr[right] >= key)  //右边找比key小的值
        {
            --right;
        }
        if (left < right)
        {
            swap(arr[left], arr[right]);  //找到之后交换左右的值
        }
    }
    swap(arr[right], arr[end]);
    return left;
}
//求一个无序数组的中位数
int GetMidNumNoSort1(int *arr,int size)
{
    assert(arr);
    int start = 0;
    int end = size - 1;
    int mid = (size - 1) / 2;
    int div = PartSort(arr,start,end);
    while (div != mid)
    {
        if (mid < div)   //左半区间找
            div = PartSort(arr, start, div - 1);
        else    //左半区间找
            div = PartSort(arr, div + 1, end);
    }
    return arr[mid];   //找到了
}
```

**45. **

**46. **

**47. **

**48. **

**49. **

**50. **

**51. **

**52. **

**53. **

**54. **

**55. **

**56. **

**57. **

**58. **

**59. **

**60. **

**61. **

**62. **

**63. **

**64. **

**65. **

**66. **

**67. **

**68. **

**69. **

**70. **

**71. **

**72. **

**73. **

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


