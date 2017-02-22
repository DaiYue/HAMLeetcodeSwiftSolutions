// #219 Contains Duplicate II https://leetcode.com/problems/contains-duplicate-ii/
// 简单的 hash。没什么可说的。
// 时间复杂度：O(n) 空间复杂度：O(n)

class Solution {
    func containsNearbyDuplicate(_ nums: [Int], _ k: Int) -> Bool {
        var dict = [Int : Int]()
        for (index, num) in nums.enumerated() {
            let previousNumPosition = dict[num]
            if previousNumPosition != nil {
                if index - previousNumPosition! <= k {
                    return true
                }
            }
            dict[num] = index
        }
        
        return false
    }
}

Solution().containsNearbyDuplicate([1,2,1], 0)