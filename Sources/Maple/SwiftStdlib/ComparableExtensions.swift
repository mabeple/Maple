//
//  ComparableExtensions.swift
//  Maple
//
//  Created by cy on 2024/9/23.
//  Copyright © 2024 cy. All rights reserved.
//

import Foundation


extension Double: MapleCompatibleValue {}

extension Decimal: MapleCompatibleValue {}

// MARK: - Methods

public extension MapleWrapper where Base: Comparable {
    /// Returns true if value is in the provided range.
    ///
    ///     1.mp.isBetween(5...7) // false
    ///     7.mp.isBetween(6...12) // true
    ///     date.mp.isBetween(date1...date2)
    ///     "c".mp.isBetween("a"..."d") // true
    ///     0.32.mp.isBetween(0.31...0.33) // true
    ///
    /// - Parameter range: Closed range against which the value is checked to be included.
    /// - Returns: `true` if the value is included in the range, `false` otherwise.
    func isBetween(_ range: ClosedRange<Base>) -> Bool {
        range.contains(base)
    }

    /// Returns value limited within the provided range.
    ///
    ///     1.mp.clamped(to: 3...8) // 3
    ///     4.mp.clamped(to: 3...7) // 4
    ///     "c".mp.clamped(to: "e"..."g") // "e"
    ///     0.32.mp.clamped(to: 0.1...0.29) // 0.29
    ///
    /// - Parameter range: Closed range that limits the value.
    /// - Returns: A value limited to the range, i.e. between `range.lowerBound` and `range.upperBound`.
    func clamped(to range: ClosedRange<Base>) -> Base {
        min(max(base, range.lowerBound), range.upperBound)
    }
}
