// #7 Reverse Integer https://leetcode.com/problems/reverse-integer/

class Solution {
    func reverse(_ x: Int) -> Int {
        var isBelowZero = 1
        var num = x
        if x < 0 {
            isBelowZero = -1
            num = -x
        }
        
        var result = 0
        while num > 0 {
            if result > (Int(Int32.max) - num % 10) / 10 {
                return 0
            }
            result = result * 10 + num % 10
            num = num / 10
        }
        
        return result * isBelowZero
    }
}

Solution().reverse(1534236469)
