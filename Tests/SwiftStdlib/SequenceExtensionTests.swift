//
//  SequenceExtensionTests.swift
//  Maple
//
//  Created by cy on 2026/1/19.
//

import Foundation
import Testing
@testable import Maple

@Suite("Sequence Extensions Test Suite")
struct SequenceExtensionTests {
    
    // MARK: - Protocol Conformance
    
    @Test("Sequence should have mp property")
    func testSequenceHasMPProperty() {
        let array = [1, 2, 3]
        let wrapper = array.mp
        #expect(wrapper.base == array)
    }
    
    // MARK: - Method: all
    
    @Test("all should check if all elements match condition")
    func testAll() {
        let array = [2, 2, 4]
        #expect(array.mp.all(matching: { $0 % 2 == 0 }) == true)
        
        let array2 = [1, 2, 2, 4]
        #expect(array2.mp.all(matching: { $0 % 2 == 0 }) == false)
        
        let emptyArray: [Int] = []
        #expect(emptyArray.mp.all(matching: { $0 % 2 == 0 }) == true)
    }
    
    // MARK: - Method: none
    
    @Test("none should check if no elements match condition")
    func testNone() {
        let array = [2, 2, 4]
        #expect(array.mp.none(matching: { $0 % 2 == 0 }) == false)
        
        let array2 = [1, 3, 5, 7]
        #expect(array2.mp.none(matching: { $0 % 2 == 0 }) == true)
        
        let emptyArray: [Int] = []
        #expect(emptyArray.mp.none(matching: { $0 % 2 == 0 }) == true)
    }
    
    // MARK: - Method: any
    
    @Test("any should check if any element matches condition")
    func testAny() {
        let array = [2, 2, 4]
        #expect(array.mp.any(matching: { $0 % 2 == 0 }) == true)
        
        let array2 = [1, 3, 5, 7]
        #expect(array2.mp.any(matching: { $0 % 2 == 0 }) == false)
        
        let emptyArray: [Int] = []
        #expect(emptyArray.mp.any(matching: { $0 % 2 == 0 }) == false)
    }
    
    // MARK: - Method: reject
    
    @Test("reject should filter elements that don't match condition")
    func testReject() {
        let array = [2, 2, 4, 7]
        let rejected = array.mp.reject(where: { $0 % 2 == 0 })
        #expect(rejected == [7])
        
        let array2 = [1, 2, 3, 4, 5]
        let rejected2 = array2.mp.reject(where: { $0 > 3 })
        #expect(rejected2 == [1, 2, 3])
    }
    
    // MARK: - Method: forEach
    
    @Test("forEach should call body for elements matching condition")
    func testForEach() {
        var result: [Int] = []
        [0, 2, 4, 7].mp.forEach(where: { $0 % 2 == 0 }, body: { result.append($0) })
        #expect(result == [0, 2, 4])
    }
    
    // MARK: - Method: accumulate
    
    @Test("accumulate should return accumulated values")
    func testAccumulate() {
        let array = [1, 2, 3]
        let accumulated = array.mp.accumulate(initial: 0, next: +)
        #expect(accumulated == [1, 3, 6])
        
        let array2 = [1, 2, 3, 4]
        let accumulated2 = array2.mp.accumulate(initial: 10, next: +)
        #expect(accumulated2 == [11, 13, 16, 20])
    }
    
    // MARK: - Method: filtered
    
    @Test("filtered should filter and map in single operation")
    func testFiltered() {
        let array = [1, 2, 3, 4, 5]
        let filtered = array.mp.filtered({ $0 % 2 == 0 }, map: { String($0) })
        #expect(filtered == ["2", "4"])
    }
    
    // MARK: - Method: single
    
    @Test("single should return only element matching condition")
    func testSingle() {
        let emptyArray: [Int] = []
        #expect(emptyArray.mp.single(where: { _ in true }) == nil)
        
        let array = [4]
        #expect(array.mp.single(where: { _ in true }) == 4)
        
        let array2 = [1, 4, 7]
        #expect(array2.mp.single(where: { $0 % 2 == 0 }) == 4)
        
        let array3 = [2, 2, 4, 7]
        #expect(array3.mp.single(where: { $0 % 2 == 0 }) == nil) // multiple matches
    }
    
    // MARK: - Method: withoutDuplicates
    
