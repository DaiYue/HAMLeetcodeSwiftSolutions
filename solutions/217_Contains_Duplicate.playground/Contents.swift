// #217 Contains Duplicate https://leetcode.com/problems/contains-duplicate/?tab=Description
// 最简单的 hash，没什么可说的。
// 时间复杂度：O(n) 空间复杂度：O(n)

class Solution {
    func containsDuplicate(_ nums: [Int]) -> Bool {
        var set = Set<Int>()
        for num in nums {
            if set.contains(num) {
                return true
            }
            set.insert(num)
        }
        return false
    }
}
