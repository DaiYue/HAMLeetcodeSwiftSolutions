// #19 Remove Nth Node From End of List https://leetcode.com/problems/remove-nth-node-from-end-of-list/
// 挺简单的题，没什么可说的。只要两个指针，第一个指向头部，第二个指向第 n 个节点；然后把两个指针同时往后挪，当第二个指针到尾部时，第一个指针指向的就是就是倒数第 n 个节点，把它去了就行了。
// 时间复杂度：O(n) 空间复杂度：O(n)

public class ListNode {
    public var val: Int
    public var next: ListNode?
    public init(_ val: Int) {
        self.val = val
        self.next = nil
    }
}

class Solution {
    func removeNthFromEnd(_ head: ListNode?, _ n: Int) -> ListNode? {
        var length = 1
        var queueHead = head, currentNode = head?.next
        
        while currentNode != nil {
            if length >= n + 1 {
                queueHead = queueHead?.next
            } else {
                length += 1
            }
            
            currentNode = currentNode?.next
        }
        
        if length < n {
            return head
        } else if length == n {
            return head?.next
        } else {
            queueHead?.next = queueHead?.next?.next
            return head
        }
    }
}
