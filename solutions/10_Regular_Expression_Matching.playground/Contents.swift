// #10 Regular Expression Matching https://leetcode.com/problems/regular-expression-matching/

class Solution {
    func isMatch(_ s: String, _ p: String) -> Bool {
        s
        p
        
        let sChars = [Character](s.characters)
        let pChars = [Character](p.characters)
        
        guard pChars.count > 0 else {
            if sChars.count == 0 {
                return true
            } else {
                return false
            }
        }
        
        let pChar = pChars[0] // pChar chould be .
        let sChar = sChars.count > 0 ? sChars[0] : nil
        let nextS = subString(chars: sChars, fromIndex: 1)
        var isStar = false
        if pChars.count > 1 {
            if pChars[1] == "*" {
                isStar = true
            }
        }
        let nextP = subString(chars: pChars, fromIndex:(isStar ? 2 : 1))
        
        let match = (pChar == "." && sChar != nil) || pChar == sChar
        
        if isStar {
            if match {
                if isMatch(nextS, nextP) || isMatch(nextS, p) {
                    return true
                }
            }
            return isMatch(s, nextP)
        } else {
            if match {
                return isMatch(nextS, nextP)
            } else {
                return false
            }
        }
    }
    
    func subString(chars:[Character], fromIndex:Int) -> String {
        if fromIndex >= chars.count {
            return ""
        }
        return String(chars[fromIndex..<chars.count])
    }
}

//Solution().isMatch("aa", "a")
//Solution().isMatch("aa", "aa")
//Solution().isMatch("aaa", "aa")
//Solution().isMatch("aa", "a*")
//Solution().isMatch("aa", ".*")
//Solution().isMatch("ab", ".*")
//Solution().isMatch("aab", "c*a*b")
//Solution().isMatch("a", "ab*")
Solution().isMatch("ab", ".*c")
