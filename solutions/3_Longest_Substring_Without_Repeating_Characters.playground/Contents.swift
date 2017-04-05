// #3 Longest Substring Without Repeating Characters https://leetcode.com/problems/longest-substring-without-repeating-characters/
// 我用的方法是用一个 hash 记录每个字母出现的 index，然后把字符串扫一遍。不出现重复时就往 hash 表里填。出现重复时，从 hash 取出字母出现的 previousIndex ，把从当前串开头至 previousIndex 的字母都从 hash 中清掉。
// 看到一个更好的方法，不需要存字母出现的 index，出现重复时直接从当前串开头至出现重复字母的位置清掉 hash 即可。这种情况下也不需要用 Dictionary 存 hash，只需用 Set 即可。
// 本来 hash 需要的额外空间很小，但因为 swift 要遍历字符串中的字符必须把字符数组存出来一份。所以空间复杂度为 O(n)。
// 时间复杂度：O(n) 空间复杂度：O(n)

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
                
                for clearIndex in index - currentLength ..< previousIndex {
                    letterAppearedDict[chars[clearIndex]] = nil
                }
                letterAppearedDict[char] = index
                currentLength = index - previousIndex
            }
            
            maxLength = max(maxLength, currentLength)
        }
        
        
        return maxLength
    }
    
    func lengthOfLongestSubstring2(_ s: String) -> Int {
        
        var maxLength = 0
        var currentLength = 0
        
        var chars = [Character](s.characters)
        
        guard chars.count > 1 else {
            return chars.count
        }
        
        for index in 0 ..< chars.count - 1 {
            var letterAppearedSet = Set<Character>()
            var length = 1
            while length <= chars.count - index {
                let char = chars[index + length - 1]
                if letterAppearedSet.contains(char) { // 已经出现重复，后面不可能再有解了
                    break
                }
                letterAppearedSet.insert(char)
                
                maxLength = max(maxLength, length)
                length += 1
            }
        }
        
        return maxLength
    }
}

Solution().lengthOfLongestSubstring2("abcabcbb")
Solution().lengthOfLongestSubstring("bbbbb")
Solution().lengthOfLongestSubstring("pwwkew")
Solution().lengthOfLongestSubstring("")
