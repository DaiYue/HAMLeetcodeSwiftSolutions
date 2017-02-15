// #33 Search in Rotated Sorted Array https://leetcode.com/problems/search-in-rotated-sorted-array/

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

Solution().search([4,5,6,7,0,1,2], 5)