//
//  EdgeInsetsExtensions.swift
//  Maple
//
//  Created by cy on 2020/5/10.
//

#if os(iOS) || os(tvOS) || os(watchOS)
import UIKit
public typealias EdgeInsets = UIEdgeInsets
#elseif os(macOS)
import Foundation
public typealias EdgeInsets = NSEdgeInsets

public extension NSEdgeInsets {
    /// An edge insets struct whose top, left, bottom, and right fields are all set to 0.
    static let zero = EdgeInsets()
}

extension NSEdgeInsets: @retroactive Equatable {
    /// Returns a Boolean value indicating whether two values are equal.
    ///
    /// Equality is the inverse of inequality. For any values `a` and `b`,
    /// `a == b` implies that `a != b` is `false`.
    ///
    /// - Parameters:
    ///   - lhs: A value to compare.
    ///   - rhs: Another value to compare.
    public static func == (lhs: NSEdgeInsets, rhs: NSEdgeInsets) -> Bool {
        return lhs.top == rhs.top &&
            lhs.left == rhs.left &&
            lhs.bottom == rhs.bottom &&
            lhs.right == rhs.right
    }
}
#endif

#if os(iOS) || os(tvOS) || os(watchOS) || os(macOS)
extension EdgeInsets: MapleCompatibleValue { }

// MARK: - Properties
public extension MapleWrapper where Base == EdgeInsets {
    /// Return the vertical insets. The vertical insets is composed by top + bottom.
    ///
    var vertical: CGFloat {
        return base.top + base.bottom
    }
    
    /// Return the horizontal insets. The horizontal insets is composed by  left + right.
    ///
    var horizontal: CGFloat {
        return base.left + base.right
    }
}

// MARK: - Methods
public extension MapleWrapper where Base == EdgeInsets {
    /// Creates an `EdgeInsets` based on current value and top offset.
    ///
    /// - Parameters:
    ///   - top: Offset to be applied in to the top edge.
    /// - Returns: EdgeInsets offset with given offset.
    func insetBy(top: CGFloat) -> Base {
        return .init(top: base.top + top, left: base.left, bottom: base.bottom, right: base.right)
    }
    
    /// Creates an `EdgeInsets` based on current value and left offset.
    ///
    /// - Parameters:
    ///   - left: Offset to be applied in to the left edge.
    /// - Returns: EdgeInsets offset with given offset.
    func insetBy(left: CGFloat) -> Base {
        return .init(top: base.top, left: base.left + left, bottom: base.bottom, right: base.right)
    }
    
    /// Creates an `EdgeInsets` based on current value and bottom offset.
    ///
    /// - Parameters:
    ///   - bottom: Offset to be applied in to the bottom edge.
    /// - Returns: EdgeInsets offset with given offset.
    func insetBy(bottom: CGFloat) -> Base {
        return .init(top: base.top, left: base.left, bottom: base.bottom + bottom, right: base.right)
    }
    
    /// Creates an `EdgeInsets` based on current value and right offset.
    ///
    /// - Parameters:
    ///   - right: Offset to be applied in to the right edge.
    /// - Returns: EdgeInsets offset with given offset.
    func insetBy(right: CGFloat) -> Base {
        return .init(top: base.top, left: base.left, bottom: base.bottom, right: base.right + right)
    }
    
    /// Creates an `EdgeInsets` based on current value and horizontal value equally divided and applied to right offset and left offset.
    ///
    /// - Parameters:
    ///   - horizontal: Offset to be applied to right and left.
    /// - Returns: EdgeInsets offset with given offset.
    func insetBy(horizontal: CGFloat) -> Base {
        return .init(top: base.top, left: base.left + horizontal / 2, bottom: base.bottom, right: base.right + horizontal / 2)
    }
    
    /// Creates an `EdgeInsets` based on current value and vertical value equally divided and applied to top and bottom.
    ///
    /// - Parameters:
    ///   - vertical: Offset to be applied to top and bottom.
    /// - Returns: EdgeInsets offset with given offset.
    func insetBy(vertical: CGFloat) -> Base {
        return .init(top: base.top + vertical / 2, left: base.left, bottom: base.bottom + vertical / 2, right: base.right)
    }
}

// MARK: - Initializers
public extension EdgeInsets {
    /// Creates an `EdgeInsets` with the inset value applied to all (top, bottom, right, left)
    ///
    /// - Parameter inset: Inset to be applied in all the edges.
    init(inset: CGFloat) {
        self.init(top: inset, left: inset, bottom: inset, right: inset)
    }
    
    /// Creates an `EdgeInsets` with the specified top, leading, bottom, and trailing inset values.
    ///
    /// - Parameters:
    ///   - top: Inset to be applied to the top edge.
    ///   - leading: Inset to be applied to the leading edge (left in LTR, right in RTL).
    ///   - bottom: Inset to be applied to the bottom edge.
    ///   - trailing: Inset to be applied to the trailing edge (right in LTR, left in RTL).
    init(top: CGFloat = 0, leading: CGFloat = 0, bottom: CGFloat = 0, trailing: CGFloat = 0) {
        self.init(top: top, left: leading, bottom: bottom, right: trailing)
    }
    
    /// Creates an `EdgeInsets` with the horizontal value equally and applied to right and left.
    /// And the vertical value equally and applied to top and bottom.
    ///
    ///
    /// - Parameter horizontal: Inset to be applied to right and left.
    /// - Parameter vertical: Inset to be applied to top and bottom.
    init(horizontal: CGFloat = 0, vertical: CGFloat = 0) {
        self.init(top: vertical, left: horizontal, bottom: vertical, right: horizontal)
    }
}

// MARK: - Operators
public extension EdgeInsets {
    
    /// Add all the properties of two `EdgeInsets` to create their addition.
    ///
    /// - Parameters:
    ///   - lhs: The left-hand expression
    ///   - rhs: The right-hand expression
    /// - Returns: A new `EdgeInsets` instance where the values of `lhs` and `rhs` are added together.
    static func + (_ lhs: EdgeInsets, _ rhs: EdgeInsets) -> EdgeInsets {
        return EdgeInsets(top: lhs.top + rhs.top,
                          left: lhs.left + rhs.left,
                          bottom: lhs.bottom + rhs.bottom,
                          right: lhs.right + rhs.right)
    }
    
    /// Add all the properties of two `EdgeInsets` to the left-hand instance.
    ///
    /// - Parameters:
    ///   - lhs: The left-hand expression to be mutated
    ///   - rhs: The right-hand expression
    static func += (_ lhs: inout EdgeInsets, _ rhs: EdgeInsets) {
        lhs.top += rhs.top
        lhs.left += rhs.left
        lhs.bottom += rhs.bottom
        lhs.right += rhs.right
    }
}
#endif

