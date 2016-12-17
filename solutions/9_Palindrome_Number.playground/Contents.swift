// #9 Palindrome Number https://leetcode.com/problems/palindrome-number/

class Solution {
    func isPalindrome(_ x: Int) -> Bool {
        if x < 0 {
            return false
        }
        
        var divider = 1
        while divider * 10 <= x {
            divider *= 10
        }
        
        return isPalindrome(target: x, divider: divider)
    }
    
    func isPalindrome(target:Int, divider:Int) -> Bool {
        if divider <= 1 {
            return true
        }
        
        if target / divider != target % 10 {
            return false
        }
        
        let nextTarget = (target % divider) / 10
        return isPalindrome(target: nextTarget, divider: divider / 100)
    }
}

Solution().isPalindrome(11)