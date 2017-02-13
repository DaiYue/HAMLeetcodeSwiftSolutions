// #30 Substring with Concatenation of All Words
// 呼…… 这是我写过代码最长的一题吧！但并不难，只是较为繁琐。
// 首先把原串按单词长度划成数个子串。因为答案可能从原串的任意地方开始，所以每次循环从第 0...wordLength - 1 个字母开始，就能覆盖到所有情况。每个子串匹配到的单词存到 matchedWords 里。
// 剩下的问题就是判断何时连续出现所有单词了…… 下面用到的方法虽然写起来很繁琐，但效率是 O(n) 的，就是一个窗口逐渐右移，两个指针分别指向两头。窗口长度不够时，右指针往右挪；遇到重复元素，左指针往右到重复元素的右边；遇到 nil，窗口跳到它的右边继续。
// 最后用时 718 ms，轻松 beats 100% ~ 看一个题解 https://soulmachine.gitbooks.io/algorithm-essentials/content/java/simulation/substring-with-concatenation-of-all-words.html ，java 似乎不用这个窗口方法也能过，但翻译成 swift（下面的 findSubstring2）就会超时 :(
// 时间复杂度：O(nm) 空间复杂度：O(n)

class Solution {
    func findSubstring(_ s: String, _ words: [String]) -> [Int] {
        let wordLength = words[0].characters.count
        let sChars = [Character](s.characters)
        
        var result = [Int]()
        for startIndex in 0...wordLength - 1 {
            var targetWordDict = [String:Int]()
            for word in words {
                targetWordDict[word] = targetWordDict[word] == nil ? 1 : targetWordDict[word]! + 1
            }
            
            var matchedWords = [String?]()
            for i in stride(from: startIndex, through: sChars.count - wordLength, by: wordLength) {
                let word = String(sChars[i ..< i + wordLength])
                sChars.count - wordLength
                matchedWords.append(targetWordDict[word] == nil ? nil : word)
            }
            
            var leftPointer = 0, rightPointer = 0, currentWordCount = 0
            var wordDict = targetWordDict
            while leftPointer < matchedWords.count && rightPointer < matchedWords.count {
                guard let word = matchedWords[rightPointer] else {
                    rightPointer += 1 // jump over nil
                    leftPointer = rightPointer
                        
                    wordDict = targetWordDict
                    currentWordCount = 0
                    continue
                }
                    
                if wordDict[word]! == 0 {
                    // already has word
                    while leftPointer < rightPointer {
                        let wordToRemove = matchedWords[leftPointer]!
                        leftPointer += 1
                        if wordToRemove == word {
                            break
                        } else {
                            currentWordCount -= 1
                            wordDict[wordToRemove] = wordDict[wordToRemove]! + 1
                        }
                    }
                } else {
                    // doesn't have word
                    wordDict[word] = wordDict[word]! - 1
                    currentWordCount += 1
                }
                rightPointer += 1
                
                if currentWordCount == words.count {
                    result.append(startIndex + leftPointer * wordLength)
                    
                    let wordToRemove = matchedWords[leftPointer]!
                    wordDict[wordToRemove] = wordDict[wordToRemove]! + 1
                    leftPointer += 1
                    currentWordCount -= 1
                }
            }
        }
        
        return result
    }
    
    func findSubstring2(_ s: String, _ words: [String]) -> [Int] {
        let wordLength = words[0].characters.count
        let sChars = [Character](s.characters)
        
        if sChars.count < wordLength * words.count {
            return []
        }
        
        var result = [Int]()
        
        var targetWordDict = [String:Int]()
        for word in words {
            targetWordDict[word] = targetWordDict[word] == nil ? 1 : targetWordDict[word]! + 1
        }
        for startIndex in 0...sChars.count - wordLength * words.count {
            var wordDict = targetWordDict
            
            for i in stride(from: startIndex, to: startIndex + wordLength * words.count, by: wordLength) {
                let word = String(sChars[i ..< i + wordLength])
                if wordDict[word] ?? 0 <= 0 {
                    break
                } else {
                    wordDict[word] = wordDict[word]! - 1
                }
            }
            
            var isValid = true
            for value in wordDict.values {
                if value != 0 {
                    isValid = false
                    break
                }
            }
            
            if isValid {
                result.append(startIndex)
            }
        }
        
        return result
    }
}

Solution().findSubstring("a", ["a","a"])
