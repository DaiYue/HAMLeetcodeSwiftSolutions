// #202 Happy Number https://leetcode.com/problems/happy-number/?tab=Description
// 简单模拟。没什么好说的。
// 值得一提的是，在题解里看到一个很有趣的解法，可以不用 hash 排重。就是用两个数，一个往前推一步，一个往前推两步，直到他俩重合…… 再判断是否是 1。跟单链表里存在环的判断差不多。
// 时间/空间复杂度：... 不知道 >< 大概需要点证明了。

class Solution {
    func isHappy(_ n: Int) -> Bool {
        var numSet = Set<Int>()
        var num = n
        while !numSet.contains(num) && num != 1 {
            numSet.insert(num)
            
            var sum = 0
            while num > 0 {
                let lastDigit = num % 10
                sum += lastDigit * lastDigit
                num /= 10
            }
            
            num = sum
        }
        
        return num == 1
    }
}

Solution().isHappy(18)