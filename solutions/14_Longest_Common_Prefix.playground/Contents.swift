// #14 Longest Common Prefix https://leetcode.com/problems/longest-common-prefix/


class Solution {
    func longestCommonPrefix(_ strs: [String]) -> String {
        guard strs.count > 0 else {
            return ""
        }
        
        var charss : [[Character]] = []
        for string in strs {
            charss.append([Character](string.characters))
        }
        
        var maxPrefixLength = 1
        let firstChars = charss[0]
        while maxPrefixLength <= firstChars.count {
            let firstChar = firstChars[maxPrefixLength - 1]
            for chars in charss {
                if maxPrefixLength > chars.count || chars[maxPrefixLength - 1] != firstChar {
                    return String(firstChars[0 ..< maxPrefixLength - 1])
                }
            }
            maxPrefixLength += 1
        }
        
        return String(firstChars[0 ..< maxPrefixLength - 1])
    }
}

Solution().longestCommonPrefix(["aa", "aa"])
