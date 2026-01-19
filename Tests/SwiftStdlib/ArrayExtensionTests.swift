//
//  ArrayExtensionTests.swift
//  Maple
//
//  Created by cy on 2026/1/19.
//

import Foundation
import Testing
@testable import Maple

@Suite("Array Extensions Test Suite")
struct ArrayExtensionTests {
    
    // MARK: - Protocol Conformance
    
    @Test("Array should conform to MapleCompatibleValue")
    func testArrayConformsToMapleCompatibleValue() {
        let array = [1, 2, 3]
        let wrapper = array.mp
        #expect(wrapper.base == array)
        #expect(type(of: wrapper) == MapleWrapper<[Int]>.self)
    }
    
    // MARK: - Method: withoutDuplicates (Equatable)
    
    @Test("withoutDuplicates should remove duplicate elements")
    func testWithoutDuplicates() {
        let array1 = [1, 1, 2, 2, 3, 3, 3, 4, 5]
        let result1 = array1.mp.withoutDuplicates()
        #expect(result1 == [1, 2, 3, 4, 5])
        
        let array2 = ["h", "e", "l", "l", "o"]
        let result2 = array2.mp.withoutDuplicates()
        #expect(result2 == ["h", "e", "l", "o"])
        
        let array3 = [1, 2, 3]
        let result3 = array3.mp.withoutDuplicates()
        #expect(result3 == [1, 2, 3])
        
        let array4: [Int] = []
        let result4 = array4.mp.withoutDuplicates()
        #expect(result4.isEmpty)
    }
    
    // MARK: - Method: withoutDuplicates (KeyPath Equatable)
    
    @Test("withoutDuplicates with Equatable KeyPath should remove duplicates by key path")
    func testWithoutDuplicatesWithEquatableKeyPath() {
        // Use a type that is Equatable but not Hashable to ensure we test the Equatable version
        struct EquatableOnly: Equatable {
            let value: String
        }
        
        struct Item {
            let key: EquatableOnly
            let data: Int
        }
        
        let items = [
            Item(key: EquatableOnly(value: "a"), data: 1),
            Item(key: EquatableOnly(value: "b"), data: 2),
            Item(key: EquatableOnly(value: "a"), data: 3), // duplicate key
            Item(key: EquatableOnly(value: "c"), data: 4)
        ]
        
        let result = items.mp.withoutDuplicates(keyPath: \.key)
        #expect(result.count == 3)
        #expect(result[0].key.value == "a")
        #expect(result[1].key.value == "b")
        #expect(result[2].key.value == "c")
        
        // Test empty array
        let empty: [Item] = []
        let emptyResult = empty.mp.withoutDuplicates(keyPath: \.key)
        #expect(emptyResult.isEmpty)
        
        // Test with all duplicates
        let allDuplicates = [
            Item(key: EquatableOnly(value: "x"), data: 1),
            Item(key: EquatableOnly(value: "x"), data: 2),
            Item(key: EquatableOnly(value: "x"), data: 3)
        ]
        let uniqueResult = allDuplicates.mp.withoutDuplicates(keyPath: \.key)
        #expect(uniqueResult.count == 1)
        #expect(uniqueResult[0].key.value == "x")
    }
    
    // MARK: - Method: withoutDuplicates (KeyPath Hashable)
    
    @Test("withoutDuplicates with Hashable KeyPath should remove duplicates")
    func testWithoutDuplicatesWithHashableKeyPath() {
        struct Person {
            let id: Int
            let name: String
        }
        
        let people = [
            Person(id: 1, name: "Alice"),
            Person(id: 2, name: "Bob"),
            Person(id: 1, name: "Alice"),
            Person(id: 3, name: "Charlie")
        ]
        
        // Int is Hashable, so this should use the Hashable version
        let result = people.mp.withoutDuplicates(keyPath: \.id)
        #expect(result.count == 3)
        #expect(result[0].id == 1)
        #expect(result[1].id == 2)
        #expect(result[2].id == 3)
        
        // Test empty array
        let empty: [Person] = []
        let emptyResult = empty.mp.withoutDuplicates(keyPath: \.id)
        #expect(emptyResult.isEmpty)
        
        // Test with String key path (String is Hashable)
        let people2 = [
            Person(id: 1, name: "Alice"),
            Person(id: 2, name: "Bob"),
            Person(id: 3, name: "Alice"), // duplicate name
            Person(id: 4, name: "Charlie")
        ]
        let result2 = people2.mp.withoutDuplicates(keyPath: \.name)
        #expect(result2.count == 3)
        #expect(result2.contains(where: { $0.name == "Alice" }))
        #expect(result2.contains(where: { $0.name == "Bob" }))
        #expect(result2.contains(where: { $0.name == "Charlie" }))
        
        // Test with all duplicates
        let allDuplicates = [
            Person(id: 1, name: "Same"),
            Person(id: 2, name: "Same"),
            Person(id: 3, name: "Same")
        ]
        let uniqueResult = allDuplicates.mp.withoutDuplicates(keyPath: \.name)
        #expect(uniqueResult.count == 1)
        #expect(uniqueResult[0].name == "Same")
    }
    
