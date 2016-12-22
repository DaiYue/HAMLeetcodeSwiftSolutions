// #10 Regular Expression Matching https://leetcode.com/problems/regular-expression-matching/

class Solution {
    func isMatch(_ s: String, _ p: String) -> Bool {
        let sChars = [Character](s.characters)
        let pChars = [Character](p.characters)
        return isMatch(sChars: sChars, pChars: pChars)
    }
    
    func isMatch(sChars : [Character], pChars : [Character]) -> Bool {
        
        guard pChars.count > 0 else {
            if sChars.count == 0 {
                return true
            } else {
                return false
            }
        }
        
        let pChar = pChars[0] // pChar chould be .
        let sChar = sChars.count > 0 ? sChars[0] : nil
        let nextS = dropFirstSafe(chars: sChars, count: 1)
        var isStar = false
        if pChars.count > 1 {
            if pChars[1] == "*" {
                isStar = true
            }
        }
        let nextP = dropFirstSafe(chars: pChars, count:(isStar ? 2 : 1))
        
        let match = (pChar == "." && sChar != nil) || pChar == sChar
        
        if isStar {
            if match {
                if isMatch(sChars:nextS, pChars:nextP) || isMatch(sChars:nextS, pChars:pChars) {
                    return true
                }
            }
            return isMatch(sChars:sChars, pChars:nextP)
        } else {
            if match {
                return isMatch(sChars:nextS, pChars:nextP)
            } else {
                return false
            }
        }
    }
    
    func dropFirstSafe(chars:[Character], count:Int) -> [Character] {
        if count >= chars.count {
            return []
        }
        return Array(chars.dropFirst(count))
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
Solution().isMatch("aaaaaaaaaaaaab", "a*a*a*a*a*a*a*a*a*a*c")
