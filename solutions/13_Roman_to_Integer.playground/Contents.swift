// #13 Roman to Integer https://leetcode.com/problems/roman-to-integer/
// 很简单的题，没啥可说的。分情况讨论，简单递归即可（我怎么这么喜欢递归……）
// 题解的思路挺巧妙，倒着往前扫，比前一位大就往上加，没前一位大就减掉。算是利用了罗马数字一个很好的特性吧。
// 不过想了想好像没啥倒过来的必要啊…… 直接从前往后扫也是一样 O  O
// 时间复杂度：O(n) 空间复杂度：O(n)

class Solution {
    func romanToInt(_ s:String) -> Int {
        let chars = [Character](s.characters)
        
        var result = 0
        for i in 0 ..< chars.count - 1 {
            let num1 = romanLetterToInt(chars[i]), num2 = romanLetterToInt(chars[i + 1])
            if num1 < num2 {
                result -= num1
            } else {
                result += num1
            }
        }
        result += romanLetterToInt(chars.last!)
        
        return result
    }
    
    func romanToInt_recursive(_ s: String) -> Int {
        let chars = [Character](s.characters)
        guard chars.count > 0 else {
            return 0
        }
        let num1 = romanLetterToInt(chars[0])
        guard chars.count > 1 else {
            return num1
        }
        let num2 = romanLetterToInt(chars[1])
        var result = 0
        if num1 < num2 {
            result = num2 - num1 + romanToInt(String(chars.suffix(from: 2)))
        } else {
            var i = 1
            while i < chars.count && chars[i] == chars[0] {
                i += 1
            }
            result = num1 * i + romanToInt(String(chars.suffix(from: i)))
        }
        return result
    }
    
    func romanLetterToInt(_ char: Character) -> Int {
        let letterNumDict : [Character : Int] = ["I" : 1, "V" : 5, "X" : 10, "L" : 50, "C" : 100, "D" : 500, "M" : 1000]
        return letterNumDict[char] != nil ? letterNumDict[char]! : 0
    }
}

Solution().romanToInt("XLIV")
Solution().romanToInt("III")
Solution().romanToInt("XXXI")
Solution().romanToInt("XI")
