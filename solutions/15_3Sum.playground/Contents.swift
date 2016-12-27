// #15 3Sum https://leetcode.com/problems/3sum/
// 我用的还是 hash 方法，先找第一个数、再找第二个数…… 去重的方法就是要求三个数的序关系，这样就不会重了。
// 看到一个题解用的是先排序，然后先定第一个数，第二个数左头，第三个数右头。然后大了挪小的、小了挪大的…… 这样。算是另一种思路吧。
// 时间复杂度：O(n^2) 空间复杂度：O(n)

class Solution {
    func threeSum(_ nums: [Int]) -> [[Int]] {
        var numDict : [Int:Int] = [:]
        for i in nums {
            if numDict[i] == nil {
                numDict[i] = 1
            } else {
                numDict[i] = numDict[i]! + 1
            }
        }
        
        var results : [[Int]] = []
        for (num1, count1) in numDict {
            numDict[num1] = count1 - 1
            
            for (num2, count2) in numDict {
                let num3 = 0 - num1 - num2
                guard count2 > 0 && num1 <= num2 && num2 <= num3 else {
                    continue
                }
                
                if (num2 == num3 && count2 >= 2) || (num2 != num3 && numDict[num3] != nil) {
                    results.append([num1, num2, num3])
                }
            }
            
            numDict[num1] = count1
        }
        
        return results
    }
}

Solution().threeSum([-1, 0, 1, 2, -1, -4])
Solution().threeSum([1,2,-2,-1])
Solution().threeSum([0, 0, 0])
