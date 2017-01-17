// #20 Valid Parentheses https://leetcode.com/problems/valid-parentheses/
// 大概是栈的最简单的一道题了。如果是左括号，push；是右括号，pop，如果不匹配返回 false。结束后如果栈空则返回 true，否则返回 false。
// 时间复杂度：O(n) 空间复杂度：O(n)

class Solution {
    func isValid(_ s: String) -> Bool {
        let chars = [Character](s.characters)
        
        var stack: [Character] = []
        for char in chars {
            if char == "(" || char == "[" || char == "{" {
                stack.append(char)
            } else if char == ")" || char == "]" || char == "}" {
                if isMatch(stack.last, c2: char) {
                    stack.removeLast()
                } else {
                    return false
                }
            }
        }
        
        return stack.count == 0
    }
    
    func isMatch(_ c1: Character?, c2:Character?) -> Bool {
        return c1 == "(" && c2 == ")" || c1 == "[" && c2 == "]" || c1 == "{" && c2 == "}"
    }
}

Solution().isValid("()")
Solution().isValid("()[]{}")
Solution().isValid("(]")
Solution().isValid("([)]")
