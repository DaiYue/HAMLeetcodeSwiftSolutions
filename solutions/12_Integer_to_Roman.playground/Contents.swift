// #12 Integer to Roman https://leetcode.com/problems/integer-to-roman/
// 很简单的递归，没什么可说的。就是细心一点吧。

class Solution {
    func intToRoman(_ num: Int) -> String {
        guard num > 0 else {
            return ""
        }
        
        let lettersForOne = ["O", "I", "X", "C", "M"]
        let lettersForFive = ["O", "V", "L", "D"]
        
        var digits = 1
        var numToCompare = 1
        while numToCompare * 10 <= num {
            numToCompare = numToCompare * 10
            digits += 1
        }
        
        let highestDigit = num / numToCompare
        var leftPart = "", middlePart = "", rightPart = ""
        if highestDigit <= 3 {
            for _ in 1...highestDigit {
                middlePart.append(lettersForOne[digits])
            }
            
        } else if highestDigit <= 5 {
            middlePart = lettersForFive[digits]
            if highestDigit == 4 {
                leftPart = lettersForOne[digits]
            }
            
        } else if highestDigit <= 8 {
            middlePart = lettersForFive[digits]
            for _ in 6...highestDigit {
                rightPart.append(lettersForOne[digits])
            }
        
        } else { // highestDigit = 9
            middlePart = lettersForOne[digits + 1]
            leftPart = lettersForOne[digits]
        }
        rightPart += intToRoman(num - highestDigit * numToCompare)
        
        return leftPart + middlePart + rightPart
    }
    
}

Solution().intToRoman(3)
Solution().intToRoman(31)
Solution().intToRoman(5)
Solution().intToRoman(4)
Solution().intToRoman(41)
Solution().intToRoman(9)
Solution().intToRoman(99)
Solution().intToRoman(89)
Solution().intToRoman(10)
Solution().intToRoman(3999)