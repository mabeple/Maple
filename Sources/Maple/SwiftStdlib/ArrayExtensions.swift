//
//  ArrayExtensions.swift
//  Maple
//
//  Created by cy on 2023/2/22.
//  Copyright © 2023 cy. All rights reserved.
//

#if canImport(Foundation)
import Foundation
#endif

extension Array: MapleCompatibleValue { }

// MARK: - Methods
public extension MapleWrapper {
    /// Return array with all duplicate elements removed.
    ///
    ///     [1, 1, 2, 2, 3, 3, 3, 4, 5].mp.withoutDuplicates() -> [1, 2, 3, 4, 5])
    ///     ["h", "e", "l", "l", "o"].mp.withoutDuplicates() -> ["h", "e", "l", "o"])
    ///
    /// - Returns: an array of unique elements.
    ///
    func withoutDuplicates<Element: Equatable>() -> [Element] where Base == [Element] {
        // Thanks to https://github.com/sairamkotha for improving the method
        return base.reduce(into: []) {
            if !$0.contains($1) {
                $0.append($1)
            }
        }
    }
    
    /// Returns an array with all duplicate elements removed using KeyPath to compare.
    ///
    /// - Parameter path: Key path to compare, the value must be Equatable.
    /// - Returns: an array of unique elements.
    func withoutDuplicates<T, E: Equatable>(keyPath path: KeyPath<T, E>) -> [T] where Base == [T] {
        return base.reduce(into: []) { result, element in
            if !result.contains(where: { $0[keyPath: path] == element[keyPath: path] }) {
                result.append(element)
            }
        }
    }

    /// Returns an array with all duplicate elements removed using KeyPath to compare.
    ///
    /// - Parameter path: Key path to compare, the value must be Hashable.
    /// - Returns: an array of unique elements.
    func withoutDuplicates<T, E: Hashable>(keyPath path: KeyPath<T, E>) -> [T] where Base == [T] {
        var set = Set<E>()
        return base.filter { set.insert($0[keyPath: path]).inserted }
    }
    
    /// Remove all instances of an item from array.
    ///
    ///        [1, 2, 2, 3, 4, 5].mp.removeAll(2) -> [1, 3, 4, 5]
    ///        ["h", "e", "l", "l", "o"].mp.removeAll("l") -> ["h", "e", "o"]
    ///
    /// - Parameter item: item to remove.
    /// - Returns: self after removing all instances of item.
    func removeAll<Element: Equatable>(_ item: Element) -> [Element] where Base == [Element] {
        return base.filter { $0 != item }
    }
}


// MARK: - Methods (Equatable)
public extension Array where Element: Equatable {
    /// Remove all instances of an item from array.
    ///
    ///        [1, 2, 2, 3, 4, 5].removeAll(2) -> [1, 3, 4, 5]
    ///        ["h", "e", "l", "l", "o"].removeAll("l") -> ["h", "e", "o"]
    ///
    /// - Parameter item: item to remove.
    /// - Returns: self after removing all instances of item.
    @discardableResult
    mutating func removeAll(_ item: Element) -> [Element] {
        removeAll(where: { $0 == item })
        return self
    }
    
    /// Remove all instances contained in items parameter from array.
    ///
    ///        [1, 2, 2, 3, 4, 5].removeAll([2,5]) -> [1, 3, 4]
    ///        ["h", "e", "l", "l", "o"].removeAll(["l", "h"]) -> ["e", "o"]
    ///
    /// - Parameter items: items to remove.
    /// - Returns: self after removing all instances of all items in given array.
    @discardableResult
    mutating func removeAll(_ items: [Element]) -> [Element] {
        guard !items.isEmpty else { return self }
        removeAll(where: { items.contains($0) })
        return self
    }

    /// Remove all duplicate elements from Array.
    ///
    ///        [1, 2, 2, 3, 4, 5].withoutDuplicates() -> [1, 2, 3, 4, 5]
    ///        ["h", "e", "l", "l", "o"].withoutDuplicates() -> ["h", "e", "l", "o"]
    ///
    /// - Returns: Return array with all duplicate elements removed.
    @discardableResult
    mutating func withoutDuplicates() -> [Element] {
        // Thanks to https://github.com/sairamkotha for improving the method
        self = reduce(into: [Element]()) {
            if !$0.contains($1) {
                $0.append($1)
            }
        }
        return self
    }
}
