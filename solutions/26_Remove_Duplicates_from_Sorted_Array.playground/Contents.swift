// #26 Remove Duplicates from Sorted Array https://leetcode.com/problems/remove-duplicates-from-sorted-array/
// 很简单的数组处理。一个指针往后读，一个指针指向写入的位置，读到不重复的（跟前一位不一样的）就在写指针的位置写入，不然继续往后读即可。
// 时间复杂度：O(n) 空间复杂度：O(1)

class Solution {
    func removeDuplicates(_ nums: inout [Int]) -> Int {
        guard nums.count > 0 else {
            return 0
        }
        
        var writeIndex = 1
        for readIndex in 1 ..< nums.count {
            if nums[readIndex] != nums[readIndex - 1] {
                nums[writeIndex] = nums[readIndex]
                writeIndex += 1
            }
        }
        
        return writeIndex
    }
}

var array = [1,2,2,2]
Solution().removeDuplicates(&array)