//
//  SequenceExtensionsTests.swift
//  Maple
//
//  Created by cy on 2026/1/19.
//  Copyright © 2026 cy. All rights reserved.
//

@testable import Maple
import XCTest

final class SequenceExtensionsTests: XCTestCase {
    
    // MARK: - Test all(matching:)
    func testAll() {
        let array1 = [2, 2, 4]
        XCTAssertTrue(array1.mp.all(matching: { $0 % 2 == 0 }))
        
        let array2 = [1, 2, 2, 4]
        XCTAssertFalse(array2.mp.all(matching: { $0 % 2 == 0 }))
        
        let array3: [Int] = []
        XCTAssertTrue(array3.mp.all(matching: { $0 % 2 == 0 })) // Empty sequence returns true
        
        let array4 = [1, 3, 5, 7]
        XCTAssertTrue(array4.mp.all(matching: { $0 % 2 == 1 }))
    }
    
    // MARK: - Test none(matching:)
    func testNone() {
        let array1 = [2, 2, 4]
        XCTAssertFalse(array1.mp.none(matching: { $0 % 2 == 0 }))
        
        let array2 = [1, 3, 5, 7]
        XCTAssertTrue(array2.mp.none(matching: { $0 % 2 == 0 }))
        
        let array3: [Int] = []
        XCTAssertTrue(array3.mp.none(matching: { $0 % 2 == 0 })) // Empty sequence returns true
        
        let array4 = [1, 2, 3, 4]
        XCTAssertFalse(array4.mp.none(matching: { $0 % 2 == 0 }))
    }
    
    // MARK: - Test any(matching:)
    func testAny() {
        let array1 = [2, 2, 4]
        XCTAssertTrue(array1.mp.any(matching: { $0 % 2 == 0 }))
        
        let array2 = [1, 3, 5, 7]
        XCTAssertFalse(array2.mp.any(matching: { $0 % 2 == 0 }))
        
        let array3: [Int] = []
        XCTAssertFalse(array3.mp.any(matching: { $0 % 2 == 0 })) // Empty sequence returns false
        
        let array4 = [1, 2, 3, 4]
        XCTAssertTrue(array4.mp.any(matching: { $0 % 2 == 0 }))
    }
    
    // MARK: - Test reject(where:)
    func testReject() {
        let array1 = [2, 2, 4, 7]
        let result1 = array1.mp.reject(where: { $0 % 2 == 0 })
        XCTAssertEqual(result1, [7])
        
        let array2 = [1, 2, 3, 4, 5]
        let result2 = array2.mp.reject(where: { $0 % 2 == 0 })
        XCTAssertEqual(result2, [1, 3, 5])
        
        let array3: [Int] = []
        let result3 = array3.mp.reject(where: { $0 % 2 == 0 })
        XCTAssertTrue(result3.isEmpty)
        
        let array4 = [1, 3, 5, 7]
        let result4 = array4.mp.reject(where: { $0 % 2 == 0 })
        XCTAssertEqual(result4, [1, 3, 5, 7])
    }
    
    // MARK: - Test forEach(where:body:)
    func testForEachWhere() {
        var result: [Int] = []
        let array1 = [0, 2, 4, 7]
        array1.mp.forEach(where: { $0 % 2 == 0 }, body: { result.append($0) })
        XCTAssertEqual(result.sorted(), [0, 2, 4])
        
        result.removeAll()
        let array2: [Int] = []
        array2.mp.forEach(where: { $0 % 2 == 0 }, body: { result.append($0) })
        XCTAssertTrue(result.isEmpty)
    }
    
    // MARK: - Test accumulate(initial:next:)
    func testAccumulate() {
        let array1 = [1, 2, 3]
        let result1 = array1.mp.accumulate(initial: 0, next: +)
        XCTAssertEqual(result1, [1, 3, 6])
        
        let array2 = [1, 2, 3]
        let result2 = array2.mp.accumulate(initial: 10, next: +)
        XCTAssertEqual(result2, [11, 13, 16])
        
        let array3: [Int] = []
        let result3 = array3.mp.accumulate(initial: 0, next: +)
        XCTAssertTrue(result3.isEmpty)
        
        let array4 = [2, 3, 4]
        let result4 = array4.mp.accumulate(initial: 1, next: *)
        XCTAssertEqual(result4, [2, 6, 24])
    }
    
