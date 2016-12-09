// #4 Median of Two Sorted Arrays https://leetcode.com/problems/median-of-two-sorted-arrays/
// 下面列出了两个解法，其中 Solution2 是自己想出来的，也过了全部测试数据，但方法非常不简洁。


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
