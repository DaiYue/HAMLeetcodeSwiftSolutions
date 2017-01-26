// #27 Remove Element https://leetcode.com/problems/remove-element/
// 跟上一题基本完全一样，两个指针，一个读一个写。
// 要注意在循环中更改数组本来是一件并不安全的事，不过在这两个例子里还好。首先长度没有改变，其次改变的部分都是读过的（废弃的）区域。总之要多想一下。
// 有一点就是 removeElement2 逻辑上基本是完全一样的，不过 removeElement 跑完全部 case 是 39 ms，removeElement2 是 22 ms。差了将近一倍，看样子 for in 还是有开销 >< 不过该用肯定还是要用的。
// 另外，https://leetcode.com/articles/remove-element/ 这里有一个如果需要换的元素很少时的解法，把每个不要的元素 swap 到末尾，可以减少很多写入。不过跑完全部 case 的时间是 48 ms，更多了有木有 >< 看来 case 并不符合需要去掉的元素很稀疏这个特点。
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
    
    func removeElement2(_ nums: inout [Int], _ val: Int) -> Int {
        var writeIndex = 0
        for readIndex in 0 ..< nums.count {
            if nums[readIndex] != val {
                nums[writeIndex] = nums[readIndex]
                writeIndex += 1
            }
        }
        return writeIndex
    }
    
    func removeElement3(_ nums: inout [Int], _ val: Int) -> Int {
        var numsEndIndex = nums.count - 1, readIndex = 0
        while readIndex <= numsEndIndex {
            if nums[readIndex] == val {
                nums[readIndex] = nums[numsEndIndex]
                numsEndIndex -= 1
            } else {
                readIndex += 1
            }
        }
        return numsEndIndex + 1
    }
}


var array = [1, 2, 3]
Solution().removeElement(&array, 1)
array
