//
//  Array+BinarySearch.swift
//  Cities
//
//  Created by Chittapon Thongchim on 2/10/2565 BE.
//

import Foundation

public extension Array where Element: Comparable {

    /// Reference: https://github.com/raywenderlich/swift-algorithm-club/tree/master/Binary%20Search
    func binarySearch(key: Element) -> Int? {
        var lowerBound = 0
        var upperBound = count
        while lowerBound < upperBound {
            let midIndex = lowerBound + (upperBound - lowerBound) / 2
            if self[midIndex] == key {
                return midIndex
            } else if self[midIndex] < key {
                lowerBound = midIndex + 1
            } else {
                upperBound = midIndex
            }
        }
        return nil
    }
    
    /// To using binary search: the array must be sorted
    func binarySearchFilter(key: Element) -> [Element] {
        
        guard let middleIndex = binarySearch(key: key) else { return [] }
        
        /// Find left side start from middle index
        var lowerBound = middleIndex
        while lowerBound > startIndex {
            if self[lowerBound - 1] != key {
                break
            } else {
                lowerBound -= 1
            }
        }
        
        /// Find right side start from middle index
        var upperBound = middleIndex
        while upperBound < endIndex - 1 {
            if self[upperBound + 1] != key {
                break
            } else {
                upperBound += 1
            }
        }
        
        return Array(self[lowerBound...upperBound])
    }
}
