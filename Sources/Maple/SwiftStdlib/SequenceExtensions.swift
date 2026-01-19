//
//  SequenceExtensions.swift
//  Maple
//
//  Created by cy on 2026/1/19.
//  Copyright © 2026 cy. All rights reserved.
//

#if canImport(Foundation)
import Foundation
#endif

// MARK: - Methods

public extension MapleWrapper where Base: Sequence {
    /// Check if all elements in sequence match a condition.
    ///
    ///        [2, 2, 4].mp.all(matching: {$0 % 2 == 0}) -> true
    ///        [1, 2, 2, 4].mp.all(matching: {$0 % 2 == 0}) -> false
    ///
    /// - Parameter condition: condition to evaluate each element against.
    /// - Returns: `true` when all elements in the sequence match the specified condition.
    func all(matching condition: (Base.Element) throws -> Bool) rethrows -> Bool {
        return try !base.contains { try !condition($0) }
    }
    
    /// Check if no elements in sequence match a condition.
    ///
    ///        [2, 2, 4].mp.none(matching: {$0 % 2 == 0}) -> false
    ///        [1, 3, 5, 7].mp.none(matching: {$0 % 2 == 0}) -> true
    ///
    /// - Parameter condition: condition to evaluate each element against.
    /// - Returns: true when no elements in the array match the specified condition.
    func none(matching condition: (Base.Element) throws -> Bool) rethrows -> Bool {
        return try !base.contains { try condition($0) }
    }
    
    /// Check if any element in sequence match a condition.
    ///
    ///        [2, 2, 4].mp.any(matching: {$0 % 2 == 0}) -> true
    ///        [1, 3, 5, 7].mp.any(matching: {$0 % 2 == 0}) -> false
    ///
    /// - Parameter condition: condition to evaluate each element against.
    /// - Returns: true when at least one element in the array match the specified condition.
    func any(matching condition: (Base.Element) throws -> Bool) rethrows -> Bool {
        return try base.contains { try condition($0) }
    }

    /// Filter elements based on a rejection condition.
    ///
    ///        [2, 2, 4, 7].reject(where: {$0 % 2 == 0}) -> [7]
    ///
    /// - Parameter condition: to evaluate the exclusion of an element from the array.
    /// - Returns: the array with rejected values filtered from it.
    func reject(where condition: (Base.Element) throws -> Bool) rethrows -> [Base.Element] {
        return try base.filter { return try !condition($0) }
    }

    /// Calls the given closure with each element where condition is true.
    ///
    ///        [0, 2, 4, 7].mp.forEach(where: {$0 % 2 == 0}, body: { print($0)}) -> // print: 0, 2, 4
    ///
    /// - Parameters:
    ///   - condition: condition to evaluate each element against.
    ///   - body: a closure that takes an element of the sequence as a parameter.
    func forEach(where condition: (Base.Element) throws -> Bool, body: (Base.Element) throws -> Void) rethrows {
        try base.lazy.filter(condition).forEach(body)
    }
    
    /// Reduces a sequence while returning each interim combination.
    ///
    ///     [1, 2, 3].mp.accumulate(initial: 0, next: +) -> [1, 3, 6]
    ///
    /// - Parameters:
    ///   - initial: initial value.
    ///   - next: closure that combines the accumulating value and next element of the sequence.
    /// - Returns: an array of the final accumulated value and each interim combination.
    func accumulate<U>(initial: U, next: (U, Base.Element) throws -> U) rethrows -> [U] {
        var runningTotal = initial
        return try base.map { element in
            runningTotal = try next(runningTotal, element)
            return runningTotal
        }
    }
    
    /// Filtered and map in a single operation.
    ///
    ///     [1,2,3,4,5].mp.filtered({ $0 % 2 == 0 }, map: { $0.string }) -> ["2", "4"]
    ///
    /// - Parameters:
    ///   - isIncluded: condition of inclusion to evaluate each element against.
    ///   - transform: transform element function to evaluate every element.
    /// - Returns: Return a filtered and mapped array.
    func filtered<T>(_ isIncluded: (Base.Element) throws -> Bool, map transform: (Base.Element) throws -> T) rethrows -> [T] {
        return try base.lazy.filter(isIncluded).map(transform)
    }
    
    /// Get the only element based on a condition.
    ///
    ///     [].mp.single(where: {_ in true}) -> nil
    ///     [4].mp.single(where: {_ in true}) -> 4
    ///     [1, 4, 7].mp.single(where: {$0 % 2 == 0}) -> 4
    ///     [2, 2, 4, 7].mp.single(where: {$0 % 2 == 0}) -> nil
    ///
    /// - Parameter condition: condition to evaluate each element against.
    /// - Returns: The only element in the sequence matching the specified condition. If there are more matching elements,
    /// `nil` is returned.
    func single(where condition: (Base.Element) throws -> Bool) rethrows -> Base.Element? {
        var singleElement: Base.Element?
        for element in base where try condition(element) {
            guard singleElement == nil else {
                singleElement = nil
                break
            }
            singleElement = element
        }
        return singleElement
    }
    
