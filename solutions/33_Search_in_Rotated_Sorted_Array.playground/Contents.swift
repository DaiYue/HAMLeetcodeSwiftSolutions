// #33 Search in Rotated Sorted Array https://leetcode.com/problems/search-in-rotated-sorted-array/
// 比较简单的二分查找，就是在判界限的时候分几种情况讨论。跟 nums[0] 比可知要找的数应该是在上升半区还是下降半区，这样。然后就分情况讨论吧…… 上面的代码是简化过的，下面是完整版的代码，更能看出分类的具体情况。
// 时间复杂度：O(lgn) 空间复杂度：O(1)

class Solution {
    func search(_ nums: [Int], _ target: Int) -> Int {
        guard nums.count > 0 else {
            return -1
        }
        var left = 0, right = nums.count - 1
        if target == nums[right] {
            return right
        }
        if target == nums[0] {
            return 0
        } else {
            // search in second half
            var i = (left + right) / 2
            while nums[i] != target { // target < nums[0]
                if target < nums[0] {
                    if nums[i] > nums[0] || nums[i] < target {
                        left = i
                    } else {
                        right = i
                    }
                } else {
                    if nums[i] > target || nums[i] < nums[0] {
                        right = i
                    } else {
                        left = i
                    }
                }
                
                if right - left <= 1 {
                    break
                }
                i = (left + right) / 2
            }
            return nums[i] == target ? i : -1
        }
    }
    
    func search_full(_ nums: [Int], _ target: Int) -> Int {
        guard nums.count > 0 else {
            return -1
        }
        var left = 0, right = nums.count - 1
        if target == nums[right] {
            return right
        }
        if target == nums[0] {
            return 0
        } else if target < nums[0] {
            // search in second half
            var i = (left + right) / 2
            while nums[i] != target {
                if nums[i] > target {
                    if nums[i] < nums[0] {
                        right = i
                    } else {
                        left = i
                    }
                } else {
                    if nums[i] < nums[0] {
                        left = i
                    } else {
                        right = i
                    }
                }
                if right - left <= 1 {
                    break
                }
                i = (left + right) / 2
            }
            return nums[i] == target ? i : -1
        } else {
            // search in first half
            var i = (left + right) / 2
            while nums[i] != target {
                if nums[i] > target {
                    if nums[i] < nums[0] {
                        left = i
                    } else {
                        right = i
                    }
                } else {
                    if nums[i] < nums[0] {
                        right = i
                    } else {
                        left = i
                    }
                }
                if right - left <= 1 {
                    break
                }
                i = (left + right) / 2
            }
            return nums[i] == target ? i : -1
        }
    }
}

Solution().search([4,5,6,7,0,1,2], 1)