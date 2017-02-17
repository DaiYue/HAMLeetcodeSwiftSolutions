// #35 Search Insert Position https://leetcode.com/problems/search-insert-position/
// 插排最基本的一步，没什么好说的。
// 时间复杂度：O(n) 空间复杂度：O(1)


class Solution {
    func searchInsert(_ nums: [Int], _ target: Int) -> Int {
        for (index, num) in nums.enumerated() {
            if num >= target {
                return index
            }
        }
        return nums.count
    }
}