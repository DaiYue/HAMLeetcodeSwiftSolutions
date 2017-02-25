// #221 Maximal Square https://leetcode.com/problems/maximal-square/?tab=Description
// 我用的是很简单的迭代，每次 size 扩大 1，记住上一轮结果，扩大时只用验证新扩展的那两条边即可。
// 看了下题解，还有 O(n^2) 的 DP 做法，非常巧妙，写出来也非常简单，但感觉并不容易凭空想出。把 i , j 矩阵分为 (i - 1) , (j - 1) 和 i, j - 1 和 i - 1, j 三个小一圈的矩阵，可以证明在 i, j 点为 1 的情况下 i, j 的矩阵大小恰恰等于那三个小矩阵的最小值（可证不大于也不小于）。我觉得只能说遇到过这样的题就把它背下来，下次遇到矩阵的题就想到把它分成 3 个小矩阵去想吧，短时间内应该是很难凭空发明这个想法的。
// 时间复杂度：O(n^3) 空间复杂度：O(n^2)

class Solution {
    func maximalSquare(_ matrix: [[Character]]) -> Int {
        let n = matrix.count
        guard n > 0 else {
            return 0
        }
        let m = matrix[0].count
        guard m > 0 else {
            return 0
        }
        
        var valid = [[Bool]]()
        var size = 1
        while size <= n && size <= m {
            var nextValid = Array(repeating: Array(repeating: false, count: m), count: n)
            var hasValid = false

            for i in 0 ... n - size {
                for j in 0 ... m - size {
                    if size == 1 {
                        nextValid[i][j] = matrix[i][j] == "1"
                        if nextValid[i][j] {
                            hasValid = true
                        }
                        continue
                    }
                    
                    guard valid[i][j] else {
                        continue
                    }
                    
                    var isValid = true
                    let lasti = i + size - 1, lastj = j + size - 1
                    for checkj in j ... lastj {
                        if matrix[lasti][checkj] != "1" {
                            isValid = false
                            break
                        }
                    }
                    if !isValid {
                        nextValid[i][j] = false
                        continue
                    }
                    for checki in i ..< lasti {
                        if matrix[checki][lastj] != "1" {
                            isValid = false
                            break
                        }
                    }
                    nextValid[i][j] = isValid
                    if isValid {
                        hasValid = true
                    }
                }
            }
            
            guard hasValid else {
                break
            }
            valid = nextValid
            size += 1
        }
        return (size - 1) * (size - 1)
    }
}
