// #17 Letter Combinations of a Phone Number https://leetcode.com/problems/letter-combinations-of-a-phone-number/
// 懒癌犯了…… 明明一道广搜的题，又写成“递归”了，仅仅是因为懒得开两个数组…… 是不是已经没得救了 O  O
// 好吧，后面老实补了一个正常版本。然后发现“递归”版本快得多…… 完全想不到任何原因呀，明明“递归”版本无谓地构造了一些后缀字符串，难道是拷贝数组很慢？
// 时间复杂度：3^n 空间复杂度：3^n

class Solution {
    func letterCombinations(_ digits: String) -> [String] {
        let lettersOfNums : [Character : [String]] = ["1":[],
                                                      "2":["a", "b", "c"],
                                                      "3":["d", "e", "f"],
                                                      "4":["g", "h", "i"],
                                                      "5":["j", "k", "l"],
                                                      "6":["m", "n", "o"],
                                                      "7":["p", "q", "r", "s"],
                                                      "8":["t", "u", "v"],
                                                      "9":["w", "x", "y", "z"]]
        
        let characters = [Character](digits.characters)
        guard characters.count > 0 else {
            return []
        }
        
        var combinations : [String] = []
        for digit in characters {
            guard let letters = lettersOfNums[digit] else {
                return []
            }
            guard combinations.count > 0 else {
                combinations = letters
                continue
            }
            
            var nextCombinations : [String] = []
            for combination in combinations {
                for letter in letters {
                    nextCombinations.append(combination + letter)
                }
            }
            
            combinations = nextCombinations
        }

        return combinations
    }
    
    func letterCombinations_recursive(_ digits: String) -> [String] {
        let lettersOfNums : [Character : [String]] = ["1":[],
                             "2":["a", "b", "c"],
                             "3":["d", "e", "f"],
                             "4":["g", "h", "i"],
                             "5":["j", "k", "l"],
                             "6":["m", "n", "o"],
                             "7":["p", "q", "r", "s"],
                             "8":["t", "u", "v"],
                             "9":["w", "x", "y", "z"]]
        
        let characters = [Character](digits.characters)
        guard characters.count > 0 else {
            return []
        }
        
        let firstDigit = characters[0]
        guard let letters = lettersOfNums[firstDigit] else {
            return []
        }
        guard characters.count > 1 else {
            return letters
        }
        
        let restCombinations = letterCombinations_recursive(String(characters.suffix(from: 1)))
        var combinations : [String] = []
        for letter in letters {
            for restCombination in restCombinations {
                combinations.append(letter + restCombination)
            }
        }
        return combinations
    }
}

Solution().letterCombinations("23")