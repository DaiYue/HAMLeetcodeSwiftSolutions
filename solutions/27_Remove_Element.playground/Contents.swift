// #27 Remove Element https://leetcode.com/problems/remove-element/
// 跟上一题基本完全一样，两个指针，一个读一个写。
// 要注意在循环中更改数组本来是一件并不安全的事，不过在这两个例子里还好。首先长度没有改变，其次改变的部分都是读过的（废弃的）区域。总之要多想一下。
// 时间复杂度：O(n) 空间复杂度：O(1)

class Solution {
    func removeElement(_ nums: inout [Int], _ val: Int) -> Int {
        var writeIndex = 0
        for num in nums {
            if num != val {
                nums[writeIndex] = num
                writeIndex += 1
            }
        }
        return writeIndex
    }
}

var array = [1, 2, 3]
Solution().removeElement(&array, 1)
array