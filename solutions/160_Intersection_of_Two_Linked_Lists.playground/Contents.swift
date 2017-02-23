// #202 Happy Number https://leetcode.com/problems/happy-number/?tab=Description


class Solution {
    func isHappy(_ n: Int) -> Bool {
        var numSet = Set<Int>()
        var num = n
        while !numSet.contains(num) && num != 1 {
            numSet.insert(num)
            
            var sum = 0
            while num > 0 {
                let lastDigit = num % 10
                sum += lastDigit * lastDigit
                num /= 10
            }
            
            num = sum
        }
        
        return num == 1
    }
}

Solution().isHappy(18)