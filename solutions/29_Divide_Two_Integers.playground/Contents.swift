// #29 Divide Two Integers https://leetcode.com/problems/divide-two-integers/

class Solution {
    func divide(_ dividend: Int, _ divisor: Int) -> Int {
        guard divisor != 0 else {
            return Int(Int32.max)
        }
        
        let sign = divisor > 0 && dividend > 0 || divisor < 0 && dividend < 0 ? 1 : -1
        
        var target = dividend
        var result = 0
        while (sign > 0 && result <= Int(Int32.max - sign)) || (sign < 0 && result >= Int(Int32.min - sign)) {
            target = sign > 0 ? target - divisor : target + divisor
            if ((target > 0 && dividend <= 0) || (target < 0 && dividend >= 0)) {
                break
            }
            
            result += sign
        }
        
        return result
    }
}

Solution().divide(0, -1)
