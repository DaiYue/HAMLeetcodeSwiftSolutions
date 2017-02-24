// #415 Add Strings https://leetcode.com/problems/add-strings/?tab=Description
// 看这 swift 的类型转换恶心的。
// 时间复杂度：O(n) 空间复杂度：O(n)

class Solution {
    func addStrings(_ num1: String, _ num2: String) -> String {
        let chars1 = [Character](num1.characters)
        let chars2 = [Character](num2.characters)
        var index1 = chars1.count - 1, index2 = chars2.count - 1
        var carry = 0
        var result : String = ""
        
        while index1 >= 0 && index2 >= 0 {
            let digit = Int(String(chars1[index1]))! + Int(String(chars2[index2]))! + carry
            result.insert(String(digit % 10).characters.first!, at: result.startIndex)
            carry = digit / 10
            
            index1 -= 1
            index2 -= 1
        }
        
        while index1 >= 0 {
            let digit = (Int(String(chars1[index1])) ?? 0) + carry
            result.insert(String(digit % 10).characters.first!, at: result.startIndex)
            carry = digit / 10
            
            index1 -= 1
        }
        
        while index2 >= 0 {
            let digit = (Int(String(chars2[index2])) ?? 0) + carry
            result.insert(String(digit % 10).characters.first!, at: result.startIndex)
            carry = digit / 10
            
            index2 -= 1
        }
        
        if carry > 0 {
            result.insert(String(carry).characters.first!, at: result.startIndex)
        }
        
        return result
    }
}

Solution().addStrings("9", "0")