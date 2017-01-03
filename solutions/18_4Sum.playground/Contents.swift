// #18 4Sum https://leetcode.com/problems/4sum/
// 在 3Sum 基础上的延伸，先排序，再循环前两位，后两位左右夹逼。听说这样会超时？然而并没有，时间还在中位数左右。500多ms
// 一些简单的剪枝，比如夹逼时最小的两个数都不够小、最大的两个数都不够大，那也就没必要继续了。加了这些剪枝，虽然代码长了很多很多，但是嗖快嗖快的，只要 52 ms。一下 beats 100% submissions，好有成就感呀。
// 时间复杂度：O(n^3) 空间复杂度：O(n)

class Solution {
    func fourSum(_ nums: [Int], _ target: Int) -> [[Int]] {
        guard nums.count >= 4 else {
            return []
        }
        
        var sortedNums = nums.sorted(by:{$0 < $1})
        var result : [[Int]] = []
        
        for i in 0 ... sortedNums.count - 4 {
            if i > 0 && sortedNums[i] == sortedNums[i - 1] {
                continue
            }
            
            // pruning
            let minSum = sortedNums[i] + sortedNums[i + 1] + sortedNums[i + 2] + sortedNums[i + 3]
            if minSum > target {
                break
            } else if minSum == target {
                result.append([sortedNums[i], sortedNums[i + 1], sortedNums[i + 2], sortedNums[i + 3]])
                break
            }
            
            let maxSum = sortedNums[i] + sortedNums[sortedNums.count - 1] + sortedNums[sortedNums.count - 2] + sortedNums[sortedNums.count - 3]
            if maxSum < target {
                continue
            } else if maxSum == target {
                result.append([sortedNums[i], sortedNums[sortedNums.count - 1], sortedNums[sortedNums.count - 2], sortedNums[sortedNums.count - 3]])
                continue
            }
            
            for j in i + 1 ... sortedNums.count - 3 {
                if j > i + 1 && sortedNums[j] == sortedNums[j - 1] {
                    continue
                }
                
                let partialTarget = target - sortedNums[i] - sortedNums[j]
                
                // pruning
                let minSum = sortedNums[j + 1] + sortedNums[j + 2]
                if minSum > partialTarget {
                    break
                } else if minSum == partialTarget {
                    result.append([sortedNums[i], sortedNums[j], sortedNums[j + 1], sortedNums[j + 2]])
                    break
                }
                
                let maxSum = sortedNums[sortedNums.count - 1] + sortedNums[sortedNums.count - 2]
                if maxSum < partialTarget {
                    continue
                } else if maxSum == partialTarget {
                    result.append([sortedNums[i], sortedNums[j], sortedNums[sortedNums.count - 1], sortedNums[sortedNums.count - 2]])
                    continue
                }
                
                var left = j + 1
                var right = sortedNums.count - 1
                
                while left < right {
                    let sum = sortedNums[left] + sortedNums[right]
                    if sum == partialTarget {
                        result.append([sortedNums[i], sortedNums[j], sortedNums[left], sortedNums[right]])
                    }
                    
                    if sum < partialTarget {
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
        }
        
        return result
    }
}

Solution().fourSum([1, 0, -1, 0, -2, 2], 0)