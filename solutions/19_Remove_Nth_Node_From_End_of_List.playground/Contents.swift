
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
        var queueHead = head, queueTail = head
        var currentNode = head?.next
        
        while currentNode != nil {
            queueTail?.next = currentNode
            queueTail = currentNode
            
            if length >= n + 1 {
                queueHead = queueHead?.next
            } else {
                length += 1
            }
            
            currentNode = currentNode?.next
        }
        
        if queueHead === head && length < n + 1 {
            if length == n {
                return head?.next
            } else {
                return head
            }
        } else {
            queueHead?.next = queueHead?.next?.next
            return head
        }
    }
}