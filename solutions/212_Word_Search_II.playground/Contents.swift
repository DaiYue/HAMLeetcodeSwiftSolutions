// #212 Word Search II https://leetcode.com/problems/word-search-ii/?tab=Description
// 这道题我一遍过的…… 实在写得累死了！不过轻松打败了 100% 的提交，我只用了 1342 ms，图上看其他人都用了 6000多 ms 哈哈
// 总体来说就是一个深搜，从每个字母开始上下左右…… 这样。深搜用递归比较方便，而且我喜欢在递归方法开头判边界，而不是调用下一轮之前，这样代码可以短一点。用过的字母放到 hash 里，防止重复。
// 然后存单词用的是一个字典树，凡是这种一个字母一个字母往下找的题都会很适合用字典树。最终结果用 Set 排重。
// 时间复杂度：O(nm) 空间复杂度：O(n^2)

class TrieNode {
    var char : Character
    var nextDict : [Character : TrieNode] = [:]
    var word : String?
    
    init(char: Character) {
        self.char = char
    }
    
    func addWord(_ word:String) {
        addWord(word: word, chars:[Character](word.characters), charIndex: 0)
    }
    
    func addWord(word:String, chars: [Character], charIndex: Int) {
        guard charIndex < chars.count else {
            self.word = word
            return
        }
        
        let char = chars[charIndex]
        
        var nextNode = nextDict[char]
        if nextNode == nil {
            nextNode = TrieNode(char: char)
            nextDict[char] = nextNode
        }
        
        nextNode!.addWord(word: word, chars: chars, charIndex: charIndex + 1)
    }
}



class Solution {
    func findWords(_ board: [[Character]], _ words: [String]) -> [String] {
        let tree = TrieNode(char: " ")
        for word in words {
            tree.addWord(word)
        }
        
        var usedPosition = [[Bool]]()
        for i in 0 ..< board.count {
            usedPosition.append(Array(repeating: false, count: board[i].count))
        }
        
        var results = Set<String>()
        for i in 0 ..< board.count {
            let line = board[i]
            for j in 0 ..< line.count {
                let partResult = findWords(board: board, usedPosition: &usedPosition, position: (x : i, y : j), trieParentNode: tree)
                for word in partResult {
                    results.insert(word)
                }
            }
        }
        
        return Array(results)
    }
    
    func findWords(board: [[Character]], usedPosition: inout [[Bool]], position: (x:Int, y:Int), trieParentNode: TrieNode) -> [String] {
        guard position.x >= 0 && position.x < board.count else {
            return []
        }
        let line = board[position.x]
        guard position.y >= 0 && position.y < line.count else {
            return []
        }
        
        if usedPosition[position.x][position.y] {
            return []
        }
        
        let char = line[position.y]
        guard let trieNode = trieParentNode.nextDict[char] else {
            return []
        }
        
        var result = [String]()
        if trieNode.word != nil {
            result.append(trieNode.word!)
        }
        
        usedPosition[position.x][position.y] = true
        
        // up
        result.append(contentsOf:findWords(board: board, usedPosition: &usedPosition, position: (x:position.x - 1, y: position.y), trieParentNode: trieNode))
        // down
        result.append(contentsOf:findWords(board: board, usedPosition: &usedPosition, position: (x:position.x + 1, y: position.y), trieParentNode: trieNode))
        // left
        result.append(contentsOf:findWords(board: board, usedPosition: &usedPosition, position: (x:position.x, y: position.y - 1), trieParentNode: trieNode))
        // right
        result.append(contentsOf:findWords(board: board, usedPosition: &usedPosition, position: (x:position.x, y: position.y + 1), trieParentNode: trieNode))
        
        usedPosition[position.x][position.y] = false
        
        return result
    }
}

Solution().findWords([Array("oaan".characters),Array("etae".characters),Array("ihkr".characters),Array("iflv".characters)], ["oath","pea","eat","rain"])
