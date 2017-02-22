// #269 Alien Dictionary https://leetcode.com/problems/alien-dictionary/?tab=Description
// 在 leet code 上做到的第一道图论题。字典序由相邻每两个单词得到两个字母的序关系，形成有向图的一条边。然后按拓扑排序输出即可。
// （大学毕业了这么多年我还记得拓扑排序我可真对得起老师呀~~）
// 时间复杂度：O(nm) 空间复杂度：O(mn^2)

class Node {
    var char : Character
    var prevs : [Character:Node] = [:]
    var nexts : [Character:Node] = [:]
    
    init(char: Character) {
        self.char = char
    }
}

class Solution {
    func alienOrder(_ words: [String]) -> String {
        guard words.count > 0 else {
            return ""
        }
        
        // build graph
        var nodeDict = [Character:Node]()
        for word in words {
            let chars = [Character](word.characters)
            for char in chars {
                if nodeDict[char] == nil {
                    nodeDict[char] = Node(char: char)
                }
            }
        }
        for i in 1 ..< words.count {
            let currentChars = [Character](words[i].characters)
            let previousChars = [Character](words[i - 1].characters)
            
            var j = 0
            while j < currentChars.count && j < previousChars.count && currentChars[j] == previousChars[j] {
                j += 1
            }
            
            if j >= currentChars.count || j >= previousChars.count {
                continue
            }
            
            // previousChar -> currentChar
            let currentChar = currentChars[j]
            let previousChar = previousChars[j]
            let currentNode = nodeDict[currentChar]
            let previousNode = nodeDict[previousChar]
            
            previousNode!.nexts[currentChar] = currentNode
            currentNode!.prevs[previousChar] = previousNode
        }
        
        // output sequece
        var result = ""
        var nodeToOutput : Node? = nil
        while nodeDict.count > 0 {
            if nodeToOutput == nil {
                for (_, node) in nodeDict {
                    if node.prevs.count == 0 {
                        nodeToOutput = node
                        break
                    }
                }
                
                if nodeToOutput == nil {
                    return ""
                }
            }
            
            result.append(nodeToOutput!.char)
            nodeDict.removeValue(forKey: nodeToOutput!.char)
            
            var nextNodeToOutput : Node? = nil
            for (_, nextNode) in nodeToOutput!.nexts {
                nextNode.prevs.removeValue(forKey:nodeToOutput!.char)
                if nextNode.prevs.count == 0 {
                    nextNodeToOutput = nextNode
                }
            }
            
            nodeToOutput = nextNodeToOutput
        }
        return result
    }
}