//
//  CollectionExtensionTests.swift
//  Maple
//
//  Created by cy on 2026/1/19.
//

import Foundation
import Testing
@testable import Maple

@Suite("Collection Extensions Test Suite")
struct CollectionExtensionTests {
    
    // MARK: - Subscript: safe
    
    @Test("safe subscript should return element when index is valid")
    func testSafeSubscriptValid() {
        let array = [1, 2, 3, 4, 5]
        #expect(array[safe: 0] == 1)
        #expect(array[safe: 2] == 3)
        #expect(array[safe: 4] == 5)
        
        let string = "Hello"
        #expect(string[safe: string.startIndex] == "H")
    }
    
    @Test("safe subscript should return nil when index is out of bounds")
    func testSafeSubscriptOutOfBounds() {
        let array = [1, 2, 3, 4, 5]
        #expect(array[safe: 10] == nil)
        #expect(array[safe: -1] == nil)
        
        let emptyArray: [Int] = []
        #expect(emptyArray[safe: 0] == nil)
    }
    
    // MARK: - Method: group
    
    @Test("group should split collection into chunks")
    func testGroup() {
        let array = [0, 2, 4, 7]
        let grouped = array.mp.group(by: 2)
        #expect(grouped != nil)
        #expect(grouped! == [[0, 2], [4, 7]])
        
        let array2 = [0, 2, 4, 7, 6]
        let grouped2 = array2.mp.group(by: 2)
        #expect(grouped2 != nil)
        #expect(grouped2! == [[0, 2], [4, 7], [6]])
        
        let array3 = [1, 2, 3, 4, 5, 6, 7]
        let grouped3 = array3.mp.group(by: 3)
        #expect(grouped3 != nil)
        #expect(grouped3! == [[1, 2, 3], [4, 5, 6], [7]])
    }
    
    @Test("group should return nil for invalid size")
    func testGroupInvalidSize() {
        let array = [1, 2, 3]
        #expect(array.mp.group(by: 0) == nil)
        #expect(array.mp.group(by: -1) == nil)
        
        let emptyArray: [Int] = []
        #expect(emptyArray.mp.group(by: 2) == nil)
    }
    
    // MARK: - Method: indices (Equatable)
    
    @Test("indices should return all indices of item")
    func testIndices() {
        let array = [1, 2, 2, 3, 4, 2, 5]
        let indices = array.mp.indices(of: 2)
        #expect(indices.count == 3)
        #expect(array[indices[0]] == 2)
        #expect(array[indices[1]] == 2)
        #expect(array[indices[2]] == 2)
        
        let array2 = ["h", "e", "l", "l", "o"]
        let indices2 = array2.mp.indices(of: "l")
        #expect(indices2.count == 2)
        #expect(array2[indices2[0]] == "l")
        #expect(array2[indices2[1]] == "l")
        
        let array3 = [1, 2, 3]
        let indices3 = array3.mp.indices(of: 5)
        #expect(indices3.isEmpty)
    }
    
    // MARK: - Method: average (BinaryInteger)
    
    @Test("average should return average of BinaryInteger collection")
    func testAverageBinaryInteger() {
        let array = [1, 2, 3, 4, 5]
        let avg = array.mp.average()
        #expect(abs(avg - 3.0) < 0.0001)
        
        let array2 = [10, 20, 30]
        let avg2 = array2.mp.average()
        #expect(abs(avg2 - 20.0) < 0.0001)
        
        let emptyArray: [Int] = []
        let avgEmpty = emptyArray.mp.average()
        #expect(avgEmpty == 0.0)
    }
    
    // MARK: - Method: average (FloatingPoint)
    
    @Test("average should return average of FloatingPoint collection")
    func testAverageFloatingPoint() {
        let array: [Double] = [1.2, 2.3, 4.5, 3.4, 4.5]
        let avg = array.mp.average()
        let expected = (1.2 + 2.3 + 4.5 + 3.4 + 4.5) / 5.0
        #expect(abs(avg - expected) < 0.0001)
        
        let array2: [Float] = [1.0, 2.0, 3.0]
        let avg2 = array2.mp.average()
        #expect(abs(avg2 - 2.0) < 0.01)
        
        let emptyArray: [Double] = []
        let avgEmpty = emptyArray.mp.average()
        #expect(avgEmpty == 0.0)
    }
}
