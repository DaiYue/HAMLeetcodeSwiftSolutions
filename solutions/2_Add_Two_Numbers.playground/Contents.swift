// #2 Add Two Numbers https://leetcode.com/problems/add-two-numbers/
// 简单的单链表处理。考虑几种情况：1. 两个数位数相等，且最高位不需进位 2. 两个数位数相等，且最高位需要进位 3. 两个数位数不相等
// 有些算法会在结果的头部先创建一个 dummy，val 任意，真正的头结点直接往 dummy 后面插。最后返回 dummy -> next
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
    func addTwoNumbers(_ l1: ListNode?, _ l2: ListNode?) -> ListNode? {
        if l1 == nil {
            return l2
        }
        
        if l2 == nil {
            return l1
        }
        
        var l1Tail:ListNode? = l1
        var l2Tail:ListNode? = l2
        
        var head:ListNode? = nil
        var tail:ListNode? = nil

        var carry = 0
        while l1Tail != nil || l2Tail != nil {
            let sum = (l1Tail?.val ?? 0) + (l2Tail?.val ?? 0) + carry
            carry = sum / 10
            let val = sum % 10
            
            let node = ListNode(val)
            
            if head == nil {
                head = node
            } else {
                tail!.next = node
            }
            tail = node
            
            l1Tail = l1Tail?.next
            l2Tail = l2Tail?.next
        }
        
        if carry != 0 {
            tail?.next = ListNode(carry)
        }
        
        return head;
    }
}

let n1 = ListNode(2)
let n2 = ListNode(4)
n1.next = n2
let n3 = ListNode(9)
n2.next = n3

let n4 = ListNode(5)
let n5 = ListNode(6)
n4.next = n5
let n6 = ListNode(4)
n5.next = n6

let solution = Solution();
let nr = solution.addTwoNumbers(n1, n4)

