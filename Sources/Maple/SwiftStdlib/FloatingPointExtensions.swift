//
//  FloatingPointExtensions.swift
//  Maple
//
//  Created by cy on 2026/1/8.
//  Copyright © 2026 cy. All rights reserved.
//

// MARK: - Properties

public extension MapleWrapper where Base: FloatingPoint {
    /// Absolute value of number.
    var abs: Base {
        return Swift.abs(base)
    }

    /// Check if number is positive.
    var isPositive: Bool {
        return base > 0
    }

    /// Check if number is negative.
    var isNegative: Bool {
        return base < 0
    }

    /// Ceil of number.
    var ceil: Base {
        return base.rounded(.up)
    }

    /// Floor of number.
    var floor: Base {
        return base.rounded(.down)
    }

    /// Radian value of degree input.
    var degreesToRadians: Base {
        return Base.pi * base / Base(180)
    }

    /// Degree value of radian input.
    var radiansToDegrees: Base {
        return base * Base(180) / Base.pi
    }
}

// MARK: - Operators
infix operator ±
/// Tuple of plus-minus operation.
///
/// - Parameters:
///   - lhs: number.
///   - rhs: number.
/// - Returns: tuple of plus-minus operation ( 2.5 ± 1.5 -> (4, 1)).
public func ± <T: FloatingPoint>(lhs: T, rhs: T) -> (T, T) {
    // http://nshipster.com/swift-operators/
    return (lhs + rhs, lhs - rhs)
}

prefix operator ±
/// Tuple of plus-minus operation.
///
/// - Parameter int: number.
/// - Returns: tuple of plus-minus operation (± 2.5 -> (2.5, -2.5)).
public prefix func ± <T: FloatingPoint>(number: T) -> (T, T) {
    // http://nshipster.com/swift-operators/
    return 0 ± number
}

prefix operator √
/// Square root of float.
///
/// - Parameter float: float value to find square root for.
/// - Returns: square root of given float.
public prefix func √ <T>(float: T) -> T where T: FloatingPoint {
    // http://nshipster.com/swift-operators/
    return float.squareRoot()
}
