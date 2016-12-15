// #5 Longest palindromic Substring https://leetcode.com/problems/longest-palindromic-substring/
// 这个解法是 O(n^2) 的。之所以写法很不简洁，多出了许多临时变量，完全是 swift 的锅。谨记 swift 字符串的特性，由于每一位字符长度不一定相等，它是不能随机访问的。也就是说，如果不存临时变量，取某一位的字符、取字符串的长度、截取子串，全部都是 n 级别的…… 所以一再超时。
// 最坑的是，我之前写作 isPalidromeMatrix[startIndex][endIndex] = ... 这样就会超时，而
// if (...) {isPalidromeMatrix[startIndex][endIndex] = true} 这样就不会。只不过多赋值了一些 false……
// 而且把 if isPalidrome 改成 if isPalidromeMatrix[startIndex][endIndex] ，时间会长一倍。感觉数据量稍微一大，swift 性能问题真的挺严重。
// 这个题是有一个 O(n) 的算法的。首先有暴搜的思路，就是以任何一位为中心往外扩展。O(n) 的算法是在这个基础上，利用回文串的特性，存在一个子串那么中心点两侧对称，在此基础上再往外搜即可。具体可见：https://www.felix021.com/blog/read.php?2040

class Solution {
    func longestPalindrome(_ s: String) -> String {
        
        let chars = [Character](s.characters)
        let length = chars.count
        guard length > 0 else {
            return ""
        }
        
        var isPalidromeMatrix = Array(repeating: Array(repeating: false, count : length), count : length)
        
        var maxLength = 0
        var maxStartIndex = 0
        
        for palidromeLength in 1 ... length {
            for startIndex in 0 ... length - palidromeLength {
                let endIndex = startIndex + palidromeLength - 1
                var isPalidrome = false
                
                if palidromeLength == 1 {
                    isPalidrome = true
                } else if palidromeLength == 2 {
                    isPalidrome = chars[startIndex] == chars[endIndex]
                } else {
                    isPalidrome = chars[startIndex] == chars[endIndex] && isPalidromeMatrix[startIndex + 1][endIndex - 1]
                }
                
                if isPalidrome {
                    isPalidromeMatrix[startIndex][endIndex] = true
                    
                    if palidromeLength > maxLength {
                        maxStartIndex = startIndex
                        maxLength = palidromeLength
                    }
                }
            }
        }
        
        return String(chars[maxStartIndex...maxStartIndex + maxLength - 1])
    }
}

Solution().longestPalindrome("000")
