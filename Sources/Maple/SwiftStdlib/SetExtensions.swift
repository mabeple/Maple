//
//  SetExtensions.swift
//  Maple
//
//  Created by cy on 2026/1/19.
//  Copyright © 2026 cy. All rights reserved.
//

#if canImport(Foundation)
import Foundation
#endif

extension Set: MapleCompatibleValue { }

// MARK: - Methods
public extension MapleWrapper where Base: SetAlgebra {
    
    /// Check if set has intersection with another set.
    ///
    ///        let set1: Set<Int> = [1, 2, 3]
    ///        let set2: Set<Int> = [3, 4, 5]
    ///        set1.mp.hasIntersection(with: set2) -> true
    ///
    ///        let set3: Set<Int> = [1, 2]
    ///        let set4: Set<Int> = [3, 4]
    ///        set3.mp.hasIntersection(with: set4) -> false
    ///
    /// - Parameter other: another set to check intersection with.
    /// - Returns: `true` if sets have at least one common element.
    func hasIntersection(with other: Base) -> Bool {
        return !base.isDisjoint(with: other)
    }
    
    /// Check if set is a proper subset of another set.
    ///
    ///        let set1: Set<Int> = [1, 2]
    ///        let set2: Set<Int> = [1, 2, 3]
    ///        set1.mp.isProperSubset(of: set2) -> true
    ///
    ///        let set3: Set<Int> = [1, 2, 3]
    ///        set3.mp.isProperSubset(of: set2) -> false
    ///
    /// - Parameter other: another set to compare with.
    /// - Returns: `true` if this set is a proper subset of the other set.
    func isProperSubset(of other: Base) -> Bool {
        return base.isSubset(of: other) && base != other
    }
    
    /// Check if set is a proper superset of another set.
    ///
    ///        let set1: Set<Int> = [1, 2, 3]
    ///        let set2: Set<Int> = [1, 2]
    ///        set1.mp.isProperSuperset(of: set2) -> true
    ///
    ///        let set3: Set<Int> = [1, 2, 3]
    ///        set3.mp.isProperSuperset(of: set1) -> false
    ///
    /// - Parameter other: another set to compare with.
    /// - Returns: `true` if this set is a proper superset of the other set.
    func isProperSuperset(of other: Base) -> Bool {
        return base.isSuperset(of: other) && base != other
    }
}

// MARK: - Methods (Collection)
public extension MapleWrapper where Base: SetAlgebra, Base: Collection {
    /// Convert set to array (order is not guaranteed).
    ///
    ///        let set: Set<Int> = [1, 2, 3]
    ///        let array = set.mp.toArray()
    ///        array.count -> 3
    ///
    /// - Returns: An array containing all elements of the set.
    func toArray() -> [Base.Element] {
        return Array(base)
    }
}