    // MARK: - Test filtered(_:map:)
    func testFiltered() {
        let array1 = [1, 2, 3, 4, 5]
        let result1 = array1.mp.filtered({ $0 % 2 == 0 }, map: { String($0) })
        XCTAssertEqual(result1, ["2", "4"])
        
        let array2: [Int] = []
        let result2 = array2.mp.filtered({ $0 % 2 == 0 }, map: { String($0) })
        XCTAssertTrue(result2.isEmpty)
        
        let array3 = [1, 2, 3, 4, 5]
        let result3 = array3.mp.filtered({ $0 > 10 }, map: { String($0) })
        XCTAssertTrue(result3.isEmpty)
    }
    
    // MARK: - Test single(where:)
    func testSingle() {
        let array1: [Int] = []
        XCTAssertNil(array1.mp.single(where: { _ in true }))
        
        let array2 = [4]
        XCTAssertEqual(array2.mp.single(where: { _ in true }), 4)
        
        let array3 = [1, 4, 7]
        XCTAssertEqual(array3.mp.single(where: { $0 % 2 == 0 }), 4)
        
        let array4 = [2, 2, 4, 7]
        XCTAssertNil(array4.mp.single(where: { $0 % 2 == 0 })) // Multiple matches
        
        let array5 = [1, 3, 5, 7]
        XCTAssertNil(array5.mp.single(where: { $0 % 2 == 0 })) // No matches
    }
    
    // MARK: - Test withoutDuplicates(transform:)
    func testWithoutDuplicatesTransform() {
        let array1 = [1, 2, 1, 3, 2]
        let result1 = array1.mp.withoutDuplicates { $0 }
        XCTAssertEqual(result1.sorted(), [1, 2, 3])
        
        let tuples = [(1, 4), (2, 2), (1, 3), (3, 2), (2, 1)]
        let result2 = tuples.mp.withoutDuplicates { $0.0 }
        XCTAssertEqual(result2.count, 3)
        XCTAssertTrue(result2.contains { $0.0 == 1 })
        XCTAssertTrue(result2.contains { $0.0 == 2 })
        XCTAssertTrue(result2.contains { $0.0 == 3 })
        
        let array3: [Int] = []
        let result3 = array3.mp.withoutDuplicates { $0 }
        XCTAssertTrue(result3.isEmpty)
    }
    
    // MARK: - Test divided(by:)
    func testDivided() {
        let array1 = [0, 1, 2, 3, 4, 5]
        let (even, odd) = array1.mp.divided { $0 % 2 == 0 }
        XCTAssertEqual(even.sorted(), [0, 2, 4])
        XCTAssertEqual(odd.sorted(), [1, 3, 5])
        
        let array2: [Int] = []
        let (matching2, nonMatching2) = array2.mp.divided { $0 % 2 == 0 }
        XCTAssertTrue(matching2.isEmpty)
        XCTAssertTrue(nonMatching2.isEmpty)
        
        let array3 = [2, 4, 6]
        let (matching3, nonMatching3) = array3.mp.divided { $0 % 2 == 0 }
        XCTAssertEqual(matching3.sorted(), [2, 4, 6])
        XCTAssertTrue(nonMatching3.isEmpty)
        
        let array4 = [1, 3, 5]
        let (matching4, nonMatching4) = array4.mp.divided { $0 % 2 == 0 }
        XCTAssertTrue(matching4.isEmpty)
        XCTAssertEqual(nonMatching4.sorted(), [1, 3, 5])
    }
    
    // MARK: - Test sorted methods
    func testSortedByKeyPath() {
        struct Person {
            let name: String
            let age: Int
        }
        
        let people = [
            Person(name: "Alice", age: 30),
            Person(name: "Bob", age: 25),
            Person(name: "Charlie", age: 35)
        ]
        
        let sorted1 = people.mp.sorted(by: \.age)
        XCTAssertEqual(sorted1[0].name, "Bob")
        XCTAssertEqual(sorted1[1].name, "Alice")
        XCTAssertEqual(sorted1[2].name, "Charlie")
        
        let sorted2 = people.mp.sorted(by: \.name)
        XCTAssertEqual(sorted2[0].name, "Alice")
        XCTAssertEqual(sorted2[1].name, "Bob")
        XCTAssertEqual(sorted2[2].name, "Charlie")
    }
    
