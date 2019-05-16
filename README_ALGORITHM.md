
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

**4. 动态规划DP:最长公共子序列**

**5. 动态规划DP:求一个字符串最长回文子串**

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
