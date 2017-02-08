// #29 Divide Two Integers https://leetcode.com/problems/divide-two-integers/
// 别看这道题题目很简单，实际写起来非常麻烦…… 看到的很多题解都是不规范的，因为 Int32.min 不管是负一下还是取一下 abs 都会溢出…… 往往只是借用了更大的 Int 才不会溢出的 =  = 或者像我一样偷懒，单判一下 Int32.min …… 不然 if 条件不知道要写的多复杂
// 坑的是不让用乘除法，我就默认 << >> 也都不能用了，所以每次循环的时候，硬是把除数加到被除数的最大值。还好每次加的时候是翻倍加，所以能快一点。朴素地把被除数减除数、一个一个往下减的方法是会超时的。如果能用 << >> 就好多了，先 << 到最大，减到不能减了再 >> 1 接着减即可。
// 时间复杂度：O((lgn)^2) 空间复杂度：O(1)

class Solution {
    func divide(_ dividend: Int, _ divisor: Int) -> Int {
        guard divisor != 0 else {
            return Int(Int32.max)
        }
        guard divisor > Int(Int32.min) else {
            return dividend == Int(Int32.min) ? 1 : 0
        }
        
        let sign = divisor > 0 && dividend > 0 || divisor < 0 && dividend < 0 ? 1 : -1
        let divisor = sign == 1 ? divisor : -divisor
        
        var remainDividend = dividend
        var result = 0
        while ((dividend > 0 && remainDividend >= divisor) || (dividend < 0 && remainDividend <= divisor)) {
            var target = divisor
            var times = sign
            while (remainDividend > 0 && target < remainDividend - target) || (remainDividend < 0 && target > remainDividend - target) {
                target = target + target
                times = times + times
            }
            
            remainDividend -= target
            if sign > 0 && result >= Int(Int32.max - times) {
                return Int(Int32.max)
            } else if sign < 0 && result <= Int(Int32.min - times) {
                return Int(Int32.min)
            }
            result += times
        }
        
        return result
    }
}

Solution().divide(1, -1)
