//
//  DirectionalEdgeInsetsExtensions.swift
//  Maple
//
//  Created by cy on 2024/4/7.
//

#if os(iOS) || os(tvOS) || os(watchOS)
import UIKit
public typealias DirectionalEdgeInsets = NSDirectionalEdgeInsets
#elseif os(macOS)
import AppKit
public typealias DirectionalEdgeInsets = NSDirectionalEdgeInsets

public extension NSDirectionalEdgeInsets {
    /// An edge insets struct whose top, leading, bottom, and trailing fields are all set to 0.
    static let zero = DirectionalEdgeInsets()
}

extension NSDirectionalEdgeInsets: @retroactive Equatable {
    /// Returns a Boolean value indicating whether two values are equal.
    ///
    /// Equality is the inverse of inequality. For any values `a` and `b`,
    /// `a == b` implies that `a != b` is `false`.
    ///
    /// - Parameters:
    ///   - lhs: A value to compare.
    ///   - rhs: Another value to compare.
    public static func == (lhs: NSDirectionalEdgeInsets, rhs: NSDirectionalEdgeInsets) -> Bool {
        return lhs.top == rhs.top &&
            lhs.leading == rhs.leading &&
            lhs.bottom == rhs.bottom &&
            lhs.trailing == rhs.trailing
    }
}
#endif

#if os(iOS) || os(tvOS) || os(watchOS) || os(macOS)
extension NSDirectionalEdgeInsets: MapleCompatibleValue { }

// MARK: - Properties
public extension MapleWrapper where Base == DirectionalEdgeInsets {
    /// Return the vertical insets. The vertical insets is composed by top + bottom.
    ///
    var vertical: CGFloat {
        return base.top + base.bottom
    }

    /// Return the horizontal insets. The horizontal insets is composed by  leading + trailing.
    ///
    var horizontal: CGFloat {
        return base.leading + base.trailing
    }
}

// MARK: - Methods
public extension MapleWrapper where Base == DirectionalEdgeInsets {
    /// Creates a `DirectionalEdgeInsets` based on current value and top offset.
    ///
    /// - Parameters:
    ///   - top: Offset to be applied to the top edge.
    /// - Returns: DirectionalEdgeInsets with given offset applied to top.
    func insetBy(top: CGFloat) -> Base {
        return .init(top: base.top + top, leading: base.leading, bottom: base.bottom, trailing: base.trailing)
    }
    
    /// Creates a `DirectionalEdgeInsets` based on current value and leading offset.
    ///
    /// - Parameters:
    ///   - leading: Offset to be applied to the leading edge.
    /// - Returns: DirectionalEdgeInsets with given offset applied to leading.
    func insetBy(leading: CGFloat) -> Base {
        return .init(top: base.top, leading: base.leading + leading, bottom: base.bottom, trailing: base.trailing)
    }
    
    /// Creates a `DirectionalEdgeInsets` based on current value and bottom offset.
    ///
    /// - Parameters:
    ///   - bottom: Offset to be applied to the bottom edge.
    /// - Returns: DirectionalEdgeInsets with given offset applied to bottom.
    func insetBy(bottom: CGFloat) -> Base {
        return .init(top: base.top, leading: base.leading, bottom: base.bottom + bottom, trailing: base.trailing)
    }
    
    /// Creates a `DirectionalEdgeInsets` based on current value and trailing offset.
    ///
    /// - Parameters:
    ///   - trailing: Offset to be applied to the trailing edge.
    /// - Returns: DirectionalEdgeInsets with given offset applied to trailing.
    func insetBy(trailing: CGFloat) -> Base {
        return .init(top: base.top, leading: base.leading, bottom: base.bottom, trailing: base.trailing + trailing)
    }
    
    /// Creates a `DirectionalEdgeInsets` based on current value and horizontal value equally divided and applied to leading and trailing.
    ///
    /// - Parameters:
    ///   - horizontal: Offset to be applied to leading and trailing (divided equally).
    /// - Returns: DirectionalEdgeInsets with given offset applied to leading and trailing.
    func insetBy(horizontal: CGFloat) -> Base {
        return .init(top: base.top, leading: base.leading + horizontal / 2, bottom: base.bottom, trailing: base.trailing + horizontal / 2)
    }
    
    /// Creates a `DirectionalEdgeInsets` based on current value and vertical value equally divided and applied to top and bottom.
    ///
    /// - Parameters:
    ///   - vertical: Offset to be applied to top and bottom (divided equally).
    /// - Returns: DirectionalEdgeInsets with given offset applied to top and bottom.
    func insetBy(vertical: CGFloat) -> Base {
        return .init(top: base.top + vertical / 2, leading: base.leading, bottom: base.bottom + vertical / 2, trailing: base.trailing)
    }
}

// MARK: - Initializers
public extension DirectionalEdgeInsets {
    /// Creates an `NSDirectionalEdgeInsets` with the inset value applied to all (top, bottom, trailing, leading)
    ///
    /// - Parameter inset: Inset to be applied in all the edges.
    init(inset: CGFloat) {
        self.init(top: inset, leading: inset, bottom: inset, trailing: inset)
    }
    
    /// Creates a `DirectionalEdgeInsets` with the specified top, left, bottom, and right inset values.
    ///
    /// - Parameters:
    ///   - top: Inset to be applied to the top edge.
    ///   - left: Inset to be applied to the left edge (mapped to leading).
    ///   - bottom: Inset to be applied to the bottom edge.
    ///   - right: Inset to be applied to the right edge (mapped to trailing).
    init(top: CGFloat = 0, left: CGFloat = 0, bottom: CGFloat = 0, right: CGFloat = 0) {
        self.init(top: top, leading: left, bottom: bottom, trailing: right)
    }
    
    /// Creates a `DirectionalEdgeInsets` with the horizontal value equally applied to leading and trailing, and the vertical value equally applied to top and bottom.
    ///
    /// - Parameters:
    ///   - horizontal: Inset to be applied to leading and trailing (divided equally).
    ///   - vertical: Inset to be applied to top and bottom (divided equally).
    init(horizontal: CGFloat = 0, vertical: CGFloat = 0) {
        self.init(top: vertical, leading: horizontal, bottom: vertical, trailing: horizontal)
    }
}

// MARK: - Operators
public extension DirectionalEdgeInsets {
    
    /// Add all the properties of two `DirectionalEdgeInsets` to create their addition.
    ///
    /// - Parameters:
    ///   - lhs: The left-hand expression.
    ///   - rhs: The right-hand expression.
    /// - Returns: A new `DirectionalEdgeInsets` instance where the values of `lhs` and `rhs` are added together.
    static func + (_ lhs: DirectionalEdgeInsets, _ rhs: DirectionalEdgeInsets) -> DirectionalEdgeInsets {
        return .init(top: lhs.top + rhs.top,
                     leading: lhs.leading + rhs.leading,
                     bottom: lhs.bottom + rhs.bottom,
                     trailing: lhs.trailing + rhs.trailing)
    }
    
    /// Add all the properties of two `DirectionalEdgeInsets` to the left-hand instance.
    ///
    /// - Parameters:
    ///   - lhs: The left-hand expression to be mutated.
    ///   - rhs: The right-hand expression.
    static func += (_ lhs: inout DirectionalEdgeInsets, _ rhs: DirectionalEdgeInsets) {
        lhs.top += rhs.top
        lhs.leading += rhs.leading
        lhs.bottom += rhs.bottom
        lhs.trailing += rhs.trailing
    }
}
#endif
