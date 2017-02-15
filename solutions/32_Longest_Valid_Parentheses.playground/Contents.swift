// #32 Longest Valid Parentheses https://leetcode.com/problems/longest-valid-parentheses/
// 我想到的这个做法是需要扫两遍的，先从头到尾记录深度，如果深度到 0 就记录当前长度，< 0 就把起始位置跳到当前位置后面。扫到最后，如果深度还 > 0，再从后往前倒着扫一遍。看了下题解，代码写法几乎除了命名之外完全一致 ><
// 还有另一个做法是只需要扫一遍的，就是需要把所有左括号的位置记到一个栈里。每次遇到右括号的时候出栈，如果栈空就记从起始位置的长度（例如 ()() 长度为4），不空就记从栈顶开始的长度（例如 ()((()) 记为4）。
// 时间复杂度：O(n) 空间复杂度：O(1)

class Solution {
    func longestValidParentheses(_ s: String) -> Int {
        let sChars = [Character](s.characters)
        guard sChars.count >= 2 else {
            return 0
        }
        
        var maxLength = 0, startIndex = 0, depth = 0
        for (index, char) in sChars.enumerated() {
            if char == "(" {
                depth += 1
            } else if char == ")" {
                depth -= 1
            }
            if depth < 0 {
                startIndex = index + 1
                depth = 0
            } else if depth == 0 {
                maxLength = max(maxLength, index - startIndex + 1)
            }
        }
        
        if depth <= 0 {
            return maxLength
        }
        
        depth = 0
        startIndex = sChars.count - 1
        for (index, char) in sChars.enumerated().reversed() {
            if char == ")" {
                depth += 1
            } else if char == "(" {
                depth -= 1
            }
            if depth < 0 {
                startIndex = index - 1
                depth = 0
            } else if depth == 0 {
                maxLength = max(maxLength, startIndex - index + 1)
            }
        }
        
        return maxLength
    }
}

Solution().longestValidParentheses(")(((((()())()()))()(()))")