    /// Remove duplicate elements based on condition.
    ///
    ///        [1, 2, 1, 3, 2].mp.withoutDuplicates { $0 } -> [1, 2, 3]
    ///        [(1, 4), (2, 2), (1, 3), (3, 2), (2, 1)].mp.withoutDuplicates { $0.0 } -> [(1, 4), (2, 2), (3, 2)]
    ///
    /// - Parameter transform: A closure that should return the value to be evaluated for repeating elements.
    /// - Returns: Sequence without repeating elements.
    /// - Complexity: O(*n*), where *n* is the length of the sequence.
    func withoutDuplicates<T: Hashable>(transform: (Base.Element) throws -> T) rethrows -> [Base.Element] {
        var set = Set<T>()
        return try base.filter { try set.insert(transform($0)).inserted }
    }
    
    /// Separates all items into 2 lists based on a given predicate. The first list contains all items
    /// for which the specified condition evaluates to true. The second list contains those that don't.
    ///
    ///     let (even, odd) = [0, 1, 2, 3, 4, 5].mp.divided { $0 % 2 == 0 }
    ///     let (minors, adults) = people.mp.divided { $0.age < 18 }
    ///
    /// - Parameter condition: condition to evaluate each element against.
    /// - Returns: A tuple of matched and non-matched items.
    func divided(by condition: (Base.Element) throws -> Bool) rethrows -> (matching: [Base.Element], nonMatching: [Base.Element]) {
        // Inspired by: http://ruby-doc.org/core-2.5.0/Enumerable.html#method-i-partition
        var matching = [Base.Element]()
        var nonMatching = [Base.Element]()

        for element in base {
            // swiftlint:disable:next void_function_in_ternary
            try condition(element) ? matching.append(element) : nonMatching.append(element)
        }
        return (matching, nonMatching)
    }
    
    /// Return a sorted array based on a key path and a compare function.
    ///
    /// - Parameter keyPath: Key path to sort by.
    /// - Parameter compare: Comparison function that will determine the ordering.
    /// - Returns: The sorted array.
    func sorted<T>(by keyPath: KeyPath<Base.Element, T>, with compare: (T, T) -> Bool) -> [Base.Element] {
        return base.sorted { compare($0[keyPath: keyPath], $1[keyPath: keyPath]) }
    }
    
    /// Return a sorted array based on a map function and a compare function.
    ///
    /// - Parameter map: Function that defines the property to sort by.
    /// - Parameter compare: Comparison function that will determine the ordering.
    /// - Returns: The sorted array.
    func sorted<T>(by map: (Base.Element) throws -> T, with compare: (T, T) -> Bool) rethrows -> [Base.Element] {
        return try base.sorted { try compare(map($0), map($1)) }
    }
    
    /// Return a sorted array based on a key path.
    ///
    /// - Parameter keyPath: Key path to sort by. The key path type must be Comparable.
    /// - Returns: The sorted array.
    func sorted(by keyPath: KeyPath<Base.Element, some Comparable>) -> [Base.Element] {
        return base.sorted { $0[keyPath: keyPath] < $1[keyPath: keyPath] }
    }

    /// Return a sorted array based on a map function.
    ///
    /// - Parameter map: Function that defines the property to sort by. The output type must be Comparable.
    /// - Returns: The sorted array.
    func sorted(by map: (Base.Element) throws -> some Comparable) rethrows -> [Base.Element] {
        return try base.sorted { try map($0) < map($1) }
    }
    
    /// Returns a sorted sequence based on two key paths. The second one will be used in case the values
    /// of the first one match.
    ///
    /// - Parameters:
    ///     - keyPath1: Key path to sort by. Must be Comparable.
    ///     - keyPath2: Key path to sort by in case the values of `keyPath1` match. Must be Comparable.
    /// - Returns: The sorted array.
    func sorted(by keyPath1: KeyPath<Base.Element, some Comparable>,
                and keyPath2: KeyPath<Base.Element, some Comparable>) -> [Base.Element] {
        return base.sorted {
            if $0[keyPath: keyPath1] != $1[keyPath: keyPath1] {
                return $0[keyPath: keyPath1] < $1[keyPath: keyPath1]
            }
            return $0[keyPath: keyPath2] < $1[keyPath: keyPath2]
        }
    }
    
