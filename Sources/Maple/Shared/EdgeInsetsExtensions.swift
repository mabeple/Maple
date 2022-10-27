//
//  EdgeInsetsExtensions.swift
//  Maple
//
//  Created by cy on 2020/5/10.
//  Copyright © 2020 cy. All rights reserved.
//

#if os(iOS) || os(tvOS) || os(watchOS)
import UIKit
/// EdgeInsets
public typealias EdgeInsets = UIEdgeInsets
#elseif os(macOS)
import Foundation
/// EdgeInsets
public typealias EdgeInsets = NSEdgeInsets

public extension NSEdgeInsets {
    /// An edge insets struct whose top, left, bottom, and right fields are all set to 0.
    static let zero = EdgeInsets()
}


extension NSEdgeInsets: Equatable {
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
extension EdgeInsets: MabpleCompatibleValue { }

// MARK: - Properties
public extension MabpleWrapper where Base == EdgeInsets {
    /// Return the vertical insets. The vertical insets is composed by top + bottom.
    ///
    var vertical: CGFloat {
        // Source: https://github.com/MessageKit/MessageKit/blob/master/Sources/SwifterSwift/EdgeInsets%2BExtensions.swift
        return base.top + base.bottom
    }
    
    /// Return the horizontal insets. The horizontal insets is composed by  left + right.
    ///
    var horizontal: CGFloat {
        // Source: https://github.com/MessageKit/MessageKit/blob/master/Sources/SwifterSwift/EdgeInsets%2BExtensions.swift
        return base.left + base.right
    }
    
    /// Creates an `EdgeInsets` based on current value and top offset.
    ///
    /// - Parameters:
    ///   - top: Offset to be applied in to the top edge.
    /// - Returns: EdgeInsets offset with given offset.
    func insetBy(top: CGFloat) -> EdgeInsets {
        return EdgeInsets(top: base.top + top, left: base.left, bottom: base.bottom, right: base.right)
    }
    
    /// Creates an `EdgeInsets` based on current value and left offset.
    ///
    /// - Parameters:
    ///   - left: Offset to be applied in to the left edge.
    /// - Returns: EdgeInsets offset with given offset.
    func insetBy(left: CGFloat) -> EdgeInsets {
        return EdgeInsets(top: base.top, left: base.left + left, bottom: base.bottom, right: base.right)
    }
    
    /// Creates an `EdgeInsets` based on current value and bottom offset.
    ///
    /// - Parameters:
    ///   - bottom: Offset to be applied in to the bottom edge.
    /// - Returns: EdgeInsets offset with given offset.
    func insetBy(bottom: CGFloat) -> EdgeInsets {
        return EdgeInsets(top: base.top, left: base.left, bottom: base.bottom + bottom, right: base.right)
    }
    
    /// Creates an `EdgeInsets` based on current value and right offset.
    ///
    /// - Parameters:
    ///   - right: Offset to be applied in to the right edge.
    /// - Returns: EdgeInsets offset with given offset.
    func insetBy(right: CGFloat) -> EdgeInsets {
        return EdgeInsets(top: base.top, left: base.left, bottom: base.bottom, right: base.right + right)
    }
    
    /// Creates an `EdgeInsets` based on current value and horizontal value equally divided and applied to right offset and left offset.
    ///
    /// - Parameters:
    ///   - horizontal: Offset to be applied to right and left.
    /// - Returns: EdgeInsets offset with given offset.
    func insetBy(horizontal: CGFloat) -> EdgeInsets {
        return EdgeInsets(top: base.top, left: base.left + horizontal / 2, bottom: base.bottom, right: base.right + horizontal / 2)
    }
    
    /// Creates an `EdgeInsets` based on current value and vertical value equally divided and applied to top and bottom.
    ///
    /// - Parameters:
    ///   - vertical: Offset to be applied to top and bottom.
    /// - Returns: EdgeInsets offset with given offset.
    func insetBy(vertical: CGFloat) -> EdgeInsets {
        return EdgeInsets(top: base.top + vertical / 2, left: base.left, bottom: base.bottom + vertical / 2, right: base.right)
    }
}

// MARK: - Methods
public extension EdgeInsets {
    /// Creates an `EdgeInsets` with the inset value applied to all (top, bottom, right, left)
    ///
    /// - Parameter inset: Inset to be applied in all the edges.
    init(inset: CGFloat) {
        self.init(top: inset, left: inset, bottom: inset, right: inset)
    }
    
    /// Creates an `EdgeInsets` with the top value equally and applied to top.
    /// And the top value equally and applied to top.
    ///
    ///
    /// - Parameter top: Inset to be applied to top.
    init(top: CGFloat) {
        self.init(top: top, left: 0, bottom: 0, right: 0)
    }
    
    /// Creates an `EdgeInsets` with the left value equally and applied to left.
    /// And the left value equally and applied to left.
    ///
    ///
    /// - Parameter left: Inset to be applied to left.
    init(left: CGFloat) {
        self.init(top: 0, left: left, bottom: 0, right: 0)
    }
    
    /// Creates an `EdgeInsets` with the bottom value equally and applied to bottom.
    /// And the bottom value equally and applied to bottom.
    ///
    ///
    /// - Parameter bottom: Inset to be applied to bottom.
    init(bottom: CGFloat) {
        self.init(top: 0, left: 0, bottom: bottom, right: 0)
    }
    
    /// Creates an `EdgeInsets` with the right value equally and applied to right.
    /// And the right value equally and applied to right.
    ///
    ///
    /// - Parameter right: Inset to be applied to right
    init(right: CGFloat) {
        self.init(top: 0, left: 0, bottom: 0, right: right)
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

