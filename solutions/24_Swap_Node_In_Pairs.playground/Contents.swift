// #24 Swap Node in Pairs https://leetcode.com/problems/swap-nodes-in-pairs/
// 非常简单的链表操作，一组两个 node，换过再往下，从头顺到尾即可。
// 发现单链表的题，前面加一个 dummy 真的应用很广泛，我已经用上瘾啦。
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
    func swapPairs(_ head: ListNode?) -> ListNode? {
        let dummy = ListNode(0)
        dummy.next = head
        
        var prev = dummy                      // prev = A
        while prev.next != nil && prev.next?.next != nil { // A->B->C->D => A->C->B->D
            let current = prev.next!          // current = B
            
            prev.next = current.next          // A -> C
            current.next = current.next?.next // B -> D
            prev.next?.next = current         // C -> B
            
            prev = current
        }
        
        return dummy.next
    }
}

Solution().swapPairs(nil)