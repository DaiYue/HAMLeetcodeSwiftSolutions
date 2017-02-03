// #28 Implement strStr() https://leetcode.com/problems/implement-strstr/
// 这道题让我惊讶地发现 swift 里的 string 类不带 contains 方法，虽然它有 hasPrefix、hasSuffix 方法。有一个 range(of:) 是需要 import UIKit 的。
// 正经做法是 KMP，偷懒不写，于是需要注意搜的时候不要搜到头，发现后面长度不够时停掉就可以了，不然超时。
// 时间复杂度：O(nm) 空间复杂度：O(n)

class Solution {
    func strStr(_ haystack: String, _ needle: String) -> Int {
        let hayChars = [Character](haystack.characters)
        let needleChars = [Character](needle.characters)
        guard needleChars.count > 0 else {
            return 0
        }
        guard hayChars.count >= needleChars.count else {
            return -1
        }
        
        for i in 0 ... hayChars.count - needleChars.count {
            var j = 0
            while j < needleChars.count && hayChars[i + j] == needleChars[j] {
                j += 1
            }
            if j == needleChars.count {
                return i
            }
        }
        return -1
    }
}

Solution().strStr("abc", "c")
Solution().strStr("abc", "ab")
Solution().strStr("abc", "d")