    // MARK: - Method: removeAll (MapleWrapper)
    
    @Test("removeAll should remove all instances of item")
    func testRemoveAll() {
        let array1 = [1, 2, 2, 3, 4, 5]
        let result1 = array1.mp.removeAll(2)
        #expect(result1 == [1, 3, 4, 5])
        
        let array2 = ["h", "e", "l", "l", "o"]
        let result2 = array2.mp.removeAll("l")
        #expect(result2 == ["h", "e", "o"])
        
        let array3 = [1, 2, 3]
        let result3 = array3.mp.removeAll(5)
        #expect(result3 == [1, 2, 3])
        
        let array4: [Int] = []
        let result4 = array4.mp.removeAll(1)
        #expect(result4.isEmpty)
    }
    
    // MARK: - Method: toSet
    
    @Test("toSet should convert array to set")
    func testToSet() {
        let array1 = [1, 2, 2, 3, 4, 5]
        let set1 = array1.mp.toSet()
        #expect(set1.count == 5)
        #expect(set1.contains(1))
        #expect(set1.contains(2))
        #expect(set1.contains(3))
        #expect(set1.contains(4))
        #expect(set1.contains(5))
        
        let array2 = ["h", "e", "l", "l", "o"]
        let set2 = array2.mp.toSet()
        #expect(set2.count == 4)
        #expect(set2.contains("h"))
        #expect(set2.contains("e"))
        #expect(set2.contains("l"))
        #expect(set2.contains("o"))
    }
    
    // MARK: - Method: removeAll (mutating Equatable)
    
    @Test("mutating removeAll should remove all instances of item")
    func testMutatingRemoveAll() {
        var array1 = [1, 2, 2, 3, 4, 5]
        let result1 = array1.removeAll(2)
        #expect(array1 == [1, 3, 4, 5])
        #expect(result1 == [1, 3, 4, 5])
        
        var array2 = ["h", "e", "l", "l", "o"]
        let result2 = array2.removeAll("l")
        #expect(array2 == ["h", "e", "o"])
        #expect(result2 == ["h", "e", "o"])
    }
    
    // MARK: - Method: removeAll (mutating array of items)
    
    @Test("mutating removeAll with array should remove all instances")
    func testMutatingRemoveAllWithArray() {
        var array1 = [1, 2, 2, 3, 4, 5]
        let result1 = array1.removeAll([2, 5])
        #expect(array1 == [1, 3, 4])
        #expect(result1 == [1, 3, 4])
        
        var array2 = ["h", "e", "l", "l", "o"]
        let result2 = array2.removeAll(["l", "h"])
        #expect(array2 == ["e", "o"])
        #expect(result2 == ["e", "o"])
        
        var array3 = [1, 2, 3]
        let result3 = array3.removeAll([])
        #expect(array3 == [1, 2, 3])
        #expect(result3 == [1, 2, 3])
        
        // Test empty array with empty items
        var array4: [Int] = []
        let result4 = array4.removeAll([])
        #expect(array4.isEmpty)
        #expect(result4.isEmpty)
    }
    
    // MARK: - Method: withoutDuplicates (mutating)
    
    @Test("mutating withoutDuplicates should remove duplicates in place")
    func testMutatingWithoutDuplicates() {
        var array1 = [1, 2, 2, 3, 4, 5]
        let result1 = array1.withoutDuplicates()
        #expect(array1 == [1, 2, 3, 4, 5])
        #expect(result1 == [1, 2, 3, 4, 5])
        
        var array2 = ["h", "e", "l", "l", "o"]
        let result2 = array2.withoutDuplicates()
        #expect(array2 == ["h", "e", "l", "o"])
        #expect(result2 == ["h", "e", "l", "o"])
        
        var array3 = [1, 2, 3]
        let result3 = array3.withoutDuplicates()
        #expect(array3 == [1, 2, 3])
        #expect(result3 == [1, 2, 3])
        
        // Test empty array
        var array4: [Int] = []
        let result4 = array4.withoutDuplicates()
        #expect(array4.isEmpty)
        #expect(result4.isEmpty)
    }
}
