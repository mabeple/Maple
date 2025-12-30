//
//  CGFloat+Maple.swift
//  Maple
//
//  Created by cy on 2024/4/7.
//  Copyright © 2024 cy. All rights reserved.
//

#if canImport(CoreGraphics)
import CoreGraphics

#if canImport(Foundation)
import Foundation
#endif

extension CGFloat: MapleCompatibleValue { }

// MARK: - Properties

public extension MapleWrapper where Base == CGFloat {
    /// Absolute of CGFloat value.
    var abs: CGFloat {
        return Swift.abs(base)
    }

    #if canImport(Foundation)
    /// Ceil of CGFloat value.
    var ceil: CGFloat {
        return Foundation.ceil(base)
    }
    #endif

    /// Radian value of degree input.
    var degreesToRadians: CGFloat {
        return .pi * base / 180.0
    }

    #if canImport(Foundation)
    /// Floor of CGFloat value.
    var floor: CGFloat {
        return Foundation.floor(base)
    }
    #endif

    /// Check if CGFloat is positive.
    var isPositive: Bool {
        return base > 0
    }

    /// Check if CGFloat is negative.
    var isNegative: Bool {
        return base < 0
    }

    /// Int.
    var int: Int {
        return Int(base)
    }

    /// Float.
    var float: Float {
        return Float(base)
    }

    /// Double.
    var double: Double {
        return Double(base)
    }

    /// Degree value of radian input.
    var radiansToDegrees: CGFloat {
        return base * 180 / CGFloat.pi
    }
}

#endif
