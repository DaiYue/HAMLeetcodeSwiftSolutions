// #68 Text Justification https://leetcode.com/problems/text-justification/?tab=Description
// 这道题写起来真是太长了，太麻烦了…… >w< 再重复一遍，太麻烦了！还好不涉及什么复杂算法，就是一个 buffer，满了之后往结果里吐就行了。
// 时间复杂度：O(n) 空间复杂度：O(n)

class Solution {
    
    func fullJustify(_ words: [String], _ maxWidth: Int) -> [String] {
        
        var result = [String]()
        var buffer = [String]()
        var bufferLength = 0
        var wordIndex = 0
        while wordIndex < words.count {
            let word = words[wordIndex]
            let wordLength = word.characters.count
            
            if bufferLength + wordLength + 1 < maxWidth {
                bufferLength += wordLength + 1
                buffer.append(word)
                wordIndex += 1
                
            } else if bufferLength + wordLength <= maxWidth {
                buffer.append(word)
                
                if wordIndex == words.count - 1 {
                    break // last line
                } else {
                    result.append(lineFromBuffer(buffer, maxWidth:maxWidth))
                }
            
                buffer = []
                bufferLength = 0
                wordIndex += 1
                
            } else {
                result.append(lineFromBuffer(buffer, maxWidth:maxWidth))
                
                buffer = []
                bufferLength = 0
            }
        }
        if buffer.count > 0 {
            result.append(lastLineFromBuffer(buffer, maxWidth:maxWidth))
        }
        return result
    }
    
    func lineFromBuffer(_ buffer:[String], maxWidth:Int) -> String {
        guard buffer.count > 0 else {
            return ""
        }
        guard buffer.count > 1 else {
            var result = buffer[0]
            if result.characters.count < maxWidth {
                for _ in (result.characters.count + 1)...maxWidth {
                    result.append(" ")
                }
            }
            return result
        }
        
        var wordsTotalLength = 0
        for word in buffer {
            wordsTotalLength += word.characters.count
        }
        let totalWhiteSpace = maxWidth - wordsTotalLength
        let whitespacesForEachWord = totalWhiteSpace / (buffer.count - 1)
        var redundantWhitespaces = totalWhiteSpace % (buffer.count - 1)
        
        var result = ""
        for (index, word) in buffer.enumerated() {
            result.append(word)
            if index == buffer.count - 1 {
                break // last
            }
            for _ in 1...whitespacesForEachWord {
                result.append(" ")
            }
            if redundantWhitespaces > 0 {
                result.append(" ")
                redundantWhitespaces -= 1
            }
        }
        
        return result
    }
    
    func lastLineFromBuffer(_ buffer:[String], maxWidth:Int) -> String {
        var result = ""
        for (index, word) in buffer.enumerated() {
            result.append(word)
            if index < buffer.count - 1 {
                result.append(" ")
            }
        }
        let trailingWhiteSpaces = maxWidth - result.characters.count
        if trailingWhiteSpaces > 0 {
            for _ in 1...trailingWhiteSpaces {
                result.append(" ")
            }
        }
        return result
    }
}

Solution().fullJustify(["",""], 0)