//
//  SetExtensionsTests.swift
//  Maple
//
//  Created by cy on 2026/1/19.
//  Copyright © 2026 cy. All rights reserved.
//

@testable import Maple
import XCTest

final class SetExtensionsTests: XCTestCase {
    
    // MARK: - Test hasIntersection(with:)
    func testHasIntersection() {
        // Test with intersection
        let set1: Set<Int> = [1, 2, 3]
        let set2: Set<Int> = [3, 4, 5]
        XCTAssertTrue(set1.mp.hasIntersection(with: set2))
        
        // Test without intersection
        let set3: Set<Int> = [1, 2]
        let set4: Set<Int> = [3, 4]
        XCTAssertFalse(set3.mp.hasIntersection(with: set4))
        
        // Test with same elements
        let set5: Set<Int> = [1, 2, 3]
        let set6: Set<Int> = [1, 2, 3]
        XCTAssertTrue(set5.mp.hasIntersection(with: set6))
        
        // Test with empty set
        let set7: Set<Int> = [1, 2, 3]
        let set8: Set<Int> = []
        XCTAssertFalse(set7.mp.hasIntersection(with: set8))
        XCTAssertFalse(set8.mp.hasIntersection(with: set7))
        
        // Test with partial overlap
        let set9: Set<String> = ["a", "b", "c"]
        let set10: Set<String> = ["c", "d", "e"]
        XCTAssertTrue(set9.mp.hasIntersection(with: set10))
    }
    
    // MARK: - Test isProperSubset(of:)
    func testIsProperSubset() {
        // Test proper subset
        let set1: Set<Int> = [1, 2]
        let set2: Set<Int> = [1, 2, 3]
        XCTAssertTrue(set1.mp.isProperSubset(of: set2))
        
        // Test not a proper subset (equal sets)
        let set3: Set<Int> = [1, 2, 3]
        let set4: Set<Int> = [1, 2, 3]
        XCTAssertFalse(set3.mp.isProperSubset(of: set4))
        
        // Test not a subset at all
        let set5: Set<Int> = [1, 2, 4]
        let set6: Set<Int> = [1, 2, 3]
        XCTAssertFalse(set5.mp.isProperSubset(of: set6))
        
        // Test empty set is proper subset
        let set7: Set<Int> = []
        let set8: Set<Int> = [1, 2, 3]
        XCTAssertTrue(set7.mp.isProperSubset(of: set8))
        
        // Test empty set is not proper subset of empty set
        let set9: Set<Int> = []
        let set10: Set<Int> = []
        XCTAssertFalse(set9.mp.isProperSubset(of: set10))
        
        // Test with String set
        let set11: Set<String> = ["a", "b"]
        let set12: Set<String> = ["a", "b", "c"]
        XCTAssertTrue(set11.mp.isProperSubset(of: set12))
    }
    
    // MARK: - Test isProperSuperset(of:)
    func testIsProperSuperset() {
        // Test proper superset
        let set1: Set<Int> = [1, 2, 3]
        let set2: Set<Int> = [1, 2]
        XCTAssertTrue(set1.mp.isProperSuperset(of: set2))
        
        // Test not a proper superset (equal sets)
        let set3: Set<Int> = [1, 2, 3]
        let set4: Set<Int> = [1, 2, 3]
        XCTAssertFalse(set3.mp.isProperSuperset(of: set4))
        
        // Test not a superset at all
        let set5: Set<Int> = [1, 2, 4]
        let set6: Set<Int> = [1, 2, 3]
        XCTAssertFalse(set5.mp.isProperSuperset(of: set6))
        
        // Test empty set is not proper superset of non-empty set
        let set7: Set<Int> = []
        let set8: Set<Int> = [1, 2, 3]
        XCTAssertFalse(set7.mp.isProperSuperset(of: set8))
        
        // Test non-empty set is proper superset of empty set
        let set9: Set<Int> = [1, 2, 3]
        let set10: Set<Int> = []
        XCTAssertTrue(set9.mp.isProperSuperset(of: set10))
        
        // Test empty set is not proper superset of empty set
        let set11: Set<Int> = []
        let set12: Set<Int> = []
        XCTAssertFalse(set11.mp.isProperSuperset(of: set12))
        
        // Test with String set
        let set13: Set<String> = ["a", "b", "c"]
        let set14: Set<String> = ["a", "b"]
        XCTAssertTrue(set13.mp.isProperSuperset(of: set14))
    }
    
    // MARK: - Test toArray()
    func testToArray() {
        // Test with Int set
        let set1: Set<Int> = [1, 2, 3]
        let array1 = set1.mp.toArray()
        XCTAssertEqual(array1.count, 3)
        XCTAssertTrue(array1.contains(1))
        XCTAssertTrue(array1.contains(2))
        XCTAssertTrue(array1.contains(3))
        
        // Test with empty set
        let set2: Set<Int> = []
        let array2 = set2.mp.toArray()
        XCTAssertTrue(array2.isEmpty)
        
        // Test with String set
        let set3: Set<String> = ["a", "b", "c"]
        let array3 = set3.mp.toArray()
        XCTAssertEqual(array3.count, 3)
        XCTAssertTrue(array3.contains("a"))
        XCTAssertTrue(array3.contains("b"))
        XCTAssertTrue(array3.contains("c"))
        
        // Test with single element
        let set4: Set<Int> = [42]
        let array4 = set4.mp.toArray()
        XCTAssertEqual(array4.count, 1)
        XCTAssertEqual(array4[0], 42)
    }
}