    func testSortedByKeyPathWithCompare() {
        struct Person {
            let age: Int
        }
        
        let people = [
            Person(age: 30),
            Person(age: 25),
            Person(age: 35)
        ]
        
        let sorted = people.mp.sorted(by: \.age, with: >)
        XCTAssertEqual(sorted[0].age, 35)
        XCTAssertEqual(sorted[1].age, 30)
        XCTAssertEqual(sorted[2].age, 25)
    }
    
    func testSortedByMap() {
        let array = [3, 1, 4, 1, 5]
        let sorted = array.mp.sorted(by: { $0 })
        XCTAssertEqual(sorted, [1, 1, 3, 4, 5])
        
        let sorted2 = array.mp.sorted(by: { -$0 })
        XCTAssertEqual(sorted2, [5, 4, 3, 1, 1])
    }
    
    func testSortedByMapWithCompare() {
        let array = [3, 1, 4, 1, 5]
        let sorted = array.mp.sorted(by: { $0 }, with: >)
        XCTAssertEqual(sorted, [5, 4, 3, 1, 1])
    }
    
    func testSortedByTwoKeyPaths() {
        struct Person {
            let name: String
            let age: Int
        }
        
        let people = [
            Person(name: "Alice", age: 30),
            Person(name: "Alice", age: 25),
            Person(name: "Bob", age: 30),
            Person(name: "Charlie", age: 35)
        ]
        
        let sorted = people.mp.sorted(by: \.name, and: \.age)
        XCTAssertEqual(sorted[0].name, "Alice")
        XCTAssertEqual(sorted[0].age, 25)
        XCTAssertEqual(sorted[1].name, "Alice")
        XCTAssertEqual(sorted[1].age, 30)
        XCTAssertEqual(sorted[2].name, "Bob")
        XCTAssertEqual(sorted[3].name, "Charlie")
    }
    
    func testSortedByTwoMaps() {
        struct Person {
            let name: String
            let age: Int
        }
        
        let people = [
            Person(name: "Alice", age: 30),
            Person(name: "Alice", age: 25),
            Person(name: "Bob", age: 30)
        ]
        
        let sorted = people.mp.sorted(by: { $0.name }, and: { $0.age })
        XCTAssertNotNil(sorted)
        XCTAssertEqual(sorted[0].age, 25)
        XCTAssertEqual(sorted[1].age, 30)
    }
    
    func testSortedByThreeKeyPaths() {
        struct Person {
            let firstName: String
            let lastName: String
            let age: Int
        }
        
        let people = [
            Person(firstName: "Alice", lastName: "Smith", age: 30),
            Person(firstName: "Alice", lastName: "Smith", age: 25),
            Person(firstName: "Alice", lastName: "Jones", age: 30),
            Person(firstName: "Bob", lastName: "Smith", age: 30)
        ]
        
        let sorted = people.mp.sorted(by: \.firstName, and: \.lastName, and: \.age)
        // Sorted by: firstName (Alice < Bob), then lastName (Jones < Smith), then age (25 < 30)
        // Expected order:
        // 0: Alice Jones 30
        // 1: Alice Smith 25
        // 2: Alice Smith 30
        // 3: Bob Smith 30
        XCTAssertEqual(sorted[0].firstName, "Alice")
        XCTAssertEqual(sorted[0].lastName, "Jones")
        XCTAssertEqual(sorted[0].age, 30)
        
        XCTAssertEqual(sorted[1].firstName, "Alice")
        XCTAssertEqual(sorted[1].lastName, "Smith")
        XCTAssertEqual(sorted[1].age, 25)
        
        XCTAssertEqual(sorted[2].firstName, "Alice")
        XCTAssertEqual(sorted[2].lastName, "Smith")
        XCTAssertEqual(sorted[2].age, 30)
        
        XCTAssertEqual(sorted[3].firstName, "Bob")
        XCTAssertEqual(sorted[3].lastName, "Smith")
        XCTAssertEqual(sorted[3].age, 30)
    }
    
    func testSortedByThreeMaps() {
        struct Person {
            let firstName: String
            let lastName: String
            let age: Int
        }
        
        let people = [
            Person(firstName: "Alice", lastName: "Smith", age: 30),
            Person(firstName: "Alice", lastName: "Smith", age: 25)
        ]
        
        let sorted = people.mp.sorted(by: { $0.firstName }, and: { $0.lastName }, and: { $0.age })
        XCTAssertNotNil(sorted)
        XCTAssertEqual(sorted[0].age, 25)
        XCTAssertEqual(sorted[1].age, 30)
    }
    
