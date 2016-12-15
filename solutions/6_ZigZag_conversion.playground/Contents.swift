// #6 ZigZag Conversion https://leetcode.com/problems/zigzag-conversion/
// 非常简单的题，唯一的难点就是题目本身描述得不太清楚了。需要自己考虑 row = 1、2 的边界情况。
// swift 有个 stride 函数用来处理 for step 的情况。

class Solution {
    func convert(_ s: String, _ numRows: Int) -> String {
        guard numRows >= 2 else {
            return s
        }
        
        let chars = [Character](s.characters)
        
        let loop = numRows + (numRows - 2)
        var result = ""
        for rowIndex in 0 ..< numRows {
            var row = ""
            for num in stride(from:rowIndex, to:chars.count, by: loop) {
                row.append(chars[num])
                
                if rowIndex > 0 && rowIndex < numRows - 1 { // not first row, not last row
                    let next = num + (numRows - rowIndex - 1) * 2
                    
                    if next < chars.count {
                        row.append(chars[next])
                    }
                }
            }
            
            result.append(row)
        }
        
        return result
    }
}

Solution().convert("PAYPALISHIRING", 3)
