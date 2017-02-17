// #34 Search for a Range https://leetcode.com/problems/search-for-a-range/
// 仍然是简单的二分查找，只是分别找左界和右界。代码行数略多……
// 时间复杂度：O(lgn) 空间复杂度：O(1)

class Solution {
    func searchRange(_ nums: [Int], _ target: Int) -> [Int] {
        guard nums.count > 0 else {
            return [-1, -1]
        }
        
        // search for lower bound
        var lowerBound = -1
        if nums[0] == target {
            lowerBound = 0
        } else if nums.last == target && nums[nums.count - 2] < target {
            return [nums.count - 1, nums.count - 1]
        } else {
            var left = 0, right = nums.count - 1
            var index = (left + right) / 2
            
            while right - left > 1 && index >= 1 {
                if nums[index] == target && nums[index - 1] < target {
                    lowerBound = index
                    break
                }
                
                if nums[index] < target {
                    left = index
                } else {
                    right = index
                }
                
                index = (left + right) / 2
            }
            
            if lowerBound == -1 {
                return [-1, -1]
            }
        }
        
        // search for upper bound
        var upperBound = -1
        if nums.last == target {
            upperBound = nums.count - 1
        } else if nums[lowerBound + 1] > target {
            upperBound = lowerBound
        } else {
            var left = lowerBound, right = nums.count - 1
            var index = (left + right) / 2
            
            while right - left > 1 && index <= nums.count - 2 {
                if nums[index] == target && nums[index + 1] > target {
                    upperBound = index
                    break
                }
                
                if nums[index] > target {
                    right = index
                } else {
                    left = index
                }
                
                index = (left + right) / 2
            }
        }
        return [lowerBound, upperBound]
    }
}

Solution().searchRange([1, 4], 4)