    // MARK: - Test sum(for:)
    func testSumForKeyPath() {
        struct Person {
            let name: String
            let age: Int
        }
        
        let people = [
            Person(name: "James", age: 5),
            Person(name: "Wade", age: 5),
            Person(name: "Bryant", age: 5)
        ]
        
        XCTAssertEqual(people.mp.sum(for: \.age), 15)
        
        let empty: [Person] = []
        XCTAssertEqual(empty.mp.sum(for: \.age), 0)
    }
    
    func testSumForMap() {
        struct Person {
            let name: String
        }
        
        let people = [
            Person(name: "James"),
            Person(name: "Wade"),
            Person(name: "Bryant")
        ]
        
        let sum = people.mp.sum(for: { $0.name.count })
        XCTAssertEqual(sum, 15)
    }
    
    // MARK: - Test product(for:)
    func testProductForMap() {
        struct Person {
            let name: String
        }
        
        let people = [
            Person(name: "James"),
            Person(name: "Wade"),
            Person(name: "Bryant")
        ]
        
        let product = people.mp.product(for: { $0.name.count })
        XCTAssertEqual(product, 120) // 5 * 4 * 6 = 120
    }
    
    // MARK: - Test first(where:equals:)
    func testFirstWhereKeyPathEquals() {
        struct Person {
            let name: String
            let age: Int
        }
        
        let people = [
            Person(name: "Alice", age: 30),
            Person(name: "Bob", age: 25),
            Person(name: "Charlie", age: 30)
        ]
        
        let result1 = people.mp.first(where: \.age, equals: 30)
        XCTAssertEqual(result1?.name, "Alice")
        
        let result2 = people.mp.first(where: \.age, equals: 25)
        XCTAssertEqual(result2?.name, "Bob")
        
        let result3 = people.mp.first(where: \.age, equals: 40)
        XCTAssertNil(result3)
    }
    
    func testFirstWhereMapEquals() {
        struct Person {
            let name: String
        }
        
        let people = [
            Person(name: "Alice"),
            Person(name: "Bob"),
            Person(name: "Charlie")
        ]
        
        let result1 = people.mp.first(where: { $0.name.count }, equals: 5)
        XCTAssertEqual(result1?.name, "Alice")
        
        let result2 = people.mp.first(where: { $0.name.count }, equals: 10)
        XCTAssertNil(result2)
    }
    
    // MARK: - Test contains (Equatable)
    func testContainsEquatable() {
        let array1 = [1, 2, 3, 4, 5]
        XCTAssertTrue(array1.mp.contains([1, 2]))
        XCTAssertTrue(array1.mp.contains([3, 4, 5]))
        XCTAssertFalse(array1.mp.contains([2, 6]))
        
        let array2 = ["h", "e", "l", "l", "o"]
        XCTAssertTrue(array2.mp.contains(["l", "o"]))
        XCTAssertFalse(array2.mp.contains(["x", "y"]))
        
        let emptyArray: [Int] = []
        XCTAssertTrue(emptyArray.mp.contains([]))
        XCTAssertFalse(emptyArray.mp.contains([1]))
    }
    
    // MARK: - Test contains (Hashable)
    func testContainsHashable() {
        // Test with Int array
        let array1 = [1, 2, 3, 4, 5]
        XCTAssertTrue(array1.mp.contains([1, 2]))
        XCTAssertTrue(array1.mp.contains([3, 4, 5]))
        XCTAssertFalse(array1.mp.contains([2, 6]))
        XCTAssertFalse(array1.mp.contains([6, 7]))
        
        // Test with String array
        let array2 = ["h", "e", "l", "l", "o"]
        XCTAssertTrue(array2.mp.contains(["l", "o"]))
        XCTAssertTrue(array2.mp.contains(["h", "e"]))
        XCTAssertFalse(array2.mp.contains(["x", "y"]))
        
        // Test with Set
        let set1: Set<Int> = [1, 2, 3, 4, 5]
        XCTAssertTrue(set1.mp.contains([1, 2]))
        XCTAssertFalse(set1.mp.contains([6, 7]))
        
        // Test with empty sequence
        let emptyArray: [Int] = []
        XCTAssertTrue(emptyArray.mp.contains([]))
        XCTAssertFalse(emptyArray.mp.contains([1]))
        
        // Test with empty elements
        let array3 = [1, 2, 3]
        XCTAssertTrue(array3.mp.contains([]))
    }
    
