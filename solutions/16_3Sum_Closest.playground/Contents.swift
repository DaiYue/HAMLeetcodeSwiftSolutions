// #16 3Sum Closest https://leetcode.com/problems/3sum-closest/
//

class Solution {
    func threeSumClosest(_ nums: [Int], _ target: Int) -> Int {
        guard nums.count > 1 else {
            return nums.count == 0 ? 0 : nums[0]
        }
        
        var sortedNums = nums.sorted(by:{$0 < $1})
        var minDifference = Int.max
        var closestSum = 0
        
        for i in 0 ... sortedNums.count - 3 {
            if i > 0 && sortedNums[i] == sortedNums[i - 1] {
                continue
            }
            
            var left = i + 1
            var right = sortedNums.count - 1
            while left < right {
                let sum = sortedNums[i] + sortedNums[left] + sortedNums[right]
                let difference = abs(target - sum)
                if difference < minDifference {
                    minDifference = difference
                    closestSum = sum
                    if difference == 0 {
                        break
                    }
                }
                
                if sum < target {
                    repeat {
                        left += 1
                    } while (left < right && sortedNums[left] == sortedNums[left - 1])
                } else {
                    repeat {
                        right -= 1
                    } while (left < right && sortedNums[right] == sortedNums[right + 1])
                }
            }
        }
        
        return closestSum
    }
}

Solution().threeSumClosest([-1, 2, 1, -4], 1)