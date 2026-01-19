//
//  CaseIterableExtensions.swift
//  Maple
//
//  Created by cy on 2024/4/7.
//  Copyright © 2024 cy. All rights reserved.
//

#if canImport(Foundation)
import Foundation
#endif

// Make types conforming to CaseIterable & Equatable automatically have mp property
// by providing mp through protocol extension
extension CaseIterable where Self: Equatable, AllCases: BidirectionalCollection {
    public var mp: MapleWrapper<Self> {
        get { MapleWrapper(self) }
        set { }
    }
}

// MARK: - Methods
public extension MapleWrapper where Base: CaseIterable, Base: Equatable, Base.AllCases: BidirectionalCollection {
    /// Method to return the previous case in the enumeration.
    ///
    /// If looped is true, it will loop back to the last case if the current case is the first.
    /// If looped is false and the current case is the first, it returns the current case.
    ///
    /// - Parameter looped: Whether to loop back to the last case when at the first. Defaults to true.
    /// - Returns: The previous case in the enumeration.
    func previous(looped: Bool = true) -> Base {
        let all = Base.allCases
        let idx = all.firstIndex(of: base)!
        let previous = all.index(before: idx)
        if previous < all.startIndex {
            return looped ? all.last! : base
        }
        return all[previous]
    }

    /// Method to return the next case in the enumeration.
    ///
    /// If looped is true, it will loop back to the first case if the current case is the last.
    /// If looped is false and the current case is the last, it returns the current case.
    ///
    /// - Parameter looped: Whether to loop back to the first case when at the last. Defaults to true.
    /// - Returns: The next case in the enumeration.
    func next(looped: Bool = true) -> Base {
        let all = Base.allCases
        let idx = all.firstIndex(of: base)!
        let next = all.index(after: idx)
        if next == all.endIndex {
            return looped ? all.first! : base
        }
        return all[next]
    }
    
    /// Method to check if the current case is the first case in the enumeration.
    ///
    /// - Returns: true if the current case is the first case, false otherwise.
    func isFirst() -> Bool {
        let all = Base.allCases
        let idx = all.firstIndex(of: base)!
        return idx == all.startIndex
    }
    
    /// Method to check if the current case is the last case in the enumeration.
    ///
    /// - Returns: true if the current case is the last case, false otherwise.
    func isLast() -> Bool {
        let all = Base.allCases
        let idx = all.firstIndex(of: base)!
        return idx == all.index(before: all.endIndex)
    }
}

