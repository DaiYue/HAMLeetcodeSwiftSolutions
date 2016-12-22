// #10 Regular Expression Matching https://leetcode.com/problems/regular-expression-matching/

struct Token {
    var char:Character
    var isStar:Bool
}

class Solution {
    func isMatch(_ s: String, _ p: String) -> Bool {
        let sChars = [Character](s.characters)
        let tokens = generateTokensFrom(pattern: p)
        
        return isMatch(sChars: sChars, tokens: tokens)
    }
    
    func generateTokensFrom(pattern:String) -> [Token] {
        let chars = [Character](pattern.characters)
        
        guard chars.count > 0 else {
            return []
        }
        
        var tokens = [Token]()
        var lastToken:Token? = nil
        var index = 0
        while index <= chars.count - 2 {
            let char = chars[index]
            let nextChar = chars[index + 1]
            
            if nextChar == "*" {
                if lastToken != nil && lastToken?.isStar == true {
                    if lastToken!.char == char || lastToken!.char == "." {
                        // merge
                        index = index + 2;
                        continue
                    }
                    if char == "." {
                        while lastToken?.isStar == true {
                            // discard
                            lastToken = tokens.popLast()
                        }
                        if lastToken != nil && lastToken?.isStar == false {
                            tokens.append(lastToken!)
                        }
                    }
                }
                lastToken = Token(char: char, isStar: true)
                index = index + 2
                
            } else {
                lastToken = Token(char: char, isStar: false)
                index = index + 1
            }
            tokens.append(lastToken!)
        }
        if index <= chars.count - 1 {
            tokens.append(Token(char: chars[index], isStar: false))
        }
        
        return tokens
    }
    
    func isMatch(sChars : [Character], tokens : [Token]) -> Bool {
        
        guard tokens.count > 0 else {
            if sChars.count == 0 {
                return true
            }
            return false
        }
        
        let token = tokens[0]
        let sChar = sChars.count > 0 ? sChars[0] : nil
        let nextS = dropFirstSafe(array: sChars) as! [Character]
        let nextTokens = dropFirstSafe(array: tokens) as! [Token]
        
        let match = (token.char == "." && sChar != nil) || token.char == sChar
        
        if token.isStar {
            if match && (isMatch(sChars:nextS, tokens:nextTokens) || isMatch(sChars:nextS, tokens:tokens)) {
                return true
            }
            return isMatch(sChars:sChars, tokens:nextTokens)
            
        } else {
            if match {
                return isMatch(sChars:nextS, tokens:nextTokens)
            }
            return false
        }
    }
    
    func dropFirstSafe(array:[Any]) -> [Any] {
        if array.count <= 1 {
            return []
        }
        return Array(array.dropFirst())
    }
}

Solution().isMatch("aa", "a")
Solution().isMatch("aa", "aa")
//Solution().isMatch("aaa", "aa")
//Solution().isMatch("aa", "a*")
//Solution().isMatch("aa", ".*")
//Solution().isMatch("ab", ".*")
//Solution().isMatch("aab", "c*a*b")
//Solution().isMatch("a", "ab*")
Solution().isMatch("bbacbcabbbbbcacabb", "aa*c*b*a*.*a*a.*.")
