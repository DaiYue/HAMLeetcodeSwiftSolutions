// #31 Next Permutation https://leetcode.com/problems/next-permutation/
// 代码写起来很简单，数学推导稍微多一些。方法如下：
// 从右往左找第一个比右边小的数字（如果找不到，逆转整个数组即可），其 index 为 leftNumIndex。再找它右边比它大的数字（一定存在）里最小的，由于右边是降序，从右往左找的第一个即是，index 为 rightNumIndex。swap 两个 index 的 num。
// leftNumIndex 左边是不变的，下面看右边。右边本来是降序，能保证 swap 过后也是（不严格的）降序。换成升序，只需逆转这部分。
// 时间复杂度：O(n) 空间复杂度：O(1)

class Solution {
    func nextPermutation(_ nums: inout [Int]) {
        var leftNumIndex = -1
        for (index, num) in nums.enumerated().reversed() {
            if index != nums.count - 1 && num < nums[index + 1] {
                leftNumIndex = index
                break
            }
        }
        
        if leftNumIndex == -1 {
            reverse(&nums, fromIndex: 0)
            return
        }
        
        var rightNumIndex = -1
        for (index, num) in nums.enumerated().reversed() {
            if num > nums[leftNumIndex] {
                rightNumIndex = index
                break
            }
        }
        
        swap(&nums[leftNumIndex], &nums[rightNumIndex])
        reverse(&nums, fromIndex: leftNumIndex + 1)
    }
    
    func reverse(_ nums: inout [Int], fromIndex: Int) {
        var leftIndex = fromIndex, rightIndex = nums.count - 1
        while leftIndex < rightIndex {
            swap(&nums[leftIndex], &nums[rightIndex])
            leftIndex += 1
            rightIndex -= 1
        }
    }
}

var nums = [3, 1, 2]
Solution().nextPermutation(&nums)
nums