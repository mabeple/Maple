//
//  CaseIterableExtensions.swift
//  Maple
//
//  Created by cy on 2024/4/7.
//

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
    
    /// Get the index of the current case in the enumeration.
    ///
    /// - Returns: The zero-based index of the current case.
    func index() -> Int {
        let all = Base.allCases
        let idx = all.firstIndex(of: base)!
        return all.distance(from: all.startIndex, to: idx)
    }
    
    /// Get the total count of all cases in the enumeration.
    ///
    /// - Returns: The total number of cases.
    var count: Int {
        Base.allCases.count
    }
    
    /// Get a case offset by a specified number of positions.
    ///
    /// If looped is true, it will wrap around when reaching the boundaries.
    /// If looped is false and the offset would go beyond boundaries, it returns nil.
    ///
    /// - Parameters:
    ///   - offset: The number of positions to offset (positive for forward, negative for backward).
    ///   - looped: Whether to wrap around when reaching boundaries. Defaults to false.
    /// - Returns: The case at the offset position, or nil if out of bounds and not looped.
    func offset(by offset: Int, looped: Bool = false) -> Base? {
        let all = Base.allCases
        guard !all.isEmpty else { return nil }
        
        let idx = all.firstIndex(of: base)!
        let currentIndex = all.distance(from: all.startIndex, to: idx)
        let totalCount = all.count
        var newIndex = currentIndex + offset
        
        if looped {
            newIndex = ((newIndex % totalCount) + totalCount) % totalCount
        } else {
            guard newIndex >= 0 && newIndex < totalCount else { return nil }
        }
        
        let targetIndex = all.index(all.startIndex, offsetBy: newIndex)
        return all[targetIndex]
    }
    
    /// Calculate the distance from the current case to another case.
    ///
    /// - Parameter other: The target case to calculate distance to.
    /// - Returns: The number of steps needed to reach the other case (positive for forward, negative for backward).
    func distance(to other: Base) -> Int {
        let all = Base.allCases
        let currentIdx = all.firstIndex(of: base)!
        let otherIdx = all.firstIndex(of: other)!
        
        let currentIndex = all.distance(from: all.startIndex, to: currentIdx)
        let otherIndex = all.distance(from: all.startIndex, to: otherIdx)
        
        return otherIndex - currentIndex
    }
}

