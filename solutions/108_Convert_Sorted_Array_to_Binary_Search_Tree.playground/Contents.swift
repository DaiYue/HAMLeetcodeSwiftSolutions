// #108 Convert Sorted Array to Binary Search Tree https://leetcode.com/problems/convert-sorted-array-to-binary-search-tree/?tab=Description
// 简单的数据结构题，只要知道 BST 的定义就能做出来。树的题一般都是递归的方法比较方便。
// 时间复杂度：O(n) 空间复杂度：O(n)

public class TreeNode {
    public var val: Int
    public var left: TreeNode?
    public var right: TreeNode?
    public init(_ val: Int) {
        self.val = val
        self.left = nil
        self.right = nil
    }
}

class Solution {
    func sortedArrayToBST(_ nums: [Int]) -> TreeNode? {
        guard nums.count > 0 else {
            return nil
        }
        
        let middleIndex = nums.count / 2
        let node = TreeNode(nums[middleIndex])
        node.left = sortedArrayToBST(Array(nums[0 ..< middleIndex]))
        node.right = sortedArrayToBST(Array(nums[middleIndex + 1 ..< nums.count]))
        
        return node
    }
}