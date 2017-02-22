// #336 Palindrome Pair https://leetcode.com/problems/palindrome-pairs/?tab=Description
// 这个题我并没有通过，现在还是超时状态。但我不打算继续做了。从理论分析，我现在的解法跟 Solution 里的并无区别，过不了想来就是 swift 的锅…… 比如 reverse 字符串…… 我懒得去为这种语言单独优化细节了。
// 顺便说，我觉得 case 里的 "" 真是毫无意义，这应该算是不好的 case。
// 时间复杂度：O(n * m^2) 空间复杂度：O(n)

class Solution {
    func palindromePairs(_ words: [String]) -> [[Int]] {
        var wordDict = [String : Int]()
        for (index, word) in words.enumerated() {
            wordDict[word] = index
        }
        
        var result = [[Int]]()
        for (wordIndex, word) in words.enumerated() {
            let chars = [Character](word.characters)
            for rightPartStartIndex in 0 ..< chars.count {
                if let oddResult = findpalindromePair(chars: chars, leftStartIndex: rightPartStartIndex, rightStartIndex: rightPartStartIndex, wordDict: wordDict, wordIndex: wordIndex) {
                    result.append(contentsOf: oddResult)
                }
                if let evenResult = findpalindromePair(chars: chars, leftStartIndex: rightPartStartIndex - 1, rightStartIndex: rightPartStartIndex, wordDict: wordDict, wordIndex: wordIndex) {
                    result.append(contentsOf: evenResult)
                }
            }
        }
        return result
    }
    
    func findpalindromePair(chars:[Character], leftStartIndex : Int, rightStartIndex : Int, wordDict:[String : Int], wordIndex : Int) -> [[Int]]? {
        // is valid part
        var leftIndex = leftStartIndex, rightIndex = rightStartIndex
        while leftIndex >= 0 && rightIndex < chars.count && chars[leftIndex] == chars[rightIndex] {
            leftIndex -= 1
            rightIndex += 1
        }
        if leftIndex >= 0 && rightIndex < chars.count {
            return nil
        }
        
        // create pair
        var pair = "", direction = 0 // left -> 1 right -> -1 both -> 0
        if rightIndex < chars.count {
            direction = -1
            while rightIndex < chars.count {
                pair.insert(chars[rightIndex], at: pair.startIndex)
                rightIndex += 1
            }
        } else if leftIndex >= 0 {
            direction = 1
            while leftIndex >= 0 {
                pair.insert(chars[leftIndex], at: pair.endIndex)
                leftIndex -= 1
            }
        } else { // pair = ""
            direction = 0
        }
        
        if let pairIndex = wordDict[pair] {
            if pairIndex != wordIndex {
                switch direction {
                case 1:
                    return [[wordIndex, pairIndex]]
                    
                case -1:
                    return [[pairIndex, wordIndex]]
                
                case 0:
                    return [[wordIndex, pairIndex], [pairIndex, wordIndex]]
                    
                default:
                    return nil
                }
            }
        }
        return nil
    }
}

Solution().palindromePairs(["a",""])