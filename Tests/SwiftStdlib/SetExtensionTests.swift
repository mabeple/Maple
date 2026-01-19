//
//  SetExtensionTests.swift
//  Maple
//
//  Created by cy on 2026/1/19.
//

import Foundation
import Testing
@testable import Maple

@Suite("Set Extensions Test Suite")
struct SetExtensionTests {
    
    // MARK: - Protocol Conformance
    
    @Test("Set should conform to MapleCompatibleValue")
    func testSetConformsToMapleCompatibleValue() {
        let set: Set<Int> = [1, 2, 3]
        let wrapper = set.mp
        #expect(wrapper.base == set)
        #expect(type(of: wrapper) == MapleWrapper<Set<Int>>.self)
    }
    
    // MARK: - Method: hasIntersection
    
    @Test("hasIntersection should check if sets have common elements")
    func testHasIntersection() {
        let set1: Set<Int> = [1, 2, 3]
        let set2: Set<Int> = [3, 4, 5]
        #expect(set1.mp.hasIntersection(with: set2) == true)
        
        let set3: Set<Int> = [1, 2]
        let set4: Set<Int> = [3, 4]
        #expect(set3.mp.hasIntersection(with: set4) == false)
        
        let set5: Set<Int> = [1, 2, 3]
        let set6: Set<Int> = [1, 2, 3]
        #expect(set5.mp.hasIntersection(with: set6) == true)
    }
    
    // MARK: - Method: isProperSubset
    
    @Test("isProperSubset should check if set is proper subset")
    func testIsProperSubset() {
        let set1: Set<Int> = [1, 2]
        let set2: Set<Int> = [1, 2, 3]
        #expect(set1.mp.isProperSubset(of: set2) == true)
        
        let set3: Set<Int> = [1, 2, 3]
        #expect(set3.mp.isProperSubset(of: set2) == false)
        
        let set4: Set<Int> = [1]
        #expect(set4.mp.isProperSubset(of: set2) == true)
        
        let set5: Set<Int> = []
        #expect(set5.mp.isProperSubset(of: set2) == true)
    }
    
    // MARK: - Method: isProperSuperset
    
    @Test("isProperSuperset should check if set is proper superset")
    func testIsProperSuperset() {
        let set1: Set<Int> = [1, 2, 3]
        let set2: Set<Int> = [1, 2]
        #expect(set1.mp.isProperSuperset(of: set2) == true)
        
        let set3: Set<Int> = [1, 2, 3]
        #expect(set3.mp.isProperSuperset(of: set1) == false)
        
        let set4: Set<Int> = [1, 2, 3, 4]
        #expect(set4.mp.isProperSuperset(of: set1) == true)
        
        let set5: Set<Int> = [1, 2, 3]
        let set6: Set<Int> = []
        #expect(set5.mp.isProperSuperset(of: set6) == true)
    }
    
    // MARK: - Method: toArray
    
    @Test("toArray should convert set to array")
    func testToArray() {
        let set: Set<Int> = [1, 2, 3]
        let array = set.mp.toArray()
        #expect(array.count == 3)
        #expect(array.contains(1))
        #expect(array.contains(2))
        #expect(array.contains(3))
        
        let emptySet: Set<Int> = []
        let emptyArray = emptySet.mp.toArray()
        #expect(emptyArray.isEmpty)
        
        let stringSet: Set<String> = ["a", "b", "c"]
        let stringArray = stringSet.mp.toArray()
        #expect(stringArray.count == 3)
        #expect(stringArray.contains("a"))
        #expect(stringArray.contains("b"))
        #expect(stringArray.contains("c"))
    }
}
