

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
            if rowIndex == 0 || rowIndex == numRows - 1 {
                for num in stride(from:rowIndex, to:chars.count, by: loop) {
                    row.append(chars[num])
                }
            } else {
                for num in stride(from:rowIndex, to:chars.count, by: loop) {
                    row.append(chars[num])
                    
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
