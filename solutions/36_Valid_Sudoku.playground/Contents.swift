// #36 Valid Sudoku https://leetcode.com/problems/valid-sudoku/
// 简单模拟每一条规则，用一个 Set 判重即可。
// 时间复杂度：O(n^2) 空间复杂度：O(n)

class Solution {
    func isValidSudoku(_ board: [[Character]]) -> Bool {
        guard board.count == 9 else {
            return false
        }
        
        // lines
        for line in board {
            if line.count != 9 {
                return false;
            }
            
            var numSet = Set<Character>()
            for char in line {
                if char == "." {
                    continue
                }
                if numSet.contains(char) {
                    return false
                }
                numSet.insert(char)
            }
        }
        
        // vertical
        for columnIndex in 0 ..< 9 {
            var numSet = Set<Character>()
            for rowIndex in 0 ..< 9 {
                let char = board[rowIndex][columnIndex]
                if char == "." {
                    continue
                }
                if numSet.contains(char) {
                    return false
                }
                numSet.insert(char)
            }
        }
        
        // grids
        for gridIndex in 0 ..< 9 {
            let startRow = (gridIndex / 3) * 3
            let startColumn = (gridIndex % 3) * 3
            
            var numSet = Set<Character>()
            for rowIndex in startRow...startRow + 2 {
                for columnIndex in startColumn...startColumn + 2 {
                    let char = board[rowIndex][columnIndex]
                    if char == "." {
                        continue
                    }
                    if numSet.contains(char) {
                        return false
                    }
                    numSet.insert(char)
                }
            }
        }
        
        return true
    }
}