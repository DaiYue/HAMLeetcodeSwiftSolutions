// #136 Single Number https://leetcode.com/problems/single-number/?tab=Description
// 以前在什么书上看到过这道题，感觉这种题完全没意义…… 就是听说过的会做，没听过的不会做。
// 利用一个数异或两次还等于原本的数的特点，直接把每个数都异或一遍。初始的数是 0 ，所以最后所剩的结果就是单独的数本身。
// 时间复杂度：O(n) 空间复杂度：O(1)

class Solution {
    func singleNumber(_ nums: [Int]) -> Int {
        var temp = 0
        for num in nums {
            temp = temp ^ num
        }
        return temp
    }
}