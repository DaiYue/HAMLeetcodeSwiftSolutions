//: Playground - noun: a place where people can play

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
                
                [num1, num2, num3]
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
