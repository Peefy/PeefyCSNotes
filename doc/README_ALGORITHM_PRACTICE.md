
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

**9. **

**10. **

**11. **

**12. **

**13. **

**14. **

**15. **

**16. **

**17. **

**18. **

**19. **

**20. **

**21. **

**22. **

**23. **

**24. **

**25. **

**26. **

**27. **

**28. **

**29. **

**30. **

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