    /// Returns a sorted sequence based on two map functions. The second one will be used in case the
    /// values of the first one match.
    ///
    /// - Parameters:
    ///     - map1: Map function to sort by. Output type must be Comparable.
    ///     - map2: Map function to sort by in case the values of `map1` match. Output type must be Comparable.
    /// - Returns: The sorted array.
    func sorted(by map1: (Base.Element) throws -> some Comparable,
                and map2: (Base.Element) throws -> some Comparable) rethrows -> [Base.Element] {
        return try base.sorted {
            let value10 = try map1($0)
            let value11 = try map1($1)
            if value10 != value11 {
                return value10 < value11
            }
            return try map2($0) < map2($1)
        }
    }
    
    /// Returns a sorted sequence based on three key paths. Whenever the values of one key path match, the
    /// next one will be used.
    ///
    /// - Parameters:
    ///     - keyPath1: Key path to sort by. Must be Comparable.
    ///     - keyPath2: Key path to sort by in case the values of `keyPath1` match. Must be Comparable.
    ///     - keyPath3: Key path to sort by in case the values of `keyPath1` and `keyPath2` match. Must be Comparable.
    /// - Returns: The sorted array.
    func sorted(by keyPath1: KeyPath<Base.Element, some Comparable>,
                and keyPath2: KeyPath<Base.Element, some Comparable>,
                and keyPath3: KeyPath<Base.Element, some Comparable>)
        -> [Base.Element] {
        return base.sorted {
            if $0[keyPath: keyPath1] != $1[keyPath: keyPath1] {
                return $0[keyPath: keyPath1] < $1[keyPath: keyPath1]
            }
            if $0[keyPath: keyPath2] != $1[keyPath: keyPath2] {
                return $0[keyPath: keyPath2] < $1[keyPath: keyPath2]
            }
            return $0[keyPath: keyPath3] < $1[keyPath: keyPath3]
        }
    }
    
    /// Returns a sorted sequence based on three map functions. Whenever the values of one map function
    /// match, the next one will be used.
    ///
    /// - Parameters:
    ///     - map1: Map function to sort by. Output type must be Comparable.
    ///     - map2: Map function to sort by in case the values of `map1` match. Output type must be Comparable.
    ///     - map3: Map function to sort by in case the values of `map1` and `map2` match.
    ///     Output type must be Comparable.
    /// - Returns: The sorted array.
    func sorted(by map1: (Base.Element) throws -> some Comparable,
                and map2: (Base.Element) throws -> some Comparable,
                and map3: (Base.Element) throws -> some Comparable) rethrows
        -> [Base.Element] {
        return try base.sorted {
            let value10 = try map1($0)
            let value11 = try map1($1)
            if value10 != value11 {
                return value10 < value11
            }

            let value20 = try map2($0)
            let value21 = try map2($1)
            if value20 != value21 {
                return value20 < value21
            }
            return try map3($0) < map3($1)
        }
    }
    
    /// Sum of a `AdditiveArithmetic` property of each `Element` in a `Sequence`.
    ///
    ///     ["James", "Wade", "Bryant"].mp.sum(for: \.count) -> 15
    ///
    /// - Parameter keyPath: Key path of the `AdditiveArithmetic` property.
    /// - Returns: The sum of the `AdditiveArithmetic` properties at `keyPath`.
    func sum<T: AdditiveArithmetic>(for keyPath: KeyPath<Base.Element, T>) -> T {
        // Inspired by: https://swiftbysundell.com/articles/reducers-in-swift/
        return base.reduce(.zero) { $0 + $1[keyPath: keyPath] }
    }

    /// Product of all elements in sequence.
    ///
    ///        ["James", "Wade", "Bryant"].mp.product(for: \.count) -> 120
    ///
    /// - Parameter map: Mapping function to `Numeric` value.
    /// - Returns: product of the sequence's elements.
    func product<T: Numeric>(for map: (Base.Element) -> T) -> T {
        base.reduce(1) { $0 * map($1) }
    }
    
    /// Sum of a `AdditiveArithmetic` property of each `Element` in a `Sequence`.
    ///
    ///     ["James", "Wade", "Bryant"].mp.sum(for: \.count) -> 15
    ///
    /// - Parameter map: Getter for the `AdditiveArithmetic` property.
    /// - Returns: The sum of the `AdditiveArithmetic` properties at `map`.
    func sum<T: AdditiveArithmetic>(for map: (Base.Element) throws -> T) rethrows -> T {
        // Inspired by: https://swiftbysundell.com/articles/reducers-in-swift/
        return try base.reduce(.zero) { try $0 + map($1) }
    }
    
