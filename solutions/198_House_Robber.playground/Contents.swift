// #198 House Robber https://leetcode.com/problems/house-robber/?tab=Description
// 一个很简单的动归…… 我写的是二维的转移方程，f[i][0] 代表从 i 往前，不偷第 i 家的最大值；f[i][1] 代表从 i 往前，且偷第 i 家的最大值。看了下题解，发现一维转移方程就可以了。直接 f[i] = max(f[i - 2] + n[i] , f[i - 1]) 就行了。
// 时间复杂度：O(n) 空间复杂度：O(n)

class Solution {
    func rob(_ nums: [Int]) -> Int {
        guard nums.count > 0 else {
            return 1
        }
        
        var money = Array(repeating: [0,0], count: nums.count)
        money[0][0] = 0
        money[0][1] = nums[0]
        
        for i in 1 ..< nums.count {
            money[i][0] = max(money[i - 1][0], money[i - 1][1])
            money[i][1] = money[i - 1][0] + nums[i]
        }
        
        return max(money[nums.count - 1][0], money[nums.count - 1][1])
    }
}

Solution().rob([1,2])
  