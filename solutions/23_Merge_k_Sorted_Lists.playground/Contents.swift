// #23 Merge k Sorted Lists https://leetcode.com/submissions/detail/90095220/
// 看起来很简单的一道题，不知道为什么评级为 HARD。结果果然超时……
// 一开始想的方法是（见下面 mergeKLists_timeLimitExceeds）把所有 head 聚集起来排个序，然后取出一个最小的，把它的 next 加进去…… 看起来维护一个堆即可。我下面写的是插入排序，没有写堆，因为我发现超时的那组数据链表长度全部为 1，跟后面用什么数据结构是没关系的，只能说上来一 sort 就超时了。
// 于是只好改另一种做法，两两归并。结果将将过了。评估这两种算法的时间复杂度，方法二是 knlogk，方法一是 klogk + knlogk，相当于同样是 knlogk。可能常数项有点差别，所以导致一个能过一个不过……
// 时间复杂度：O(knlogk) 空间复杂度：O(k)


public class ListNode {
    public var val: Int
    public var next: ListNode?
    public init(_ val: Int) {
        self.val = val
        self.next = nil
    }
}

class Solution {
    
    func mergeKLists(_ lists: [ListNode?]) -> ListNode? {
        var lists : [ListNode] = lists.flatMap{$0}
        
        while lists.count > 1 {
            var nextLists = [ListNode]()
            for i in stride(from: 0, to:lists.count - 1 , by: 2) {
                nextLists.append(mergeTwoLists(lists[i], lists[i + 1]))
            }
            if lists.count % 2 == 1 {
                nextLists.append(lists.last!)
            }
            lists = nextLists
        }
        
        return lists.count > 0 ? lists[0] : nil
    }
    
    func mergeTwoLists(_ l1: ListNode, _ l2: ListNode) -> ListNode {
        var p1 : ListNode? = l1, p2 : ListNode? = l2;
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
        return head.next!
    }
    
    func mergeKLists_timeLimitExceeds(_ lists: [ListNode?]) -> ListNode? {
        var listHeads : [ListNode] = lists.flatMap{$0}
        let dummyHead = ListNode(0)
        var tail : ListNode = dummyHead
        listHeads.sort(by: {$0.val < $1.val})
        
        while listHeads.count > 0 {
            let smallestHead = listHeads[0]
            tail.next = smallestHead
            tail = smallestHead
            
            guard let nextHead = smallestHead.next else {
                listHeads.remove(at: 0);
                continue
            }
            var inserted = false
            for i in 1 ..< listHeads.count {
                if listHeads[i].val >= nextHead.val {
                    listHeads[i - 1] = nextHead
                    inserted = true
                    break
                } else {
                    listHeads[i - 1] = listHeads[i]
                }
            }
            if !inserted {
                listHeads[listHeads.count - 1] = nextHead
            }
        }
        
        return dummyHead.next
    }
}

//[[0,2,5]]

