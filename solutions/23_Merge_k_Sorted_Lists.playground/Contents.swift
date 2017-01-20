
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
        var listHeads : [ListNode] = lists.flatMap{$0}
        let dummyHead = ListNode(0)
        var tail : ListNode = dummyHead
        listHeads.sort(by: {$0.val < $1.val})
        
        while listHeads.count > 0 {
            let smallestHead = listHeads[0]
            tail.next = smallestHead
            tail = smallestHead
            
            listHeads.remove(at: 0);
            guard let nextHead = smallestHead.next else {
                continue
            }
            for i in 0 ..< listHeads.count {
                if listHeads[i].val >= nextHead.val {
                    listHeads.insert(smallestHead, at: i)
                    break
                }
            }
            
        }
        
        return dummyHead.next
    }
}

var array : [Int?] = [1, nil, 2]
array

var i = 0
for i in 0..<3 {
    i
}
i