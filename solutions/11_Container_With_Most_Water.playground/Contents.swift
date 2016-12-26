// #11 Container With Most Water https://leetcode.com/problems/container-with-most-water/
// 本来想的是搜索加剪枝，搜以每个点做一端的。最坏情况 O(n^2)，结果最后有两组数据（就是最坏情况）过不去，超时。
// 改成题解里这样，从两边往中间搜，结果变成 O(n) 了。想改成记忆化搜索，发现很难。
// 搜索的顺序果然还是非常重要！很多东西从后往前搜，从中间往两边搜，从两边往中间搜，就差得多了……
// 时间复杂度：O(n) 空间复杂度：O(1)

class Solution {
    func maxArea(_ height: [Int]) -> Int {
        var maxArea = 0
        var i = 0, j = height.count - 1
        while i < j {
            let area = (j - i) * min(height[i], height[j])
            maxArea = max(maxArea, area)
            if height[i] < height[j] {
                i = i + 1
            } else {
                j = j - 1
            }
        }
        return maxArea
    }
}

Solution().maxArea([1, 1])