    @Test("withoutDuplicates should remove duplicates based on transform")
    func testWithoutDuplicates() {
        let array = [1, 2, 1, 3, 2]
        let unique = array.mp.withoutDuplicates { $0 }
        #expect(unique == [1, 2, 3])
        
        struct Pair {
            let first: Int
            let second: Int
        }
        let pairs = [
            Pair(first: 1, second: 4),
            Pair(first: 2, second: 2),
            Pair(first: 1, second: 3),
            Pair(first: 3, second: 2),
            Pair(first: 2, second: 1)
        ]
        let uniquePairs = pairs.mp.withoutDuplicates { $0.first }
        #expect(uniquePairs.count == 3)
    }
    
    // MARK: - Method: divided
    
    @Test("divided should separate items into matching and non-matching")
    func testDivided() {
        let array = [0, 1, 2, 3, 4, 5]
        let (even, odd) = array.mp.divided { $0 % 2 == 0 }
        #expect(even == [0, 2, 4])
        #expect(odd == [1, 3, 5])
        
        let array2 = [1, 2, 3]
        let (greater, less) = array2.mp.divided { $0 > 2 }
        #expect(greater == [3])
        #expect(less == [1, 2])
    }
    
    // MARK: - Method: sorted (by keyPath with compare)
    
    @Test("sorted by keyPath with compare should sort array")
    func testSortedByKeyPathWithCompare() {
        struct Person {
            let age: Int
            let name: String
        }
        let people = [
            Person(age: 30, name: "Alice"),
            Person(age: 20, name: "Bob"),
            Person(age: 25, name: "Charlie")
        ]
        let sorted = people.mp.sorted(by: \.age, with: >)
        #expect(sorted[0].age == 30)
        #expect(sorted[1].age == 25)
        #expect(sorted[2].age == 20)
    }
    
    // MARK: - Method: sorted (by map with compare)
    
    @Test("sorted by map with compare should sort array")
    func testSortedByMapWithCompare() {
        let array = [3, 1, 4, 1, 5]
        let sorted = array.mp.sorted(by: { $0 }, with: >)
        #expect(sorted == [5, 4, 3, 1, 1])
    }
    
    // MARK: - Method: sorted (by keyPath Comparable)
    
    @Test("sorted by Comparable keyPath should sort array")
    func testSortedByComparableKeyPath() {
        struct Person {
            let age: Int
        }
        let people = [
            Person(age: 30),
            Person(age: 20),
            Person(age: 25)
        ]
        let sorted = people.mp.sorted(by: \.age)
        #expect(sorted[0].age == 20)
        #expect(sorted[1].age == 25)
        #expect(sorted[2].age == 30)
    }
    
    // MARK: - Method: sorted (by map Comparable)
    
    @Test("sorted by Comparable map should sort array")
    func testSortedByComparableMap() {
        let array = [3, 1, 4, 1, 5]
        let sorted = array.mp.sorted(by: { $0 })
        #expect(sorted == [1, 1, 3, 4, 5])
    }
    
    // MARK: - Method: sorted (by two keyPaths)
    
    @Test("sorted by two keyPaths should sort array")
    func testSortedByTwoKeyPaths() {
        struct Person {
            let age: Int
            let name: String
        }
        let people = [
            Person(age: 30, name: "Alice"),
            Person(age: 30, name: "Bob"),
            Person(age: 20, name: "Charlie")
        ]
        let sorted = people.mp.sorted(by: \.age, and: \.name)
        #expect(sorted[0].age == 20)
        #expect(sorted[1].age == 30)
        #expect(sorted[1].name == "Alice")
        #expect(sorted[2].name == "Bob")
    }
    
    // MARK: - Method: sorted (by two maps)
    
    @Test("sorted by two maps should sort array")
    func testSortedByTwoMaps() {
        struct Point {
            let x: Int
            let y: Int
        }
        let points = [
            Point(x: 1, y: 2),
            Point(x: 1, y: 1),
            Point(x: 0, y: 0)
        ]
        let sorted = points.mp.sorted(by: { $0.x }, and: { $0.y })
        #expect(sorted[0].x == 0)
        #expect(sorted[1].x == 1)
        #expect(sorted[1].y == 1)
        #expect(sorted[2].y == 2)
    }
    
    // MARK: - Method: sorted (by three keyPaths)
    
