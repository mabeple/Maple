//
//  DirectionalEdgeInsetsExtensions.swift
//  Maple
//
//  Created by cy on 2024/4/7.
//  Copyright © 2024 cy. All rights reserved.
//

#if os(iOS) || os(tvOS) || os(watchOS)
import UIKit
public typealias DirectionalEdgeInsets = NSDirectionalEdgeInsets
#elseif os(macOS)
import AppKit
public typealias DirectionalEdgeInsets = NSDirectionalEdgeInsets

public extension NSDirectionalEdgeInsets {
    /// An edge insets struct whose top, left, bottom, and right fields are all set to 0.
    static let zero = DirectionalEdgeInsets()
}

extension NSDirectionalEdgeInsets: Equatable {
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

extension NSDirectionalEdgeInsets: MabpleCompatibleValue { }

// MARK: - Properties
public extension MabpleWrapper where Base == DirectionalEdgeInsets {
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
public extension MabpleWrapper where Base == DirectionalEdgeInsets {
    /// Creates an `EdgeInsets` based on current value and top offset.
    ///
    /// - Parameters:
    ///   - top: Offset to be applied in to the top edge.
    /// - Returns: EdgeInsets offset with given offset.
    func insetBy(top: CGFloat) -> Base {
        return .init(top: base.top + top, leading: base.leading, bottom: base.bottom, trailing: base.trailing)
    }
    
    /// Creates an `EdgeInsets` based on current value and leading offset.
    ///
    /// - Parameters:
    ///   - leading: Offset to be applied in to the leading edge.
    /// - Returns: EdgeInsets offset with given offset.
    func insetBy(leading: CGFloat) -> Base {
        return .init(top: base.top, leading: base.leading + leading, bottom: base.bottom, trailing: base.trailing)
    }
    
    /// Creates an `NSDirectionalEdgeInsets` based on current value and bottom offset.
    ///
    /// - Parameters:
    ///   - bottom: Offset to be applied in to the bottom edge.
    /// - Returns: EdgeInsets offset with given offset.
    func insetBy(bottom: CGFloat) -> Base {
        return .init(top: base.top, leading: base.leading, bottom: base.bottom + bottom, trailing: base.trailing)
    }
    
    /// Creates an `NSDirectionalEdgeInsets` based on current value and trailing offset.
    ///
    /// - Parameters:
    ///   - trailing: Offset to be applied in to the trailing edge.
    /// - Returns: EdgeInsets offset with given offset.
    func insetBy(trailing: CGFloat) -> Base {
        return .init(top: base.top, leading: base.leading, bottom: base.bottom, trailing: base.trailing + trailing)
    }
    
    /// Creates an `NSDirectionalEdgeInsets` based on current value and horizontal value equally divided and applied to trailing offset and leading offset.
    ///
    /// - Parameters:
    ///   - horizontal: Offset to be applied to trailing and leading.
    /// - Returns: EdgeInsets offset with given offset.
    func insetBy(horizontal: CGFloat) -> Base {
        return .init(top: base.top, leading: base.leading + horizontal / 2, bottom: base.bottom, trailing: base.trailing + horizontal / 2)
    }
    
    /// Creates an `NSDirectionalEdgeInsets` based on current value and vertical value equally divided and applied to top and bottom.
    ///
    /// - Parameters:
    ///   - vertical: Offset to be applied to top and bottom.
    /// - Returns: EdgeInsets offset with given offset.
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
    
    /// Creates an `NSDirectionalEdgeInsets` with the top value equally and applied to top.
    /// And the top value equally and applied to top.
    ///
    ///
    /// - Parameter top: Inset to be applied to top.
    init(top: CGFloat) {
        self.init(top: top, leading: 0, bottom: 0, trailing: 0)
    }
    
    /// Creates an `NSDirectionalEdgeInsets` with the leading value equally and applied to leading.
    /// And the leading value equally and applied to leading.
    ///
    ///
    /// - Parameter leading: Inset to be applied to leading.
    init(leading: CGFloat) {
        self.init(top: 0, leading: leading, bottom: 0, trailing: 0)
    }
    
    /// Creates an `NSDirectionalEdgeInsets` with the bottom value equally and applied to bottom.
    /// And the bottom value equally and applied to bottom.
    ///
    ///
    /// - Parameter bottom: Inset to be applied to bottom.
    init(bottom: CGFloat) {
        self.init(top: 0, leading: 0, bottom: bottom, trailing: 0)
    }
    
    /// Creates an `NSDirectionalEdgeInsets` with the trailing value equally and applied to trailing.
    /// And the trailing value equally and applied to trailing.
    ///
    ///
    /// - Parameter trailing: Inset to be applied to trailing
    init(trailing: CGFloat) {
        self.init(top: 0, leading: 0, bottom: 0, trailing: trailing)
    }
    
    /// Creates an `NSDirectionalEdgeInsets` with the horizontal value equally and applied to leading and trailing.
    /// And the vertical value equally and applied to top and bottom.
    ///
    ///
    /// - Parameter horizontal: Inset to be applied to leading and trailing.
    /// - Parameter vertical: Inset to be applied to top and bottom.
    init(horizontal: CGFloat = 0, vertical: CGFloat = 0) {
        self.init(top: vertical, leading: horizontal, bottom: vertical, trailing: horizontal)
    }
}

// MARK: - Operators
public extension DirectionalEdgeInsets {
    
    /// Add all the properties of two `NSDirectionalEdgeInsets` to create their addition.
    ///
    /// - Parameters:
    ///   - lhs: The left-hand expression
    ///   - rhs: The right-hand expression
    /// - Returns: A new `EdgeInsets` instance where the values of `lhs` and `rhs` are added together.
    static func + (_ lhs: DirectionalEdgeInsets, _ rhs: DirectionalEdgeInsets) -> DirectionalEdgeInsets {
        return .init(top: lhs.top + rhs.top,
                     leading: lhs.leading + rhs.leading,
                     bottom: lhs.bottom + rhs.bottom,
                     trailing: lhs.trailing + rhs.trailing)
    }
    
    /// Add all the properties of two `NSDirectionalEdgeInsets` to the left-hand instance.
    ///
    /// - Parameters:
    ///   - lhs: The left-hand expression to be mutated
    ///   - rhs: The right-hand expression
    static func += (_ lhs: inout DirectionalEdgeInsets, _ rhs: DirectionalEdgeInsets) {
        lhs.top += rhs.top
        lhs.leading += rhs.leading
        lhs.bottom += rhs.bottom
        lhs.trailing += rhs.trailing
    }
}
