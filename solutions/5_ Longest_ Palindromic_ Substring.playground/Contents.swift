//: Playground - noun: a place where people can play

class Solution {
    func longestPalindrome(_ s: String) -> String {
        
        var isPalidromeMatrix = [[Bool]]()
        let length = s.characters.count
        for _ in 0 ..< length {
            let array = Array(repeating: false, count : length)
            isPalidromeMatrix.append(array)
        }
        
        let chars = [Character](s.characters)
        var longestPalindrome = ""
        
        for palidromeLength in 1 ... length {
            for startIndex in 0 ..< length {
                let endIndex = startIndex + palidromeLength - 1
                
                guard endIndex <= length - 1 else {
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