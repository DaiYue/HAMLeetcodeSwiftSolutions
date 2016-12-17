// #9 Palindrome Number https://leetcode.com/problems/palindrome-number/

class Solution {
    func isPalindrome(_ x: Int) -> Bool {
        guard x >= 0 else {
            return false
        }
        
        var divider = 1
        while divider * 10 <= x {
            divider *= 10
        }
        
        var target = x
        while divider >= 10 {
            if target / divider != target % 10 {
                return false
            }
            
            target = (target % divider) / 10
            divider = divider / 100
        }
        
        return true
    }
}

Solution().isPalindrome(11)