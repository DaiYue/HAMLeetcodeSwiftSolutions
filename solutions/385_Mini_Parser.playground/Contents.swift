// #385 Mini Parser https://leetcode.com/problems/mini-parser/?tab=Description
// 这道题用栈很简单。左括号入栈、右括号出栈即可。第一个想到的其实是递归，但递归的方法由于 Swift 的字符串截取性能差，估计会比较慢。
// 做的过程比较委屈，感觉就给的信心而言题意不是太明确。实际上有一个理解的关键是，出现一个数字的时候，不是把栈顶 setInteger 设一个数字，而是先 new 一个数字节点，再 add 给栈顶。提交之前先试一试以下两个 case："[]" "[-1]" 保证你的理解正确。
// 时间复杂度：O(n) 空间复杂度：O(n)


// This is the interface that allows for creating nested lists.
// You should not implement it, or speculate about its implementation
class NestedInteger {
    // Return true if this NestedInteger holds a single integer, rather than a nested list.
    public func isInteger() -> Bool {
        return true
    }

    // Return the single integer that this NestedInteger holds, if it holds a single integer
    // The result is undefined if this NestedInteger holds a nested list
    public func getInteger() -> Int {
        return 0
    }
    
    // Set this NestedInteger to hold a single integer.
    public func setInteger(_ value: Int) {}
    
    // Set this NestedInteger to hold a nested list and adds a nested integer to it.
    public func add(_ elem: NestedInteger) {}
    
    // Return the nested list that this NestedInteger holds, if it holds a nested list
    // The result is undefined if this NestedInteger holds a single integer
    public func getList() -> [NestedInteger] {return []}
}

class Solution {
    func deserialize(_ s: String) -> NestedInteger {
        let chars = [Character](s.characters)
        var stack = [NestedInteger]()
        
        var sign = 1
        var num : Int? = nil
        
        for char in chars {
            switch char {
            case "[":
                let nestedInteger = NestedInteger()
                stack.last?.add(nestedInteger)
                stack.append(nestedInteger)
                
            case "-":
                sign = -1
                
            case ",", "]":
                if let numUnwrap = num {
                    let nestedInteger = NestedInteger()
                    nestedInteger.setInteger(numUnwrap)
                    stack.last?.add(nestedInteger)

                    sign = 1
                    num = nil
                }
                if char == "]" {
                    let last = stack.removeLast()
                    if stack.count == 0 {
                        return last
                    }
                }
                
            case "0", "1", "2", "3", "4", "5", "6", "7", "8", "9":
                let digit = Int(String(char))!
                if num == nil {
                    num = 0
                }
                num = num! * 10 + digit * sign
                
            default: break
            }
        }
        
        if let numUnwrap = num {
            let nestedInteger = stack.last!
            nestedInteger.setInteger(numUnwrap)
            return nestedInteger
        }
        
        return NestedInteger()
    }
}

Solution().deserialize("[]")