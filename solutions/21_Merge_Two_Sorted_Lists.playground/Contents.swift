// #21 Merge Two Sorted Lists https://leetcode.com/problems/merge-two-sorted-lists/
// 很简单的归并排序，两个指针分别指向两个链表头，比较哪个指向的节点小就把哪个节点加入结果，然后把指针往后移就行了
// 现在我也学会了像题解那样，在链表头部搞一个 dummy，简化代码。另外这道题可以用到 swift 的 ?? 运算符
// 时间复杂度：O(n) 空间复杂度：O(1)

public class ListNode {
    public var val: Int
    public var next: ListNode?
    public init(_ val: Int) {
        self.val = val
        self.next = nil
    }
}

class Solution {
    func mergeTwoLists(_ l1: ListNode?, _ l2: ListNode?) -> ListNode? {
        var p1 = l1, p2 = l2;
        let head = ListNode(0)
        var tail = head
        while p1 != nil && p2 != nil {
            if p1!.val <= p2!.val {
                tail.next = p1
                p1 = p1!.next
            } else {
                tail.next = p2
                p2 = p2!.next
            }
            tail = tail.next!
        }
        
        tail.next = p1 ?? p2
        return head.next
    }
}