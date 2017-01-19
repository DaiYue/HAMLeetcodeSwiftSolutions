// #22 Generate Parentheses https://leetcode.com/problems/generate-parentheses/
// 我用的方法是从短到长构建，记录每个串的括号深度（每有一个左括号深度 +1，右括号深度 -1）。长度每增加 1，就在之前的每个串基础上往后拼“(”、")"并剪去深度低于 0 的情况（如 "())"）。最后在所有长度为 2n 的串里找深度为 0 的就行了。
// 看到题解用的也是从短到长构建，是一对一对括号往上加的，每一轮往任意位置插“()”。不过这样会出现很多重复，因此用 Set 排重。这样的方法要比我的方法慢不少，不过还是可以过的。
// 因为结果集实在是很大，是指数级的，所以 case 很小，不过 8 个 case。
// 时间复杂度: O(2^n) 空间复杂度：O(2^n)

class ParenthesisPrefix {
    let content: String
    let depth: Int
    
    init(content: String, depth: Int) {
        self.content = content
        self.depth = depth
    }
}


class Solution {
    func generateParenthesis(_ n: Int) -> [String] {
        guard n >= 1 else {
            return []
        }
        var prefixes = [ParenthesisPrefix(content: "(", depth: 1)]
        for _ in 2 ... n * 2 {
            var nextPrefixes : [ParenthesisPrefix] = []
            for prefix in prefixes {
                nextPrefixes.append(ParenthesisPrefix(content: prefix.content + "(", depth: prefix.depth + 1))
                if prefix.depth > 0 {
                    nextPrefixes.append(ParenthesisPrefix(content: prefix.content + ")", depth: prefix.depth - 1))
                }
            }
            prefixes = nextPrefixes
        }
        var validParenthesis : [String] = []
        for parenthesisPrefix in prefixes {
            if parenthesisPrefix.depth == 0 {
                validParenthesis.append(parenthesisPrefix.content)
            }
        }
        
        return validParenthesis
    }
}

Solution().generateParenthesis(3)