    // MARK: - Test containsDuplicates
    func testContainsDuplicates() {
        // Test with duplicates
        let array1 = [1, 2, 2, 3, 4]
        XCTAssertTrue(array1.mp.containsDuplicates())
        
        let array2 = [1, 1, 2, 2, 3, 3, 3]
        XCTAssertTrue(array2.mp.containsDuplicates())
        
        let stringArray = ["h", "e", "l", "l", "o"]
        XCTAssertTrue(stringArray.mp.containsDuplicates())
        
        // Test without duplicates
        let array3 = [1, 2, 3, 4, 5]
        XCTAssertFalse(array3.mp.containsDuplicates())
        
        let array4: [Int] = []
        XCTAssertFalse(array4.mp.containsDuplicates())
        
        let array5 = [1]
        XCTAssertFalse(array5.mp.containsDuplicates())
    }
    
    // MARK: - Test duplicates
    func testDuplicates() {
        // Test with multiple duplicates
        let array1 = [1, 1, 2, 2, 3, 3, 3, 4, 5]
        let duplicates1 = array1.mp.duplicates().sorted()
        XCTAssertEqual(duplicates1, [1, 2, 3])
        
        // Test with single duplicate
        let array2 = ["h", "e", "l", "l", "o"]
        let duplicates2 = array2.mp.duplicates().sorted()
        XCTAssertEqual(duplicates2, ["l"])
        
        // Test without duplicates
        let array3 = [1, 2, 3, 4, 5]
        let duplicates3 = array3.mp.duplicates()
        XCTAssertTrue(duplicates3.isEmpty)
        
        // Test with empty array
        let array4: [Int] = []
        let duplicates4 = array4.mp.duplicates()
        XCTAssertTrue(duplicates4.isEmpty)
        
        // Test with all same elements
        let array5 = [1, 1, 1, 1]
        let duplicates5 = array5.mp.duplicates()
        XCTAssertEqual(duplicates5.count, 1)
        XCTAssertTrue(duplicates5.contains(1))
    }
    
    // MARK: - Test sum (AdditiveArithmetic)
    func testSum() {
        // Test with Int array
        let array1 = [1, 2, 3, 4, 5]
        XCTAssertEqual(array1.mp.sum(), 15)
        
        // Test with empty array
        let array2: [Int] = []
        XCTAssertEqual(array2.mp.sum(), 0)
        
        // Test with single element
        let array3 = [10]
        XCTAssertEqual(array3.mp.sum(), 10)
        
        // Test with negative numbers
        let array4 = [-1, -2, -3]
        XCTAssertEqual(array4.mp.sum(), -6)
        
        // Test with mixed positive and negative
        let array5 = [1, -2, 3, -4, 5]
        XCTAssertEqual(array5.mp.sum(), 3)
        
        // Test with Double array
        let array6 = [1.5, 2.5, 3.0]
        XCTAssertEqual(array6.mp.sum(), 7.0, accuracy: 0.001)
        
        // Test with Float array
        let array7: [Float] = [1.5, 2.5, 3.0]
        XCTAssertEqual(array7.mp.sum(), 7.0, accuracy: 0.001)
    }
    
    // MARK: - Test product (Numeric)
    func testProduct() {
        // Test with Int array
        let array1 = [1, 2, 3, 4, 5]
        XCTAssertEqual(array1.mp.product(), 120)
        
        // Test with empty array (should return 1)
        let array2: [Int] = []
        XCTAssertEqual(array2.mp.product(), 1)
        
        // Test with single element
        let array3 = [10]
        XCTAssertEqual(array3.mp.product(), 10)
        
        // Test with zero
        let array4 = [1, 2, 0, 4, 5]
        XCTAssertEqual(array4.mp.product(), 0)
        
        // Test with negative numbers
        let array5 = [-1, -2, -3]
        XCTAssertEqual(array5.mp.product(), -6)
        
        // Test with mixed positive and negative
        let array6 = [1, -2, 3, -4]
        XCTAssertEqual(array6.mp.product(), 24)
        
        // Test with Double array
        let array7 = [1.5, 2.0, 3.0]
        XCTAssertEqual(array7.mp.product(), 9.0, accuracy: 0.001)
        
        // Test with Float array
        let array8: [Float] = [1.5, 2.0, 3.0]
        XCTAssertEqual(array8.mp.product(), 9.0, accuracy: 0.001)
    }
}