    @Test("sorted by three keyPaths should sort array")
    func testSortedByThreeKeyPaths() {
        struct Person {
            let age: Int
            let name: String
            let id: Int
        }
        
        // Test case 1: keyPath1 differs (branch 1)
        let people1 = [
            Person(age: 30, name: "Alice", id: 2),
            Person(age: 20, name: "Bob", id: 3),
            Person(age: 30, name: "Alice", id: 1)
        ]
        let sorted1 = people1.mp.sorted(by: \.age, and: \.name, and: \.id)
        #expect(sorted1[0].age == 20) // Different age, so sorted by age
        
        // Test case 2: keyPath1 same, keyPath2 differs (branch 2)
        let people2 = [
            Person(age: 30, name: "Bob", id: 2),
            Person(age: 30, name: "Alice", id: 1),
            Person(age: 30, name: "Charlie", id: 3)
        ]
        let sorted2 = people2.mp.sorted(by: \.age, and: \.name, and: \.id)
        #expect(sorted2[0].age == 30)
        #expect(sorted2[0].name == "Alice") // Same age, sorted by name
        #expect(sorted2[1].name == "Bob")
        #expect(sorted2[2].name == "Charlie")
        
        // Test case 3: keyPath1 and keyPath2 same, use keyPath3 (branch 3)
        let people3 = [
            Person(age: 30, name: "Alice", id: 2),
            Person(age: 30, name: "Alice", id: 1),
            Person(age: 30, name: "Alice", id: 3)
        ]
        let sorted3 = people3.mp.sorted(by: \.age, and: \.name, and: \.id)
        #expect(sorted3[0].age == 30)
        #expect(sorted3[0].name == "Alice")
        #expect(sorted3[0].id == 1) // Same age and name, sorted by id
        #expect(sorted3[1].id == 2)
        #expect(sorted3[2].id == 3)
        
        // Test case 4: Mixed scenario covering all branches
        let people4 = [
            Person(age: 30, name: "Alice", id: 2),
            Person(age: 30, name: "Alice", id: 1),
            Person(age: 20, name: "Bob", id: 3),
            Person(age: 30, name: "Bob", id: 4)
        ]
        let sorted4 = people4.mp.sorted(by: \.age, and: \.name, and: \.id)
        #expect(sorted4[0].age == 20) // Different age (branch 1)
        #expect(sorted4[1].age == 30)
        #expect(sorted4[1].name == "Alice") // Same age, different name (branch 2)
        #expect(sorted4[1].id == 1) // Same age and name, different id (branch 3)
        #expect(sorted4[2].id == 2)
        #expect(sorted4[3].name == "Bob") // Same age, different name (branch 2)
    }
    
    // MARK: - Method: sorted (by three maps)
    
    @Test("sorted by three maps should sort array")
    func testSortedByThreeMaps() {
        struct Point {
            let x: Int
            let y: Int
            let z: Int
        }
        
        // Test case: Mixed scenario covering all branches with multiple comparisons
        let points = [
            Point(x: 2, y: 1, z: 2),
            Point(x: 1, y: 1, z: 2),
            Point(x: 1, y: 1, z: 1),
            Point(x: 0, y: 0, z: 0),
            Point(x: 1, y: 2, z: 4),
            Point(x: 2, y: 0, z: 1)
        ]
        let sorted = points.mp.sorted(by: { $0.x }, and: { $0.y }, and: { $0.z })
        #expect(sorted[0].x == 0) // Different x (branch 1)
        #expect(sorted[1].x == 1)
        #expect(sorted[1].y == 1) // Same x, different y (branch 2)
        #expect(sorted[1].z == 1) // Same x and y, different z (branch 3)
        #expect(sorted[2].z == 2)
        #expect(sorted[3].y == 2) // Same x, different y (branch 2)
        #expect(sorted[4].x == 2) // Different x (branch 1)
        #expect(sorted[4].y == 0)
        #expect(sorted[5].y == 1)
    }
    
    // MARK: - Method: sum (for keyPath)
    
    @Test("sum for keyPath should sum AdditiveArithmetic properties")
    func testSumForKeyPath() {
        struct Person {
            let age: Int
        }
        let people = [
            Person(age: 20),
            Person(age: 30),
            Person(age: 40)
        ]
        let totalAge = people.mp.sum(for: \.age)
        #expect(totalAge == 90)
    }
    
    // MARK: - Method: sum (for map)
    
    @Test("sum for map should sum AdditiveArithmetic values")
    func testSumForMap() {
        let array = [1, 2, 3, 4, 5]
        let sum = array.mp.sum(for: { $0 })
        #expect(sum == 15)
    }
    
    // MARK: - Method: product (for map)
    
    @Test("product for map should calculate product")
    func testProductForMap() {
        let array = [1, 2, 3, 4, 5]
        let product = array.mp.product(for: { $0 })
        #expect(product == 120)
        
        let array2 = [2, 3, 4]
        let product2 = array2.mp.product(for: { $0 })
        #expect(product2 == 24)
    }
    
    // MARK: - Method: first (where keyPath equals)
    
