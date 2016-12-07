//: Playground - noun: a place where people can play

class Solution {
    func lengthOfLongestSubstring(_ s: String) -> Int {
        
        var letterAppearedDict = [Character:Int]()
        var maxLength = 0
        var currentLength = 0
        
        var chars = [Character](s.characters)
    
        for index in 0 ..< chars.count {
            let char = chars[index]
            if letterAppearedDict[char] == nil {
                letterAppearedDict[char] = index
                currentLength += 1
            } else {
                let previousIndex = letterAppearedDict[char]!
                
                for clearIndex in index - currentLength..<previousIndex {
                    letterAppearedDict[chars[clearIndex]] = nil
                }
                letterAppearedDict[char] = index
                currentLength = index - previousIndex
            }
            
            maxLength = max(maxLength, currentLength)
        }
        
        
        return maxLength
    }
}

Solution().lengthOfLongestSubstring("abcabcbb")
Solution().lengthOfLongestSubstring("bbbbb")
Solution().lengthOfLongestSubstring("pwwkew")
Solution().lengthOfLongestSubstring("")