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



public extension CaseIterable where Self: Equatable, AllCases: BidirectionalCollection {
    
    // Method to return the previous case in the enumeration.
    // If looped is true, it will loop back to the last case if the current case is the first.
    // If looped is false and the current case is the first, it returns the current case.
    func previous(looped: Bool = true) -> Self {
        let all = Self.allCases
        let idx = all.firstIndex(of: self)!
        let previous = all.index(before: idx)
        if previous < all.startIndex {
            return looped ? all.last! : self
        }
        return all[previous]
    }

    // Method to return the next case in the enumeration.
    // If looped is true, it will loop back to the first case if the current case is the last.
    // If looped is false and the current case is the last, it returns the current case.
    func next(looped: Bool = true) -> Self {
        let all = Self.allCases
        let idx = all.firstIndex(of: self)!
        let next = all.index(after: idx)
        if next == all.endIndex {
            return looped ? all.first! : self
        }
        return all[next]
    }
    
    // Method to check if the current case is the last case in the enumeration.
    func isLast() -> Bool {
        let all = Self.allCases
        let idx = all.firstIndex(of: self)!
        return idx == all.index(before: all.endIndex)
    }
}