    @Test("first where keyPath equals should return first matching element")
    func testFirstWhereKeyPathEquals() {
        struct Person {
            let age: Int
            let name: String
        }
        let people = [
            Person(age: 20, name: "Alice"),
            Person(age: 30, name: "Bob"),
            Person(age: 20, name: "Charlie")
        ]
        let first = people.mp.first(where: \.age, equals: 20)
        #expect(first?.name == "Alice")
        
        let notFound = people.mp.first(where: \.age, equals: 40)
        #expect(notFound == nil)
    }
    
    // MARK: - Method: first (where map equals)
    
    @Test("first where map equals should return first matching element")
    func testFirstWhereMapEquals() {
        let array = [1, 2, 3, 4, 5]
        let first = array.mp.first(where: { $0 * 2 }, equals: 6)
        #expect(first == 3)
        
        let notFound = array.mp.first(where: { $0 * 2 }, equals: 20)
        #expect(notFound == nil)
    }
    
    // MARK: - Method: contains (Equatable)
    
    @Test("contains should check if sequence contains all elements")
    func testContainsEquatable() {
        // Use a type that is Equatable but not Hashable to ensure we test the Equatable version
        struct EquatableOnly: Equatable {
            let value: Int
        }
        
        let array = [
            EquatableOnly(value: 1),
            EquatableOnly(value: 2),
            EquatableOnly(value: 3),
            EquatableOnly(value: 4),
            EquatableOnly(value: 5)
        ]
        
        let search1 = [EquatableOnly(value: 1), EquatableOnly(value: 2)]
        #expect(array.mp.contains(search1) == true)
        
        let search2 = [EquatableOnly(value: 2), EquatableOnly(value: 6)]
        #expect(array.mp.contains(search2) == false)
        
        let search3 = [EquatableOnly(value: 3), EquatableOnly(value: 4)]
        #expect(array.mp.contains(search3) == true)
        
        // Test with empty search sequence
        let emptySearch: [EquatableOnly] = []
        #expect(array.mp.contains(emptySearch) == true)
        
        // Test with single element
        let singleSearch = [EquatableOnly(value: 1)]
        #expect(array.mp.contains(singleSearch) == true)
        
        let singleSearchNotFound = [EquatableOnly(value: 10)]
        #expect(array.mp.contains(singleSearchNotFound) == false)
    }
    
    // MARK: - Method: contains (Hashable)
    
    @Test("contains should check if sequence contains all elements (Hashable)")
    func testContainsHashable() {
        let array = [1, 2, 3, 4, 5]
        #expect(array.mp.contains([1, 2]) == true)
        #expect(array.mp.contains([2, 6]) == false)
        
        let array2 = ["h", "e", "l", "l", "o"]
        #expect(array2.mp.contains(["l", "o"]) == true)
    }
    
    // MARK: - Method: containsDuplicates
    
    @Test("containsDuplicates should check if sequence has duplicates")
    func testContainsDuplicates() {
        let array = [1, 2, 2, 3, 4]
        #expect(array.mp.containsDuplicates() == true)
        
        let array2 = [1, 2, 3, 4, 5]
        #expect(array2.mp.containsDuplicates() == false)
        
        let array3 = [1, 1, 1]
        #expect(array3.mp.containsDuplicates() == true)
    }
    
    // MARK: - Method: duplicates
    
    @Test("duplicates should return duplicated elements")
    func testDuplicates() {
        let array = [1, 1, 2, 2, 3, 3, 3, 4, 5]
        let duplicates = array.mp.duplicates().sorted()
        #expect(duplicates == [1, 2, 3])
        
        let array2 = ["h", "e", "l", "l", "o"]
        let duplicates2 = array2.mp.duplicates().sorted()
        #expect(duplicates2 == ["l"])
        
        let array3 = [1, 2, 3]
        let duplicates3 = array3.mp.duplicates()
        #expect(duplicates3.isEmpty)
    }
    
    // MARK: - Method: sum (AdditiveArithmetic)
    
    @Test("sum should return sum of all elements")
    func testSum() {
        let array = [1, 2, 3, 4, 5]
        let sum = array.mp.sum()
        #expect(sum == 15)
        
        let array2: [Double] = [1.5, 2.5, 3.5]
        let sum2 = array2.mp.sum()
        #expect(abs(sum2 - 7.5) < 0.0001)
    }
    
    // MARK: - Method: product (Numeric)
    
    @Test("product should return product of all elements")
    func testProduct() {
        let array = [1, 2, 3, 4, 5]
        let product = array.mp.product()
        #expect(product == 120)
        
        let array2 = [2, 3, 4]
        let product2 = array2.mp.product()
        #expect(product2 == 24)
    }
}
