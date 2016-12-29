// #16 3Sum Closest https://leetcode.com/problems/3sum-closest/
// 这时候就用上上一题的排序思路了。先排好序，然后指定第一个数从左往右，第二个为第一个数右边（剩下区间的最左端），第三个数为最右端。然后小了把左边的往右挪、大了把右边的往左挪……
// 时间复杂度：O(n^2) 空间复杂度：O(n)

class Solution {
    func threeSumClosest(_ nums: [Int], _ target: Int) -> Int {
        guard nums.count >= 3 else {
            return 0
        }
        
        var sortedNums = nums.sorted(by:{$0 < $1})
        var minDifference = Int.max
        
        for i in 0 ... sortedNums.count - 3 {
            if i > 0 && sortedNums[i] == sortedNums[i - 1] {
                continue
            }
            
            var left = i + 1
            var right = sortedNums.count - 1
            while left < right {
                let sum = sortedNums[i] + sortedNums[left] + sortedNums[right]
                let difference = target - sum
                if abs(difference) < abs(minDifference) {
                    minDifference = difference
                    if difference == 0 {
                        return target
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
        
        return target - minDifference
    }
}

Solution().threeSumClosest([-1, 2, 1, -4], 1)