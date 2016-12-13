// #4 Median of Two Sorted Arrays https://leetcode.com/problems/median-of-two-sorted-arrays/
// 下面列出了两个解法，其中 Solution2 是自己想出来的，也过了全部测试数据，但方法非常不简洁。思路是从两边逼近中位数，取两个数列的中点，可证明总有一个不能满足第 k 大的条件。然后就调整这个数列。问题在于，有些情况可能会调整过头。另外，还有这个数列已经到头、调整不了的情况，此时就需要去调另一个数列。总的来说仍然是 log(m + n) 的，但代码非常长，原理也不够清晰。
// Solution1 参考了别人的题解，每次两个数列各取 k/2 处，小者在这个位置之前全都截断。
// 为啥 Solution1 就非常简洁呢？最主要的问题在于，Solution1 是从一侧逼近问题的，每次迭代都更靠近答案。Solution2 是从两侧往中间逼近，然而两个数列并没有二分查找那么好的特性，有可能两个指针都在答案的同侧，还要回头找。
// 另外，Solution1 利用了一个技巧，保证每次迭代时 nums1 都更短，不然交换。可以避免很多对称的重复代码。
// 在语言方面，可以看出 swift 里 if(...) {return ...} 这种基本都用 guard 代替。
// 时间复杂度：log(m+n) 空间复杂度：O(m + n)


class Solution {
    
    func findMedianSortedArrays(_ nums1: [Int], _ nums2: [Int]) -> Double {
        if (nums1.count + nums2.count) % 2 == 0 {
            let lowerMedian = findKthInSortedArrays(k: (nums1.count + nums2.count) / 2, nums1: nums1, nums2: nums2)
            let higherMedian = findKthInSortedArrays(k: (nums1.count + nums2.count) / 2 + 1, nums1: nums1, nums2: nums2)
            return (Double(lowerMedian) + Double(higherMedian)) / 2;
        } else {
            return Double(findKthInSortedArrays(k: (nums1.count + nums2.count + 1) / 2, nums1: nums1, nums2: nums2))
        }
    }
    
    func findKthInSortedArrays(k: Int,  nums1: [Int], nums2: [Int]) -> Int {
        
        guard nums1.count <= nums2.count else {
            return findKthInSortedArrays(k: k, nums1: nums2, nums2: nums1)
        }
        
        guard nums1.count > 0 else {
            return nums2[k - 1]
        }
        
        guard k > 1 else {
            return min(nums1[0], nums2[0])
        }
        
        let num1Index = min(k / 2 - 1, nums1.count - 1)
        let num2Index = min(k / 2 - 1, nums2.count - 1)
        
        if nums1[num1Index] < nums2[num2Index] {
            return findKthInSortedArrays(k: k - (num1Index + 1), nums1: Array(nums1[num1Index + 1 ..< nums1.count]), nums2: nums2)
        } else {
            return findKthInSortedArrays(k: k - (num2Index + 1), nums1: nums1, nums2: Array(nums2[num2Index + 1 ..< nums2.count]))
        }
    }
}

class Solution2 {
    func findMedianSortedArrays(_ nums1: [Int], _ nums2: [Int]) -> Double {
        
        if nums1.count == 0 {
            return findMedianInSortedArray(nums2)
        }
        
        if nums2.count == 0 {
            return findMedianInSortedArray(nums1)
        }
        
        if (nums1.count + nums2.count) % 2 == 0 {
            let lowerMedian = findKthInSortedArrays(k: (nums1.count + nums2.count) / 2, nums1: nums1, range1: 0 ... nums1.count - 1, nums2: nums2, range2: 0 ... nums2.count - 1)
            let higherMedian = findKthInSortedArrays(k: (nums1.count + nums2.count) / 2 + 1, nums1: nums1, range1: 0 ... nums1.count - 1, nums2: nums2, range2: 0 ... nums2.count - 1)
            return (Double(lowerMedian) + Double(higherMedian)) / 2;
        } else {
            return Double(findKthInSortedArrays(k: (nums1.count + nums2.count + 1) / 2, nums1: nums1, range1: 0 ... nums1.count - 1, nums2: nums2, range2: 0 ... nums2.count - 1))
        }
    }
    
    func findMedianInSortedArray(_ nums: [Int]) -> Double {
        if nums.count % 2 == 0 {
            let lowerMedian = nums[nums.count / 2 - 1]
            let higherMedian = nums[nums.count / 2]
            return (Double(lowerMedian) + Double(higherMedian)) / 2
        } else {
            return Double(nums[nums.count / 2])
        }
    }
    
    func findKthInSortedArrays(k: Int, nums1: [Int], range1: CountableClosedRange<Int>, nums2: [Int], range2: CountableClosedRange<Int>) -> Int {
        
        
        
        let index1 = (range1.lowerBound + range1.upperBound) / 2
        let index2 = (range2.lowerBound + range2.upperBound) / 2
        
        let num1 = nums1[index1]
        let num2 = nums2[index2]
        
        if num1 < num2 {
            return findKthInSortedArrays(k: k, lowerNums: nums1, lowerRange: range1, higherNums: nums2, higherRange: range2)
        } else {
            return findKthInSortedArrays(k: k, lowerNums: nums2, lowerRange: range2, higherNums: nums1, higherRange: range1)
        }
    }
    
    func findKthInSortedArrays(k: Int, lowerNums: [Int], lowerRange: CountableClosedRange<Int>, higherNums: [Int], higherRange: CountableClosedRange<Int>) -> Int {
        let lowerIndex = (lowerRange.lowerBound + lowerRange.upperBound) / 2
        let higherIndex = (higherRange.lowerBound + higherRange.upperBound) / 2
        
        let lowerMaxSortedIndex = lowerIndex + higherIndex + 1
        let higherMinSortedIndex = lowerIndex + 1 + higherIndex + 1
        
        if lowerMaxSortedIndex == k && higherIndex == higherRange.lowerBound {
            return lowerNums[lowerIndex]
        }
        
        if higherMinSortedIndex == k && lowerIndex == lowerRange.upperBound {
            return higherNums[higherIndex]
        }
        
        
        
        if lowerMaxSortedIndex < k {
            if lowerIndex < lowerRange.upperBound {
                let nextRange = lowerIndex + 1...lowerRange.upperBound
                return findKthInSortedArrays(k: k, nums1: lowerNums, range1: nextRange, nums2: higherNums, range2: higherRange)
            } else {
                let nextRange = higherIndex + 1...higherRange.upperBound
                return findKthInSortedArrays(k: k, nums1: lowerNums, range1: lowerRange, nums2: higherNums, range2: nextRange)
            }
        } else { // must have num2MinSortedIndex > k
            if higherIndex > higherRange.lowerBound {
                let nextRange = higherRange.lowerBound...higherIndex - 1
                return findKthInSortedArrays(k: k, nums1: lowerNums, range1: lowerRange, nums2: higherNums, range2: nextRange)
            } else {
                let nextRange = lowerRange.lowerBound...lowerIndex - 1
                return findKthInSortedArrays(k: k, nums1: lowerNums, range1: nextRange, nums2: higherNums, range2: higherRange)
            }
        }
    }
}

Solution().findMedianSortedArrays([1,3], [2])
