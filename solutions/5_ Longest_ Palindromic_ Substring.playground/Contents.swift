//: Playground - noun: a place where people can play

class Solution {
    func longestPalindrome(_ s: String) -> String {
        
        var isPalidromeMatrix = [[Bool]]()
        for _ in 0 ..< s.characters.count {
            let array = Array(repeating: false, count : s.characters.count)
            isPalidromeMatrix.append(array)
        }
        
        let chars = [Character](s.characters)
        var longestPalindrome = ""
        
        for palidromeLength in 1 ... s.characters.count {
            for startIndex in 0 ..< s.characters.count {
                let endIndex = startIndex + palidromeLength - 1
                
                guard endIndex <= s.characters.count - 1 else {
                    break
                }
                
                if palidromeLength == 1 {
                    isPalidromeMatrix[startIndex][endIndex] = true
                } else if palidromeLength == 2 {
                    isPalidromeMatrix[startIndex][endIndex] = chars[startIndex] == chars[endIndex]
                } else {
                    isPalidromeMatrix[startIndex][endIndex] = chars[startIndex] == chars[endIndex] && isPalidromeMatrix[startIndex + 1][endIndex - 1]
                }
                
                if isPalidromeMatrix[startIndex][endIndex] && palidromeLength > longestPalindrome.characters.count {
                    longestPalindrome = String(chars[startIndex...endIndex])
                }
            }
        }
        
        return longestPalindrome
    }
}

Solution().longestPalindrome("cacbc")