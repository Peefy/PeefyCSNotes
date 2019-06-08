
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

**31. **

**32. **

**33. **

**34. **

**35. **

**36. **

**37. **

**38. **

**39. **

**40. **

**41. **

**42. **

**43. **

**44. **

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


