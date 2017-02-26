// #227 Basic Calculator II https://leetcode.com/problems/basic-calculator-ii/?tab=Description
// 经典的表达式求值，用一个符号栈和一个数字栈。往符号栈压入的时候，如果栈顶优先级 >= 当前符号就 pop、计算、再push，直到栈空或优先级 < 当前符号。这题还有一个略微变化是含有若干多余空格。
// 时间复杂度：O(n) 空间复杂度：O(n)

class Solution {
    func calculate(_ s: String) -> Int {
        let chars = [Character](s.characters)
        guard chars.count > 0 else {
            return 0
        }
        
        var nums = [Int]()
        var operators = [Character]()
        var numStartIndex = -1, numEndIndex = -1
        for (index, char) in chars.enumerated() {
            switch char {
            case "0", "1", "2", "3", "4", "5", "6", "7", "8", "9":
                if numStartIndex < 0 {
                    numStartIndex = index
                }
                numEndIndex = index
                
            case "+", "-", "*", "/":
                let rightOperand = Int(String(chars[numStartIndex ... numEndIndex]))!
                numStartIndex = -1
                numEndIndex = -1
                nums.append(rightOperand)
                
                var lastOperator = operators.last
                while lastOperator != nil && priorityOfOperator(lastOperator!) >= priorityOfOperator(char) {
                    let rightOperand = nums.popLast()!
                    let leftOperand = nums.popLast()!
                    nums.append(calculate(left: leftOperand, operand: lastOperator!, right: rightOperand))
                    operators.popLast()
                    lastOperator = operators.last
                }
                
                operators.append(char)
            
            default: break
            }
        }
        
        let rightOperand = Int(String(chars[numStartIndex ... numEndIndex]))!
        nums.append(rightOperand)
        operators
        
        while operators.count > 0 {
            let rightOperand = nums.popLast()!
            let leftOperand = nums.popLast()!
            let operatorChar = operators.popLast()!
            calculate(left: leftOperand, operand: operatorChar, right: rightOperand)
            nums.append(calculate(left: leftOperand, operand: operatorChar, right: rightOperand))
        }
        
        nums
        return nums[0]
    }
        
    func priorityOfOperator(_ char: Character) -> Int {
        switch char {
        case "+", "-":
            return 1
        case "*", "/":
            return 2
        default:
            return -1
        }
    }
    
    func calculate(left: Int, operand: Character, right: Int) -> Int {
        switch operand {
        case "+":
            return left + right
        
        case "-":
            return left - right
            
        case "*":
            return left * right
            
        case "/":
            return left / right
            
        default:
            return 0
        }
    }
}

Solution().calculate("1*2-3/4+5*6-7*8+9/10")