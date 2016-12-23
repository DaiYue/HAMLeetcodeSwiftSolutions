// #10 Regular Expression Matching https://leetcode.com/problems/regular-expression-matching/
// 评级为 hard，但感觉这题不难…… 一个问题就是直接递归会超时。需要先把正则式处理一下：a*a* 合并为 a*，a*.*b* 合并为 .*（就是 .* 前后所有的 x* 全都去掉）。

struct Token {
    var char:Character
    var isStar:Bool
}

class Solution {
    func isMatch(_ s: String, _ p: String) -> Bool {
        return isMatch(sChars: [Character](s.characters), tokens: generateTokensFrom(pattern: p))
    }
    
    func generateTokensFrom(pattern:String) -> [Token] {
        let chars = [Character](pattern.characters)
        var tokens = [Token]()
        var index = 0
        while index < chars.count {
            let char = chars[index]
            let nextChar = index + 1 < chars.count ? chars[index + 1] : " "
            
            if nextChar == "*" {
                index = index + 2
                let lastToken = tokens.count > 0 ? tokens.last! : Token(char: " ", isStar: false)
                if lastToken.isStar == true && (lastToken.char == char || lastToken.char == ".") {
                    continue // ignore x* after x* or .*
                }
                if char == "." {
                    while tokens.count > 0 && tokens.last?.isStar == true {
                        tokens.popLast() // remove every x* before .*
                    }
                }
                tokens.append(Token(char: char, isStar: true))
            } else {
                index = index + 1
                tokens.append(Token(char: char, isStar: false))
            }
        }
        
        return tokens
    }
    
    func isMatch(sChars : [Character], tokens : [Token]) -> Bool {
        guard tokens.count > 0 else {
            return sChars.count == 0 ? true : false
        }
        
        guard sChars.count > 0 else {
            for token in tokens {
                if !token.isStar {
                    return false
                }
            }
            return true
        }
        
        let token = tokens[0]
        let sChar = sChars[0]
        let nextS = Array(sChars.dropFirst())
        let nextTokens = Array(tokens.dropFirst())
        
        let match = token.char == "." || token.char == sChar
        if token.isStar {
            if match && (isMatch(sChars:nextS, tokens:nextTokens) || isMatch(sChars:nextS, tokens:tokens)) {
                return true
            }
            return isMatch(sChars:sChars, tokens:nextTokens)
        } else {
            return match && isMatch(sChars:nextS, tokens:nextTokens)
        }
    }
}

Solution().isMatch("aa", "a")
Solution().isMatch("aa", "aa")
Solution().isMatch("aaa", "aa")
Solution().isMatch("aa", "a*")
Solution().isMatch("aa", ".*")
Solution().isMatch("ab", ".*")
Solution().isMatch("aab", "c*a*b")
Solution().isMatch("a", "ab*")
Solution().isMatch("bbacbcabbbbbcacabb", "aa*c*b*a*.*a*a.*.")
