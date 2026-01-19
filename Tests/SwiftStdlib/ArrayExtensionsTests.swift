//
//  ArrayExtensionsTests.swift
//  Maple
//
//  Created by cy on 2023/2/22.
//  Copyright © 2023 cy. All rights reserved.
//

@testable import Maple
import XCTest

final class ArrayExtensionsTests: XCTestCase {
    
    struct Person: Equatable {
        var name: String
        var age: Int?
        var location: Location?
        var isStudent: Bool

        init(name: String, age: Int?, location: Location? = nil, isStudent: Bool = false) {
            self.name = name
            self.age = age
            self.location = location
            self.isStudent = isStudent
        }
    }
    
    struct Location: Equatable {
        let city: String
    }
    
    func testRemoveAll() {
        var arr = [0, 1, 2, 0, 3, 4, 5, 0, 0]
        arr.removeAll(0)
        XCTAssertEqual(arr, [1, 2, 3, 4, 5])
        arr = []
        arr.removeAll(0)
        XCTAssertEqual(arr, [])
    }

    func testRemoveAllItems() {
        var arr = [0, 1, 2, 2, 0, 3, 4, 5, 0, 0]
        arr.removeAll([0, 2])
        XCTAssertEqual(arr, [1, 3, 4, 5])
        arr.removeAll([])
        XCTAssertEqual(arr, [1, 3, 4, 5])
        arr = []
        arr.removeAll([])
        XCTAssertEqual(arr, [])
    }

    func testRemoveDuplicates() {
        var array = [1, 1, 2, 2, 3, 3, 3, 4, 5]
        array.withoutDuplicates()
        XCTAssertEqual(array, [1, 2, 3, 4, 5])
    }

    func testWithoutDuplicates() {
        XCTAssertEqual([1, 1, 2, 2, 3, 3, 3, 4, 5].mp.withoutDuplicates(), [1, 2, 3, 4, 5])
        XCTAssertEqual(["h", "e", "l", "l", "o"].mp.withoutDuplicates(), ["h", "e", "l", "o"])
    }

    func testWithoutDuplicatesUsingKeyPath() {
        let array = [
            Person(name: "Wade", age: 20, location: Location(city: "London")),
            Person(name: "James", age: 32),
            Person(name: "James", age: 36),
            Person(name: "Rose", age: 29),
            Person(name: "James", age: 72, location: Location(city: "Moscow")),
            Person(name: "Rose", age: 56),
            Person(name: "Wade", age: 22, location: Location(city: "Prague"))
        ]
        let arrayWithoutDuplicatesHashable = array.mp.withoutDuplicates(keyPath: \.name)
        let arrayWithoutDuplicatesHashablePrepared = [
            Person(name: "Wade", age: 20, location: Location(city: "London")),
            Person(name: "James", age: 32),
            Person(name: "Rose", age: 29)
        ]
        XCTAssertEqual(arrayWithoutDuplicatesHashable, arrayWithoutDuplicatesHashablePrepared)
        let arrayWithoutDuplicatesNHashable = array.mp.withoutDuplicates(keyPath: \.location)
        let arrayWithoutDuplicatesNHashablePrepared = [
            Person(name: "Wade", age: 20, location: Location(city: "London")),
            Person(name: "James", age: 32),
            Person(name: "James", age: 72, location: Location(city: "Moscow")),
            Person(name: "Wade", age: 22, location: Location(city: "Prague"))
        ]
        XCTAssertEqual(arrayWithoutDuplicatesNHashable, arrayWithoutDuplicatesNHashablePrepared)
    }
    
    // MARK: - Test toSet()
    func testToSet() {
        // Test with Int array containing duplicates
        let array1 = [1, 2, 2, 3, 4, 5]
        let set1 = array1.mp.toSet()
        XCTAssertEqual(set1.count, 5)
        XCTAssertTrue(set1.contains(1))
        XCTAssertTrue(set1.contains(2))
        XCTAssertTrue(set1.contains(3))
        XCTAssertTrue(set1.contains(4))
        XCTAssertTrue(set1.contains(5))
        
        // Test with String array containing duplicates
        let array2 = ["h", "e", "l", "l", "o"]
        let set2 = array2.mp.toSet()
        XCTAssertEqual(set2.count, 4)
        XCTAssertTrue(set2.contains("h"))
        XCTAssertTrue(set2.contains("e"))
        XCTAssertTrue(set2.contains("l"))
        XCTAssertTrue(set2.contains("o"))
        
        // Test with empty array
        let array3: [Int] = []
        let set3 = array3.mp.toSet()
        XCTAssertTrue(set3.isEmpty)
        
        // Test with single element
        let array4 = [42]
        let set4 = array4.mp.toSet()
        XCTAssertEqual(set4.count, 1)
        XCTAssertTrue(set4.contains(42))
        
        // Test with all unique elements
        let array5 = [1, 2, 3, 4, 5]
        let set5 = array5.mp.toSet()
        XCTAssertEqual(set5.count, 5)
        XCTAssertEqual(set5, Set([1, 2, 3, 4, 5]))
        
        // Test with all same elements
        let array6 = [1, 1, 1, 1, 1]
        let set6 = array6.mp.toSet()
        XCTAssertEqual(set6.count, 1)
        XCTAssertTrue(set6.contains(1))
    }
}
