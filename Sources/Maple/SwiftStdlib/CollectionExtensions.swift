//
//  CollectionExtensions.swift
//  Maple
//
//  Created by cy on 2024/9/23.
//  Copyright © 2024 cy. All rights reserved.
//

import Foundation

// MARK: - Methods

public extension Collection {
    /// Safe protects the array from out of bounds by use of optional.
    ///
    ///        let arr = [1, 2, 3, 4, 5]
    ///        arr[safe: 1] -> 2
    ///        arr[safe: 10] -> nil
    ///
    /// - Parameter index: index of element to access element.
    subscript(safe index: Index) -> Element? {
        return indices.contains(index) ? self[index] : nil
    }
}

public extension MapleWrapper where Base: Collection {
    /// Returns an array of slices of length "size" from the array. If array can't be split evenly, the
    /// final slice will be the remaining elements.
    ///
    ///     [0, 2, 4, 7].group(by: 2) -> [[0, 2], [4, 7]]
    ///     [0, 2, 4, 7, 6].group(by: 2) -> [[0, 2], [4, 7], [6]]
    ///
    /// - Parameter size: The size of the slices to be returned.
    /// - Returns: grouped self.
    func group(by size: Int) -> [[Base.Element]]? {
        // Inspired by: https://lodash.com/docs/4.17.4#chunk
        guard size > 0, !base.isEmpty else { return nil }
        var start = base.startIndex
        var slices = [[Base.Element]]()
        while start != base.endIndex {
            let end = base.index(start, offsetBy: size, limitedBy: base.endIndex) ?? base.endIndex
            slices.append(Array(base[start..<end]))
            start = end
        }
        return slices
    }
}

// MARK: - Methods (Equatable)

public extension MapleWrapper where Base: Collection, Base.Element: Equatable {
    /// All indices of specified item.
    ///
    ///        [1, 2, 2, 3, 4, 2, 5].indices(of 2) -> [1, 2, 5]
    ///        [1.2, 2.3, 4.5, 3.4, 4.5].indices(of 2.3) -> [1]
    ///        ["h", "e", "l", "l", "o"].indices(of "l") -> [2, 3]
    ///
    /// - Parameter item: item to check.
    /// - Returns: an array with all indices of the given item.
    func indices(of item: Base.Element) -> [Base.Index] {
        return base.indices.filter { base[$0] == item }
    }
}

// MARK: - Methods (BinaryInteger)

public extension MapleWrapper where Base: Collection, Base.Element: BinaryInteger {
    /// Average of all elements in array.
    ///
    /// - Returns: the average of the array's elements.
    func average() -> Double {
        // http://stackoverflow.com/questions/28288148/making-my-function-calculate-average-of-array-swift
        guard !base.isEmpty else { return .zero }
        return Double(base.reduce(.zero, +)) / Double(base.count)
    }
}

// MARK: - Methods (FloatingPoint)

public extension MapleWrapper where Base: Collection, Base.Element: FloatingPoint {
    /// Average of all elements in array.
    ///
    ///        [1.2, 2.3, 4.5, 3.4, 4.5].average() = 3.18
    ///
    /// - Returns: average of the array's elements.
    func average() -> Base.Element {
        guard !base.isEmpty else { return .zero }
        return base.reduce(.zero, +) / Base.Element(base.count)
    }
}
