// #9 Palindrome Number https://leetcode.com/problems/palindrome-number/
// 很简单的题，没给出的条件是负数不算回文数。有个 case 1000021 一开始做错了。另外一开始写了个递归，后来发现没必要……
// 时间复杂度：O(n) 空间复杂度：O(1)

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
