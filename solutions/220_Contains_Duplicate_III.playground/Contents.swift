// #220 Contains Duplicated III https://leetcode.com/problems/contains-duplicate-iii/?tab=Description
// 做这道题太折腾了，一开始想得很好，维护一个最大堆最小堆，随着窗口往后挪，往里插一个删一个。都写到一半了，才发现插一个好插，删一个不好删……原来用堆是不够的，得用平衡树啊 O  O
// 但是平衡树也太难写了…… 看了下题解，发现用桶排序很好。有个陷阱是在 0 两侧会有两个桶，所以我把所有负数的桶都 -1 往后挪了一位。
// 时间复杂度：O(n) 空间复杂度：O(t)

//class BinaryHeapNode {
//    var val : Int
//    var parent : BinaryHeapNode?
//    var leftChild : BinaryHeapNode?
//    var rightChild : BinaryHeapNode?
//    
//    init(_ val:Int) {
//        self.val = val
//    }
//    
//    static func < (left: BinaryHeapNode, right: BinaryHeapNode) -> Bool {
//        return left.val < right.val
//    }
// 
//    static func > (left: BinaryHeapNode, right: BinaryHeapNode) -> Bool {
//        return left.val > right.val
//    }
//}

//class BinaryHeap {
//    var nodes = [Int]()
//    var comparator : (Int, Int) -> Bool
//    
//    init(comparator : @escaping (Int, Int) -> Bool) {
//        self.comparator = comparator
//    }
//    
//    func insert(node: Int) {
//        nodes.append(node)
//        var index = nodes.count - 1
//        while index > 0 {
//            let parentIndex = (index - 1) / 2
//            if !comparator(nodes[parentIndex], nodes[index]) {
//                swap(&nodes[parentIndex], &nodes[index])
//                index = parentIndex
//            }
//        }
//    }
//    
//    
//}

class Solution {
    func containsNearbyAlmostDuplicate(_ nums: [Int], _ k: Int, _ t: Int) -> Bool {
        guard k > 0 && nums.count > 0 && t >= 0 else {
            return false
        }
        
        let bucketSize = t + 1
        var bucketDict = [Int : Int]()
        for (index, num) in nums.enumerated() {
            let bucket = bucketOfNum(bucketSize: bucketSize, num: num)
            if bucketDict[bucket] != nil {
                return true
            }
            if let leftBucketNum = bucketDict[bucket - 1] {
                if num - leftBucketNum <= t  {
                    return true
                }
            }
            if let rightBucketNum = bucketDict[bucket + 1] {
                if rightBucketNum - num <= t {
                    return true
                }
            }
            
            if bucketDict.count >= k {
                let bucketToRemove = bucketOfNum(bucketSize: bucketSize, num: nums[index - k])
                bucketDict.removeValue(forKey: bucketToRemove)
            }
            bucketDict[bucket] = num
        }
        
        return false
    }
    
    func bucketOfNum(bucketSize: Int, num: Int) -> Int {
        if num > 0 {
            return num / bucketSize
        }
        return num / bucketSize - 1
    }
}

Solution().containsNearbyAlmostDuplicate([1, 3, 1], 1, 1)