// #25 Reverse Nodes in k-Group https://leetcode.com/problems/reverse-nodes-in-k-group/
// 虽然评级为 HARD，不过题并不难，只是略为繁琐…… 画个图就明白了。
// 每次循环交换一组，先找到本组末尾，然后从后往前连起来，最后把本组头部连到前一组尾部后。
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
    func reverseKGroup(_ head: ListNode?, _ k: Int) -> ListNode? {
        let dummy = ListNode(0)
        dummy.next = head
        
        var prev = dummy                      // prev = A
        while prev.next != nil { // A->B->C->D->E => A->D->C->B->E
            var groupTail : ListNode? = prev
            for _ in 1...k {
                groupTail = groupTail?.next
            }
            guard groupTail != nil else { // groupTail = D
                break
            }
            
            let nextGroupHead = groupTail!.next      // nextGroupHead = E
            var last = nextGroupHead                 // last = E
            var current : ListNode? = prev.next!      // current = B
            while current != nil && current !== nextGroupHead {
                let next = current!.next  // next = C
                current!.next = last      // B -> E
                last = current            // last = B
                current = next            // current = C
            }
            
            groupTail = prev.next
            prev.next = last
            prev = groupTail!
        }
        
        return dummy.next
    }
    
}

let node1 = ListNode(1)
let node2 = ListNode(2)
let node3 = ListNode(3)
let node4 = ListNode(4)
node1.next = node2
node2.next = node3
node3.next = node4
Solution().reverseKGroup(node1, 2)?.next?.next?.val