    /// Returns the first element of the sequence with having property by given key path equals to given
    /// `value`.
    ///
    /// - Parameters:
    ///   - keyPath: The `KeyPath` of property for `Element` to compare.
    ///   - value: The value to compare with `Element` property.
    /// - Returns: The first element of the sequence that has property by given key path equals to given `value` or
    /// `nil` if there is no such element.
    func first<T: Equatable>(where keyPath: KeyPath<Base.Element, T>, equals value: T) -> Base.Element? {
        return base.first { $0[keyPath: keyPath] == value }
    }
    
    /// Returns the first element of the sequence with having property by given map function equals to given
    /// `value`.
    ///
    /// - Parameters:
    ///   - map: Function for `Element` to compare.
    ///   - value: The value to compare with `Element` property.
    /// - Returns: The first element of the sequence that has property by given map function equals to given `value`
    /// or `nil` if there is no such element.
    func first<T: Equatable>(where map: (Base.Element) throws -> T, equals value: T) rethrows -> Base.Element? {
        return try base.first { try map($0) == value }
    }
}

// MARK: - Methods (Equatable)
public extension MapleWrapper where Base: Sequence, Base.Element: Equatable {
    /// Check if sequence contains all elements from another sequence.
    ///
    ///        [1, 2, 3, 4, 5].mp.contains([1, 2]) -> true
    ///        [1.2, 2.3, 4.5, 3.4, 4.5].mp.contains([2, 6]) -> false
    ///        ["h", "e", "l", "l", "o"].mp.contains(["l", "o"]) -> true
    ///
    /// - Parameter elements: sequence of elements to check.
    /// - Returns: `true` if sequence contains all given items.
    /// - Complexity: _O(m·n)_, where _m_ is the length of `elements` and _n_ is the length of this sequence.
    func contains<S>(_ elements: S) -> Bool where S: Sequence, Base.Element == S.Element {
        return elements.allSatisfy { base.contains($0) }
    }
}

// MARK: - Methods (Hashable)
public extension MapleWrapper where Base: Sequence, Base.Element: Hashable {
    /// Check if sequence contains elements of another sequence.
    ///
    ///        [1, 2, 3, 4, 5].mp.contains([1, 2]) -> true
    ///        [1.2, 2.3, 4.5, 3.4, 4.5].mp.contains([2, 6]) -> false
    ///        ["h", "e", "l", "l", "o"].mp.contains(["l", "o"]) -> true
    ///
    /// - Parameter elements: sequence of elements to check.
    /// - Returns: `true` if sequence contains all given items.
    /// - Complexity: _O(m + n)_, where _m_ is the length of `elements` and _n_ is the length of this sequence.
    func contains<S: Sequence>(_ elements: S) -> Bool where Base.Element == S.Element {
        let set = Set(base)
        return elements.allSatisfy { set.contains($0) }
    }
    
    /// Check whether a sequence contains duplicates.
    ///
    ///        [1, 2, 2, 3, 4].mp.containsDuplicates() -> true
    ///        [1, 2, 3, 4, 5].mp.containsDuplicates() -> false
    ///
    /// - Returns: `true` if the sequence contains duplicates.
    func containsDuplicates() -> Bool {
        var set = Set<Base.Element>()
        return base.contains { !set.insert($0).inserted }
    }

    /// Getting the duplicated elements in a sequence.
    ///
    ///     [1, 1, 2, 2, 3, 3, 3, 4, 5].mp.duplicates().sorted() -> [1, 2, 3]
    ///     ["h", "e", "l", "l", "o"].mp.duplicates().sorted() -> ["l"]
    ///
    /// - Returns: An array of duplicated elements.
    func duplicates() -> [Base.Element] {
        var set = Set<Base.Element>()
        var duplicates = Set<Base.Element>()
        base.forEach {
            if !set.insert($0).inserted {
                duplicates.insert($0)
            }
        }
        return Array(duplicates)
    }
}

// MARK: - Methods (AdditiveArithmetic)
public extension MapleWrapper where Base: Sequence, Base.Element: AdditiveArithmetic {
    /// Sum of all elements in sequence.
    ///
    ///        [1, 2, 3, 4, 5].mp.sum() -> 15
    ///
    /// - Returns: sum of the sequence's elements.
    func sum() -> Base.Element {
        return base.reduce(.zero, +)
    }
}

// MARK: - Methods (Numeric)
public extension MapleWrapper where Base: Sequence, Base.Element: Numeric {
    /// Product of all elements in sequence.
    ///
    ///        [1, 2, 3, 4, 5].mp.product() -> 120
    ///
    /// - Returns: product of the sequence's elements.
    func product() -> Base.Element {
        base.reduce(1, *)
    }
}
