// #8 String to Integer https://leetcode.com/problems/string-to-integer-atoi/
// 这道题与其说是写代码不如说是写 case…… 一堆 case，真是一点懒都不能偷呀。

class Solution {
    func myAtoi(_ str: String) -> Int {
        let chars = [Character](str.characters)
        
        var result = 0
        var sign = 0
        var isPrefix = true
        for char in chars {
            if (char == " " || char == " ") && isPrefix {
                continue
            }
            
            isPrefix = false
            
            if char == "+" || char == "-" {
                if sign != 0 {
                    break
                }
                sign = char == "+" ? 1 : -1
                continue
            }
            
            if char >= "0" && char <= "9" {
                let charValue = Int(String(char))!
                
                if sign >= 0 && result > (Int(Int32.max) - charValue) / 10 {
                    result = Int(Int32.max)
                    break
                }
                
                if sign == -1 && result > (-Int(Int32.min) - charValue) / 10 {
                    result = -Int(Int32.min)
                    break
                }
                
                result = result * 10 + charValue
                
            } else {
                break
            }
        }
        
        if sign == 0 {
            sign = 1
        }
        return result * sign
    }
}

Solution().myAtoi("9223372036854775809")
