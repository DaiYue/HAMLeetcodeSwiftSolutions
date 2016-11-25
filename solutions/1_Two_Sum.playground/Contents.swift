// #1 Two Sum https://leetcode.com/problems/two-sum/
// 很简单的 hash。一个小技巧是，对于每个数先看和为 target 所需的数是否已经在 dict 里，如果已经在则直接返回，否则才把自身放进 dict 里。这样只需循环一次，不用先构建 hash、再遍历，循环两次。
// 时间复杂度：O(n) 空间复杂度：O(n)

import UIKit

class Solution {
    func twoSum(_ nums: [Int], _ target: Int) -> [Int] {
        
        var numberIndexDict = [Int:Int]()
        
        for (index, num) in nums.enumerated() {
            guard let pairedIndex = numberIndexDict[target - num] else {
                // 把自身放入 hash 表
                numberIndexDict[num] = index
                continue
            }
            
            // 配对的数已存在
            return [pairedIndex, index]
        }
        
        return [-1, -1]
    }
}

let solution = Solution()
solution.twoSum([3,-2,4], 1)
